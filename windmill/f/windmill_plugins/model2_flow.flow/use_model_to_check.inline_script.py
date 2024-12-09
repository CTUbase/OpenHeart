def main(data, url):
    ratios = data["ratio"]
    locations = data['locations']

    weight = [0.12054469, 0.05292558, 0.01311273]
    bias = -0.019999999999999997

    calc = ratios[0] * weight[0] + ratios[1] * weight[1] + ratios[2] * weight[2] + bias
    prediction = 1 if calc >= 0 else 0

    if prediction == 1:
        result = [
            (url, location)
            for location in locations
        ]
        return result
    else:
        return None
