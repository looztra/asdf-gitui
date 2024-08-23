#!/usr/bin/env bats
# shellcheck disable=SC2034
BATS_TEST_FILENAME_BASENAME=$(basename "${BATS_TEST_FILENAME}")
# bats file_tags=type:features

@test "can list all" {
  asdf list all gitui
}

@test "can install latest [${BATS_TEST_FILENAME_BASENAME}]" {
  asdf install gitui latest
}

@test "can install 0.25.2 [${BATS_TEST_FILENAME_BASENAME}]" {
  asdf install gitui 0.25.2
  asdf list gitui
}

@test "can install 0.26.2 [${BATS_TEST_FILENAME_BASENAME}]" {
  asdf install gitui 0.26.2
  asdf list gitui
}
