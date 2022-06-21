#!/bin/bash -eu

# Workaround for https://github.com/Automattic/buildkite-ci/issues/79
echo "--- :rubygems: Fixing Ruby Setup"
gem install bundler

echo "--- :rubygems: Setting up Gems"
install_gems

echo "--- Verify BUILDKITE_ANALYTICS_TOKEN"
if [ -z "$BUILDKITE_ANALYTICS_TOKEN" ]; then
  # This should not run because of the `-u` in the shebang, but just in case...
  echo "+++ Token not available!"
  exit 1
else
  echo "+++ Test Analytics token found, moving on"
fi

echo "--- :hammer_and_wrench: Building for testing"
bundle exec fastlane build_for_testing

echo "--- Hack to pass token to the xctestrun"
# TODO: In real life, the env var name, value, and xctestrun path should be
# parameters read or injected from somewhere
/usr/libexec/PlistBuddy -c \
  "add TestPressTests:EnvironmentVariables:BUILDKITE_ANALYTICS_TOKEN string $BUILDKITE_ANALYTICS_TOKEN" \
  ./DerivedData/Build/Products/TestPress_iphonesimulator15.5-x86_64.xctestrun

echo "--- :microscope: Running unit tests"
bundle exec fastlane test_without_building
