#!/usr/bin/env python
import json
import boto3

def get_ec2_by_tag(tag_key, tag_value):
    ec2_client = boto3.client('ec2')

    response = ec2_client.describe_instances(
        Filters=[
            { 'Name': 'instance-state-name', 'Values': ['running'] },
            { 'Name': f'tag:{tag_key}', 'Values': [tag_value] }
        ]
    )

    instances = []
    reservations = response['Reservations']
    for reservation in reservations:
        instances.extend(reservation['Instances'])

    return instances


def get_public_ip_by_role(role: str) -> str:
    return get_ec2_by_tag("Role", role)[0]['PublicIpAddress']

def get_private_ip_by_role(role: str) -> str:
    return get_ec2_by_tag("Role", role)[0]['PrivateIpAddress']


def main():

    inventory = {
        'node': {
            'hosts': [get_public_ip_by_role('node')], 
            'vars': { 'ansible_user': 'ec2-user','ansible_ssh_private_key_file': './cks.pem', 'ansible_ssh_common_args': '-o StrictHostKeyChecking=no'}
        },
        'prometheus': {
            'hosts': [get_public_ip_by_role('prometheus')], 
            'vars': { 'ansible_user': 'ec2-user','ansible_ssh_private_key_file': './cks.pem', 'ansible_ssh_common_args': '-o StrictHostKeyChecking=no', 
                      'node_ip': get_private_ip_by_role('node')}
        },
        'grafana': {
            'hosts': [get_public_ip_by_role('grafana')], 
            'vars': { 'ansible_user': 'ec2-user','ansible_ssh_private_key_file': './cks.pem', 'ansible_ssh_common_args': '-o StrictHostKeyChecking=no', 
                      'prometheus_ip': get_private_ip_by_role('prometheus')}
        }
    }

    print(json.dumps(inventory, indent=2))

if __name__ == '__main__':
    main()