#!/usr/bin/env bats

help() {
  bash "${BATS_TEST_DIRNAME}"/../dotbare fupgrade -h
}

invalid_option() {
  bash "${BATS_TEST_DIRNAME}"/../dotbare fupgrade -p
}

upgrade() {
  bash "${BATS_TEST_DIRNAME}"/../dotbare fupgrade
}

@test "fupgrade help" {
  run help
  [ "${status}" -eq 0 ]
  [ "${lines[0]}" = "Usage: dotbare fupgrade [-h] ..." ]
}

@test "fupgrade invliad option" {
  run invalid_option
  [ "${status}" -eq 1 ]
  [ "${lines[0]}" = "Invalid option: -p" ]
}

@test "fupgrade upgrade" {
  dotbare_version="$(git describe --tags $(git rev-list --tags --max-count=1))"
  run upgrade
  [ "${status}" -eq 0 ]
  [ "${lines[0]}" = "Updating dotbare ..." ]
  [[ "${output}" =~ "dotbare updated successfully" ]]
  [[ "${output}" =~ "Current dotbare version: ${dotbare_version}" ]]
}
