import wmill
import base64
from supabase import create_client, Client
from datetime import datetime
def main(base64_data: str, file_name: str,name: str,description: str,s_date: str,e_date: str,location: str,amount: str,id_org):
# Initialize Supabase client
    SUPABASE_URL =wmill.get_variable("f/info_page/supabase_url")
    SUPABASE_KEY = wmill.get_variable("f/info_page/supabase_service_key")
    supabase: Client = create_client(SUPABASE_URL, SUPABASE_KEY)

    file_binary = base64.b64decode(base64_data) #decode b64 -> binary

# Upload to Supabase Storage
    response = supabase.storage.from_('image-events').upload(file_name, file_binary)
    url_img = "https://euchsokljjcbkuaryyco.supabase.co/storage/v1/object/public/"+response.full_path
    ds = datetime.fromisoformat(s_date)
    start_date = ds.strftime("%Y-%m-%d %H:%M:%S")
    de = datetime.fromisoformat(e_date)
    end_date = de.strftime("%Y-%m-%d %H:%M:%S")
# Insert events
    response = (
        supabase.table("events")
        .insert({"name":name,"description":description,"start_date":start_date,"end_date":end_date,"location":location,"amount": amount,"image":url_img,"id_org":id_org})
        .execute()
    )
    return response    
    