#!/bin/bash
# Wraps aur sync command to mount an amazon s3 bucket which contains a repository
set -uo pipefail
trap 's=$?; echo "$0: Error on line "$LINENO": $BASH_COMMAND"; exit $s' ERR

REMOTE_PATH=s3://arch-pkgs/repo/x86_64
LOCAL_PATH=$PWD/repo/x86_64
REPO_NAME=alpyg

mkdir -p "$LOCAL_PATH"


# build packages
PKGS=${@:-pkgs/*}
BUILT_PKGS=()
for package in $PKGS; do
  cd "$package"
  makepkg -cfs 
  for f in *.pkg.tar.{zst,zx}; do
    [[ -e $f ]] && BUILT_PKGS+=("$PWD/$f")
  done
  cd -
done


# add packages to db
echo "adding packages to repo: ${BUILT_PKGS[*]}"
repo-add "$LOCAL_PATH/$REPO_NAME.db.tar.xz" "${BUILT_PKGS[@]}"


# sync to s3
s3cmd sync "$REMOTE_PATH/$REPO_NAME".{db,files}.tar.xz "$LOCAL_PATH/"
rm "$LOCAL_PATH/$REPO_NAME.db"
rm "$LOCAL_PATH/$REPO_NAME.files"
cp "$LOCAL_PATH/$REPO_NAME.db.tar.xz" "$LOCAL_PATH/$REPO_NAME.db"
cp "$LOCAL_PATH/$REPO_NAME.files.tar.xz" "$LOCAL_PATH/$REPO_NAME.files"

s3cmd sync --follow-symlinks --acl-public \
  "${BUILT_PKGS[@]}" \
  "$LOCAL_PATH/$REPO_NAME".{db,files}{,.tar.xz} \
  "$REMOTE_PATH/"
