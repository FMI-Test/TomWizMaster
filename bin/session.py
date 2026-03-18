import boto3
from botocore.exceptions import ClientError, BotoCoreError
import logging

class BotoSessionManager:
    """
    Wrapper class for managing AWS Boto3 sessions and clients.
    Centralizes error handling and logging.
    """
    def __init__(self, profile_name=None, region_name='us-east-1'):
        self.profile_name = profile_name
        self.region_name = region_name
        self.session = None
        self.logger = logging.getLogger(__name__)
        self._init_session()

    def _init_session(self):
        try:
            if self.profile_name:
                self.session = boto3.Session(profile_name=self.profile_name, region_name=self.region_name)
            else:
                self.session = boto3.Session(region_name=self.region_name)
            self.logger.info(f"AWS Session initialized. Region: {self.region_name}")
        except (ClientError, BotoCoreError) as e:
            self.logger.error(f"Failed to initialize AWS session: {e}")
            raise

    def get_client(self, service_name):
        """Returns a low-level service client."""
        try:
            return self.session.client(service_name)
        except (ClientError, BotoCoreError) as e:
            self.logger.error(f"Failed to create client for {service_name}: {e}")
            raise

    def get_resource(self, service_name):
        """Returns a high-level service resource."""
        try:
            return self.session.resource(service_name)
        except (ClientError, BotoCoreError) as e:
            self.logger.error(f"Failed to create resource for {service_name}: {e}")
            raise
