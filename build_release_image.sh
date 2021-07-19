#!/bin/bash
set -eux

BRANCH=$1

git push -d origin $BRANCH
git branch -D $BRANCH

git checkout -b $BRANCH
git push --set-upstream origin $BRANCH
