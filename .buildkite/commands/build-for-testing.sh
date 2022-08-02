#!/bin/bash -eu

# Workaround for https://github.com/Automattic/buildkite-ci/issues/79
echo "--- :rubygems: Fixing Ruby Setup"
gem install bundler

echo "--- :rubygems: Setting up Gems"
install_gems

echo "--- :hammer_and_wrench: Building for testing"
bundle exec fastlane build_for_testing

echo "--- :arrow_up: Upload Build Products"
tar -cf build-products.tar DerivedData/Build/Products/
upload_artifact build-products.tar
