from supabase import create_client, Client
import wmill

def main():
    url = wmill.get_variable("f/info_page/supabase_url")
    key = wmill.get_variable("f/info_page/supabase_service_key")
    account_id = 2
    supabase: Client = create_client(url, key)

    response = supabase.table("accounts").select("*").eq("id", account_id).execute()
    account_data = response.data[0]

    response = supabase.table("organizations").select("*").eq("id_account", account_id).execute()
    organization_data = response.data[0]

    response = supabase.table("provinces").select("*").eq("code", organization_data['id_provinces']).execute()
    provinces_data = response.data[0]
    provinces_data["provinces_name"] = provinces_data["name"]
    del provinces_data["name"]


    result = {**organization_data, **provinces_data, **account_data}
    return result
