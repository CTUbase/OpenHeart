

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;


CREATE EXTENSION IF NOT EXISTS "pgsodium" WITH SCHEMA "pgsodium";






COMMENT ON SCHEMA "public" IS 'standard public schema';



CREATE EXTENSION IF NOT EXISTS "pg_graphql" WITH SCHEMA "graphql";






CREATE EXTENSION IF NOT EXISTS "pg_stat_statements" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "pgcrypto" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "pgjwt" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "supabase_vault" WITH SCHEMA "vault";






CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA "extensions";





SET default_tablespace = '';

SET default_table_access_method = "heap";


CREATE TABLE IF NOT EXISTS "public"."accounts" (
    "id" bigint NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "email" character varying,
    "pass" character varying,
    "id_role" bigint
);


ALTER TABLE "public"."accounts" OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."get_account"() RETURNS SETOF "public"."accounts"
    LANGUAGE "sql"
    AS $$
  select * from accounts;
$$;


ALTER FUNCTION "public"."get_account"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."get_account"("uid" bigint) RETURNS SETOF "public"."accounts"
    LANGUAGE "sql"
    AS $$
  select * from accounts
  where accounts.id = uid;
$$;


ALTER FUNCTION "public"."get_account"("uid" bigint) OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."get_amount_vlr_by_org"("org_id" bigint) RETURNS bigint
    LANGUAGE "plpgsql"
    AS $$DECLARE
    total_slots INT8;
BEGIN
SELECT 
    COUNT(reg.id)
INTO  total_slots
FROM 
    public.events evt
LEFT JOIN 
    public.registrations reg ON evt.id = reg.event_id
LEFT JOIN 
    public.organizations org ON evt.id_org = org.id
WHERE 
    org.id = org_id -- Thay :organization_id bằng ID của tổ chức bạn cần
GROUP BY 
    org.name;
RETURN total_slots;
END;$$;


ALTER FUNCTION "public"."get_amount_vlr_by_org"("org_id" bigint) OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."get_data_envents"() RETURNS TABLE("id" bigint, "name" "text", "description" "text", "start_date" timestamp without time zone, "end_date" timestamp without time zone, "location" "text", "amount" bigint, "image" "text", "slot" bigint, "org_name" "text", "org_provinces" character varying)
    LANGUAGE "plpgsql"
    AS $$
begin 
  return query
  SELECT 
    a.id, 
    a.name, 
    a.description, 
    a.start_date, 
    a.end_date, 
    a.location,
    a.amount, 
    a.image,
    a.slot, 
    b.name AS organization_name, 
    c.name AS provinces_name
FROM 
    events a
JOIN 
    organizations b 
ON 
    a.id_org = b.id
JOIN 
    provinces c 
ON 
    b.id_provinces = c.code;
END;
$$;


ALTER FUNCTION "public"."get_data_envents"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."get_data_event_by_id"("id_evt" integer) RETURNS TABLE("id" bigint, "name" "text", "description" "text", "start_date" timestamp without time zone, "end_date" timestamp without time zone, "location" "text", "amount" bigint, "image" "text", "slot" bigint, "org_name" "text", "org_provinces" character varying)
    LANGUAGE "plpgsql"
    AS $$
begin 
  return query
  SELECT 
    a.id, 
    a.name, 
    a.description, 
    a.start_date, 
    a.end_date, 
    a.location,
    a.amount, 
    a.image,
    a.slot, 
    b.name AS organization_name, 
    c.name AS provinces_name
FROM 
    events a
JOIN 
    organizations b 
ON 
    a.id_org = b.id
JOIN 
    provinces c 
ON 
    b.id_provinces = c.code
where a.id = id_evt;
END;
$$;


ALTER FUNCTION "public"."get_data_event_by_id"("id_evt" integer) OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."get_data_event_by_id_org"("id_evt" integer) RETURNS TABLE("id" bigint, "name" "text", "description" "text", "start_date" timestamp without time zone, "end_date" timestamp without time zone, "location" "text", "amount" bigint, "image" "text", "slot" bigint, "org_name" "text", "org_provinces" character varying)
    LANGUAGE "plpgsql"
    AS $$
begin 
  return query
  SELECT 
    a.id, 
    a.name, 
    a.description, 
    a.start_date, 
    a.end_date, 
    a.location,
    a.amount, 
    a.image,
    a.slot, 
    b.name AS organization_name, 
    c.name AS provinces_name
FROM 
    events a
JOIN 
    organizations b 
ON 
    a.id_org = b.id
JOIN 
    provinces c 
ON 
    b.id_provinces = c.code
where b.id = id_evt;
END;
$$;


ALTER FUNCTION "public"."get_data_event_by_id_org"("id_evt" integer) OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."get_data_vlr_from_event"("id_evt" integer) RETURNS TABLE("id" bigint, "hoten" "text", "birthday" "date", "phone" "text", "picpath" "text", "gender_name" character varying, "provinces_name" character varying)
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    RETURN QUERY 
    select a.id,a.full_name,a.birthday,a.phone,a."picPath",c.gender_name,d.name from volunteers a join registrations b on a.id = b.volunteer_id join genders c on a.id_gender=c.id join provinces d on a.id_provinces = d.code where b.event_id = id_evt;
END;
$$;


ALTER FUNCTION "public"."get_data_vlr_from_event"("id_evt" integer) OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."get_event_times_by_org"("org_id" bigint) RETURNS TABLE("event_time" "text")
    LANGUAGE "plpgsql"
    AS $$BEGIN
    RETURN QUERY
    SELECT 
        CONCAT(TO_CHAR(start_date, 'YYYY-MM-DD HH24:MI'), ' - ', TO_CHAR(end_date, 'YYYY-MM-DD HH24:MI'))
    FROM 
        public.events
    WHERE 
        id_org = org_id;
END;$$;


ALTER FUNCTION "public"."get_event_times_by_org"("org_id" bigint) OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."get_registration_count"("event_id_input" bigint) RETURNS "text"
    LANGUAGE "plpgsql"
    AS $$DECLARE
    registered_count BIGINT;
    total_slots BIGINT;
BEGIN
    -- Lấy số lượng người đã đăng ký
    SELECT COUNT(*) INTO registered_count
    FROM public.registrations
    WHERE event_id = event_id_input;

    -- Lấy tổng số lượng slot cho sự kiện
    SELECT amount INTO total_slots
    FROM public.events
    WHERE id = event_id_input;

    -- Trả về kết quả dạng "Số lượng: X/Y"
    RETURN registered_count || '/' || total_slots;
END;$$;


ALTER FUNCTION "public"."get_registration_count"("event_id_input" bigint) OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."handle_new_user"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
  -- Kiểm tra nếu user chưa có trong bảng Users
  IF NOT EXISTS (SELECT 1 FROM public."Users" WHERE id = NEW.id) THEN
    INSERT INTO public."Users" (id, email, role)
    VALUES (NEW.id, NEW.email, 'user'); -- Gán role mặc định là 'user'
  END IF;

  RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."handle_new_user"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."hello_world"() RETURNS "text"
    LANGUAGE "sql"
    AS $$  -- 4
  select 'hello world';  -- 5
$$;


ALTER FUNCTION "public"."hello_world"() OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."events" (
    "id" bigint NOT NULL,
    "name" "text" NOT NULL,
    "description" "text",
    "start_date" timestamp without time zone NOT NULL,
    "end_date" timestamp without time zone NOT NULL,
    "location" "text" NOT NULL,
    "amount" bigint NOT NULL,
    "image" "text" NOT NULL,
    "created_at" timestamp without time zone DEFAULT "now"(),
    "updated_at" timestamp without time zone DEFAULT "now"(),
    "id_org" bigint,
    "slot" bigint NOT NULL,
    "id_imt" bigint,
    CONSTRAINT "events_check" CHECK (("slot" < "amount"))
);


ALTER TABLE "public"."events" OWNER TO "postgres";


COMMENT ON COLUMN "public"."events"."slot" IS 'số lượng còn lại';



CREATE SEQUENCE IF NOT EXISTS "public"."Events_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "public"."Events_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "public"."Events_id_seq" OWNED BY "public"."events"."id";



CREATE TABLE IF NOT EXISTS "public"."important_level" (
    "id" bigint NOT NULL,
    "description" "text",
    "name_level" "text",
    "dead_quantity" bigint,
    "injuries_quantity" bigint,
    "property damage" "text",
    "urgency" "text"
);


ALTER TABLE "public"."important_level" OWNER TO "postgres";


ALTER TABLE "public"."important_level" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "public"."Importan_level_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."organizations" (
    "id" bigint NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "id_account" bigint,
    "id_provinces" character varying,
    "name" "text",
    "address" "text",
    "description" "text",
    "phone" "text",
    "image" "text",
    CONSTRAINT "check_phone_format" CHECK (("phone" ~ '^[0][0-9]{9}$'::"text"))
);


ALTER TABLE "public"."organizations" OWNER TO "postgres";


ALTER TABLE "public"."organizations" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "public"."Organizations_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."registrations" (
    "id" bigint NOT NULL,
    "event_id" bigint NOT NULL,
    "volunteer_id" bigint NOT NULL,
    "status" character varying(50) DEFAULT 'pending'::character varying,
    "registered_at" timestamp without time zone DEFAULT "now"()
);


ALTER TABLE "public"."registrations" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "public"."Registrations_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "public"."Registrations_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "public"."Registrations_id_seq" OWNED BY "public"."registrations"."id";



ALTER TABLE "public"."accounts" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "public"."accounts_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."administrative_regions" (
    "id" integer NOT NULL,
    "name" character varying(255) NOT NULL,
    "name_en" character varying(255) NOT NULL,
    "code_name" character varying(255),
    "code_name_en" character varying(255)
);


ALTER TABLE "public"."administrative_regions" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."administrative_units" (
    "id" integer NOT NULL,
    "full_name" character varying(255),
    "full_name_en" character varying(255),
    "short_name" character varying(255),
    "short_name_en" character varying(255),
    "code_name" character varying(255),
    "code_name_en" character varying(255)
);


ALTER TABLE "public"."administrative_units" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."admins" (
    "id" bigint NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "id_account" bigint,
    "name" "text"
);


ALTER TABLE "public"."admins" OWNER TO "postgres";


ALTER TABLE "public"."admins" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "public"."admins_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."districts" (
    "code" character varying(20) NOT NULL,
    "name" character varying(255) NOT NULL,
    "name_en" character varying(255),
    "full_name" character varying(255),
    "full_name_en" character varying(255),
    "code_name" character varying(255),
    "province_code" character varying(20),
    "administrative_unit_id" integer
);


ALTER TABLE "public"."districts" OWNER TO "postgres";


ALTER TABLE "public"."events" ALTER COLUMN "slot" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "public"."events_slot_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."genders" (
    "id" bigint NOT NULL,
    "gender_name" character varying
);


ALTER TABLE "public"."genders" OWNER TO "postgres";


CREATE OR REPLACE VIEW "public"."gender_view" AS
 SELECT "genders"."id" AS "value",
    "genders"."gender_name" AS "label"
   FROM "public"."genders";


ALTER TABLE "public"."gender_view" OWNER TO "postgres";


ALTER TABLE "public"."genders" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "public"."genders_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."notification" (
    "id" bigint NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "location" "text",
    "id_account" bigint,
    "url" "text"
);


ALTER TABLE "public"."notification" OWNER TO "postgres";


ALTER TABLE "public"."notification" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "public"."notification_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."provinces" (
    "code" character varying(20) NOT NULL,
    "name" character varying(255) NOT NULL,
    "name_en" character varying(255),
    "full_name" character varying(255) NOT NULL,
    "full_name_en" character varying(255),
    "code_name" character varying(255),
    "administrative_unit_id" integer,
    "administrative_region_id" integer
);


ALTER TABLE "public"."provinces" OWNER TO "postgres";


CREATE OR REPLACE VIEW "public"."province_view" AS
 SELECT "provinces"."name" AS "label",
    "provinces"."code" AS "value"
   FROM "public"."provinces";


ALTER TABLE "public"."province_view" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."roles" (
    "id" bigint NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "role_name" character varying
);


ALTER TABLE "public"."roles" OWNER TO "postgres";


ALTER TABLE "public"."roles" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "public"."roles_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."volunteers" (
    "id" bigint NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "id_account" bigint,
    "id_gender" bigint,
    "full_name" "text",
    "birthday" "date",
    "id_provinces" "text",
    "phone" "text",
    "picPath" "text" DEFAULT 'https://euchsokljjcbkuaryyco.supabase.co/storage/v1/object/public/image-volunteer/istockphoto-1223671392-170667a.jpg'::"text",
    CONSTRAINT "check_phone_format" CHECK (("phone" ~ '^[0][0-9]{9}$'::"text"))
);


ALTER TABLE "public"."volunteers" OWNER TO "postgres";


ALTER TABLE "public"."volunteers" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "public"."volunteers_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."wards" (
    "code" character varying(20) NOT NULL,
    "name" character varying(255) NOT NULL,
    "name_en" character varying(255),
    "full_name" character varying(255),
    "full_name_en" character varying(255),
    "code_name" character varying(255),
    "district_code" character varying(20),
    "administrative_unit_id" integer
);


ALTER TABLE "public"."wards" OWNER TO "postgres";


ALTER TABLE ONLY "public"."events" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."Events_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."registrations" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."Registrations_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."events"
    ADD CONSTRAINT "Events_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."important_level"
    ADD CONSTRAINT "Importan_level_name_level_key" UNIQUE ("name_level");



ALTER TABLE ONLY "public"."important_level"
    ADD CONSTRAINT "Importan_level_nguoi_gap_nan_key" UNIQUE ("injuries_quantity");



ALTER TABLE ONLY "public"."important_level"
    ADD CONSTRAINT "Importan_level_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."organizations"
    ADD CONSTRAINT "Organizations_name_key" UNIQUE ("name");



ALTER TABLE ONLY "public"."organizations"
    ADD CONSTRAINT "Organizations_phone_key" UNIQUE ("phone");



ALTER TABLE ONLY "public"."organizations"
    ADD CONSTRAINT "Organizations_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."registrations"
    ADD CONSTRAINT "Registrations_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."accounts"
    ADD CONSTRAINT "accounts_email_key" UNIQUE ("email");



ALTER TABLE ONLY "public"."accounts"
    ADD CONSTRAINT "accounts_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."administrative_regions"
    ADD CONSTRAINT "administrative_regions_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."administrative_units"
    ADD CONSTRAINT "administrative_units_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."admins"
    ADD CONSTRAINT "admins_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."districts"
    ADD CONSTRAINT "districts_pkey" PRIMARY KEY ("code");



ALTER TABLE ONLY "public"."genders"
    ADD CONSTRAINT "genders_gender_name_key" UNIQUE ("gender_name");



ALTER TABLE ONLY "public"."genders"
    ADD CONSTRAINT "genders_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."notification"
    ADD CONSTRAINT "notification_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."provinces"
    ADD CONSTRAINT "provinces_pkey" PRIMARY KEY ("code");



ALTER TABLE ONLY "public"."roles"
    ADD CONSTRAINT "roles_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."roles"
    ADD CONSTRAINT "roles_role_name_key" UNIQUE ("role_name");



ALTER TABLE ONLY "public"."volunteers"
    ADD CONSTRAINT "volunteers_phone_key" UNIQUE ("phone");



ALTER TABLE ONLY "public"."volunteers"
    ADD CONSTRAINT "volunteers_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."wards"
    ADD CONSTRAINT "wards_pkey" PRIMARY KEY ("code");



CREATE INDEX "idx_districts_province" ON "public"."districts" USING "btree" ("province_code");



CREATE INDEX "idx_districts_unit" ON "public"."districts" USING "btree" ("administrative_unit_id");



CREATE INDEX "idx_provinces_region" ON "public"."provinces" USING "btree" ("administrative_region_id");



CREATE INDEX "idx_provinces_unit" ON "public"."provinces" USING "btree" ("administrative_unit_id");



CREATE INDEX "idx_wards_district" ON "public"."wards" USING "btree" ("district_code");



CREATE INDEX "idx_wards_unit" ON "public"."wards" USING "btree" ("administrative_unit_id");



ALTER TABLE ONLY "public"."organizations"
    ADD CONSTRAINT "Organizations_id_account_fkey" FOREIGN KEY ("id_account") REFERENCES "public"."accounts"("id");



ALTER TABLE ONLY "public"."organizations"
    ADD CONSTRAINT "Organizations_id_provinces_fkey" FOREIGN KEY ("id_provinces") REFERENCES "public"."provinces"("code");



ALTER TABLE ONLY "public"."accounts"
    ADD CONSTRAINT "accounts_id_role_fkey" FOREIGN KEY ("id_role") REFERENCES "public"."roles"("id");



ALTER TABLE ONLY "public"."admins"
    ADD CONSTRAINT "admins_id_account_fkey" FOREIGN KEY ("id_account") REFERENCES "public"."accounts"("id");



ALTER TABLE ONLY "public"."districts"
    ADD CONSTRAINT "districts_administrative_unit_id_fkey" FOREIGN KEY ("administrative_unit_id") REFERENCES "public"."administrative_units"("id");



ALTER TABLE ONLY "public"."districts"
    ADD CONSTRAINT "districts_province_code_fkey" FOREIGN KEY ("province_code") REFERENCES "public"."provinces"("code");



ALTER TABLE ONLY "public"."events"
    ADD CONSTRAINT "events_id_imt_fkey" FOREIGN KEY ("id_imt") REFERENCES "public"."important_level"("id");



ALTER TABLE ONLY "public"."events"
    ADD CONSTRAINT "events_id_org_fkey" FOREIGN KEY ("id_org") REFERENCES "public"."organizations"("id");



ALTER TABLE ONLY "public"."registrations"
    ADD CONSTRAINT "fk_event" FOREIGN KEY ("event_id") REFERENCES "public"."events"("id");



ALTER TABLE ONLY "public"."registrations"
    ADD CONSTRAINT "fk_volunteer" FOREIGN KEY ("volunteer_id") REFERENCES "public"."volunteers"("id");



ALTER TABLE ONLY "public"."notification"
    ADD CONSTRAINT "notification_id_account_fkey" FOREIGN KEY ("id_account") REFERENCES "public"."accounts"("id");



ALTER TABLE ONLY "public"."provinces"
    ADD CONSTRAINT "provinces_administrative_region_id_fkey" FOREIGN KEY ("administrative_region_id") REFERENCES "public"."administrative_regions"("id");



ALTER TABLE ONLY "public"."provinces"
    ADD CONSTRAINT "provinces_administrative_unit_id_fkey" FOREIGN KEY ("administrative_unit_id") REFERENCES "public"."administrative_units"("id");



ALTER TABLE ONLY "public"."volunteers"
    ADD CONSTRAINT "volunteers_id_account_fkey" FOREIGN KEY ("id_account") REFERENCES "public"."accounts"("id");



ALTER TABLE ONLY "public"."volunteers"
    ADD CONSTRAINT "volunteers_id_gender_fkey" FOREIGN KEY ("id_gender") REFERENCES "public"."genders"("id");



ALTER TABLE ONLY "public"."volunteers"
    ADD CONSTRAINT "volunteers_id_provinces_fkey" FOREIGN KEY ("id_provinces") REFERENCES "public"."provinces"("code");



ALTER TABLE ONLY "public"."wards"
    ADD CONSTRAINT "wards_administrative_unit_id_fkey" FOREIGN KEY ("administrative_unit_id") REFERENCES "public"."administrative_units"("id");



ALTER TABLE ONLY "public"."wards"
    ADD CONSTRAINT "wards_district_code_fkey" FOREIGN KEY ("district_code") REFERENCES "public"."districts"("code");



ALTER TABLE "public"."accounts" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."admins" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."genders" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."important_level" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."notification" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."organizations" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."volunteers" ENABLE ROW LEVEL SECURITY;




ALTER PUBLICATION "supabase_realtime" OWNER TO "postgres";


GRANT USAGE ON SCHEMA "public" TO "postgres";
GRANT USAGE ON SCHEMA "public" TO "anon";
GRANT USAGE ON SCHEMA "public" TO "authenticated";
GRANT USAGE ON SCHEMA "public" TO "service_role";




















































































































































































GRANT ALL ON TABLE "public"."accounts" TO "anon";
GRANT ALL ON TABLE "public"."accounts" TO "authenticated";
GRANT ALL ON TABLE "public"."accounts" TO "service_role";



GRANT ALL ON FUNCTION "public"."get_account"() TO "anon";
GRANT ALL ON FUNCTION "public"."get_account"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_account"() TO "service_role";



GRANT ALL ON FUNCTION "public"."get_account"("uid" bigint) TO "anon";
GRANT ALL ON FUNCTION "public"."get_account"("uid" bigint) TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_account"("uid" bigint) TO "service_role";



GRANT ALL ON FUNCTION "public"."get_amount_vlr_by_org"("org_id" bigint) TO "anon";
GRANT ALL ON FUNCTION "public"."get_amount_vlr_by_org"("org_id" bigint) TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_amount_vlr_by_org"("org_id" bigint) TO "service_role";



GRANT ALL ON FUNCTION "public"."get_data_envents"() TO "anon";
GRANT ALL ON FUNCTION "public"."get_data_envents"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_data_envents"() TO "service_role";



GRANT ALL ON FUNCTION "public"."get_data_event_by_id"("id_evt" integer) TO "anon";
GRANT ALL ON FUNCTION "public"."get_data_event_by_id"("id_evt" integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_data_event_by_id"("id_evt" integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."get_data_event_by_id_org"("id_evt" integer) TO "anon";
GRANT ALL ON FUNCTION "public"."get_data_event_by_id_org"("id_evt" integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_data_event_by_id_org"("id_evt" integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."get_data_vlr_from_event"("id_evt" integer) TO "anon";
GRANT ALL ON FUNCTION "public"."get_data_vlr_from_event"("id_evt" integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_data_vlr_from_event"("id_evt" integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."get_event_times_by_org"("org_id" bigint) TO "anon";
GRANT ALL ON FUNCTION "public"."get_event_times_by_org"("org_id" bigint) TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_event_times_by_org"("org_id" bigint) TO "service_role";



GRANT ALL ON FUNCTION "public"."get_registration_count"("event_id_input" bigint) TO "anon";
GRANT ALL ON FUNCTION "public"."get_registration_count"("event_id_input" bigint) TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_registration_count"("event_id_input" bigint) TO "service_role";



GRANT ALL ON FUNCTION "public"."handle_new_user"() TO "anon";
GRANT ALL ON FUNCTION "public"."handle_new_user"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."handle_new_user"() TO "service_role";



GRANT ALL ON FUNCTION "public"."hello_world"() TO "anon";
GRANT ALL ON FUNCTION "public"."hello_world"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."hello_world"() TO "service_role";


















GRANT ALL ON TABLE "public"."events" TO "anon";
GRANT ALL ON TABLE "public"."events" TO "authenticated";
GRANT ALL ON TABLE "public"."events" TO "service_role";



GRANT ALL ON SEQUENCE "public"."Events_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."Events_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."Events_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."important_level" TO "anon";
GRANT ALL ON TABLE "public"."important_level" TO "authenticated";
GRANT ALL ON TABLE "public"."important_level" TO "service_role";



GRANT ALL ON SEQUENCE "public"."Importan_level_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."Importan_level_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."Importan_level_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."organizations" TO "anon";
GRANT ALL ON TABLE "public"."organizations" TO "authenticated";
GRANT ALL ON TABLE "public"."organizations" TO "service_role";



GRANT ALL ON SEQUENCE "public"."Organizations_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."Organizations_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."Organizations_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."registrations" TO "anon";
GRANT ALL ON TABLE "public"."registrations" TO "authenticated";
GRANT ALL ON TABLE "public"."registrations" TO "service_role";



GRANT ALL ON SEQUENCE "public"."Registrations_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."Registrations_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."Registrations_id_seq" TO "service_role";



GRANT ALL ON SEQUENCE "public"."accounts_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."accounts_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."accounts_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."administrative_regions" TO "anon";
GRANT ALL ON TABLE "public"."administrative_regions" TO "authenticated";
GRANT ALL ON TABLE "public"."administrative_regions" TO "service_role";



GRANT ALL ON TABLE "public"."administrative_units" TO "anon";
GRANT ALL ON TABLE "public"."administrative_units" TO "authenticated";
GRANT ALL ON TABLE "public"."administrative_units" TO "service_role";



GRANT ALL ON TABLE "public"."admins" TO "anon";
GRANT ALL ON TABLE "public"."admins" TO "authenticated";
GRANT ALL ON TABLE "public"."admins" TO "service_role";



GRANT ALL ON SEQUENCE "public"."admins_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."admins_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."admins_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."districts" TO "anon";
GRANT ALL ON TABLE "public"."districts" TO "authenticated";
GRANT ALL ON TABLE "public"."districts" TO "service_role";



GRANT ALL ON SEQUENCE "public"."events_slot_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."events_slot_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."events_slot_seq" TO "service_role";



GRANT ALL ON TABLE "public"."genders" TO "anon";
GRANT ALL ON TABLE "public"."genders" TO "authenticated";
GRANT ALL ON TABLE "public"."genders" TO "service_role";



GRANT ALL ON TABLE "public"."gender_view" TO "anon";
GRANT ALL ON TABLE "public"."gender_view" TO "authenticated";
GRANT ALL ON TABLE "public"."gender_view" TO "service_role";



GRANT ALL ON SEQUENCE "public"."genders_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."genders_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."genders_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."notification" TO "anon";
GRANT ALL ON TABLE "public"."notification" TO "authenticated";
GRANT ALL ON TABLE "public"."notification" TO "service_role";



GRANT ALL ON SEQUENCE "public"."notification_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."notification_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."notification_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."provinces" TO "anon";
GRANT ALL ON TABLE "public"."provinces" TO "authenticated";
GRANT ALL ON TABLE "public"."provinces" TO "service_role";



GRANT ALL ON TABLE "public"."province_view" TO "anon";
GRANT ALL ON TABLE "public"."province_view" TO "authenticated";
GRANT ALL ON TABLE "public"."province_view" TO "service_role";



GRANT ALL ON TABLE "public"."roles" TO "anon";
GRANT ALL ON TABLE "public"."roles" TO "authenticated";
GRANT ALL ON TABLE "public"."roles" TO "service_role";



GRANT ALL ON SEQUENCE "public"."roles_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."roles_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."roles_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."volunteers" TO "anon";
GRANT ALL ON TABLE "public"."volunteers" TO "authenticated";
GRANT ALL ON TABLE "public"."volunteers" TO "service_role";



GRANT ALL ON SEQUENCE "public"."volunteers_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."volunteers_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."volunteers_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."wards" TO "anon";
GRANT ALL ON TABLE "public"."wards" TO "authenticated";
GRANT ALL ON TABLE "public"."wards" TO "service_role";



ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES  TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES  TO "service_role";






ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS  TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS  TO "service_role";






ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES  TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES  TO "service_role";






























RESET ALL;
