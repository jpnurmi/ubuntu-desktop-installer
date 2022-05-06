#!/bin/sh

set -e

docker exec \
    -w /workspace/packages/ubuntu_desktop_installer \
    snapc \
        xvfb-run -a -s "-screen 0 1024x768x24 +extension GLX" \
            flutter test integration_test --plain-name="minimal installation"

docker exec \
    snapc \
        cat /var/log/installer/subiquity-server-info.log

docker exec \
    snapc \
        tree /target
