#!/bin/bash

cargo build --manifest-path utils/image-tool/Cargo.toml -j "$(nproc)" --release
cp utils/image-tool/target/release/image-tool scripts/dot_config/scripts/image-tool
