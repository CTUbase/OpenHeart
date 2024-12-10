from supabase import create_client, Client
import wmill

url = wmill.get_variable("f/info_page/supabase_url")
key = wmill.get_variable("f/info_page/supabase_service_key")
supabase: Client = create_client(url, key)


def main():
    response = supabase.table("events").select("*, organizations(*)").execute()

    if not response.data:
        raise Exception("Khong the tai du lieu")
    else:
        locations = set()
        organizations = set()

        for index, event in enumerate(response.data):
            print(event)
            locations.add(event["location"])
            organizations.add(event["organizations"]["name"])

        response = {}
        response["locations"] = list(locations)
        response["organizations"] = list(organizations)

        return response
