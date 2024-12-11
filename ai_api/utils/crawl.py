from joblib import Parallel, delayed
import requests
from bs4 import BeautifulSoup


def crawl_vnexpress(url):
    # Gửi request đến trang web
    response = requests.get(url)
    response.raise_for_status()  # Kiểm tra nếu request thành công

    # Phân tích nội dung HTML
    soup = BeautifulSoup(response.text, "html.parser")

    # Tìm tất cả các thẻ h1 có class="title-detail"
    title_of_article = soup.find("h1", class_="title-detail")
    if title_of_article is None:
        return None
    title_of_article = title_of_article.text

    description_of_article = soup.find("p", class_="description").text

    # Tìm thẻ article có class="fck_detail"
    article = soup.find("article", class_="fck_detail")

    # Lấy nội dung các thẻ p bên trong thẻ article
    paragraphs = article.find_all("p")
    detail_of_article = [p.text for p in paragraphs]
    detail_of_article.pop().strip()

    detail_of_article = " ".join(detail_of_article)

    return {
        "title": title_of_article,
        "description": description_of_article,
        "content": detail_of_article,
    }

def crawl_dantri(url):
    # Gửi request đến trang web
    response = requests.get(url)
    response.raise_for_status()  # Kiểm tra nếu request thành công

    # Phân tích nội dung HTML
    soup = BeautifulSoup(response.text, "html.parser")

    title_of_article = soup.find("h1", class_="title-page").text
    description_of_article = soup.find("h2", class_="singular-sapo").text

    article = soup.find("div", class_="singular-content")

    paragraphs = article.find_all("p")
    detail_of_article = [p.text for p in paragraphs]

    detail_of_article = " ".join(detail_of_article)

    return {
        "title": title_of_article,
        "description": description_of_article,
        "content": detail_of_article,
    }

def crawl_vietnamnet(url):
    # Gửi request đến trang web
    response = requests.get(url)
    response.raise_for_status()  # Kiểm tra nếu request thành công

    # Phân tích nội dung HTML
    soup = BeautifulSoup(response.text, "html.parser")

    title_of_article = soup.find("h1", class_="content-detail-title").text
    description_of_article = soup.find("h2", class_="content-detail-sapo").text

    article = soup.find("div", class_="maincontent")

    paragraphs = article.find_all("p")
    detail_of_article = [p.text for p in paragraphs]

    detail_of_article = " ".join(detail_of_article)

    return {
        "title": title_of_article,
        "description": description_of_article,
        "content": detail_of_article,
    }

def crawl_thanhnien(url):
    # Gửi request đến trang web
    response = requests.get(url)
    response.raise_for_status()  # Kiểm tra nếu request thành công

    # Phân tích nội dung HTML
    soup = BeautifulSoup(response.text, "html.parser")

    title_of_article = soup.find("h1", class_="detail-title").text
    description_of_article = soup.find("h2", class_="detail-sapo").text

    article = soup.find("div", class_="detail-cmain")

    paragraphs = article.find_all("p")
    detail_of_article = [p.text for p in paragraphs]

    detail_of_article = " ".join(detail_of_article)

    return {
        "title": title_of_article,
        "description": description_of_article,
        "content": detail_of_article,
    }

def crawl_tuoitre(url):
    # Gửi request đến trang web
    response = requests.get(url)
    response.raise_for_status()  # Kiểm tra nếu request thành công

    # Phân tích nội dung HTML
    soup = BeautifulSoup(response.text, "html.parser")

    title_of_article = soup.find("h1", class_="detail-title").text
    description_of_article = soup.find("h2", class_="detail-sapo").text

    article = soup.find("div", class_="detail-content")

    paragraphs = article.find_all("p")
    detail_of_article = [p.text for p in paragraphs]

    detail_of_article = " ".join(detail_of_article)

    return {
        "title": title_of_article,
        "description": description_of_article,
        "content": detail_of_article,
    }

def define_and_crawl(url):
    if "vnexpress" in url:
        return crawl_vnexpress(url)
    elif "dantri" in url:
        return crawl_dantri(url)
    elif "vietnamnet" in url:
        return crawl_vietnamnet(url)
    elif "thanhnien" in url:
        return crawl_thanhnien(url)
    elif "tuoitre" in url:
        return crawl_tuoitre(url)
    else:
        return None

def find_vnexpress(keyword, maximum=5):
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

