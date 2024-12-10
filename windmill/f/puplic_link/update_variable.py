import wmill

def main(selfhost: bool, supabase_url:str, supabase_service_key:str):
    try:
        if selfhost:
            wmill.set_variable("f/page/windmill_path",'http://localhost/apps/get/f/')
        else:
            wmill.set_variable("f/page/windmill_path",'https://app.windmill.dev/apps/get/f/')

        wmill.set_variable("f/info_page/supabase_url", supabase_url)
        wmill.set_variable("f/info_page/supabase_service_key", supabase_service_key)
        return "success"
    except Exception:
        return  'Error, please try again'