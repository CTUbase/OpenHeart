# import wmill

from datetime import datetime
def main(x: str):
    ds = datetime.fromisoformat(x)
    formatted_timestamp1 = ds.strftime("%Y-%m-%d %H:%M:%S")
    return formatted_timestamp1
