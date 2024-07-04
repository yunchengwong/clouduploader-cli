#!/usr/bin/env bats

sudo apt-get install bats

# Load helper functions
load 'test_helper/bats-support/load'
load 'test_helper/bats-assert/load'

setup() {
    PROJECT="test-project"
    OBJECT="test-object"
    BUCKET="${PROJECT}-bucket"
}

@test "Error when no object specified" {
    run ./clouduploader.sh
    [ "$status" -ne 0 ]
    assert_output --partial "Error: No object specified."
}

@test "Error when object does not exist" {
    run ./clouduploader.sh non_existing_file
    [ "$status" -ne 0 ]
    assert_output --partial "Error: The object \"non_existing_file\" does not exist in current directory"
}

@test "Error when object already exists in bucket" {
    run gcloud storage cp dummy_file gs://$BUCKET/$OBJECT
    run ./clouduploader.sh dummy_file
    [ "$status" -ne 0 ]
    assert_output --partial "Error: The object \"dummy_file\" already exists in the bucket \"$BUCKET\""
}

@test "Warning when bucket does not exist" {
    run gcloud storage rm -r gs://$BUCKET
    run ./clouduploader.sh dummy_file
    assert_output --partial "Warning: The bucket \"$BUCKET\" does not exist."
}

@test "Warning when uploading a directory" {
    run mkdir -p dummy_directory
    run ./clouduploader.sh dummy_directory
    assert_output --partial "Warning: This operation will upload all files in the directory \"dummy_directory\""
}

@test "Error when invalid bucket name is provided" {
    run ./clouduploader.sh dummy_file --bucket=invalid_bucket_name
    [ "$status" -ne 0 ]
    assert_output --partial "Invalid value for field 'bucket': Invalid bucket name"
}

# Cleanup after tests
teardown() {
    rm -rf dummy_file dummy_directory
    gcloud storage rm -r gs://$BUCKET/$OBJECT
}

