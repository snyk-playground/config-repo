#!/bin/bash

PKGS=("git" "curl" "jq")

apt-get -qq update && \
    apt-get -qq install -y "${PKGS[@]}" && \
    apt-get -qq upgrade -y && \
    apt-get -qq clean && \
    rm -rf /var/lib/apt/lists/*
