#!/usr/bin/env bash

ssh-keygen -t ecdsa -b 521 -f ~/.ssh/root
mv ~/.ssh/root ~/.ssh/root.pem
ssh-add ~/.ssh/root.pem
cp ~/.ssh/root.pub files/keys/