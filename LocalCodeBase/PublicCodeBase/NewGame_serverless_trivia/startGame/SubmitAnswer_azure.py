import json
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
        req_body = req.get_json()
        session_id = req_body['session_id']
        question_id = req_body['question_id']
        user_answer = req_body['answer'].strip()
        
        # Get session from Cosmos DB
        item = container.read_item(item=session_id, partition_key=session_id)
        
        answered = item.get('answered', [])
        questions = load_questions()
        correct_answer = questions.get(question_id, {}).get('answer')
        
        if not correct_answer:
            raise Exception('Invalid question ID')
        
        score = item.get('score', 0)
        is_correct = user_answer.lower() == correct_answer.lower()
        
        if is_correct and question_id not in answered:
            score += 1
            answered.append(question_id)
        
        # Update session in Cosmos DB
        item['score'] = score
        item['answered'] = answered
        container.upsert_item(item)
        
        return func.HttpResponse(
            json.dumps({
                'correct': is_correct,
                'score': int(score)
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