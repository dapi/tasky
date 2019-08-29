#!/bin/bash

openssl aes-256-cbc -K $encrypted_22a700342178_key -iv $encrypted_22a700342178_iv -in .travis/id_rsa.enc -out .travis/id_rsa -d
eval "$(ssh-agent -s)" # Start ssh-agent cache
chmod 600 .travis/id_rsa # Allow read access to the private key
ssh-add .travis/id_rsa # Add the private key to SSH

ssh-add -l
ruby -v
bundle -v
bundle exec cap production deploy
