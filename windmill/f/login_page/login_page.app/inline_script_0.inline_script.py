import requests
from supabase import create_client, Client
import wmill

url = wmill.get_variable("f/info_page/supabase_url")
key = wmill.get_variable("f/info_page/supabase_service_key")
supabase: Client = create_client(url, key)


def handle_login(username, password):
    if username is None or len(username) == 0:
        raise Exception("Email is required")

    if password is None or len(password) == 0:
        raise Exception("Password is required")

    response = (
        supabase.table("accounts")
        .select("*")
        .eq("email", username)
        .eq("pass", password)
        .execute()
    )
    if not response.data:
        raise Exception("Tai khoan khong hop le")
    else:
        if response.data[0]["id_role"] == 2:
            url_profile = (
                wmill.get_variable("f/page/windmill_path")
                + "page/home?user="
                + str(response.data[0]["id"])
            )
            return url_profile
        if response.data[0]["id_role"] == 3:
            url_profile = (
                wmill.get_variable("f/page/windmill_path")
                + "org/home?user="
                + str(response.data[0]["id"])
            )
            return url_profile


def main(email: str, pass1: str):
    return handle_login(email, pass1)
