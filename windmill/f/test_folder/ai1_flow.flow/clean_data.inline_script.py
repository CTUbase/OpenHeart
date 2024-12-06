def main(data):
    cleaned_data = set()

    for entry in data:
        if isinstance(entry, list):  # Chỉ xử lý nếu phần tử là danh sách
            cleaned_data.update(entry)

    return sorted(cleaned_data)
