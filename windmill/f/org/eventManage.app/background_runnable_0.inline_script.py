# import wmill
from supabase import create_client, Client
import wmill

def main(x: str):
    url = wmill.get_variable("f/info_page/supabase_url")
    key = wmill.get_variable("f/info_page/supabase_service_key")
    supabase: Client = create_client(url, key)
    response = supabase.rpc('get_amount_vlr_by_org', {"org_id": x}).execute()
    return response.data