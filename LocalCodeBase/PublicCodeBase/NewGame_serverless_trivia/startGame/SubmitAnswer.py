import json
import boto3
from questions_loader import load_questions

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('NewGameTrivia')


def lambda_handler(event, context):
    try:
        data = json.loads(event['body'])
        session_id = data['session_id']
        question_id = data['question_id']
        user_answer = data['answer'].strip()
        response = table.get_item(Key={'session_id': session_id})

        if 'Item' not in response:
            raise Exception('Session not found')
        item = response['Item']
        answered = item.get('answered', [])
        questions = load_questions()
        correct_answer = questions.get(question_id, {}).get('answer')

        if not correct_answer:
            raise Exception('Invalid question ID')
        score = item.get('score', 0)
        answered = item.get('answered', [])
        is_correct = user_answer.lower() == correct_answer.lower()

        if is_correct and question_id not in answered:
            score += 1
            answered.append(question_id)

        table.update_item(
            Key={'session_id': session_id},
            UpdateExpression='SET score = :score, answered = :answered',
            ExpressionAttributeValues={
                ':score': score,
                ':answered': answered
            }
        )

        return {
            'statusCode': 200,
            'headers': {
                'Access-Control-Allow-Origin': '*'
            },
            'body': json.dumps({
                'correct': is_correct,
                'score': int(score)
            })
        }

    except Exception as e:
        return {
            'statusCode': 500,
            'headers': {'Access-Control-Allow-Origin': '*'},
            'body': json.dumps({'error': str(e)})
        }
