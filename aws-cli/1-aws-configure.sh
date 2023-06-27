#!/bin/bash

csv_file="rootkey.csv"

# Row number (starting from 1) containing the desired value
row_number=2
# Column number (starting from 1) containing the desired value
column_number=1
# Reade the cell value
aws_access_key_id=$(awk -F',' -v row="$row_number" -v col="$column_number" 'NR==row {print $col}' "$csv_file")

# Row number (starting from 1) containing the desired value
row_number=2
# Column number (starting from 1) containing the desired value
column_number=2
# Reade the cell value
aws_secret_access_key=$(awk -F',' -v row="$row_number" -v col="$column_number" 'NR==row {print $col}' "$csv_file")

# default_region='us-east-1'
default_region='us-west-1'
output_format='json'

echo "Value at default_region: $default_region"
echo "Value at output_format: $output_format"

# Set AWS CLI configuration
aws configure set aws_access_key_id $aws_access_key_id
aws configure set aws_secret_access_key $aws_secret_access_key
aws configure set default.region $default_region
aws configure set default.output $output_format

# Check if login is successful
output=$(aws sts get-caller-identity --output text)
echo "Check if login is successful!: '$output'"

# Display logged-in user
output=$(aws sts get-caller-identity --query 'Arn' --output text)
echo "AWS CLI login successful! '$output'"
