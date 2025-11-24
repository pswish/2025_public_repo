import json
import boto3

s3 = boto3.client('s3')

# Cache questions to avoid repeated S3 calls
QUESTIONS_CACHE = None
BUCKET_NAME = 'serverless-trivia-game'
QUESTIONS_KEY = 'questions.json'


def load_questions():
    global QUESTIONS_CACHE
    if QUESTIONS_CACHE is None:
        response = s3.get_object(Bucket=BUCKET_NAME, Key=QUESTIONS_KEY)
        QUESTIONS_CACHE = json.loads(response['Body'].read())
    return QUESTIONS_CACHE