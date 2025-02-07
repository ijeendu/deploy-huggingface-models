from fastapi import FastAPI
from pydantic import BaseModel
from transformers import pipeline

# get model from hugging face
pipe = pipeline("text-classification", model="distilbert-base-uncased-finetuned-sst-2-english")

# define web app
app = FastAPI()

# define input class
class RequestModel(BaseModel):
    input_text: str


@app.get("/sentiment/")
def root():
    return {"message": "Sentiment Analysis Inference API is up and running!"}


# define endpoint
@app.post("/sentiment/")
def get_sentiment(request: RequestModel):
    input = request.input_text
    response = pipe(input)
    label = response[0]["label"]
    score = response[0]["score"]
    return f"The '{input}' input is classified as: {label} with a score of {score}."


