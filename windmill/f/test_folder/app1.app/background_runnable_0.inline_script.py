# import wmill
from supabase import create_client, Client


def main():
    url = "https://pgtqxwktdlbvlixlobis.supabase.co"
    key = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBndHF4d2t0ZGxidmxpeGxvYmlzIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTczMTMzMzQ2NiwiZXhwIjoyMDQ2OTA5NDY2fQ.rxv6Nff4vMBHrjC_9FIL7ZWdK7CaoILNYBN1XinjBhQ"
    supabase: Client = create_client(url, key)

    response = supabase.table("book").select("*").execute()

    return response.data
