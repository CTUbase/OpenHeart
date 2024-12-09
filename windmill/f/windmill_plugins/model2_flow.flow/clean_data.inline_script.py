def fix_text(text):
    text = text.replace('_', ' ').title()
    return text


def main(data):
    # Tập hợp lưu trữ các địa danh đã gặp
    unique_locations = set()
    # Danh sách kết quả
    result = []

    for entry in data:
        if isinstance(entry, list):  # Chỉ xử lý các phần tử kiểu danh sách
            for pair in entry:
                # Kiểm tra nếu phần tử là danh sách và địa danh chưa xuất hiện
                if isinstance(pair, list) and pair[1] not in unique_locations:
                    unique_locations.add(pair[1])  # Đánh dấu địa danh đã gặp
                    result.append(pair)  # Thêm cặp (url, địa danh) vào kết quả

    final = []
    for e in result:
        final.append({"Địa điểm": fix_text(e[1]), "Nguồn": e[0]})

    return final
