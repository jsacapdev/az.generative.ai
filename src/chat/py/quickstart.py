import os
import openai

openai.api_type = "azure"
openai.api_base = os.getenv("AZURE_OPENAI_ENDPOINT")
openai.api_version = "2023-07-01-preview"
openai.api_key = os.getenv("AZURE_OPENAI_KEY")

chat_completion_messages = [
    # {"role": "system", "content": "You are a helpful assistant."},
    {"role": "system", "content": "Assistant is a large language model trained by OpenAI."},
    # {"role": "user", "content": "Does Azure OpenAI support customer managed keys?"},
    # {"role": "assistant", "content": "Yes, customer managed keys are supported by Azure OpenAI."},
    # {"role": "user", "content": "Do other Azure AI services support this too?"},
    {"role": "user", "content": "Are Arsenal a football club?"},
    {"role": "assistant",
        "content": "Yes, Arsenal FC are a soccer club that play in the Premier League."},
    {"role": "user", "content": "How many times have Arsenal won the F.A. Cup?"},
    # {"role": "user", "content": "Are Arsenal likely to win the Premier League this year?"},
    # {"role": "user", "content": "Are Arsenal playing in the Champions League tonight?"},
]

chat_engine = "gpt-35-turbo"

response = openai.ChatCompletion.create(
    engine=chat_engine,
    messages=chat_completion_messages,
    temperature=0.7,
    max_tokens=800,
    top_p=0.95,
    frequency_penalty=0,
    presence_penalty=0,
    stop=None)

print(response)
print(response['choices'][0]['message']['content'])

print("!!!")
