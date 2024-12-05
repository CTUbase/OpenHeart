from datetime import date
from supabase import create_client, Client
import wmill
url = wmill.get_variable("f/info_page/supabase_url")
key = wmill.get_variable("f/info_page/supabase_service_key")
supabase: Client = create_client(url, key)
def create_account(email: str,pass1: str):
    response = (
        supabase.table("accounts")
        .insert({"email": email,"pass": pass1,"id_role": 2})
        .execute()
    ) 
    if not response.data:
        return 'Data not corret'
    else:
        return response.data[0]['id']
def create_volunteer(id_account: str,id_gender: str,full_name: str,brithday: str,id_provinces: str,phone: str):
    response =(
        supabase.table("volunteers")
        .insert({"id_account": id_account,"id_gender": id_gender,"full_name": full_name,"birthday": brithday,"id_provinces": id_provinces,"phone": phone})
        .execute()
    )
    if not response.data:
        return 'Data not corret'
    else:
        return 'Tạo thành công'
def main(email: str,pass1: str,id_gender: str,full_name: str,brithday: str,id_provinces: str,phone: str):
    id_acc = create_account(email,pass1)
    return create_volunteer(id_acc,id_gender,full_name,brithday,id_provinces,phone)