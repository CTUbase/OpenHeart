from datetime import date
from supabase import create_client, Client
import wmill

url = wmill.get_variable("f/info_page/supabase_url")
key = wmill.get_variable("f/info_page/supabase_service_key")
supabase: Client = create_client(url, key)


def main(user_id: str, evt_id: str):
    response = (
        supabase.table("registrations")
        .insert({"event_id": evt_id, "volunteer_id": user_id, "status": "Tham gia"})
        .execute()
    )
    return response