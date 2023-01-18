--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)

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

DROP DATABASE ng;
--
-- Name: ng; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE ng WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE ng OWNER TO freecodecamp;

\connect ng

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: users; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    username character varying(22),
    games_played integer DEFAULT 0,
    best_game integer DEFAULT 0
);


ALTER TABLE public.users OWNER TO freecodecamp;

--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_user_id_seq OWNER TO freecodecamp;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.users VALUES (104, 'billy', 3, 1);
INSERT INTO public.users VALUES (98, 'user_1674012061924', 2, 738);
INSERT INTO public.users VALUES (112, 'user_1674012269827', 2, 413);
INSERT INTO public.users VALUES (97, 'user_1674012061925', 5, 10);
INSERT INTO public.users VALUES (111, 'user_1674012269828', 5, 177);
INSERT INTO public.users VALUES (100, 'user_1674012109437', 2, 626);
INSERT INTO public.users VALUES (99, 'user_1674012109438', 5, 293);
INSERT INTO public.users VALUES (101, 'BILLY', 1, 1);
INSERT INTO public.users VALUES (114, 'user_1674012298207', 2, 144);
INSERT INTO public.users VALUES (103, 'user_1674012121591', 2, 691);
INSERT INTO public.users VALUES (113, 'user_1674012298208', 5, 395);
INSERT INTO public.users VALUES (102, 'user_1674012121592', 5, 191);
INSERT INTO public.users VALUES (106, 'user_1674012139494', 2, 600);
INSERT INTO public.users VALUES (105, 'user_1674012139495', 5, 262);
INSERT INTO public.users VALUES (108, 'user_1674012181116', 2, 255);
INSERT INTO public.users VALUES (107, 'user_1674012181117', 5, 312);
INSERT INTO public.users VALUES (110, 'user_1674012187595', 2, 120);
INSERT INTO public.users VALUES (109, 'user_1674012187596', 5, 427);


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.users_user_id_seq', 114, true);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- PostgreSQL database dump complete
--

