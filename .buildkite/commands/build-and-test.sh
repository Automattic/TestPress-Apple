#!/bin/bash -eu

echo "--- :hammer_and_wrench: Building and testing"
xcodebuild clean test \
  -project 'TestPress.xcodeproj' \
  -scheme 'TestPress' \
  -destination 'platform=iOS Simulator,name=iPhone 13,OS=15.5'
