#!/bin/sh

set -e

WORKSPACE=${1:?"Pass workspace arg"}

docker cp $WORKSPACE snapc:/workspace

SUBIQUITY_PATH=/workspace/packages/subiquity_client/subiquity

docker exec \
    -w $SUBIQUITY_PATH \
    snapc \
        ./scripts/installdeps.sh

docker exec \
    -e PYTHONPATH="$SUBIQUITY_PATH:$SUBIQUITY_PATH/curtin:$SUBIQUITY_PATH/probert" \
    -w $SUBIQUITY_PATH \
    snapc \
        python3 -m subiquity.cmd.server
    # --detach \
