#!/usr/bin/env bats

@test "can list all" {
  asdf list all gitui
}

@test "can install latest" {
  asdf install gitui latest
}

@test "can install 0.25.2" {
  asdf install gitui 0.25.2
  asdf list gitui
}

@test "can install 0.26.2" {
  asdf install gitui 0.26.2
  asdf list gitui
}
