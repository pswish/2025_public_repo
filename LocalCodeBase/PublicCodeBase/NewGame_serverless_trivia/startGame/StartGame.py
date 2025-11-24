import json
import boto3
import uuid

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('NewGameTrivia')


def lambda_handler(event, context):
    user_id = event['queryStringParameters']['user_id']
    session_id = str(uuid.uuid4())
    item = {
        'session_id': session_id,
        'user_id': user_id,
        'score': 0,
        'current_question': None,
        'questions_answered': 0,
        'answered': []
    }

    table.put_item(Item=item)
    return {
        'statusCode': 201,
        'headers': {
            'Access-Control-Allow-Origin': '*'
        },
        'body': json.dumps({'session_id': session_id,
                            'message': 'New game session started!'})
    }
