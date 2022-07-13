#!/bin/bash -eu

# Workaround for https://github.com/Automattic/buildkite-ci/issues/79
echo "--- :rubygems: Fixing Ruby Setup"
gem install bundler

echo "--- :rubygems: Setting up Gems"
install_gems

echo "--- :test-analytics: Verify BUILDKITE_ANALYTICS_TOKEN"
if [ -z "$BUILDKITE_ANALYTICS_TOKEN_UI_TESTS_IPHONE" ]; then
  # This should not run because of the `-u` in the shebang, but just in case...
  echo "+++ Token not available!"
  exit 1
else
  echo "+++ Test Analytics token found, moving on"
fi

SCHEME=TestPress-UI-Tests

echo "--- :hammer_and_wrench: Building for testing"
bundle exec fastlane build_for_testing scheme:$SCHEME

echo "--- :microscope: Running UI tests"
bundle exec fastlane test_without_building scheme:$SCHEME