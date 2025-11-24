import json
import os
from azure.storage.blob import BlobServiceClient

# Azure Blob Storage configuration
connection_string = os.environ['AZURE_STORAGE_CONNECTION_STRING']
container_name = 'trivia-questions'
blob_name = 'questions.json'

# Cache questions to avoid repeated calls
QUESTIONS_CACHE = None

def load_questions():
    global QUESTIONS_CACHE
    if QUESTIONS_CACHE is None:
        blob_service_client = BlobServiceClient.from_connection_string(connection_string)
        blob_client = blob_service_client.get_blob_client(
            container=container_name, 
            blob=blob_name
        )
        blob_data = blob_client.download_blob()
        QUESTIONS_CACHE = json.loads(blob_data.readall())
    return QUESTIONS_CACHE