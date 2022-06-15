import boto3
import time
import json

def lambda_handler(event, context):

    instance_id = event['instance_id']
    metadata_field = event['metadata_field']

    ssm = boto3.client('ssm')
    command = "curl http://169.254.169.254/latest/meta-data/" + metadata_field

    response = ssm.send_command(
        InstanceIds=[instance_id],
        DocumentName='AWS-RunShellScript',
        Parameters={
                "commands":[command]
        }
    )
    command_id = response['Command']['CommandId']
    time.sleep(15)
    output = ssm.get_command_invocation(
      CommandId=command_id,
      InstanceId=instance_id,
    )
    return output
