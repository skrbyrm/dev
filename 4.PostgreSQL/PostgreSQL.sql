--
-- PostgreSQL database dump
--

-- Dumped from database version 15.2 (Debian 15.2-1.pgdg110+1)
-- Dumped by pg_dump version 15.2 (Ubuntu 15.2-1.pgdg22.04+1)

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

--
-- Name: daily_by_ssno(integer); Type: PROCEDURE; Schema: public; Owner: pgadmin
--

CREATE PROCEDURE public.daily_by_ssno(IN meterid integer)
    LANGUAGE plpgsql
    AS $$
DECLARE
    active_cons numeric(18,2);
    inductive_cons numeric(18,2);
    capacitive_cons numeric(18,2);
    inductive_ratio numeric(18,4);
    capacitive_ratio numeric(18,4);
BEGIN
    -- Create temporary table to hold query result
	DROP TABLE IF EXISTS temp_day;
    CREATE TEMP TABLE temp_day AS 
   SELECT 
        q.date, 
        q.active,
        q.inductive,
        q.capacitive,
        q.active - COALESCE(LAG(q.active) OVER (PARTITION BY q.ssno ORDER BY q.date ASC), 0) AS active_cons,
        q.inductive - COALESCE(LAG(q.inductive) OVER (PARTITION BY q.ssno ORDER BY q.date ASC), 0) AS inductive_cons,
        q.capacitive - COALESCE(LAG(q.capacitive) OVER (PARTITION BY q.ssno ORDER BY q.date ASC), 0) AS capacitive_cons,
        CASE 
            WHEN q.active - COALESCE(LAG(q.active) OVER (PARTITION BY q.ssno ORDER BY q.date ASC), 0) = 0 THEN 0 
            ELSE ((q.inductive - COALESCE(LAG(q.inductive) OVER (PARTITION BY q.ssno ORDER BY q.date ASC), 0)) / (q.active - COALESCE(LAG(q.active) OVER (PARTITION BY q.ssno ORDER BY q.date ASC), 0))) * 100 ::numeric(18,4) 
        END AS inductive_ratio,
        CASE 
            WHEN q.active - COALESCE(LAG(q.active) OVER (PARTITION BY q.ssno ORDER BY q.date ASC), 0) = 0 THEN 0 
            ELSE ((q.capacitive - COALESCE(LAG(q.capacitive) OVER (PARTITION BY q.ssno ORDER BY q.date ASC), 0)) / (q.active - COALESCE(LAG(q.active) OVER (PARTITION BY q.ssno ORDER BY q.date ASC), 0))) * 100 ::numeric(18,4) 
        END AS capacitive_ratio,
        CASE 
            WHEN ((q.inductive - COALESCE(LAG(q.inductive) OVER (PARTITION BY q.ssno ORDER BY q.date ASC), 0)) / NULLIF(q.active - COALESCE(LAG(q.active) OVER (PARTITION BY q.ssno ORDER BY q.date ASC), 0), 0)) * 100 >= 20 
                  OR ((q.capacitive - COALESCE(LAG(q.capacitive) OVER (PARTITION BY q.ssno ORDER BY q.date ASC), 0)) / NULLIF(q.active - COALESCE(LAG(q.active) OVER (PARTITION BY q.ssno ORDER BY q.date ASC), 0), 0)) * 100 >= 15 
            THEN 1 
            ELSE 0 
        END AS penalized,
        q.ssno,
        q.userid
    FROM (
        SELECT 
            firm_list.userid AS userid,
            firm_list.ssno AS ssno,
            MAX(c.date) AS date,
            MAX(c.active) AS active,
            MAX(c.inductive) AS inductive,
            MAX(c.capacitive) AS capacitive
        FROM            
            consumptions c
        INNER JOIN
            firm_list ON c.ssno = firm_list.ssno
        WHERE 
            firm_list.ssno = meterid
            AND date_trunc('day', c.date) >= current_date - interval '30 days'
        GROUP BY 
            date_trunc('day', c.date),
            firm_list.ssno, 
            firm_list.userid
    ) AS q
    ORDER BY 
        q.date DESC;
END;
$$;


ALTER PROCEDURE public.daily_by_ssno(IN meterid integer) OWNER TO pgadmin;

--
-- Name: hourly_by_ssno(integer); Type: PROCEDURE; Schema: public; Owner: pgadmin
--

CREATE PROCEDURE public.hourly_by_ssno(IN meterid integer)
    LANGUAGE plpgsql
    AS $$
DECLARE
    active_cons numeric(18,2);
    inductive_cons numeric(18,2);
    capacitive_cons numeric(18,2);
    inductive_ratio numeric(18,4);
    capacitive_ratio numeric(18,4);
BEGIN
    -- Create temporary table to hold query result
	DROP TABLE IF EXISTS temp_hour;
    CREATE TEMP TABLE temp_hour AS 
   SELECT 
        q.date, 
        q.active,
        q.inductive,
        q.capacitive,
        q.active - COALESCE(LAG(q.active) OVER (PARTITION BY q.ssno ORDER BY q.date ASC), 0) AS active_cons,
        q.inductive - COALESCE(LAG(q.inductive) OVER (PARTITION BY q.ssno ORDER BY q.date ASC), 0) AS inductive_cons,
        q.capacitive - COALESCE(LAG(q.capacitive) OVER (PARTITION BY q.ssno ORDER BY q.date ASC), 0) AS capacitive_cons,
        CASE 
            WHEN q.active - COALESCE(LAG(q.active) OVER (PARTITION BY q.ssno ORDER BY q.date ASC), 0) = 0 THEN 0 
            ELSE ((q.inductive - COALESCE(LAG(q.inductive) OVER (PARTITION BY q.ssno ORDER BY q.date ASC), 0)) / (q.active - COALESCE(LAG(q.active) OVER (PARTITION BY q.ssno ORDER BY q.date ASC), 0))) * 100 ::numeric(18,4) 
        END AS inductive_ratio,
        CASE 
            WHEN q.active - COALESCE(LAG(q.active) OVER (PARTITION BY q.ssno ORDER BY q.date ASC), 0) = 0 THEN 0 
            ELSE ((q.capacitive - COALESCE(LAG(q.capacitive) OVER (PARTITION BY q.ssno ORDER BY q.date ASC), 0)) / (q.active - COALESCE(LAG(q.active) OVER (PARTITION BY q.ssno ORDER BY q.date ASC), 0))) * 100 ::numeric(18,4) 
        END AS capacitive_ratio,
        CASE 
            WHEN ((q.inductive - COALESCE(LAG(q.inductive) OVER (PARTITION BY q.ssno ORDER BY q.date ASC), 0)) / NULLIF(q.active - COALESCE(LAG(q.active) OVER (PARTITION BY q.ssno ORDER BY q.date ASC), 0), 0)) * 100 >= 20 
                  OR ((q.capacitive - COALESCE(LAG(q.capacitive) OVER (PARTITION BY q.ssno ORDER BY q.date ASC), 0)) / NULLIF(q.active - COALESCE(LAG(q.active) OVER (PARTITION BY q.ssno ORDER BY q.date ASC), 0), 0)) * 100 >= 15 
            THEN 1 
            ELSE 0 
        END AS penalized,
        q.ssno,
        q.userid
    FROM (
        SELECT 
            firm_list.userid AS userid,
            firm_list.ssno AS ssno,
            MAX(c.date) AS date,
            MAX(c.active) AS active,
            MAX(c.inductive) AS inductive,
            MAX(c.capacitive) AS capacitive
        FROM            
            consumptions c
        INNER JOIN
            firm_list ON c.ssno = firm_list.ssno
        WHERE 
            firm_list.ssno = meterid
            AND date_trunc('hour', c.date) >= date_trunc('hour', current_date) - interval '24 hours'
        GROUP BY 
            date_trunc('hour', c.date),
            firm_list.ssno, 
            firm_list.userid
    ) AS q
    ORDER BY 
        q.date DESC;
END;
$$;


ALTER PROCEDURE public.hourly_by_ssno(IN meterid integer) OWNER TO pgadmin;

--
-- Name: monthly_by_ssno(integer); Type: PROCEDURE; Schema: public; Owner: pgadmin
--

CREATE PROCEDURE public.monthly_by_ssno(IN meterid integer)
    LANGUAGE plpgsql
    AS $$
DECLARE
    active_cons numeric(18,2);
    inductive_cons numeric(18,2);
    capacitive_cons numeric(18,2);
    inductive_ratio numeric(18,4);
    capacitive_ratio numeric(18,4);
BEGIN
    -- Create temporary table to hold query result
	DROP TABLE IF EXISTS temp_month;
    CREATE TEMP TABLE temp_month AS 
   SELECT 
        q.date, 
        q.active - COALESCE(LAG(q.active) OVER (PARTITION BY q.ssno ORDER BY q.date ASC), 0) AS active_cons,
        q.inductive - COALESCE(LAG(q.inductive) OVER (PARTITION BY q.ssno ORDER BY q.date ASC), 0) AS inductive_cons,
        q.capacitive - COALESCE(LAG(q.capacitive) OVER (PARTITION BY q.ssno ORDER BY q.date ASC), 0) AS capacitive_cons,
        CASE 
            WHEN q.active - COALESCE(LAG(q.active) OVER (PARTITION BY q.ssno ORDER BY q.date ASC), 0) = 0 THEN 0 
            ELSE ((q.inductive - COALESCE(LAG(q.inductive) OVER (PARTITION BY q.ssno ORDER BY q.date ASC), 0)) / (q.active - COALESCE(LAG(q.active) OVER (PARTITION BY q.ssno ORDER BY q.date ASC), 0))) * 100 ::numeric(18,4) 
        END AS inductive_ratio,
        CASE 
            WHEN q.active - COALESCE(LAG(q.active) OVER (PARTITION BY q.ssno ORDER BY q.date ASC), 0) = 0 THEN 0 
            ELSE ((q.capacitive - COALESCE(LAG(q.capacitive) OVER (PARTITION BY q.ssno ORDER BY q.date ASC), 0)) / (q.active - COALESCE(LAG(q.active) OVER (PARTITION BY q.ssno ORDER BY q.date ASC), 0))) * 100 ::numeric(18,4) 
        END AS capacitive_ratio,
        CASE 
            WHEN ((q.inductive - COALESCE(LAG(q.inductive) OVER (PARTITION BY q.ssno ORDER BY q.date ASC), 0)) / NULLIF(q.active - COALESCE(LAG(q.active) OVER (PARTITION BY q.ssno ORDER BY q.date ASC), 0), 0)) * 100 >= 20 
                  OR ((q.capacitive - COALESCE(LAG(q.capacitive) OVER (PARTITION BY q.ssno ORDER BY q.date ASC), 0)) / NULLIF(q.active - COALESCE(LAG(q.active) OVER (PARTITION BY q.ssno ORDER BY q.date ASC), 0), 0)) * 100 >= 15 
            THEN true 
            ELSE false
        END AS penalized,
        q.ssno,
        q.userid
    FROM (
        SELECT 
            firm_list.userid AS userid,
            firm_list.ssno AS ssno,
            MAX(c.date) AS date,
            MAX(c.active) AS active,
            MAX(c.inductive) AS inductive,
            MAX(c.capacitive) AS capacitive
        FROM            
            consumptions c
        INNER JOIN
            firm_list ON c.ssno = firm_list.ssno
        WHERE 
            firm_list.ssno = meterid
            AND date_trunc('month', c.date) >= date_trunc('month', current_date) - interval '11 months'
        GROUP BY 
            date_trunc('month', c.date),
            firm_list.ssno, 
            firm_list.userid
    ) AS q
    ORDER BY 
        q.date DESC;
END;
$$;


ALTER PROCEDURE public.monthly_by_ssno(IN meterid integer) OWNER TO pgadmin;

--
-- Name: proc_data_by_dates(); Type: PROCEDURE; Schema: public; Owner: pgadmin
--

CREATE PROCEDURE public.proc_data_by_dates()
    LANGUAGE plpgsql
    AS $$
DECLARE
  meterid integer;
BEGIN
  -- Create temporary table to hold all the data
  TRUNCATE TABLE data_by_dates;
  
  -- Loop through each ssno in the firm_list table and call the daily_by_ssno procedure
  FOR meterid IN (SELECT ssno FROM firm_list) LOOP
      CALL daily_by_ssno(meterid);
      INSERT INTO data_by_dates SELECT * FROM temp_day;
  END LOOP;
END;
$$;


ALTER PROCEDURE public.proc_data_by_dates() OWNER TO pgadmin;

--
-- Name: proc_data_by_hours(); Type: PROCEDURE; Schema: public; Owner: pgadmin
--

CREATE PROCEDURE public.proc_data_by_hours()
    LANGUAGE plpgsql
    AS $$
DECLARE
  meterid integer;
BEGIN
  -- Create temporary table to hold all the data
  TRUNCATE TABLE data_by_hours;
  
  -- Loop through each ssno in the firm_list table and call the daily_by_ssno procedure
  FOR meterid IN (SELECT ssno FROM firm_list) LOOP
      CALL hourly_by_ssno(meterid);
      INSERT INTO data_by_hours SELECT * FROM temp_hour;
  END LOOP;
END;
$$;


ALTER PROCEDURE public.proc_data_by_hours() OWNER TO pgadmin;

--
-- Name: proc_data_by_months(); Type: PROCEDURE; Schema: public; Owner: pgadmin
--

CREATE PROCEDURE public.proc_data_by_months()
    LANGUAGE plpgsql
    AS $$
DECLARE
  meterid integer;
BEGIN
  -- Create temporary table to hold all the data
  TRUNCATE TABLE data_by_months;
  
  -- Loop through each ssno in the firm_list table and call the daily_by_ssno procedure
  FOR meterid IN (SELECT ssno FROM firm_list) LOOP
      CALL monthly_by_ssno(meterid);
      INSERT INTO data_by_months SELECT * FROM temp_month;
  END LOOP;
END;
$$;


ALTER PROCEDURE public.proc_data_by_months() OWNER TO pgadmin;

--
-- Name: proc_data_by_weeks(); Type: PROCEDURE; Schema: public; Owner: pgadmin
--

CREATE PROCEDURE public.proc_data_by_weeks()
    LANGUAGE plpgsql
    AS $$
DECLARE
  meterid integer;
BEGIN
  -- Create temporary table to hold all the data
  TRUNCATE TABLE data_by_weeks; 
  -- Loop through each ssno in the firm_list table and call the daily_by_ssno procedure
  FOR meterid IN (SELECT ssno FROM firm_list) LOOP
      CALL weekly_by_ssno(meterid);
      INSERT INTO data_by_weeks SELECT * FROM temp_week;
  END LOOP;
END;
$$;


ALTER PROCEDURE public.proc_data_by_weeks() OWNER TO pgadmin;

--
-- Name: proc_summary(); Type: PROCEDURE; Schema: public; Owner: pgadmin
--

CREATE PROCEDURE public.proc_summary()
    LANGUAGE plpgsql
    AS $$
DECLARE
  meterid integer;
BEGIN
  -- Create temporary table to hold all the data
  TRUNCATE TABLE summary; 
  -- Loop through each ssno in the firm_list table and call the daily_by_ssno procedure
  FOR meterid IN (SELECT ssno FROM firm_list) LOOP
      CALL monthly_by_ssno(meterid);
      INSERT INTO summary SELECT * FROM temp_month LIMIT 1;
  END LOOP;
END;
$$;


ALTER PROCEDURE public.proc_summary() OWNER TO pgadmin;

--
-- Name: trigger_cons_data(); Type: FUNCTION; Schema: public; Owner: pgadmin
--

CREATE FUNCTION public.trigger_cons_data() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF (TG_OP = 'INSERT') THEN
        PERFORM proc_data_by_dates();
        PERFORM proc_data_by_weeks();
        PERFORM proc_data_by_months();
        PERFORM proc_data_by_hours();
        PERFORM proc_summary();
    END IF;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.trigger_cons_data() OWNER TO pgadmin;

--
-- Name: weekly_by_ssno(integer); Type: PROCEDURE; Schema: public; Owner: pgadmin
--

CREATE PROCEDURE public.weekly_by_ssno(IN meterid integer)
    LANGUAGE plpgsql
    AS $$
DECLARE
    active_cons numeric(18,2);
    inductive_cons numeric(18,2);
    capacitive_cons numeric(18,2);
    inductive_ratio numeric(18,4);
    capacitive_ratio numeric(18,4);
BEGIN
    -- Create temporary table to hold query result
	DROP TABLE IF EXISTS temp_week;
    CREATE TEMP TABLE temp_week AS 
   SELECT 
        q.date, 
        q.active - COALESCE(LAG(q.active) OVER (PARTITION BY q.ssno ORDER BY q.date ASC), 0) AS active_cons,
        q.inductive - COALESCE(LAG(q.inductive) OVER (PARTITION BY q.ssno ORDER BY q.date ASC), 0) AS inductive_cons,
        q.capacitive - COALESCE(LAG(q.capacitive) OVER (PARTITION BY q.ssno ORDER BY q.date ASC), 0) AS capacitive_cons,
        CASE 
            WHEN q.active - COALESCE(LAG(q.active) OVER (PARTITION BY q.ssno ORDER BY q.date ASC), 0) = 0 THEN 0 
            ELSE ((q.inductive - COALESCE(LAG(q.inductive) OVER (PARTITION BY q.ssno ORDER BY q.date ASC), 0)) / (q.active - COALESCE(LAG(q.active) OVER (PARTITION BY q.ssno ORDER BY q.date ASC), 0))) * 100 ::numeric(18,4) 
        END AS inductive_ratio,
        CASE 
            WHEN q.active - COALESCE(LAG(q.active) OVER (PARTITION BY q.ssno ORDER BY q.date ASC), 0) = 0 THEN 0 
            ELSE ((q.capacitive - COALESCE(LAG(q.capacitive) OVER (PARTITION BY q.ssno ORDER BY q.date ASC), 0)) / (q.active - COALESCE(LAG(q.active) OVER (PARTITION BY q.ssno ORDER BY q.date ASC), 0))) * 100 ::numeric(18,4) 
        END AS capacitive_ratio,
        CASE 
            WHEN ((q.inductive - COALESCE(LAG(q.inductive) OVER (PARTITION BY q.ssno ORDER BY q.date ASC), 0)) / NULLIF(q.active - COALESCE(LAG(q.active) OVER (PARTITION BY q.ssno ORDER BY q.date ASC), 0), 0)) * 100 >= 20 
                  OR ((q.capacitive - COALESCE(LAG(q.capacitive) OVER (PARTITION BY q.ssno ORDER BY q.date ASC), 0)) / NULLIF(q.active - COALESCE(LAG(q.active) OVER (PARTITION BY q.ssno ORDER BY q.date ASC), 0), 0)) * 100 >= 15 
            THEN true
            ELSE false
        END AS penalized,
        q.ssno,
        q.userid
    FROM (
        SELECT 
            firm_list.userid AS userid,
            firm_list.ssno AS ssno,
            MAX(c.date) AS date,
            MAX(c.active) AS active,
            MAX(c.inductive) AS inductive,
            MAX(c.capacitive) AS capacitive
        FROM            
            consumptions c
        INNER JOIN
            firm_list ON c.ssno = firm_list.ssno
        WHERE 
            firm_list.ssno = meterid
            AND date_trunc('week', c.date) >= date_trunc('week', current_date) - interval '4 weeks'
        GROUP BY 
            date_trunc('week', c.date),
            firm_list.ssno, 
            firm_list.userid
    ) AS q
    ORDER BY 
        q.date DESC;
END;
$$;


ALTER PROCEDURE public.weekly_by_ssno(IN meterid integer) OWNER TO pgadmin;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: Sessions; Type: TABLE; Schema: public; Owner: pgadmin
--

CREATE TABLE public."Sessions" (
    sid text,
    expires timestamp without time zone,
    data text,
    createdat timestamp without time zone,
    updatedat timestamp without time zone
);


ALTER TABLE public."Sessions" OWNER TO pgadmin;

--
-- Name: consumptions; Type: TABLE; Schema: public; Owner: pgadmin
--

CREATE TABLE public.consumptions (
    id integer NOT NULL,
    date timestamp without time zone,
    active double precision,
    inductive double precision,
    capacitive double precision,
    hno bigint,
    ssno bigint,
    facility_id integer,
    createdat timestamp without time zone,
    updatedat timestamp without time zone
);


ALTER TABLE public.consumptions OWNER TO pgadmin;

--
-- Name: consumptions_id_seq; Type: SEQUENCE; Schema: public; Owner: pgadmin
--

CREATE SEQUENCE public.consumptions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.consumptions_id_seq OWNER TO pgadmin;

--
-- Name: consumptions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgadmin
--

ALTER SEQUENCE public.consumptions_id_seq OWNED BY public.consumptions.id;


--
-- Name: data_by_dates; Type: TABLE; Schema: public; Owner: pgadmin
--

CREATE TABLE public.data_by_dates (
    date timestamp without time zone,
    active numeric(18,2),
    inductive numeric(18,2),
    capacitive numeric(18,2),
    active_cons numeric(18,2),
    inductive_cons numeric(18,2),
    capacitive_cons numeric(18,2),
    inductive_ratio numeric(18,4),
    capacitive_ratio numeric(18,4),
    penalized integer,
    ssno integer,
    userid integer
);


ALTER TABLE public.data_by_dates OWNER TO pgadmin;

--
-- Name: data_by_hours; Type: TABLE; Schema: public; Owner: pgadmin
--

CREATE TABLE public.data_by_hours (
    date timestamp without time zone,
    active numeric(18,2),
    inductive numeric(18,2),
    capacitive numeric(18,2),
    active_cons numeric(18,2),
    inductive_cons numeric(18,2),
    capacitive_cons numeric(18,2),
    inductive_ratio numeric(18,4),
    capacitive_ratio numeric(18,4),
    penalized integer,
    ssno integer,
    userid integer
);


ALTER TABLE public.data_by_hours OWNER TO pgadmin;

--
-- Name: data_by_months; Type: TABLE; Schema: public; Owner: pgadmin
--

CREATE TABLE public.data_by_months (
    date timestamp without time zone,
    active_cons numeric(18,2),
    inductive_cons numeric(18,2),
    capacitive_cons numeric(18,2),
    inductive_ratio numeric(18,4),
    capacitive_ratio numeric(18,4),
    penalized boolean,
    ssno bigint,
    userid integer
);


ALTER TABLE public.data_by_months OWNER TO pgadmin;

--
-- Name: data_by_weeks; Type: TABLE; Schema: public; Owner: pgadmin
--

CREATE TABLE public.data_by_weeks (
    date timestamp without time zone,
    active_cons numeric(18,2),
    inductive_cons numeric(18,2),
    capacitive_cons numeric(18,2),
    inductive_ratio numeric(18,4),
    capacitive_ratio numeric(18,4),
    penalized boolean,
    ssno bigint,
    userid integer
);


ALTER TABLE public.data_by_weeks OWNER TO pgadmin;

--
-- Name: firm_list; Type: TABLE; Schema: public; Owner: pgadmin
--

CREATE TABLE public.firm_list (
    service_point_number bigint,
    ssno bigint,
    city text,
    district text,
    facility text,
    meter_id bigint,
    userid integer,
    facility_id bigint,
    adress_id bigint,
    os_username bigint,
    createdat timestamp without time zone,
    updatedat timestamp without time zone
);


ALTER TABLE public.firm_list OWNER TO pgadmin;

--
-- Name: summary; Type: TABLE; Schema: public; Owner: pgadmin
--

CREATE TABLE public.summary (
    date timestamp without time zone,
    active_cons numeric(18,2),
    inductive_cons numeric(18,2),
    capacitive_cons numeric(18,2),
    inductive_ratio numeric(18,4),
    capacitive_ratio numeric(18,4),
    penalized boolean,
    ssno bigint,
    userid integer
);


ALTER TABLE public.summary OWNER TO pgadmin;

--
-- Name: users; Type: TABLE; Schema: public; Owner: pgadmin
--

CREATE TABLE public.users (
    id integer NOT NULL,
    uuid character varying(255),
    name character varying(255),
    email character varying(255),
    password character varying(255),
    role character varying(255),
    createdat timestamp without time zone,
    updatedat timestamp without time zone
);


ALTER TABLE public.users OWNER TO pgadmin;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: pgadmin
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO pgadmin;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgadmin
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: view_data_by_dates; Type: VIEW; Schema: public; Owner: pgadmin
--

CREATE VIEW public.view_data_by_dates AS
 SELECT firm_list.facility AS "Tesis",
    firm_list.district AS "İlçe",
    firm_list.service_point_number AS "Abone",
    data_by_dates.date AS "Tarih",
    data_by_dates.active AS "Aktif",
    data_by_dates.inductive AS "Endüktif",
    data_by_dates.capacitive AS "Kapasitif",
    data_by_dates.active_cons AS "Aktif Tüketim",
    data_by_dates.inductive_cons AS "Endüktif Tüketim",
    data_by_dates.capacitive_cons AS "Kapasitif Tüketim"
   FROM (public.data_by_dates
     JOIN public.firm_list ON ((data_by_dates.ssno = firm_list.ssno)));


ALTER TABLE public.view_data_by_dates OWNER TO pgadmin;

--
-- Name: view_data_by_hours; Type: VIEW; Schema: public; Owner: pgadmin
--

CREATE VIEW public.view_data_by_hours AS
 SELECT firm_list.facility AS "Tesis",
    firm_list.district AS "İlçe",
    firm_list.service_point_number AS "Abone",
    data_by_hours.date AS "Tarih",
    data_by_hours.active AS "Aktif",
    data_by_hours.inductive AS "Endüktif",
    data_by_hours.capacitive AS "Kapasitif",
    data_by_hours.active_cons AS "Aktif Tüketim",
    data_by_hours.inductive_cons AS "Endüktif Tüketim",
    data_by_hours.capacitive_cons AS "Kapasitif Tüketim"
   FROM (public.data_by_hours
     JOIN public.firm_list ON ((data_by_hours.ssno = firm_list.ssno)));


ALTER TABLE public.view_data_by_hours OWNER TO pgadmin;

--
-- Name: view_data_by_months; Type: VIEW; Schema: public; Owner: pgadmin
--

CREATE VIEW public.view_data_by_months AS
 SELECT firm_list.facility AS "Tesis",
    firm_list.district AS "İlçe",
    firm_list.service_point_number AS "Abone",
    data_by_months.date AS "Tarih",
    data_by_months.active_cons AS "Aktif Tüketim",
    data_by_months.inductive_cons AS "Endüktif Tüketim",
    data_by_months.capacitive_cons AS "Kapasitif Tüketim",
    data_by_months.inductive_ratio AS "End. Oran",
    data_by_months.capacitive_ratio AS "Kap. Oran",
    data_by_months.penalized AS "Ceza Durumu"
   FROM (public.data_by_months
     JOIN public.firm_list ON ((data_by_months.ssno = firm_list.ssno)))
  ORDER BY data_by_months.penalized DESC;


ALTER TABLE public.view_data_by_months OWNER TO pgadmin;

--
-- Name: view_data_by_weeks; Type: VIEW; Schema: public; Owner: pgadmin
--

CREATE VIEW public.view_data_by_weeks AS
 SELECT firm_list.facility AS "Tesis",
    firm_list.district AS "İlçe",
    firm_list.service_point_number AS "Abone",
    data_by_weeks.date AS "Tarih",
    data_by_weeks.active_cons AS "Aktif Tüketim",
    data_by_weeks.inductive_cons AS "Endüktif Tüketim",
    data_by_weeks.capacitive_cons AS "Kapasitif Tüketim",
    data_by_weeks.inductive_ratio AS "End. Oran",
    data_by_weeks.capacitive_ratio AS "Kap. Oran",
    data_by_weeks.penalized AS "Ceza Durumu"
   FROM (public.data_by_weeks
     JOIN public.firm_list ON ((data_by_weeks.ssno = firm_list.ssno)))
  ORDER BY data_by_weeks.penalized DESC;


ALTER TABLE public.view_data_by_weeks OWNER TO pgadmin;

--
-- Name: view_summary; Type: VIEW; Schema: public; Owner: pgadmin
--

CREATE VIEW public.view_summary AS
 SELECT firm_list.facility AS "Tesis",
    firm_list.district AS "İlçe",
    firm_list.service_point_number AS "Abone",
    summary.date AS "Tarih",
    summary.active_cons AS "Aktif Tüketim",
    summary.inductive_cons AS "Endüktif Tüketim",
    summary.capacitive_cons AS "Kapasitif Tüketim",
    summary.inductive_ratio AS "End. Oran",
    summary.capacitive_ratio AS "Kap. Oran",
    summary.penalized AS "Ceza Durumu"
   FROM (public.summary
     JOIN public.firm_list ON ((summary.ssno = firm_list.ssno)))
  ORDER BY summary.penalized DESC;


ALTER TABLE public.view_summary OWNER TO pgadmin;

--
-- Name: consumptions id; Type: DEFAULT; Schema: public; Owner: pgadmin
--

ALTER TABLE ONLY public.consumptions ALTER COLUMN id SET DEFAULT nextval('public.consumptions_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: pgadmin
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: consumptions consumptions_pkey; Type: CONSTRAINT; Schema: public; Owner: pgadmin
--

ALTER TABLE ONLY public.consumptions
    ADD CONSTRAINT consumptions_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: pgadmin
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: consumptions trigger_data_insert; Type: TRIGGER; Schema: public; Owner: pgadmin
--

CREATE TRIGGER trigger_data_insert 
AFTER INSERT ON public.consumptions 
FOR EACH ROW EXECUTE FUNCTION public.trigger_cons_data();


--
-- PostgreSQL database dump complete
--

