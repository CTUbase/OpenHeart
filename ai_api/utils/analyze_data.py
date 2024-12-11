
from utils.crawl import *
from utils.utils import *


def analyze(url):
    article = define_and_crawl(url)

    if article is None:
        return None

    title = article['title']
    description = article['description']
    content = article['content']
    
    doc = title +  " " + description + " " + content
    tokens = create_tokens(doc)

    len_tokens = len(tokens)

    region_count = count_tokens_in_file('./sample/region.txt', tokens)
    baolu_count = count_tokens_in_file('./sample/baolu.txt', tokens)
    dichbenh_count = count_tokens_in_file('./sample/dichbenh.txt', tokens)

    region_ratio = region_count / len_tokens
    baolu_ratio = baolu_count / len_tokens
    dichbenh_ratio = dichbenh_count / len_tokens

    return {
        'article': article,        
        'ratio': [region_ratio, baolu_ratio, dichbenh_ratio]
    }

def find_location(article):
    title = article['title']
    description = article['description']
    content = article['content']

    doc = title +  " " + description + " " + content
    tokens = create_tokens(doc)
    # response = requests.get('https://raw.githubusercontent.com/CTUbase/windmill-plugins/main/model_1/sample/region.txt')
    # if response.status_code != 200:
    #     return None
    
   
    region_keywords = get_tokens_from_file('./sample/region.txt')

    found_locations = list(set(token for token in tokens if token in region_keywords and "_" in token))

    return found_locations

