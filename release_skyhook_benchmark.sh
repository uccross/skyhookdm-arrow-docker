#!/bin/bash
set -x

BRANCH=$1

git push -d origin $BRANCH
git checkout master
git branch -D $BRANCH

git checkout -b $BRANCH
echo "# Triggering release build" >> .github/workflows/skyhook-benchmark.yml
git add .github/workflows/skyhook-benchmark.yml
git commit -m "Trigger release build"
git push --set-upstream origin $BRANCH
git checkout master
