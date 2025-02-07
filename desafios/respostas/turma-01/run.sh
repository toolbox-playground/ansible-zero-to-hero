#!/bin/bash

# Ensure the inventory is updated before running the playbook
ansible-inventory -i inventory/aws_ec2.yaml --list > /dev/null 2>&1

# Run the playbook
ansible-playbook -i inventory/aws_ec2.yaml playbook.yml --ask-vault-pass