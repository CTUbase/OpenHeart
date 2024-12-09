from supabase import create_client, Client
import wmill
import json
def main():
    url = wmill.get_variable("f/info_page/supabase_url")
    key = wmill.get_variable("f/info_page/supabase_service_key")
    supabase: Client = create_client(url, key)
    response = supabase.table("gender_view").select("*").execute()
    return response.data