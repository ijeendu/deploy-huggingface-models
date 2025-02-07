# This repository contains the code I used to deploy an open source text classification model obtained from Hugging face as an end point.

The project uses the `distilbert-base-uncased-finetuned-sst-2-english`  text classification model obtained from `HuggingFace`. 

The endpoint application is built using `FastAPI` and `Docker`. `NGINX` and `Gunicorn` were used for server scaling and load balancing.




# Usage

1. **Clone the repository**
    ```
    git clone https://github.com/ijeendu/deploy-huggingface-models.git
    ```

1. **Make sure you are in the code directory**
    ``` 
    cd deploy-huggingface-models
    ```

1. **Create a new virtual environment**
    ```
    pyenv virtualenv 3.12 hf_app
    ```

1. **Activate the environment**
    ```
    pyenv activate hf_app
    ```

1. **Install the requirements file**

    ```
    pip install -r requirements.txt
    ```


1. **Start your local installation of Docker**

    If you do not have Docker installed, follow [this link](https://docs.docker.com/desktop/) to download and install the correct desktop version for your OS.


1. **Build the docker container**
    ```
    docker build -t hf-sentiment-app .
    ```

1. **Run the docker container**
    ```
    docker run -p 80:80 -p 8000:8000 --name hf_app hf-sentiment-app
    ```

1.    Go to http://0.0.0.0:8000/sentiment/ in your web browser to be sure the API is up and running


1. **Test your model on the terminal**
    Replace the input text in the following command before running

    ```
    curl -X 'POST' \                              
      'http://127.0.0.1:8000/sentiment' \
      -H 'Content-Type: application/json' \
      -d '{"input_text": "<INPUT_TEXT>"}'
    ```


1. **Test the end point using Python**

    Replace the input_text in `post_request.py` with your `test_text` and run 

    ```
    python post_request.py
    ```


