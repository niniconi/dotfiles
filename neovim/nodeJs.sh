#!/bin/bash
set -o errexit    # exit when command fails

# Install latest nodejs
echo -e "${tip}:装不起卡住可能就是网络问题，需科学上网"
if [ ! -x "$(command -v node)" ]; then
    sh -c "$(wget https://install-node.now.sh/latest -O -)"
    # curl --fail -LSs https://install-node.now.sh/latest | sh
    export PATH="/usr/local/bin/:$PATH"
fi
