from supabase import create_client, Client
import wmill

url = wmill.get_variable("f/info_page/supabase_url")
key = wmill.get_variable("f/info_page/supabase_service_key")
supabase: Client = create_client(url, key)

def main():
    response = (
        supabase.table("events")
        .select("*, organizations(*)")
        .execute()
    )        
    if not response.data:
        return "err fetching data"
    else:
        return response.data
