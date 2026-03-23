from ....session import BotoSessionManager
import logging

class EC2Service:
    """
    Service wrapper for EC2 operations.
    """
    def __init__(self, session_manager: BotoSessionManager):
        self.client = session_manager.get_client('ec2')
        self.logger = logging.getLogger(__name__)

    def list_instances(self, state_filter=['running']):
        """
        List instances filtered by state.
        """
        try:
            filters = [{'Name': 'instance-state-name', 'Values': state_filter}]
            response = self.client.describe_instances(Filters=filters)
            instances = []
            for reservation in response.get('Reservations', []):
                for instance in reservation.get('Instances', []):
                    instances.append({
                        'InstanceId': instance.get('InstanceId'),
                        'InstanceType': instance.get('InstanceType'),
                        'State': instance.get('State', {}).get('Name'),
                        'PublicIp': instance.get('PublicIpAddress'),
                        'Tags': instance.get('Tags', [])
                    })
            return instances
        except Exception as e:
            self.logger.error(f"Error listing EC2 instances: {e}")
            raise

    def get_instance_status(self, instance_id):
        try:
            response = self.client.describe_instance_status(InstanceIds=[instance_id])
            statuses = response.get('InstanceStatuses', [])
            if statuses:
                return statuses[0]
            return None
        except Exception as e:
            self.logger.error(f"Error getting status for {instance_id}: {e}")
            return None
