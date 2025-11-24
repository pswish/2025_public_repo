import json
import uuid
import azure.functions as func
from azure.cosmos import CosmosClient
import os

# Azure Cosmos DB configuration
endpoint = os.environ['COSMOS_DB_ENDPOINT']
key = os.environ['COSMOS_DB_KEY']
database_name = 'TriviaGame'
container_name = 'GameSessions'

client = CosmosClient(endpoint, key)
database = client.get_database_client(database_name)
container = database.get_container_client(container_name)

def main(req: func.HttpRequest) -> func.HttpResponse:
    try:
        user_id = req.params.get('user_id')
        if not user_id:
            return func.HttpResponse(
                json.dumps({'error': 'user_id parameter required'}),
                status_code=400,
                headers={'Content-Type': 'application/json'}
            )
        
        session_id = str(uuid.uuid4())
        item = {
            'id': session_id,
            'session_id': session_id,
            'user_id': user_id,
            'score': 0,
            'current_question': None,
            'questions_answered': 0,
            'answered': []
        }
        
        container.create_item(body=item)
        
        return func.HttpResponse(
            json.dumps({
                'session_id': session_id,
                'message': 'New game session started!'
            }),
            status_code=201,
            headers={'Content-Type': 'application/json'}
        )
    except Exception as e:
        return func.HttpResponse(
            json.dumps({'error': str(e)}),
            status_code=500,
            headers={'Content-Type': 'application/json'}
        )