# import wmill
from supabase import create_client, Client
import wmill

def main(id_evt: str):
    url = wmill.get_variable("f/info_page/supabase_url")
    key = wmill.get_variable("f/info_page/supabase_service_key")
    supabase: Client = create_client(url, key) 
    response = (
        supabase.table("events")
        .select("id_org")
        .eq("id", id_evt)
        .execute()
    )
    id_org = response.data[0]["id_org"]
    response = (
        supabase.table("organizations")
        .select("*")
        .eq("id", id_org)
        .execute()
    )
    data_org = response.data[0]
    id_account = response.data[0]["id_account"]
    response = (
        supabase.table("accounts")
        .select("*")
        .eq("id", id_account)
        .execute()
    )
    data_account = response.data[0]
    result = {**data_org,**data_account}
    return result