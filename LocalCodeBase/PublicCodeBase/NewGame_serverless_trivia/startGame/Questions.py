import json
import boto3
import random
from questions_loader import load_questions


def lambda_handler(event, context):
    session_id = event['queryStringParameters']['session_id']

    # Load questions from S3
    questions = load_questions()

    # For the sake of simiplicity, we randomly select a question
    question_id = random.choice(list(questions.keys()))
    question_text = questions[question_id]["question"]

    # Update the current_question in dynamodb
    dynamodb = boto3.resource('dynamodb')
    table = dynamodb.Table('NewGameTrivia')
    table.update_item(
        Key={'session_id': session_id},
        UpdateExpression='SET current_question = :val1',
        ExpressionAttributeValues={':val1': question_id}
    )

    return {
        'statusCode': 200,
        'headers': {
            'Access-Control-Allow-Origin': '*'
        },
        'body': json.dumps({'question_id': question_id,
                            'question': question_text,
                            })
    }
