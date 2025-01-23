#!/bin/bash
echo "Uploading test files, please wait..."
for i in TESTS_DIR/*
do
    echo "Uploading ${i##*/} to BUCKET..."
    aws s3 cp --quiet "TESTS_DIR/${i##*/}" BUCKET
done
echo "Upload complete. Check Cloud Functions logs or use the get-findings command for scan results."
