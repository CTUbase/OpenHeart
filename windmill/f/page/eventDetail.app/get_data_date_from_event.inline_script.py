# import wmill


from supabase import create_client, Client
import wmill
from datetime import datetime
def main(x: str):
    url = wmill.get_variable("f/info_page/supabase_url")
    key = wmill.get_variable("f/info_page/supabase_service_key")
    supabase: Client = create_client(url, key)
    response = supabase.rpc('get_data_event_by_id', {"id_evt": x}).execute()
    start = response.data[0]["start_date"]
    ds = datetime.fromisoformat(start)
    formatted_timestamp1 = ds.strftime("Ngày dự kiến: %Y-%m-%d   Giờ dự kiến: %H:%M:%S")
    end = response.data[0]["end_date"]
    de = datetime.fromisoformat(end)
    formatted_timestamp2 = de.strftime("Ngày dự kiến: %Y-%m-%d   Giờ dự kiến: %H:%M:%S")
    response = supabase.rpc('get_registration_count', {"event_id_input": x}).execute()
    amount = response.data
    result = {"start":formatted_timestamp1,"end":formatted_timestamp2,"amount": amount}
    return result
