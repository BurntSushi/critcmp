#!/bin/bash

# vim: ft=sh sw=2 ts=2 sts=2

set -ex

cargo build --verbose
cargo test --verbose

if [ "$TRAVIS_RUST_VERSION" = "stable" ]; then
  rustup component add rustfmt
  cargo fmt -- --check
fi
