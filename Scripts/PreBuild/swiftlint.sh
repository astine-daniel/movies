#!/bin/sh

if which ${PODS_ROOT}/SwiftLint/swiftlint >/dev/null; then
  ${PODS_ROOT}/SwiftLint/swiftlint lint --config ../.swiftlint.yml
else
  echo "warning: SwiftLint not installed, install using cocoapods - 'bundle exec pod install'"
fi
