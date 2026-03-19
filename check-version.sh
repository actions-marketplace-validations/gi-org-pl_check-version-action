#!/bin/sh
set -e

VERSION="${1:-}"

if [ -z "$VERSION" ]; then
  echo "❌ No version provided."
  exit 1
fi

if [ "$(git rev-parse --is-shallow-repository)" = "true" ]; then
  echo "❌ Shallow clone detected. Set fetch-depth: 0 in your checkout step."
  exit 1
fi

echo "Checking if tag '$VERSION' already exists..."

if git tag -l "$VERSION" | grep -q .; then
  echo "❌ Image version '$VERSION' is already in use and cannot be used as next release version."
  exit 1
fi

echo "✅ Image version '$VERSION' can be used as next release version."
