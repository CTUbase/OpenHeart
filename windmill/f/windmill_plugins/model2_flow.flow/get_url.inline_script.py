from joblib import Parallel, delayed
import requests
from bs4 import BeautifulSoup

def main(keyword: str, maximum:int = 5):
    def fetch_page(page):
        find_url = f"https://timkiem.vnexpress.net/?q={keyword}&media_type=all&fromdate=0&todate=0&latest=&cate_code=&search_f=title,tag_list&date_format=all&page={page}"
        response = requests.get(find_url)
        response.raise_for_status()

        soup = BeautifulSoup(response.text, "html.parser")

        articles = soup.find_all("article", class_="item-news")
        return [article.get("data-url") for article in articles if article.get("data-url")]

    results = Parallel(n_jobs=-1)(delayed(fetch_page)(i) for i in range(1, maximum + 1))
    urls = [url for sublist in results for url in sublist]
    print("Finished fetching URLs")
    return urls