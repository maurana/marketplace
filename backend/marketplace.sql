--
-- PostgreSQL database dump
--

-- Dumped from database version 16.4 (Debian 16.4-1)
-- Dumped by pg_dump version 16.4 (Debian 16.4-1)

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
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_migrations (
    id bigint NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.django_migrations ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: v1_categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.v1_categories (
    categories_id bigint NOT NULL,
    categories_name character varying(250) NOT NULL
);


ALTER TABLE public.v1_categories OWNER TO postgres;

--
-- Name: v1_categories_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.v1_categories ALTER COLUMN categories_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.v1_categories_categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: v1_order_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.v1_order_items (
    item_id bigint NOT NULL,
    item_price double precision DEFAULT 0.0 NOT NULL,
    item_stock integer DEFAULT 0 NOT NULL,
    orders_id bigint NOT NULL,
    products_id bigint NOT NULL
);


ALTER TABLE public.v1_order_items OWNER TO postgres;

--
-- Name: v1_order_items_item_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.v1_order_items ALTER COLUMN item_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.v1_order_items_item_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: v1_orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.v1_orders (
    orders_id bigint NOT NULL,
    customer_name character varying(250) NOT NULL,
    customer_email character varying(250) NOT NULL,
    total_item integer DEFAULT 0 NOT NULL,
    total_price double precision DEFAULT 0.0 NOT NULL,
    orders_date date
);


ALTER TABLE public.v1_orders OWNER TO postgres;

--
-- Name: v1_orders_orders_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.v1_orders ALTER COLUMN orders_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.v1_orders_orders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: v1_products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.v1_products (
    products_id bigint NOT NULL,
    products_name character varying(250) NOT NULL,
    products_price double precision DEFAULT 0.0 NOT NULL,
    products_stock integer DEFAULT 0 NOT NULL,
    products_desc text,
    products_image character varying(100) NOT NULL,
    categories_id bigint NOT NULL
);


ALTER TABLE public.v1_products OWNER TO postgres;

--
-- Name: v1_products_products_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.v1_products ALTER COLUMN products_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.v1_products_products_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	v1	0001_initial	2024-12-01 00:55:14.234888+07
\.


--
-- Data for Name: v1_categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.v1_categories (categories_id, categories_name) FROM stdin;
1	Information
2	Publication
3	Technology
4	Story
5	Education
6	Religion
7	Health
8	Business & Investment
\.


--
-- Data for Name: v1_order_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.v1_order_items (item_id, item_price, item_stock, orders_id, products_id) FROM stdin;
1	999999	2	1	13
2	888888	2	1	14
3	777777	2	1	15
4	72000	5	2	30
5	76227	5	2	1
6	68000	1	3	2
7	271981	1	3	11
8	257000.04	1	3	10
9	396000	1	3	12
10	72000	5	4	30
11	104839.89	4	4	29
12	195563.66	3	4	28
13	82599.74	2	4	27
14	158584.77	1	4	26
15	301447.23	2	5	3
16	554796.25	2	5	4
17	571146.47	2	5	5
18	777825.93	2	5	6
19	322559.65	1	5	7
20	1698517.84	1	5	9
21	76227	1	6	1
22	317321.23	1	6	8
23	475426.26	1	6	18
24	682423.2	1	6	19
25	598291.01	1	6	23
26	68638.33	1	6	24
27	777777	1	6	15
28	76227	1	7	1
29	317321.23	1	7	8
30	475426.26	1	7	18
31	682423.2	1	7	19
32	598291.01	1	7	23
33	68638.33	1	7	24
34	777777	1	7	15
35	383357.06	1	8	21
\.


--
-- Data for Name: v1_orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.v1_orders (orders_id, customer_name, customer_email, total_item, total_price, orders_date) FROM stdin;
1	Vladimir Putin	vladimir@gmail.com	3	5333328	2024-11-30
2	Maulana	maulana69@gmail.com	2	741135	2024-11-30
3	Zhao Liu	zhaoliu@gmail.com	4	992981.04	2024-11-30
4	Maulana Ajah	maulana@gmail.com	5	1689834.79	2024-11-30
5	Thom Haye	haye19@gmail.com	6	6431509.250000001	2024-11-30
6	Rockefeller	rockefeller@gmail.com	7	2996104.03	2024-11-30
7	Rothschild	rothschild@gmail.com	7	2996104.03	2024-11-30
8	Bob Marley	marley@gmail.com	1	383357.06	2024-11-30
\.


--
-- Data for Name: v1_products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.v1_products (products_id, products_name, products_price, products_stock, products_desc, products_image, categories_id) FROM stdin;
16	Harry Potter And The Deathly Hallows	317479.97	5000	Novel yang mengisahkan tentang pencarian Harry Potter untuk menghancurkan Horcrux, imortalitas Lord Voldemort	products_image/IMG_20241128_045112.jpg	4
17	Doraemon Vol 6	250000	5000	Komik manga jepang yang mengisahkan robot kucing dari abad 22	products_image/IMG_20241128_045142.jpg	4
20	Traditional Chinese Medicine	412565.22	5000	Traditional Chinese medicine is one of the most renowned and most controversial scientific achievements of ancient Chinese civilisation	products_image/IMG_20241128_050556.jpg	7
22	For Anonymous	253825.24	5000	How a mysterious hacker collective transformed the world	products_image/IMG_20241128_050646.jpg	5
25	Advanced Technologies In Modern Robotics Applictions	1674072.39	5000	Presents in a systematic manner the advanced technologies used for various modern robot applications	products_image/IMG_20241128_052835.jpg	3
13	Al Quran	999999	4998	Kitab suci agama Islam	products_image/IMG_20241128_043605.jpg	6
14	Bible	888888	4998	Kitab suci agama Kristen	products_image/IMG_20241128_043654.jpg	6
1	Indonesia Dalam Rekayasa Kehidupan	76227	4993	Sebuah perenungan anak bangsa menghadapi Globalisasi	products_image/IMG_20241128_041024.jpg	1
3	The Nature Of Technology	301447.23	4998	More than anything else technology creates our world	products_image/IMG_20241128_041147.jpg	3
8	Covid 19: The Great Reset	317321.23	4998	A guide for anyone who wants to understand how COVID-19 disrupted our social and economic systems, and what changes will be needed to create a more inclusive, resilient and sustainable world going forward	products_image/IMG_20241128_041656.jpg	2
2	Rich Dad Poor Dad	68000	4999	Membahas tentang pentingnya pemahaman keuangan dan membuat keputusan keuangan yang bijak	products_image/IMG_20241128_041115.jpg	8
11	Think And Grow Rich	271981	4999	Karya klasik yang menawarkan kebijaksanaan untuk pertumbuhan pribadi dan kelimpahan finansial	products_image/IMG_20241128_042023.jpg	8
10	The Lean Startup	257000.04	4999	Most startups fail, but many of those failures are preventable	products_image/IMG_20241128_041910.jpg	8
12	The Intelligent Investor	396000	4999	The definitive book on value investing	products_image/IMG_20241128_042048.jpg	8
30	Perjuangan Mempertahankan Kemerdekaan Indonesia	72000	4990	Perjuangan rakyat Indonesia tidak berhenti setelah proklamasi kemerdekaan. Para penjajah yang masih ingin merebut Indonesia, membuat rakyat bersatu untuk mempertahankan kemerdekaan	products_image/IMG_20241128_054846.jpg	1
29	Jazz Styles	104839.89	4996	History jazz and music analysis	products_image/IMG_20241128_054828.jpg	2
28	Relativity	195563.66	4997	The Special & General Theory	products_image/IMG_20241128_054810.jpg	5
27	Interstellar Space Journey	82599.74	4998	A book about interstellar space exploration can help them see how wondrous the idea is for mankind	products_image/IMG_20241128_054737.jpg	4
26	Sundaland	158584.77	4999	The history of the asian landmass that started sinking after the ice age	products_image/IMG_20241128_052901.jpg	5
4	Fundamentals Of Software Engineering	554796.25	4998	Designed to provide an insight into the software engineering concepts	products_image/IMG_20241128_041244.jpg	5
5	Bitcoin And Cryptocurrency Technologies	571146.47	4998	An authoritative introduction to the exciting new technologies of digital money	products_image/IMG_20241128_041414.jpg	3
6	Programming Fundamentals	777825.93	4998	A modular structured approach using C++	products_image/IMG_20241128_041450.jpg	5
7	Good Health In The 21st Century	322559.65	4999	A family doctor's unconventional guide	products_image/IMG_20241128_041544.jpg	7
9	Encyclopedia Of Artificial Intelligence	1698517.84	4999	The past, present and future of AI	products_image/IMG_20241128_041810.jpg	3
21	So Much Things To Say	383357.06	4999	The oral history of Bob Marley	products_image/IMG_20241128_050623.jpg	4
18	The Federal Reserve System	475426.26	4998	Federal Reserve System (FRS) adalah bank sentral Amerika Serikat yang dikenal dengan sebutan The Fed. Bank sentral adalah lembaga keuangan yang diberikan kontrol istimewa atas produksi dan distribusi uang dan kredit untuk suatu negara atau sekelompok negara	products_image/IMG_20241128_045228.jpg	2
19	Book Of The Fallen	682423.2	4998	Satanic theory, ethics, and practice. The Satanic community has historically been plagued by division and conflict. Segregated along theological lines, Satanism as a whole has suffered a crisis of identity in the modern era	products_image/IMG_20241128_045317.jpg	1
23	The Illuminati	598291.01	4998	The secret society that hijacked the world	products_image/IMG_20241128_050723.jpg	1
24	MIT Mossad CIA Gladio	68638.33	4998	Sebuah buku yang membahas dan memproses aktivitas kerja menakjubkan dari organisasi spionase (intelijen) terbesar di dunia	products_image/IMG_20241128_052800.jpg	4
15	Taurat	777777	4996	Kitab suci agama Yahudi	products_image/IMG_20241128_043749.jpg	6
\.


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 1, true);


--
-- Name: v1_categories_categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.v1_categories_categories_id_seq', 8, true);


--
-- Name: v1_order_items_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.v1_order_items_item_id_seq', 35, true);


--
-- Name: v1_orders_orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.v1_orders_orders_id_seq', 8, true);


--
-- Name: v1_products_products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.v1_products_products_id_seq', 30, true);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: v1_categories v1_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.v1_categories
    ADD CONSTRAINT v1_categories_pkey PRIMARY KEY (categories_id);


--
-- Name: v1_order_items v1_order_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.v1_order_items
    ADD CONSTRAINT v1_order_items_pkey PRIMARY KEY (item_id);


--
-- Name: v1_orders v1_orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.v1_orders
    ADD CONSTRAINT v1_orders_pkey PRIMARY KEY (orders_id);


--
-- Name: v1_products v1_products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.v1_products
    ADD CONSTRAINT v1_products_pkey PRIMARY KEY (products_id);


--
-- Name: v1_order_items_orders_id_f9baf5e5; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX v1_order_items_orders_id_f9baf5e5 ON public.v1_order_items USING btree (orders_id);


--
-- Name: v1_order_items_products_id_ba190a6c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX v1_order_items_products_id_ba190a6c ON public.v1_order_items USING btree (products_id);


--
-- Name: v1_products_categories_id_15326234; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX v1_products_categories_id_15326234 ON public.v1_products USING btree (categories_id);


--
-- Name: v1_order_items v1_order_items_orders_id_f9baf5e5_fk_v1_orders_orders_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.v1_order_items
    ADD CONSTRAINT v1_order_items_orders_id_f9baf5e5_fk_v1_orders_orders_id FOREIGN KEY (orders_id) REFERENCES public.v1_orders(orders_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: v1_order_items v1_order_items_products_id_ba190a6c_fk_v1_products_products_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.v1_order_items
    ADD CONSTRAINT v1_order_items_products_id_ba190a6c_fk_v1_products_products_id FOREIGN KEY (products_id) REFERENCES public.v1_products(products_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: v1_products v1_products_categories_id_15326234_fk_v1_catego; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.v1_products
    ADD CONSTRAINT v1_products_categories_id_15326234_fk_v1_catego FOREIGN KEY (categories_id) REFERENCES public.v1_categories(categories_id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--
