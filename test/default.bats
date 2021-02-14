#!/usr/bin/env bats

@test "can list all" {
  asdf list all gitui
}

@test "can install latest" {
  asdf install gitui latest
}
