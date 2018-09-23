#!/bin/bash

# vim: ft=sh sw=2 ts=2 sts=2

set -ex

cargo build --verbose
cargo test --verbose
