#!/bin/bash
set -eux

IMAGE=${1:?"Pass image arg (e.g. ubuntu-daily:xxx)"}
TESTER=ubuntu-desktop-installer-${IMAGE##*:}

lxd init --auto

if [ -z "$(lxc list -f csv -c n ^${TESTER}\$)" ]; then
    lxc launch $IMAGE $TESTER
    lxc config device add $TESTER code disk source=`pwd` path=/ubuntu-desktop-installer
elif [ "$(lxc list -f csv -c s ^${TESTER}\$)" != "STOPPED" ]; then
    lxc restart $TESTER
else
    lxc start $TESTER
fi
# copy is allowed to fail, in case the ubuntu-desktop-installer directory being tested
# includes some uncopyable stuff
lxc exec $TESTER -- sh -ec "
    cd ~
    sudo cp -a /ubuntu-desktop-installer . || true
    [ -d ~/ubuntu-desktop-installer ]
    "

attempts=0
while ! lxc file pull $TESTER/etc/resolv.conf - 2> /dev/null | grep -q ^nameserver; do
    sleep 1
    attempts=$((attempts+1))
    if [ $attempts -gt 30 ]; then
        lxc file pull $TESTER/etc/resolv.conf
        lxc exec $TESTER -- ps aux
        echo "Network failed to come up after 30 seconds"
        exit 1
    fi
done
if ! lxc file pull $TESTER/etc/resolv.conf - 2> /dev/null | grep ^nameserver | grep -qv 127.0.0.53
then
    echo "systemd-resolved"
    while ! lxc file pull $TESTER/run/systemd/resolve/resolv.conf - 2> /dev/null | grep -v fe80 | grep -q ^nameserver; do
        sleep 1
        attempts=$((attempts+1))
        if [ $attempts -gt 30 ]; then
            echo "Network failed to come up after 30 seconds"
            exit 1
        fi
    done
fi

lxc exec $TESTER -- cloud-init status --wait

lxc exec $TESTER -- sh -ec "
    ls -laR /etc/apt/

    echo /etc/apt/sources.list
    cat /etc/apt/sources.list
    echo
    for f in `find /etc/apt/sources.list.d/ -type f`; do
        echo $f
        cat $f
        echo
    done

    export DEBIAN_FRONTEND=noninteractive
    apt update
    apt install -y clang cmake curl libgtk-3-dev ninja-build pkg-config unzip xz-utils zip

    if [ ! -d ~/flutter ]; then
        git clone --branch stable --depth 1 https://github.com/flutter/flutter.git ~/flutter
    else
        git -C ~/flutter fetch
        git -C ~/flutter reset --hard origin/stable
    fi
    export PATH=\$PATH:~/flutter/bin
    flutter config --enable-linux-desktop
    flutter doctor -v

    pwd
    ls
    ls ~/ubuntu-desktop-installer/
    ls ~/ubuntu-desktop-installer/packages/
    ls ~/ubuntu-desktop-installer/packages/subiquity_client/
    ls ~/ubuntu-desktop-installer/packages/subiquity_client/subiquity/
    ls ~/ubuntu-desktop-installer/packages/subiquity_client/subiquity/scripts/

    ~/ubuntu-desktop-installer/packages/subiquity_client/subiquity/scripts/installdeps.sh
    apt install -y dbus network-manager upower xvfb

    cd ~/ubuntu-desktop-installer/packages/ubuntu_desktop_installer
    flutter clean
    xvfb-run -a -s \"-screen 0 1024x768x24 +extension GLX\" flutter test integration_test --plain-name=\"minimal installation\"
    "

lxc stop $TESTER
