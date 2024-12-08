# import wmill
from supabase import create_client, Client
import wmill

def main(id_evt: str):
    url = wmill.get_variable("f/info_page/supabase_url")
    key = wmill.get_variable("f/info_page/supabase_service_key")
    supabase: Client = create_client(url, key)
    response = supabase.rpc('get_data_event_by_id', {"id_evt": id_evt}).execute()
    return response.data[0]
