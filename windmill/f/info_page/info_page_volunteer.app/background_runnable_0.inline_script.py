from supabase import create_client, Client
import wmill

def main():
    url = wmill.get_variable("f/info_page/supabase_url")
    key = wmill.get_variable("f/info_page/supabase_service_key")
    account_id = 1
    supabase: Client = create_client(url, key)

    response = supabase.table("accounts").select("*").eq("id", account_id).execute()
    account_data = response.data[0]

    response = supabase.table("volunteers").select("*").eq("id_account", account_id).execute()
    volunteer_data = response.data[0]

    response = supabase.table("genders").select("*").eq("id", volunteer_data['id_gender']).execute()
    gender_data = response.data[0]

    response = supabase.table("provinces").select("*").eq("code", volunteer_data['id_provinces']).execute()
    provinces_data = response.data[0]
    provinces_data["provinces_name"] = provinces_data["full_name"]
    del provinces_data["full_name"]


    result = {**volunteer_data, **gender_data, **provinces_data, **account_data}
    return result
