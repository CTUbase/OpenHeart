from supabase import create_client, Client
import wmill

url = wmill.get_variable("f/info_page/supabase_url")
key = wmill.get_variable("f/info_page/supabase_service_key")
supabase: Client = create_client(url, key)


def main(user_id: str):
    response = (
        supabase.table("organizations")
        .select("id", "name", "image")
        .eq("id_account", user_id)
        .execute()
    )
    if not response.data:
        return "err fetching data"
    else:
        return response.data
