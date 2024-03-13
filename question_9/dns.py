#! /bin/python

import boto3

def dns_update(zone_id, record_name, new_value):
    
    try:
        # AWS Route 53 boto client
        client = boto3.client('route53')

        # retrieve current DNS record
        response = client.list_resource_record_sets(
            HostedZoneId=zone_id,
            StartRecordName=record_name,
            StartRecordType='A',
            MaxItems='1'
        )

        # Extract the current DNS record details
        record_set = response['ResourceRecordSets'][0]
        current_value = record_set['ResourceRecords'][0]['Value']
        ttl = record_set['TTL']

        # Construct the new DNS record
        new_record = {
            'Value': new_value
        }

        # Update the DNS record
        response = client.change_resource_record_sets(
            HostedZoneId=zone_id,
            ChangeBatch={
                'Changes': [
                    {
                        'Action': 'UPSERT',
                        'ResourceRecordSet': {
                            'Name': record_name,
                            'Type': 'A',
                            'TTL': ttl,
                            'ResourceRecords': [new_record]
                        }
                    }
                ]
            }
        )

        print(f"DNS record for {record_name} updated successfully.")
        return True

    except Exception as e:
        print(f"Failed to update DNS record for {record_name}: {e}")
        return False

if __name__ == "__main__":
    zone_id = 'meta'
    record_name = 'meta.com'
    new_value = '192.168.1.255'

    # Update the DNS record
    dns_update(zone_id, record_name, new_value)
