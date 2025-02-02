# Módulo 03 - Instalação e Configuração

## Dynamic Inventory


1.	Install Boto3 and Botocore
```
pip install boto3 botocore
```

2.	Set Up AWS CLI Credentials
```
aws configure
```

4.	Create the Inventory Configuration File
```
plugin: amazon.aws.aws_ec2
regions:
  - us-east-1  # Specify your AWS region(s)
filters:
  instance-state-name: running  # Only fetch running instances
keyed_groups:
  - key: tags.Name  # Group instances by their Name tag
```

5.	Test the Dynamic Inventory
```
ansible-inventory -i aws_ec2.yml --list
```

6.	Use the Dynamic Inventory in a Playbook
```
---
- name: Fetch EC2 Instance Information
  hosts: all
  gather_facts: no
  tasks:
    - name: Print Instance Details
      debug:
        msg: >
          Instance ID: {{ item.id }}
          Instance Type: {{ item.instance_type }}
          Private IP: {{ item.private_ip_address }}
          Tags: {{ item.tags }}
      with_items: "{{ hostvars.values() }}"
```

7.	Run the Playbook
```
ansible-playbook -i aws_ec2.yml fetch-ec2-info.yml
```