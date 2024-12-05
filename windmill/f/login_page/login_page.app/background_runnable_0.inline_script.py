import requests
from supabase import create_client, Client
import wmill

url = wmill.get_variable("f/info_page/supabase_url")
key = wmill.get_variable("f/info_page/supabase_service_key")
supabase: Client = create_client(url, key)


from fastapi.responses import RedirectResponse


def handle_login(username, password):
    response = (
        supabase.table("accounts")
        .select("*")
        .eq("email", username)
        .eq("pass", password)
        .execute()
    )        
    if not response.data:
        print("Request thất bại với mã lỗi")
    else:
        if(response.data[0]['id_role'] == 2):
            url_profile = 'https://app.windmill.dev/apps/get/f/info_page/info_page_volunteer?id_user=' + str(response.data[0]['id'])
            return url_profile
        if(response.data[0]['id_role'] == 3):
            url_profile = 'https://app.windmill.dev/apps/get/f/info_page/info_page_organization?id_user=' + str(response.data[0]['id'])
            return url_profile
def main(email: str,pass1: str):
    return handle_login(email,pass1)
