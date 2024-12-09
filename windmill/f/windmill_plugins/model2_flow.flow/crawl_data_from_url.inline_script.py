import requests
from bs4 import BeautifulSoup


def main(url):
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
