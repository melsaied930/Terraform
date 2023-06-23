#!/bin/bash

username="mohamed"
password="P@ssw0rd"
groupname="AdminGroup"

output=$(aws iam create-user --user-name "$username")
echo "Creating user $username successful!"

output=$(aws iam create-login-profile --user-name "$username" --password "$password" --no-password-reset-required)
echo "Set the custom password for the user $username successful!"

aws iam add-user-to-group --user-name "$username" --group-name "$groupname"
echo "Adding user $username to group successful!"

# Retrieve the account number
account_number=$(aws sts get-caller-identity --query "Account" --output text)

# Create the credentials file
cat <<EOF >"$username"_credentials.csv
User name,Password,Console sign-in URL
$username,"$password","https://$account_number.signin.aws.amazon.com/console
EOF
echo "Access key file created: '$username'_credentials.csv"

# Create the access key
output=$(aws iam create-access-key --user-name "$username")
echo "Create access keys for the user successful!"

# Extract the access key and secret key from the output using awk
ACCESS_KEY=$(echo "$output" | awk '/AccessKeyId/ {print $2}' | tr -d ',"')
SECRET_KEY=$(echo "$output" | awk '/SecretAccessKey/ {print $2}' | tr -d ',"')

# Create the access key file
cat <<EOF >"$username"_access_keys.csv
Access Key ID,Secret Access Key
$ACCESS_KEY","$SECRET_KEY
EOF
echo "Access key file created: "$username"_access_keys.csv"
echo "IAM access activated for user $username as a $groupname successful!"
