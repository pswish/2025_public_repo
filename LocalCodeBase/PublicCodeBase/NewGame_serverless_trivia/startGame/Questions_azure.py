import json
import random
import azure.functions as func
from azure.cosmos import CosmosClient
from questions_loader_azure import load_questions
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
        session_id = req.params.get('session_id')
        if not session_id:
            return func.HttpResponse(
                json.dumps({'error': 'session_id parameter required'}),
                status_code=400,
                headers={'Content-Type': 'application/json'}
            )
        
        # Load questions from Blob Storage
        questions = load_questions()
        
        # Randomly select a question
        question_id = random.choice(list(questions.keys()))
        question_text = questions[question_id]["question"]
        
        # Update current_question in Cosmos DB
        container.upsert_item({
            'id': session_id,
            'session_id': session_id,
            'current_question': question_id
        })
        
        return func.HttpResponse(
            json.dumps({
                'question_id': question_id,
                'question': question_text
            }),
            status_code=200,
            headers={'Content-Type': 'application/json'}
        )
    except Exception as e:
        return func.HttpResponse(
            json.dumps({'error': str(e)}),
            status_code=500,
            headers={'Content-Type': 'application/json'}
        )