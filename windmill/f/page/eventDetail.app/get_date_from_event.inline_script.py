# import wmill


from supabase import create_client, Client
import wmill
from datetime import datetime
def main(x: str):
    url = wmill.get_variable("f/info_page/supabase_url")
    key = wmill.get_variable("f/info_page/supabase_service_key")
    supabase: Client = create_client(url, key)
    res_data_event = supabase.rpc('get_data_event_by_id', {"id_evt": x}).execute()
    start = res_data_event.data[0]["start_date"]
    ds = datetime.fromisoformat(start)
    formatted_timestamp1 = ds.strftime("%d-%m-%Y - %H:%M:%S")
    end = res_data_event.data[0]["end_date"]
    de = datetime.fromisoformat(end)
    formatted_timestamp2 = de.strftime("%d-%m-%Y - %H:%M:%S")
    res_amount = supabase.rpc('get_registration_count', {"event_id_input": x}).execute()
    amount = res_amount.data
    result = {
        "start":formatted_timestamp1,
        "end":formatted_timestamp2,
        "amount": amount
        }
    return result
