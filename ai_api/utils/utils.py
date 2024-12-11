from pyvi import ViTokenizer, ViPosTagger
import string
import os
import requests

def create_tokens(doc) -> list:
    """
    Tạo danh sách các token từ một văn bản cho trước.
    
    :param doc: Văn bản đầu vào
    """

    doc = ViTokenizer.tokenize(doc) 
    doc = doc.lower() 
    tokens = doc.split()
    table = str.maketrans('', '', string.punctuation.replace("_", "")) 
    tokens = [w.translate(table) for w in tokens]
    tokens = [word for word in tokens if word]
    
    # response = requests.get('https://raw.githubusercontent.com/CTUbase/windmill-plugins/main/model_1/sample/stopwords.txt')
    # if response.status_code != 200:
    #     return None
    
    stopwords = get_tokens_from_file('./sample/stopwords.txt')

    tokens = [word for word in tokens if word not in stopwords and not word.isdigit()]
    tokens = [word for word in tokens if len(word) > 2]
    return tokens


def count_tokens_in_file(file_path, tokens) -> int:

    """
    Đếm số lần xuất hiện của các tokens trong file.

    :param file_path: Đường dẫn đến file chứa các tokens.
    
    """

    if not os.path.exists(file_path):
        return 0
    with open(file_path, 'r', encoding='utf-8') as file:
        file_tokens = set(line.strip() for line in file.readlines())
    return sum(1 for token in tokens if token in file_tokens)


def get_tokens_from_url(url):
    response = requests.get(url)
    if response.status_code != 200:
        return None

    return set(response.text.splitlines())

def get_tokens_from_file(file_path):
    if not os.path.exists(file_path):
        return None
    with open(file_path, 'r', encoding='utf-8') as file:
        return set(line.strip() for line in file.readlines())

def count_tokens_in_url(url, tokens):
    keywords = get_tokens_from_url(url)

    count = 0
    for token in tokens:
        if token in keywords:
            count += 1

    return count
