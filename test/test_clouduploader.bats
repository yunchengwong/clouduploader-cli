#!/usr/bin/env bats

# Load helper functions
load 'test_helper/bats-support/load'
load 'test_helper/bats-assert/load'

setup() {
    PROJECT=$(gcloud config get project)
    OBJECT="dummy_file"
    INVALID_BUCKET="goog-invalid-bucket"
    VALID_BUCKET="$PROJECT-bucket"
}

@test "can run our script" {
    run clouduploader $OBJECT
    assert_output --partial "complete"
}

teardown() {
    rm -rf dummy_file dummy_directory
    gcloud storage rm -r gs://$VALID_BUCKET
}
