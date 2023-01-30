#!/bin/bash
sudo ./nodeJs.sh

SOURCE_DIR=$(pwd)
echo ${SOURCE_DIR}

# Install extensions
mkdir -p ~/.config/coc/extensions
cd ~/.config/coc/extensions
if [ ! -f package.json ];then
    echo '{"dependencies":{}}' > package.json
fi

# Change extension names to the extensions you need
npm install coc-snippets --global-style --ignore-scripts --no-bin-links --no-package-lock --only=prod

# return this dir
cd ${SOURCE_DIR}
mkdir ~/.config/nvim -p
cp ./init.lua ~/.config/nvim/init.lua
rm ~/.config/nvim/lua -rf
rm ~/.config/nvim/snapshots -rf
cp ./lua ~/.config/nvim/lua -r
cp ./snapshots ~/.config/nvim/snapshots -r
