from ..core.session import BotoSessionManager
import logging
import os

class S3Service:
    """
    Service wrapper for S3 operations.
    """
    def __init__(self, session_manager: BotoSessionManager):
        self.client = session_manager.get_client('s3')
        self.logger = logging.getLogger(__name__)

    def list_buckets(self):
        try:
            response = self.client.list_buckets()
            return [bucket['Name'] for bucket in response.get('Buckets', [])]
        except Exception as e:
            self.logger.error(f"Error listing buckets: {e}")
            raise

    def upload_file(self, file_path, bucket_name, object_name=None):
        if object_name is None:
            object_name = os.path.basename(file_path)
        try:
            self.client.upload_file(file_path, bucket_name, object_name)
            self.logger.info(f"Uploaded {file_path} to {bucket_name}/{object_name}")
            return True
        except Exception as e:
            self.logger.error(f"Upload failed: {e}")
            return False

    def download_file(self, bucket_name, object_name, file_path):
        try:
            self.client.download_file(bucket_name, object_name, file_path)
            self.logger.info(f"Downloaded {bucket_name}/{object_name} to {file_path}")
            return True
        except Exception as e:
            self.logger.error(f"Download failed: {e}")
            return False
