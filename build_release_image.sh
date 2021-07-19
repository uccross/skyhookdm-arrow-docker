#!/bin/bash
set -x

BRANCH=$1

git push -d origin $BRANCH
git checkout master
git branch -D $BRANCH

git checkout -b $BRANCH
git push --set-upstream origin $BRANCH
git checkout master
