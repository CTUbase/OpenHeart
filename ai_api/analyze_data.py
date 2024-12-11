import requests
from pyvi import ViTokenizer, ViPosTagger
import string
from utils.utils import *
from utils.crawl import *

def create_tokens(doc) -> list:
    doc = ViTokenizer.tokenize(doc) 
    doc = doc.lower() 
    tokens = doc.split()
    table = str.maketrans('', '', string.punctuation.replace("_", "")) 
    tokens = [w.translate(table) for w in tokens]
    tokens = [word for word in tokens if word]
    stopwords = get_tokens_from_file('./sample/stopwords.txt')
    tokens = [word for word in tokens if word not in stopwords]
    return tokens




def count_tokens(check_tokens, tokens):
    count = 0
    for token in tokens:
        if token in check_tokens:
            count += 1
    return count

def count_partial_tokens(check_tokens, tokens):
    count = 0
    for token in tokens:
        for check_token in check_tokens:
            if check_token in token:
                count += 1
                break  # Stop checking other check_tokens for this token
    return count

def first_appearance_index(test_token_list, context):
    for idx, test_token in enumerate(test_token_list):
        count = count_tokens(test_token, context)
        if count > 0:
            return idx+1
    return 0

def appearance_array(test_token_list, context):
    appearance = []
    for test_token in test_token_list:
        count = count_tokens(test_token, context)
        appearance.append(count)
    return appearance


def remove_tokens(tokens, check_tokens):
    for token in tokens:
        if token in check_tokens:
            tokens.remove(token)
    return tokens


def create_input(article):

    # Lấy token từ url tương ứng trên repo github
    people_death_tokens = get_tokens_from_file('./sample/people_death_keywords.txt')
    people_injuries_tokens = get_tokens_from_file('./sample/people_injuries_keywords.txt')
    large_property_tokens = get_tokens_from_file('./sample/property_large_keywords.txt')
    average_property_tokens = get_tokens_from_file('./sample/property_medium_keywords.txt')
    small_property_tokens = get_tokens_from_file('./sample/property_small_keywords.txt')
    serious_keyword_tokens = get_tokens_from_file('./sample/serious_keywords.txt')

    # Khởi tạo dữ liệu ban đầu
    data = {
        'deaths': 0,
        'injuries': 0,
        'property': [],
        'keyword': 0
    }
    
    tokens = create_tokens(article)

    # Xử lý số
    number_conversion = {
        "trăm": 100,
        "ngàn": 1000,
        "nghìn": 1000,
        "vạn": 10000,
        "triệu": 1000000,
        "tỷ": 1000000000,
        "trăm_ngàn": 100000,
        "chục_ngàn": 10000,
        "chục": 10,
        "mươi": 10,
        "nhiều": 2
    }

    for idx, token in enumerate(tokens):
        if token in number_conversion:
            tokens[idx] = str(number_conversion[token])


    people_token_list = [people_death_tokens, people_injuries_tokens]
    property_token_list = [large_property_tokens, average_property_tokens, small_property_tokens]

    for token in tokens:

        if token.isdigit():
            left_context = tokens[max(0, tokens.index(token) - 2):tokens.index(token)]
            check_value = first_appearance_index(people_token_list, left_context)
            if (check_value != 0):
                if check_value == 1:
                    data['deaths'] += int(token)
                else:
                    data['injuries'] += int(token)
                remove_tokens(tokens, left_context)
                continue


            right_context = tokens[tokens.index(token) + 1:tokens.index(token) + 2]
            check_value = first_appearance_index(people_token_list, right_context)
            if (check_value != 0):
                if check_value == 1:
                    data['deaths'] += int(token)
                else:
                    data['injuries'] += int(token)
                remove_tokens(tokens, right_context)
                continue



    check_value = appearance_array(property_token_list, tokens)
    data['property'] = check_value

    filtered_tokens = [word for word in tokens if len(word) > 2]
    length = len(filtered_tokens)
    data['keyword'] = count_tokens(serious_keyword_tokens, filtered_tokens)/length

    return data
