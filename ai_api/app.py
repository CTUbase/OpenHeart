# app.py
from fastapi import FastAPI
from pydantic import BaseModel
from utils.crawl import *
from utils.analyze_data import *
import joblib
from joblib import Parallel, delayed
from analyze_data import *
import numpy as np
import pandas as pd
from perceptron import Perceptron

app = FastAPI()

# Khai báo mẫu request data
class InputData(BaseModel):
    keyword: str
    num_pages: int

@app.post("/getinfo")
def run_prediction(data: InputData):
    data = find_vnexpress(data.keyword, data.num_pages)

    model = joblib.load('models/trained_perceptron_model.joblib')

    location_urls = {}
    def process_url(url):

        analyzed_data = analyze(url)
        if analyzed_data is not None:
            prediction = model.predict([analyzed_data['ratio']])
            if prediction[0] == 1:
                locations = find_location(analyzed_data['article'])
                return url, locations
        return url, []

    data = Parallel(n_jobs=-1)(delayed(process_url)(url) for url in data)

    
    location_to_url = {}
    for url, locations in data:
        for loc in locations:
            # Chỉ thêm nếu location chưa từng xuất hiện
            if loc not in location_to_url:
                location_to_url[loc] = url

    # Chuyển dict sang list (location, url)
    result = [(loc, url) for loc, url in location_to_url.items()]
    return result

@app.get("/ping")
def ping():
    return "pong"


class InputData1(BaseModel):
    article: str

@app.post("/predict")
def predict(data: InputData1):
    article = data.article
    data = create_input(article)

    model = joblib.load('models/best_decision_tree_model.joblib')

    data_df = pd.DataFrame([{
        'death': data['deaths'],
        'injuries': data['injuries'],
        'property_large': data['property'][0],
        'property_medium': data['property'][1],
        'property_small': data['property'][2],
        'keyword': data['keyword']
    }])

    # Nếu bạn muốn trả về DataFrame cho mục đích debug
    result = data_df.to_dict(orient="records")

    # Ép kiểu dữ liệu numpy.int64 về int (nếu có)
    for row in result:
        for k, v in row.items():
            if isinstance(v, np.integer):
                row[k] = int(v)

    prediction = model.predict(data_df)
    return int(prediction[0])
