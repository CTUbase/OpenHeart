import csv
from utils.crawl import *
from utils.utils import * 
from utils.analyze_data import *

with open('input.txt', 'r') as file:
    urls = [line.strip() for line in file.readlines()]

for url in urls: 
    # Crawl dữ liệu từ url
    
    data = analyze(url)

    article = data['article']
    ratios = data['ratio']

    # Write the ratios to a CSV file
    with open('datasets/datasets.csv', 'a', newline='', encoding='utf-8') as csvfile:
        fieldnames = ['region', 'bao_lu', 'dich_benh', 'label']
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)

        # Write the header only if the file is empty
        if csvfile.tell() == 0:
            writer.writeheader()

        writer.writerow({
            'region': ratios[0],
            'bao_lu': ratios[1],
            'dich_benh': ratios[2],
            'label': 0
        })
    
print("Succcessfully write datasets!")

