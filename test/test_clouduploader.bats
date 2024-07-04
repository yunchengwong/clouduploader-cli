#!/usr/bin/env bats

# Load helper functions
load 'test_helper/bats-support/load'
load 'test_helper/bats-assert/load'

setup() {
    # create example.txt
    PROJECT=$(gcloud config get project)
    
    INVALID_BUCKET="goog-invalid-bucket"
    VALID_BUCKET="$PROJECT-bucket"
}


@test "upload fail on empty argument" {
    run clouduploader
    assert_output --partial "Usage" # line 108

    [ "$status" -eq 0 ]
}

@test "upload fail on user confirmation to object details" {
    run bash -c 'echo -e "q\n" | clouduploader example'
    refute_output --partial "Creating"
    refute_output --partial "Uploading"

    assert_output --partial "cancelled" # line 120
}

@test "upload fail on invalid object" {
    run bash -c 'echo -e "q\n\n" | clouduploader example'
    assert_output --partial "No such file or directory"

    assert_output --partial "cancelled"
}

@test "upload success on new invalid object" {
    run bash -c 'echo -e "example.txt\n\n" | clouduploader example'
    assert_output --partial "No such file or directory"

    assert_output --partial "completed"
}


teardown() {
    # rm example.txt
    if gcloud storage ls gs://$VALID_BUCKET >/dev/null 2>&1; then
        gcloud storage rm -r gs://$VALID_BUCKET
    fi
}
