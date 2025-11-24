#!/bin/bash
set -e  # Exit on any error

# Clean up old zips
rm -f StartGame.zip Questions.zip SubmitAnswer.zip

# Create zip files including dependencies
echo "Creating zip files..."
zip -q StartGame.zip StartGame.py
zip -q Questions.zip Questions.py questions_loader.py
zip -q SubmitAnswer.zip SubmitAnswer.py questions_loader.py

# Function to update lambda with timeout
update_lambda() {
    local func_name=$1
    local zip_file=$2
    echo "Updating $func_name..."
    timeout 60 aws lambda update-function-code \
        --function-name "$func_name" \
        --zip-file "fileb://$zip_file" \
        --region us-west-2 \
        --output text > /dev/null
    if [ $? -eq 0 ]; then
        echo "✓ $func_name updated successfully"
    else
        echo "✗ Failed to update $func_name"
        exit 1
    fi
}

# Update Lambda functions
update_lambda "StartGame" "StartGame.zip"
update_lambda "Questions" "Questions.zip"
update_lambda "SubmitAnswer" "SubmitAnswer.zip"

# Upload to S3
echo "Uploading files to S3..."
timeout 30 aws s3 cp home.html s3://serverless-trivia-game
timeout 30 aws s3 cp questions.json s3://serverless-trivia-game
echo "✓ All deployments completed successfully"