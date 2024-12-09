import requests
from pyvi import ViTokenizer
import string


def get_tokens_from_url(url):
    response = requests.get(url)
    if response.status_code != 200:
        return None

    return set(response.text.splitlines())


def count_tokens_in_url(url, tokens):
    keywords = get_tokens_from_url(url)

    count = 0
    for token in tokens:
        if token in keywords:
            count += 1

    return count


def create_tokens(doc) -> list:
    doc = ViTokenizer.tokenize(doc)
    doc = doc.lower()
    tokens = doc.split()
    table = str.maketrans("", "", string.punctuation.replace("_", ""))
    tokens = [w.translate(table) for w in tokens]
    tokens = [word for word in tokens if word]
    stopwords = get_tokens_from_url(
        "https://raw.githubusercontent.com/NguyenDoanHoangPhuc/txt_for_ai/main/stopwords.txt"
    )

    tokens = [word for word in tokens if word not in stopwords and not word.isdigit()]
    tokens = [word for word in tokens if len(word) > 2]
    return tokens


def main(article):
    if article is None:
        return None

    title = article["title"]
    description = article["description"]
    content = article["content"]

    doc = title + " " + description + " " + content
    tokens = create_tokens(doc)

    len_tokens = len(tokens)

    region_count = count_tokens_in_url(
        "https://raw.githubusercontent.com/NguyenDoanHoangPhuc/txt_for_ai/main/region.txt",
        tokens,
    )
    baolu_count = count_tokens_in_url(
        "https://raw.githubusercontent.com/NguyenDoanHoangPhuc/txt_for_ai/main/bao_lu.txt",
        tokens,
    )
    dichbenh_count = count_tokens_in_url(
        "https://raw.githubusercontent.com/NguyenDoanHoangPhuc/txt_for_ai/main/dich_benh.txt",
        tokens,
    )

    region_ratio = region_count / len_tokens
    baolu_ratio = baolu_count / len_tokens
    dichbenh_ratio = dichbenh_count / len_tokens

    doc = title + " " + description + " " + content
    tokens = create_tokens(doc)
   
    region_keywords = get_tokens_from_url("https://raw.githubusercontent.com/NguyenDoanHoangPhuc/txt_for_ai/main/region.txt")

    found_locations = list(
        set(token for token in tokens if token in region_keywords and "_" in token)
    )

    return {
        "article": article,
        "ratio": [region_ratio, baolu_ratio, dichbenh_ratio],
        "locations": found_locations,
    }
