#!/bin/bash
set -ex

export HOMEBREW_PREFIX=~/homebrew
# export HOMEBREW_NO_ANALYTICS=1
mkdir -p "${HOMEBREW_PREFIX}"
curl -fsSLk https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C "${HOMEBREW_PREFIX}"

ls -laR "${HOMEBREW_PREFIX}"

export PATH="${HOMEBREW_PREFIX}/bin:${PATH}"
type -a brew

type -a openssl || :
openssl version -a || :

type -a curl || :
curl -V || :

# Fails to lock a .git/config file.
##brew analytics off

# No "brew update" until installing the proper openssl and a curl that uses it.
# brew update

# brew remove openssl || :
brew install openssl
brew link --force openssl

# brew remove curl || :
brew install --with-openssl curl
brew link --force curl || :
curl -V

ls -la "${HOMEBREW_PREFIX}/opt"
ls -la "${HOMEBREW_PREFIX}/bin"
ls -laLR "${HOMEBREW_PREFIX}/opt/curl/"

set +x
