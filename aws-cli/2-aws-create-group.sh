#!/bin/bash

# Set the desired group name
group_name="AdminGroup"

# Create the group
output=$(aws iam create-group --group-name "$group_name")
echo "User group '$group_name' created successfully."

# Attach AdministratorAccess policy to the group
output=$(aws iam attach-group-policy --group-name "$group_name" --policy-arn "arn:aws:iam::aws:policy/AdministratorAccess")
echo "Attach AdministratorAccess for '$group_name' created successfully."
