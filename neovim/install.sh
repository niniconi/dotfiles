#!/bin/bash
execute_exist nvim npm
install_config_file "${CONFIG_PATH}/init.lua" "$HOME/.config/nvim"
install_config_dir "${CONFIG_PATH}/lua" "$HOME/.config/nvim"
