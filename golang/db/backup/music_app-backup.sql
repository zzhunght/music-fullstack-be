PGDMP      #                |         	   music_app    16.2 (Debian 16.2-1.pgdg120+2)    16.2 |    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    16384 	   music_app    DATABASE     t   CREATE DATABASE music_app WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';
    DROP DATABASE music_app;
                postgres    false            �            1259    16408    accounts    TABLE     �  CREATE TABLE public.accounts (
    id integer NOT NULL,
    name character varying NOT NULL,
    email character varying NOT NULL,
    password character varying NOT NULL,
    role_id integer DEFAULT 1 NOT NULL,
    is_verify boolean DEFAULT false NOT NULL,
    secret_key character varying,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone
);
    DROP TABLE public.accounts;
       public         heap    postgres    false            �            1259    16407    accounts_id_seq    SEQUENCE     �   CREATE SEQUENCE public.accounts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.accounts_id_seq;
       public          postgres    false    219            �           0    0    accounts_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.accounts_id_seq OWNED BY public.accounts.id;
          public          postgres    false    218            �            1259    16475    albums    TABLE     
  CREATE TABLE public.albums (
    id integer NOT NULL,
    artist_id integer NOT NULL,
    name character varying NOT NULL,
    thumbnail character varying NOT NULL,
    release_date date NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL
);
    DROP TABLE public.albums;
       public         heap    postgres    false            �            1259    16474    albums_id_seq    SEQUENCE     �   CREATE SEQUENCE public.albums_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.albums_id_seq;
       public          postgres    false    233            �           0    0    albums_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.albums_id_seq OWNED BY public.albums.id;
          public          postgres    false    232            �            1259    16485    albums_songs    TABLE     �   CREATE TABLE public.albums_songs (
    id integer NOT NULL,
    song_id integer NOT NULL,
    album_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT now()
);
     DROP TABLE public.albums_songs;
       public         heap    postgres    false            �            1259    16484    albums_songs_id_seq    SEQUENCE     �   CREATE SEQUENCE public.albums_songs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.albums_songs_id_seq;
       public          postgres    false    235            �           0    0    albums_songs_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.albums_songs_id_seq OWNED BY public.albums_songs.id;
          public          postgres    false    234            �            1259    16458    artist    TABLE     �   CREATE TABLE public.artist (
    id integer NOT NULL,
    name character varying NOT NULL,
    avatar_url character varying,
    created_at timestamp without time zone DEFAULT now()
);
    DROP TABLE public.artist;
       public         heap    postgres    false            �            1259    16519    artist_follow    TABLE     �   CREATE TABLE public.artist_follow (
    id integer NOT NULL,
    account_id integer NOT NULL,
    artist_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT now()
);
 !   DROP TABLE public.artist_follow;
       public         heap    postgres    false            �            1259    16518    artist_follow_id_seq    SEQUENCE     �   CREATE SEQUENCE public.artist_follow_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.artist_follow_id_seq;
       public          postgres    false    243            �           0    0    artist_follow_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.artist_follow_id_seq OWNED BY public.artist_follow.id;
          public          postgres    false    242            �            1259    16457    artist_id_seq    SEQUENCE     �   CREATE SEQUENCE public.artist_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.artist_id_seq;
       public          postgres    false    229            �           0    0    artist_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.artist_id_seq OWNED BY public.artist.id;
          public          postgres    false    228            �            1259    16440 
   categories    TABLE     �   CREATE TABLE public.categories (
    id integer NOT NULL,
    name character varying NOT NULL,
    created_at timestamp without time zone DEFAULT now()
);
    DROP TABLE public.categories;
       public         heap    postgres    false            �            1259    16439    categories_id_seq    SEQUENCE     �   CREATE SEQUENCE public.categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.categories_id_seq;
       public          postgres    false    225            �           0    0    categories_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;
          public          postgres    false    224            �            1259    16511    favorite_albums    TABLE     �   CREATE TABLE public.favorite_albums (
    id integer NOT NULL,
    account_id integer NOT NULL,
    album_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT now()
);
 #   DROP TABLE public.favorite_albums;
       public         heap    postgres    false            �            1259    16510    favorite_albums_id_seq    SEQUENCE     �   CREATE SEQUENCE public.favorite_albums_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.favorite_albums_id_seq;
       public          postgres    false    241            �           0    0    favorite_albums_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.favorite_albums_id_seq OWNED BY public.favorite_albums.id;
          public          postgres    false    240            �            1259    16432    favorite_songs    TABLE     �   CREATE TABLE public.favorite_songs (
    id integer NOT NULL,
    account_id integer NOT NULL,
    song_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT now()
);
 "   DROP TABLE public.favorite_songs;
       public         heap    postgres    false            �            1259    16431    favorite_songs_id_seq    SEQUENCE     �   CREATE SEQUENCE public.favorite_songs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.favorite_songs_id_seq;
       public          postgres    false    223            �           0    0    favorite_songs_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.favorite_songs_id_seq OWNED BY public.favorite_songs.id;
          public          postgres    false    222            �            1259    16493    playlist    TABLE     �   CREATE TABLE public.playlist (
    id integer NOT NULL,
    name character varying NOT NULL,
    account_id integer NOT NULL,
    description character varying,
    created_at timestamp without time zone DEFAULT now()
);
    DROP TABLE public.playlist;
       public         heap    postgres    false            �            1259    16492    playlist_id_seq    SEQUENCE     �   CREATE SEQUENCE public.playlist_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.playlist_id_seq;
       public          postgres    false    237            �           0    0    playlist_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.playlist_id_seq OWNED BY public.playlist.id;
          public          postgres    false    236            �            1259    16503    playlist_song    TABLE     �   CREATE TABLE public.playlist_song (
    id integer NOT NULL,
    playlist_id integer NOT NULL,
    song_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT now()
);
 !   DROP TABLE public.playlist_song;
       public         heap    postgres    false            �            1259    16502    playlist_song_id_seq    SEQUENCE     �   CREATE SEQUENCE public.playlist_song_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.playlist_song_id_seq;
       public          postgres    false    239            �           0    0    playlist_song_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.playlist_song_id_seq OWNED BY public.playlist_song.id;
          public          postgres    false    238            �            1259    16398    roles    TABLE     �   CREATE TABLE public.roles (
    id integer NOT NULL,
    name character varying NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone
);
    DROP TABLE public.roles;
       public         heap    postgres    false            �            1259    16397    roles_id_seq    SEQUENCE     �   CREATE SEQUENCE public.roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.roles_id_seq;
       public          postgres    false    217            �           0    0    roles_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;
          public          postgres    false    216            �            1259    16389    session    TABLE     :  CREATE TABLE public.session (
    id uuid NOT NULL,
    email character varying NOT NULL,
    client_agent character varying NOT NULL,
    refresh_token character varying NOT NULL,
    client_ip character varying NOT NULL,
    is_block boolean DEFAULT false,
    expired_at timestamp without time zone NOT NULL
);
    DROP TABLE public.session;
       public         heap    postgres    false            �            1259    16450    song_categories    TABLE     �   CREATE TABLE public.song_categories (
    id integer NOT NULL,
    song_id integer NOT NULL,
    category_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT now()
);
 #   DROP TABLE public.song_categories;
       public         heap    postgres    false            �            1259    16449    song_categories_id_seq    SEQUENCE     �   CREATE SEQUENCE public.song_categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.song_categories_id_seq;
       public          postgres    false    227            �           0    0    song_categories_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.song_categories_id_seq OWNED BY public.song_categories.id;
          public          postgres    false    226            �            1259    16422    songs    TABLE     =  CREATE TABLE public.songs (
    id integer NOT NULL,
    name character varying NOT NULL,
    thumbnail character varying,
    path character varying,
    lyrics text,
    duration integer,
    release_date date,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone
);
    DROP TABLE public.songs;
       public         heap    postgres    false            �            1259    16468    songs_artist    TABLE     �   CREATE TABLE public.songs_artist (
    id integer NOT NULL,
    song_id integer NOT NULL,
    artist_id integer NOT NULL,
    owner boolean NOT NULL
);
     DROP TABLE public.songs_artist;
       public         heap    postgres    false            �            1259    16467    songs_artist_id_seq    SEQUENCE     �   CREATE SEQUENCE public.songs_artist_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.songs_artist_id_seq;
       public          postgres    false    231            �           0    0    songs_artist_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.songs_artist_id_seq OWNED BY public.songs_artist.id;
          public          postgres    false    230            �            1259    16421    songs_id_seq    SEQUENCE     �   CREATE SEQUENCE public.songs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.songs_id_seq;
       public          postgres    false    221            �           0    0    songs_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.songs_id_seq OWNED BY public.songs.id;
          public          postgres    false    220            �           2604    16411    accounts id    DEFAULT     j   ALTER TABLE ONLY public.accounts ALTER COLUMN id SET DEFAULT nextval('public.accounts_id_seq'::regclass);
 :   ALTER TABLE public.accounts ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    219    218    219            �           2604    16478 	   albums id    DEFAULT     f   ALTER TABLE ONLY public.albums ALTER COLUMN id SET DEFAULT nextval('public.albums_id_seq'::regclass);
 8   ALTER TABLE public.albums ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    232    233    233            �           2604    16488    albums_songs id    DEFAULT     r   ALTER TABLE ONLY public.albums_songs ALTER COLUMN id SET DEFAULT nextval('public.albums_songs_id_seq'::regclass);
 >   ALTER TABLE public.albums_songs ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    234    235    235            �           2604    16461 	   artist id    DEFAULT     f   ALTER TABLE ONLY public.artist ALTER COLUMN id SET DEFAULT nextval('public.artist_id_seq'::regclass);
 8   ALTER TABLE public.artist ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    229    228    229            �           2604    16522    artist_follow id    DEFAULT     t   ALTER TABLE ONLY public.artist_follow ALTER COLUMN id SET DEFAULT nextval('public.artist_follow_id_seq'::regclass);
 ?   ALTER TABLE public.artist_follow ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    242    243    243            �           2604    16443    categories id    DEFAULT     n   ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);
 <   ALTER TABLE public.categories ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    225    224    225            �           2604    16514    favorite_albums id    DEFAULT     x   ALTER TABLE ONLY public.favorite_albums ALTER COLUMN id SET DEFAULT nextval('public.favorite_albums_id_seq'::regclass);
 A   ALTER TABLE public.favorite_albums ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    240    241    241            �           2604    16435    favorite_songs id    DEFAULT     v   ALTER TABLE ONLY public.favorite_songs ALTER COLUMN id SET DEFAULT nextval('public.favorite_songs_id_seq'::regclass);
 @   ALTER TABLE public.favorite_songs ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    222    223    223            �           2604    16496    playlist id    DEFAULT     j   ALTER TABLE ONLY public.playlist ALTER COLUMN id SET DEFAULT nextval('public.playlist_id_seq'::regclass);
 :   ALTER TABLE public.playlist ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    237    236    237            �           2604    16506    playlist_song id    DEFAULT     t   ALTER TABLE ONLY public.playlist_song ALTER COLUMN id SET DEFAULT nextval('public.playlist_song_id_seq'::regclass);
 ?   ALTER TABLE public.playlist_song ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    239    238    239            �           2604    16401    roles id    DEFAULT     d   ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);
 7   ALTER TABLE public.roles ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    216    217    217            �           2604    16453    song_categories id    DEFAULT     x   ALTER TABLE ONLY public.song_categories ALTER COLUMN id SET DEFAULT nextval('public.song_categories_id_seq'::regclass);
 A   ALTER TABLE public.song_categories ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    227    226    227            �           2604    16425    songs id    DEFAULT     d   ALTER TABLE ONLY public.songs ALTER COLUMN id SET DEFAULT nextval('public.songs_id_seq'::regclass);
 7   ALTER TABLE public.songs ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    220    221    221            �           2604    16471    songs_artist id    DEFAULT     r   ALTER TABLE ONLY public.songs_artist ALTER COLUMN id SET DEFAULT nextval('public.songs_artist_id_seq'::regclass);
 >   ALTER TABLE public.songs_artist ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    230    231    231            �          0    16408    accounts 
   TABLE DATA           u   COPY public.accounts (id, name, email, password, role_id, is_verify, secret_key, created_at, updated_at) FROM stdin;
    public          postgres    false    219   ��       �          0    16475    albums 
   TABLE DATA           Z   COPY public.albums (id, artist_id, name, thumbnail, release_date, created_at) FROM stdin;
    public          postgres    false    233   ^�       �          0    16485    albums_songs 
   TABLE DATA           I   COPY public.albums_songs (id, song_id, album_id, created_at) FROM stdin;
    public          postgres    false    235   {�       �          0    16458    artist 
   TABLE DATA           B   COPY public.artist (id, name, avatar_url, created_at) FROM stdin;
    public          postgres    false    229   ��       �          0    16519    artist_follow 
   TABLE DATA           N   COPY public.artist_follow (id, account_id, artist_id, created_at) FROM stdin;
    public          postgres    false    243   K�       �          0    16440 
   categories 
   TABLE DATA           :   COPY public.categories (id, name, created_at) FROM stdin;
    public          postgres    false    225   h�       �          0    16511    favorite_albums 
   TABLE DATA           O   COPY public.favorite_albums (id, account_id, album_id, created_at) FROM stdin;
    public          postgres    false    241   �       �          0    16432    favorite_songs 
   TABLE DATA           M   COPY public.favorite_songs (id, account_id, song_id, created_at) FROM stdin;
    public          postgres    false    223   �       �          0    16493    playlist 
   TABLE DATA           Q   COPY public.playlist (id, name, account_id, description, created_at) FROM stdin;
    public          postgres    false    237   (�       �          0    16503    playlist_song 
   TABLE DATA           M   COPY public.playlist_song (id, playlist_id, song_id, created_at) FROM stdin;
    public          postgres    false    239   E�       �          0    16398    roles 
   TABLE DATA           A   COPY public.roles (id, name, created_at, updated_at) FROM stdin;
    public          postgres    false    217   b�       �          0    16389    session 
   TABLE DATA           j   COPY public.session (id, email, client_agent, refresh_token, client_ip, is_block, expired_at) FROM stdin;
    public          postgres    false    215   ��       �          0    16450    song_categories 
   TABLE DATA           O   COPY public.song_categories (id, song_id, category_id, created_at) FROM stdin;
    public          postgres    false    227   �       �          0    16422    songs 
   TABLE DATA           r   COPY public.songs (id, name, thumbnail, path, lyrics, duration, release_date, created_at, updated_at) FROM stdin;
    public          postgres    false    221   �       �          0    16468    songs_artist 
   TABLE DATA           E   COPY public.songs_artist (id, song_id, artist_id, owner) FROM stdin;
    public          postgres    false    231   O�       �           0    0    accounts_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.accounts_id_seq', 1, true);
          public          postgres    false    218            �           0    0    albums_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.albums_id_seq', 1, false);
          public          postgres    false    232            �           0    0    albums_songs_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.albums_songs_id_seq', 1, false);
          public          postgres    false    234            �           0    0    artist_follow_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.artist_follow_id_seq', 1, false);
          public          postgres    false    242            �           0    0    artist_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.artist_id_seq', 35, true);
          public          postgres    false    228            �           0    0    categories_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.categories_id_seq', 8, true);
          public          postgres    false    224            �           0    0    favorite_albums_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.favorite_albums_id_seq', 1, false);
          public          postgres    false    240            �           0    0    favorite_songs_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.favorite_songs_id_seq', 1, false);
          public          postgres    false    222            �           0    0    playlist_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.playlist_id_seq', 1, false);
          public          postgres    false    236            �           0    0    playlist_song_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.playlist_song_id_seq', 1, false);
          public          postgres    false    238            �           0    0    roles_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.roles_id_seq', 2, true);
          public          postgres    false    216            �           0    0    song_categories_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.song_categories_id_seq', 1, false);
          public          postgres    false    226            �           0    0    songs_artist_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.songs_artist_id_seq', 152, true);
          public          postgres    false    230            �           0    0    songs_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.songs_id_seq', 188, true);
          public          postgres    false    220            �           2606    16420    accounts accounts_email_key 
   CONSTRAINT     W   ALTER TABLE ONLY public.accounts
    ADD CONSTRAINT accounts_email_key UNIQUE (email);
 E   ALTER TABLE ONLY public.accounts DROP CONSTRAINT accounts_email_key;
       public            postgres    false    219            �           2606    16418    accounts accounts_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.accounts
    ADD CONSTRAINT accounts_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.accounts DROP CONSTRAINT accounts_pkey;
       public            postgres    false    219            �           2606    16483    albums albums_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.albums
    ADD CONSTRAINT albums_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.albums DROP CONSTRAINT albums_pkey;
       public            postgres    false    233            �           2606    16491    albums_songs albums_songs_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.albums_songs
    ADD CONSTRAINT albums_songs_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.albums_songs DROP CONSTRAINT albums_songs_pkey;
       public            postgres    false    235                       2606    16525     artist_follow artist_follow_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.artist_follow
    ADD CONSTRAINT artist_follow_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.artist_follow DROP CONSTRAINT artist_follow_pkey;
       public            postgres    false    243            �           2606    16466    artist artist_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.artist
    ADD CONSTRAINT artist_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.artist DROP CONSTRAINT artist_pkey;
       public            postgres    false    229            �           2606    16448    categories categories_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.categories DROP CONSTRAINT categories_pkey;
       public            postgres    false    225                       2606    16517 $   favorite_albums favorite_albums_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.favorite_albums
    ADD CONSTRAINT favorite_albums_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.favorite_albums DROP CONSTRAINT favorite_albums_pkey;
       public            postgres    false    241            �           2606    16438 "   favorite_songs favorite_songs_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.favorite_songs
    ADD CONSTRAINT favorite_songs_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.favorite_songs DROP CONSTRAINT favorite_songs_pkey;
       public            postgres    false    223                        2606    16501    playlist playlist_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.playlist
    ADD CONSTRAINT playlist_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.playlist DROP CONSTRAINT playlist_pkey;
       public            postgres    false    237                       2606    16509     playlist_song playlist_song_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.playlist_song
    ADD CONSTRAINT playlist_song_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.playlist_song DROP CONSTRAINT playlist_song_pkey;
       public            postgres    false    239            �           2606    16406    roles roles_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.roles DROP CONSTRAINT roles_pkey;
       public            postgres    false    217            �           2606    16396    session session_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.session
    ADD CONSTRAINT session_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.session DROP CONSTRAINT session_pkey;
       public            postgres    false    215            �           2606    16456 $   song_categories song_categories_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.song_categories
    ADD CONSTRAINT song_categories_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.song_categories DROP CONSTRAINT song_categories_pkey;
       public            postgres    false    227            �           2606    16473    songs_artist songs_artist_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.songs_artist
    ADD CONSTRAINT songs_artist_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.songs_artist DROP CONSTRAINT songs_artist_pkey;
       public            postgres    false    231            �           2606    16430    songs songs_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.songs
    ADD CONSTRAINT songs_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.songs DROP CONSTRAINT songs_pkey;
       public            postgres    false    221            �           1259    16526    songs_name_idx    INDEX     @   CREATE INDEX songs_name_idx ON public.songs USING btree (name);
 "   DROP INDEX public.songs_name_idx;
       public            postgres    false    221                       2606    16527    accounts accounts_role_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.accounts
    ADD CONSTRAINT accounts_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.roles(id) ON UPDATE CASCADE ON DELETE CASCADE;
 H   ALTER TABLE ONLY public.accounts DROP CONSTRAINT accounts_role_id_fkey;
       public          postgres    false    217    219    3305                       2606    16562    albums albums_artist_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.albums
    ADD CONSTRAINT albums_artist_id_fkey FOREIGN KEY (artist_id) REFERENCES public.artist(id) ON UPDATE CASCADE ON DELETE CASCADE;
 F   ALTER TABLE ONLY public.albums DROP CONSTRAINT albums_artist_id_fkey;
       public          postgres    false    229    3320    233                       2606    16567 '   albums_songs albums_songs_album_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.albums_songs
    ADD CONSTRAINT albums_songs_album_id_fkey FOREIGN KEY (album_id) REFERENCES public.albums(id) ON UPDATE CASCADE ON DELETE CASCADE;
 Q   ALTER TABLE ONLY public.albums_songs DROP CONSTRAINT albums_songs_album_id_fkey;
       public          postgres    false    3324    235    233                       2606    16572 &   albums_songs albums_songs_song_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.albums_songs
    ADD CONSTRAINT albums_songs_song_id_fkey FOREIGN KEY (song_id) REFERENCES public.songs(id) ON UPDATE CASCADE ON DELETE CASCADE;
 P   ALTER TABLE ONLY public.albums_songs DROP CONSTRAINT albums_songs_song_id_fkey;
       public          postgres    false    3312    221    235                       2606    16602 +   artist_follow artist_follow_account_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.artist_follow
    ADD CONSTRAINT artist_follow_account_id_fkey FOREIGN KEY (account_id) REFERENCES public.accounts(id) ON UPDATE CASCADE ON DELETE CASCADE;
 U   ALTER TABLE ONLY public.artist_follow DROP CONSTRAINT artist_follow_account_id_fkey;
       public          postgres    false    3309    243    219                       2606    16607 *   artist_follow artist_follow_artist_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.artist_follow
    ADD CONSTRAINT artist_follow_artist_id_fkey FOREIGN KEY (artist_id) REFERENCES public.artist(id) ON UPDATE CASCADE ON DELETE CASCADE;
 T   ALTER TABLE ONLY public.artist_follow DROP CONSTRAINT artist_follow_artist_id_fkey;
       public          postgres    false    229    3320    243                       2606    16592 /   favorite_albums favorite_albums_account_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.favorite_albums
    ADD CONSTRAINT favorite_albums_account_id_fkey FOREIGN KEY (account_id) REFERENCES public.accounts(id) ON UPDATE CASCADE ON DELETE CASCADE;
 Y   ALTER TABLE ONLY public.favorite_albums DROP CONSTRAINT favorite_albums_account_id_fkey;
       public          postgres    false    241    3309    219                       2606    16597 -   favorite_albums favorite_albums_album_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.favorite_albums
    ADD CONSTRAINT favorite_albums_album_id_fkey FOREIGN KEY (album_id) REFERENCES public.albums(id) ON UPDATE CASCADE ON DELETE CASCADE;
 W   ALTER TABLE ONLY public.favorite_albums DROP CONSTRAINT favorite_albums_album_id_fkey;
       public          postgres    false    3324    241    233                       2606    16537 -   favorite_songs favorite_songs_account_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.favorite_songs
    ADD CONSTRAINT favorite_songs_account_id_fkey FOREIGN KEY (account_id) REFERENCES public.accounts(id) ON UPDATE CASCADE ON DELETE CASCADE;
 W   ALTER TABLE ONLY public.favorite_songs DROP CONSTRAINT favorite_songs_account_id_fkey;
       public          postgres    false    219    3309    223            	           2606    16532 *   favorite_songs favorite_songs_song_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.favorite_songs
    ADD CONSTRAINT favorite_songs_song_id_fkey FOREIGN KEY (song_id) REFERENCES public.songs(id) ON UPDATE CASCADE ON DELETE CASCADE;
 T   ALTER TABLE ONLY public.favorite_songs DROP CONSTRAINT favorite_songs_song_id_fkey;
       public          postgres    false    221    223    3312                       2606    16577 !   playlist playlist_account_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.playlist
    ADD CONSTRAINT playlist_account_id_fkey FOREIGN KEY (account_id) REFERENCES public.accounts(id) ON UPDATE CASCADE ON DELETE CASCADE;
 K   ALTER TABLE ONLY public.playlist DROP CONSTRAINT playlist_account_id_fkey;
       public          postgres    false    3309    237    219                       2606    16582 ,   playlist_song playlist_song_playlist_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.playlist_song
    ADD CONSTRAINT playlist_song_playlist_id_fkey FOREIGN KEY (playlist_id) REFERENCES public.playlist(id) ON UPDATE CASCADE ON DELETE CASCADE;
 V   ALTER TABLE ONLY public.playlist_song DROP CONSTRAINT playlist_song_playlist_id_fkey;
       public          postgres    false    239    3328    237                       2606    16587 (   playlist_song playlist_song_song_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.playlist_song
    ADD CONSTRAINT playlist_song_song_id_fkey FOREIGN KEY (song_id) REFERENCES public.songs(id) ON UPDATE CASCADE ON DELETE CASCADE;
 R   ALTER TABLE ONLY public.playlist_song DROP CONSTRAINT playlist_song_song_id_fkey;
       public          postgres    false    239    3312    221            
           2606    16542 0   song_categories song_categories_category_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.song_categories
    ADD CONSTRAINT song_categories_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.categories(id) ON UPDATE CASCADE ON DELETE CASCADE;
 Z   ALTER TABLE ONLY public.song_categories DROP CONSTRAINT song_categories_category_id_fkey;
       public          postgres    false    225    3316    227                       2606    16547 ,   song_categories song_categories_song_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.song_categories
    ADD CONSTRAINT song_categories_song_id_fkey FOREIGN KEY (song_id) REFERENCES public.songs(id) ON UPDATE CASCADE ON DELETE CASCADE;
 V   ALTER TABLE ONLY public.song_categories DROP CONSTRAINT song_categories_song_id_fkey;
       public          postgres    false    227    221    3312                       2606    16552 (   songs_artist songs_artist_artist_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.songs_artist
    ADD CONSTRAINT songs_artist_artist_id_fkey FOREIGN KEY (artist_id) REFERENCES public.artist(id) ON UPDATE CASCADE ON DELETE CASCADE;
 R   ALTER TABLE ONLY public.songs_artist DROP CONSTRAINT songs_artist_artist_id_fkey;
       public          postgres    false    231    229    3320                       2606    16557 &   songs_artist songs_artist_song_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.songs_artist
    ADD CONSTRAINT songs_artist_song_id_fkey FOREIGN KEY (song_id) REFERENCES public.songs(id) ON UPDATE CASCADE ON DELETE CASCADE;
 P   ALTER TABLE ONLY public.songs_artist DROP CONSTRAINT songs_artist_song_id_fkey;
       public          postgres    false    3312    231    221            �   �   x��I�0 �u9��`�)�J2EE!c��bd0�&pz�#���CK?��(��p膲���4 J�`����f�޽�N�&�����e];?�o�r6�����A-��f�~��1�zf�^gj�a��ό��� U0U��� 8�T-l[G�U*TI��\/�      �      x������ � �      �      x������ � �      �   �  x��W�n�H]3_���J�wّ��CR�N0�P)��DR)���z0��g�i`̢�Y%^�'��?�[��0��,����{��^���cR��~N�Z�{�DE��^�n,f���e$a}��E'��Q<�xb�`6��RL���K�[D��{L)N��ph��}C�k�����گ��Ё�q�9�^�ׄ���<.�zE�?�v��$���ϧ$|�$��*+���Ya�xP��5���[p�u���������v��֬�t��{��g�L_{�}S���g�Wz4��*ΰm���N��?��i���x�\�E&���|����Ϳ��u��S���e<	����<t���~r�$Mfn���=��:��>gW���w7��k��K�337��Q�D�EPO���O*�fq��>Ԑx.�.� ă�!<�0��^Ob�	�t�L_>��C(�&.����IPX���b\2D$�<L@(��(�4���@���z�EI$V��j,5�L2���\��J�K�;��XhAQ�I-�Q-%��b �b�N7��ע���3�׉�¯��s	��b��?�z=����9;Q\{s�[�c	r��E�I�T�����Zk����{JlL�`�[�}�GR����5%c�^��>K�Z(\A0���r�t"��$D�Qy$h`�,FE��.'pml&ȷ��� G Se��)�-�db�&qZw7���~��m�%ĝ\� jqhs*)\"�W�x3uּ�n>jg��Gm@,����EQ���
66\Z!��6(Ѭ\��E�:��d0������\�n�������+ԍ����"EE�Dh��()��P�(�Pߤ(7h2G�k�����%�ٿ��� �Z���V�)�
,;@��\A��bP(�׽��D���}�$D0�ٯ�6�2"xu�r��b?�D�8x�%V��I��2��1Om�9"��$x���B+2~rO�0�Y�ǳ�f@]a�'2q��ƈ`�1�t�ss�S��0�x��x�(��J1����z=���x�9IS�����n�>�u�j�|���p�"` I�n��[�r:r 2}0��)��Y/�P�@�0T6b�vt513�� ��Y��>6�����N�� �=���,�3^9��LL���no'���{v�K0�Z�q�z���Ѯ����֐dŠ
�ìG�;��`2�����6�O��/�-����4�Z'��XT5݈����,fDè#/Y(�3��jq����V�yݫ޺��Z�L�>��
�\��<�����	xk�<f�	I	�Ts�(�i�=��6�J|���J��˜���q��O��[s1m�d�b��ǵS2 ڴ ��(�"ڸ�I�~�9�]��!I������`���j��,>��+Ѝ�C��������^��)Vv��4�&k"�S7�Uиv�t�_ID�=�[�ׂ3�nƬT�
=��,JavU�{��T�F�x�U���o��j@�~������ū��p%!� x
R�����v�\���$2ET�����;x�:���`70���;����O��w=�(K��ǀ���`�M�~Q1�t���s�}}@0�X=L�p�� �IJ� �è9[|�a�#�s�h�v��<����^�}ǣ��L�����z����z�\v��(�M��v6���RL���ւP�"�����Q>z.u�~�<�� ��<�>ht��hw/L�ߓV������w�';�E{y�%1�HN�j�M���â@��?0�<5�IJy�M��.s�˫��_�j��җ�n��ӝ���0j,��w˩��l/����H���e�\�ݦ�g���>	#є�����h
:3�qv���a3�'������6�/���[z��q:7������e����;����(���Q� �v�����@����W�^��%�      �      x������ � �      �   v   x�3��/�4202�50�5�T0��2��20ҳ4152��2�<2����y�
���W�Si�����O�	�sFfN>%�������y%�����q����S`�钘���O��WbU>1z\\\ �?�      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �   ;   x�3�,-N-�4202�50�5�P04�24�22�372�03���2�LL���#�*F��� ���      �      x�͚�r�Ȗ�7Oq^@L^%� �¤d@ K1]	0������9]�����2SaE�,�T~���ڙ5R]d�&�Hȟ-��t#a��3����e�do�[t~�����h��&�����\E/������R��-k&�x�l���^�6v���~��d`�vyxZ&�:��E�:dF\ɦ�nx�ٱ6۠�ן�Р���h����[���$����-�'�Z�w���6�ޢ��.�<�q�ٵ�&���M��og{[o�J�����k���`rH��C�O�[�����^.��a�6\=6-zXz�V6�n��������Z�Od����E�q��3�Hk�����o�:�l]/���5^B��ѐ�y�������.��m�"g����K�/�߰A���"X��7��ӈ�/���Cp�c�h�4t3�y��	�4FH�EI��L�	JcN��z�k���X�SoS8���M�ś��z�/Ik�m,ɤ����� W��L�H�n���g|����kq��q�a#�!���mx�~W��E�e�Z6�m�<W��Л����q��=,�lɟ��;���%:&w(�&MA�4ѱ�RkQ̄��J��矠[Y�v݆�I1����gg<kŶ ���6h{�v��ꆺ�J�𞊤q��_*Wf����������]�����qP��~��==��/���TM�O��u�T�?ز����D� L7p'G9'��Z�#زH3	��4I)Ù��'�
�X�ZAM��8�֊-
��J�����_r�n��a��;-J�\p��d�ϰ-@��`���+۵���q]�KY��t����q��gf�u��q����~^�-[��
��r;��<&8�J��"bh�D�PJ�c̍�t��qk1�M��}�a�4�KoU ���������fl[跪._TMv�^�/��l[�P��B��j�/�k���b總��6o�dg��QzF��۵���C>�g�z���@Y�P���X�b�i����h,�r-�	�2���Td���ek����^8%H�t��N6�n��-�m�b�d�`��{��h%q�%�3���A���l�}�{�49���/�e�����-�*s���tH��ɫ�7x�����=;�z���R��]��K�g��J2gi��L�M&����`��4�P��e�Tv�<e��(/��+�,���u�d1D���AsK�Ku�k��T�K�Q���&C�]��{q�ɕ������j���Q�/�V��\��
�o��s��;�j�}+E�8|��n9t�!�"SPͤX)�-9��،b�e�'�dX�V֮U�So݂� ��#�o]?��^	��݆�js�v�ޭ��&���T��"��m2p6��ǻn�~�ج�Qd�k����2�4Z����;���a���a��_�LY)e�	30�Pa�QS�x�ǚi�LÜ��`]�M�	햻�]E	k(��o�`��k��gC,���K�*`�v����%�� ������	�*�bh�`��J��?l�'�Է���o��r�0�)���p����q����-�[��:3�n)C������<U5لh$�6��luڠ�@m�6ٚ�dǟ]k20nC��Cx	n��+h���fY4�[��"����;Eze�wW�hy���2|yMf�/��랖e6N��q��xrb>'߷��wHt52;IJp$R�%����;0�`����S�ů���S�EV#��ԗ��+�<��� *̕�ڀMn\/�88�7������AR#����܇�R�]�w��ǔ��5��X*Q��|��{�M'���?D�M`���&&����i���?��?��wH�c�K�0��a�,���iL]��5�q��)I�z�θ�( ��:�(z�ے;�'�P��5�ʒ�j�A�sݮ&[[�[���^�]�o?��ms���d���/5g�إKB}�E�)}:�?���w����'��K�ކ��|�&�;�������Di���a-Mt���Ta�L�nr(տ^��2����R��Z\�O���p >����m��j4x���4��6���զjT��\���b;k�k�P�������(��Q�Y�M�q7�W������儫]�j#��r��~M��0�#���$�`��qJ���8�~�#-22C�3C f��^�C&�tu8.YP�v}oY�w�?�<�x�	oÖ����Q�+�~�z��S�@xV+�����j2u-��v����}z��mU�9��Lغ�o���X�|/Zߌ��;�5���H�U�~��n�3%�H +��[(y�3NY�>�VC
Y�j^jWH�U0^�*�:դ�zi�/u<	��&7ʷ�-}��C�pY�Cc)`>J�9�@ޒ�j������{}�):�������*f���1Y�}[�צyfW���[C��.�\D��]��
��&b3�r\�aSD����+I���S�����w���w��~@��r�5�d�qn�o�b��R�a�x^�'٪��ߗ�o�َfk<�W������A�M�Љ�*^�I�Yl���i����F�4Ƣ#��3�sMP�kc�'�,�rj��'x��&��X�)K���ք��J�E������K��zd1l�E	�;���&�#���-�|�e���yE	��ɫg9|{\�?��d�������U1�#p������2��}vA��dK�&]a�:�1�	��$cPZ�L33=C(��6ib�a1)�[>��&�]�->�}�ف���ףr����B�A*�ׇ|�Wl!Ր���\�}v�s��a�ܢ'��y�ׇ%�l;Lw\`<��a@���ز.�BP�a9Os���k��2Pk�0�AF�r�	�@�����W>��(��O�M��DF[XW5��~���^�m}�����T"�?�v���- 	��=Yin�L�ct�lُ���y;ˎ���szE3ws�3L�~Ėw1FD�	ΰZ���kQ��aY����׳m\������a�t�X�����i�]�����ʹ�\�+��;��v�5w�Y����l1�%�
�l�����K&��@��V�a|�������ǝz}s�o��ي���A���wu���m*X��T3MlQ.�85����K�H?a��+]o^��SN�5�cŶ_���P͓�Qz#�!��͓g;S{-d���7�=�͓��"�W �@�KK��x��!�`ϖ�ޒ�/yHk����X�<�|�_����w�Lџ���l�ô˰��#SO�F1J�\�
!��p3g�'��	�s�Y;�$Ժ�[�:����y���+��5��V�k�=�}�Ox�+���Q�sY3���o__Jk?�Y��+Q�#�w��*#g�x�����aS��-�� \�aT'Y�0�0b跺�h1!XC9V��E�?avz,&;�A��	
�o��ǾL�~%=U7��K|��_Y�:v��.C�d�e�Wi%:���V�f�:z�X�r�ŁϪ�}<��3ӫ�h��4xe���2>�j#�`񦏪����_*__j��,����_���_��v �n���;lj�Zb���R��&7#ͤ��$˄)~=�p'Հ�M!�H�u^��A ܨM]h���8�Ѓ�q���o���:�7d��������n_���6#���zb���V�e�8����[�3r��6�ɟ�_�5\D(6I����PB5�9$�HMDi�E�a�Ld��vpYЮk9�P��iwȥ�^@*��� �Rw<��Z���\Y���xwT�)������]�Z���/�]�V��:VI���351 ���o6Of�7&o���uq������1o��l�\�!��^\Xe�`���HG�X�HW����фB��E�F���;�Pv�+� Y�*�^O�9���d�l�\W6���6[�����Vߴ �%ZZ˟�ʭ�-����]w�"}�p�a#�?l�c�������mgE��O�i��p�;�wMbl'MX阂\y��8��ؤ�f���FN8 ��c�yጝ��,���8�:25��X��Іk���!A1w{���7l�*��+��䟱m ?  W��A��k��!�W˷�$K�"��#�簞M��f,���~Ey\�����
L�ntr��3�$�̄�lb�F��,Gf��yn~�>_@]�[u�\bG��C;[ ȁ)���aQñ���M��7pd\u^J���Gp��\o�r�7-wƞ6��E?F���._lz��t6��t:�����w�]3DiGO͔���%z�ĥ�d�,����q�	-7,���pl3�S$����O��í�R�-����WeAl��S��^�o}����Ik����6zJz���]8�;a������cZod����w�.e����O����/��/�      �      x������ � �      �      x��i���v�Y�+� eW����` 8��8��D�gq%�S A7���F#1�}ˎ�$��۶�����v���O��>��sc;����F����D>\óֻ�z����O����|.��x.��y��������i��7��6	�o�<����ɳ�˚o�<�V]���h�f]w�i���@�J$�A.7��1��	���R�b�R�����|�"Yi�R�Ͱ�(-��W��~H(�.�N�n����aQ���Ю�<끴�#�}cE]��V�YP�3WQ(���o������^�0
�( Ss������!��W�xf�v?W��'Y�(.Z1�tNE!�1�^�6���89ǝ}�p~(0���� 'Gn��Ժ�%��1;�j.�"���#���u��x���'8@��Á�~��(e����	߿��l
$����xYn�)^u�ž���&���A��� 8"�Zl%u���)!�6����+��Ѫ�a%����@��63���'� ៏:3�|Ng��
�{��ϕpԠ�}�n��o"'��FcWwP��AMGC�4.��zm�|����,���Ǵ�W��u.�N�MO�4kט��)���TE0��RϐXXzW%G�H�IvP��c�������w����?z��vބ���	�,�a���4k@HV�쒄�Zh݈�Cc5�B��Z���y���q����J���x��ݬ�k��'�,-\�ؾ���|X��|����}�����O~�n|B��	�\��;�h�/�W��uU��d<��]��p��6�=�X����2���^�7v�m�t(RR?��>���:���������W�����y��KS��P8�:�����^9I��G^f�����|"� Zg����d�h�H.�Np��F67��*,^>��RPEf���N0<�L��Ke1��=}� �'�Cq�W�C�  d�[\�a}M��O��5S��u}�O��_�������a}��Q� Y�%�a-=��[ܻ��ƿ	��D�ė���f5�b6|��쯑�y1�� �b����0�ɍO�t�|Nd��!�t/��^7�䠧�NǴ���z�t�Af���/��eW=D{)�	�	6O��K��4�}��`f p&�����l�y�˻�.��O�	�hd��-ے��bj[��L���Ω�	���>�ZaA���*8H1j��_��R`�E�0�L��D���?Wʗ�փr��3S��fr?�;��0�Di"�ق�����x]�wgA�k���j.G�nPt-$WX��z��[�g��|�z4��M�gxj��(��]��&xj��^�hn��y������ݏF;�5W�v��7^ݦ�Su �N��08��T����dՍLC6Pö�"-�r��H/��ő�O4��)��ҥ�/ ��><"��@v|Ŝ��k�|�;c\p��ѸL@Brΐt�Ư]g�]���	�p���ߋ�h���A[�����{�t�䆑\~��A�'B�j��(B�\�Ee����yP����ݵ�|���01G� l.�%-�5�ot}�ʇ�n� 0�%��hE���Sxew����"�����XR�ەIj������F�h��+a��	���6��oE���Ok$��8�6{Qo��4��Y�`vZ�<E�+��_��u�[�u���X
BI-�
A�л9���eً�ӂ��Z��ycM���7�C�,���&��y6~o�qI2�[��j�^�g�^Xym�es�PJ�����ZV�7��@�x*J�J�FW�I�zh��?�d�x(�21+�U6��̀L p1clw.�稩'���lS��)2�� G��(���̮g�T��d��C�5QQ����L<���LZgσ�$Y�gx�p�7�����OH S�93�ht�S`�����Sb$��֊�d�+Iկ�D/ģt;H��Q+{+g氤R΂�V7�G���7�3pX@�kb� �r+S�.5��f�l�j�LQ�`��B����xRڰ���m���`/��]�0G�SR�H��<C���!�#�����*��Gy-�e�T��M$&(���:��m�>|��y��k���l
��1�Z���_ :*�M�QG]͢Rv]쪭�c�9&P��R�m�mz
�٭ �d@a��u!cb�<%�;��p��?ACNЖ�h����oG��{��������7s3J'`;�V7�I 5����6Y�[7���\��.k[ED$ؽė�~�����������b�gM�#x�U�꜆δo*�Ѳ	:�3-��+:������)�_Rx�t;�f̅qs�;���WL`1�������$�1�B�!(�t�q�I�� ��ÆU]�O �A�iP�gm��7�B2�h����^�������������˗�Y���J:JmWvl�4"�%.f'��d{�z^%�eI�t�B��v��1��n�m�U);�aZ��y������p#k��2�Ag���������?Q���q�z~��ѻ���'���.��/�B'@�-�}"�6�%��z�����l�,��j����]�ə�v]*'\��	
�%$�X���d	|�����g`��O0�ioN�I�r
f�_�d�'��J�D�0��o�0�љޑ�am��� �9�O]���q�A�*\�W����*�<_���<�4��\N�^�"7㣶��n~x�O�h�����C��CF�|��1������^��T��*�їRȡ�f+��x�4�L�N�*�v[�n[]��'�a0Z�K}��,�l������Y�Z�I���No�]dB�&fw3���=���S�$([a 8?��,�f���dq���Ar'[_�E�3��Ёԁ�"y 4KEb�:o�����wYޮO�ö����+ �l�q
�!gI�E�e/E;�veO��2sn�?:-��L��K�_v�[�BWu.��P%����9C~��[⢖F�6m���`d�m�6;T=#w����� C�_�R��|��w�f���N8���<E\�D���V`�v#�˝m捳N�-ò ���%頺KPYb�
5V�MQ���,�p��P���4 >ci����g��X�e覬Â�":��vw��4�i���a� b_p�F6��}�8K^!�K����\��Q��[�xX�E��
�q��' �ۛ�3����N�1���Ǽ����������b��v;�Z��'�����7����\	��������)���jQf's#o3��l'��x^؍!� �&��V��K�^�QrcP��/�%}�����a���Q��Ǘ���F6�ot��	��=V,������`@�g�p���/��8��+����Gվ�g�wD8����l�J��·�K�C#D���-7�ߓ �B�∸i��u0QnVGp���&�N����o(��3����3�v�/�l$dj|Q�A���HEwfľ��e�nnJH�_��Oo���6��V��%lh��]�Pb��[jW�?3C��g��h'�@.-��.�@��`��9[�3V�[Go�e�oIxB������{.�S�]��7�FO�W���Z×�eh��c3�y4�9q�l��l4-4���j%d�3N]����g(?I��-~�RP�`�QW�����	�?�����gT�(X�I��o�B�Ͻ� k݈y��W��9��P���|���EOn;���2�8m�+��N�[�	(�C�n�tm����".����1{M�����=�g��&�Lmr�^h��,�;j@�YQ��P0��H�tL $�/��Kqܠ��~���T��d��us�������D���_D�b�04t��վ�n�X�� ���"TOc�%F�]��K�w)�օ�FX�(`�Tg&b"���u�jO�Z�>�����v$O}���:�3�5�z^�q{���?F��{�������ܲE[/�aA|J���`��\&�cU��	�����N�$c���$�fůUA�W||^�Y�U Pw���a� ��9x�T����oS�5{�>T���V��Ԭ+N]�l���d,)�r    .�D�'`��E�0s�]��l۝��ࢇ�Nj�.��S�^����Rwu@��аL�r������:6|��eo��?��5�7��<���&��ɽr�N��S�Bݝ;�;�"���=���{��0?�r	=j{�o���%����� �jViy��b�[������7��ܔXd��0| l�;�+��ṁ�_/�#���J�ΒUq@q�tb0��	":S��Kth�����<��jm�O ���]�@�&!�C�³���}m����U���9�����R�|��,W'�\l��߮��L����ЇJ[����iU�֕�Ӗfw�o�EGskR�M�	�T�7,xL��Ʊ	�6(2���Z��e�ʿ�1�w��2b����f]�y�KL͋G '\��1O\O��Ҙ��2��R1�(��c��.�C�ζvy�-}v0S~�E�\����ѹi�\74%���.�i'o�&r�H�#��|%z�]����b��F�����*����|���IŲ��oBi�R���R|�ݮ�8�yF��$�X����hJQ��Z�Ȏw����1�ϧ��S��1%���Eg�!��C�� �CdAD�s8�8v�'P��jوzW_e1���ap�����a�7m'�����ǘ*��^{�}�Ƈ���	�ȗ ���ު���� ��˶���^�����ʾ�4��w�vK\�磲"�;����P1W�}A�E�7���hݪ�G���$|�&f���Ͱ��,
�l'��l�1ޫ�
�筎#e���96w��"߶�F�}��_��&��Χր�׆q�)b�6nk�F6�d�"�Q�@w�]�k8~��	El#۹Wm)a;7�)��_
m��@�a~ƶ_T�����W��.�R13�,/�NP%�vF�mOYH�iKy�ñ�WLr����uGj��/�&C� 
�!�W}��G&�Dr����]�7��^��ZU��#����(�8� ��H��7G=Ae0hv�E��Ϙ�l(ܸ�̅�����^�V�*����]|��m�K�&�twڳ�F���|�vkaXg0Z��K�n�r��=cbE�4ZU�f��-����gk;���rT�����/���oit'�&EEC�	��E�6u�%Y|X���)t��DY���q8���r����kۮ�
7�Ĥ�m�-�Xgo����H�fۣn��[�1E^��� �����H_��N�zJ4�S���¤�{�*�)J�G�S
�	#��N���B��E;���!���1w�9<uь�:�d�<�"��������SE(>eaCg�W�s.J�o���]���}���?x]Ԛ�)�� /���C��Q$B*i*�m3E��-��w���쌳+�Xe ���%�C�zůҭ�\:�r���g��06��,��	0�l �|uZ��q�5�(���d�����]���#{6�+��l��H�w�%m�jv3�Q��mJD
��)��u7l�/��c$i�Yl7i>�)>G�H�!�V�yq^�9�Ax����J8-�KU��%h�s[+b��kSA��ɀ�RuJ�.�
+sc���!�t��'/ϟ-�MȪ`�lT�$z,L��!��ʲԵ-�p�B�jz��{Sṇ�$
Q�$���W�O�RN�(3�	�l��)�Y���9�����<c92fV%��z�|Q�F�F1�p��)H�~y�Ѭ,���Sg�,��4�n�=�\$�¶�-���:B
2DWK�"t�CD9��M�X���O�B���8^a�*"�)n���m:��hf��k����ߑ��b��H������.���aʧv8z�!jz�����B�@��we������*�uB"�^���.��f�&Iu|Fwd#�+!s(Du������k�;a��4�����EM�&.R[��MI���@�S{X�ݭ��û{b#cc��.�!x��=�,���O5
��!5��ίhB�o�g����(�+e��OP$��4$g7��`�ݦڈ�O2���($7�ê�h���ym���Ю�ԥ]S�JC|@Nc���&X]�M]�����ȻyE:�ņ�����h.Oj�6�h0��Ln�SE������%���Sٮ�����&���="Z����h�����2�ċ��U �!X��Fo7��L�?��v�ѿ̗�M��	�͵zMR+�T׋�l���Y-���z���VV	��ey�V�;fv2��Xa��e�<uN��~}Fy��;��}���@�p�N²93~E5��t��&�#׶ .m�m��
Ss$6y�4Bl�g_���uG�>eC���������0~���%�P� d�|�hȧȼ��
o�1�9�f"��sKi~��2��' +�G�%�e��nݻ�x~v5��B(`C./P�� O��%U3k��Cp��b�u�)L�۰]�.�����Bcm���Ei"]�%�����d4�sft����S��
�k=�R����(H ����M8��"^����� T�^�s7�L�.Q�N	B�����M�U���3R#~(��ۘ~#�8	N�m�7?��$$2xq2�F:��}|���ѵ��h�]Q�"��O��������˓�m�|���&Z9�_,�Clu��v���a�fE�KE[��	9Em�W;7�fn'�q^���������G�L��2�Nջ���'�7##�EPD��t	U^KVja��Tϑka�v媮�!�Kn7����-p�Ԍ��f��#o=F�kc��2W�����*L���b��.G��~�}����]oؼ�iIO�8���bOgX���=�^��a�3��쏉���|�}�=gZ�����?z�����q�A����D��3S��)��4A/%ˢ�3ܮɭsU����y�?�lC���K�%����Z�W�����>�g�dhǪ.��B|F�����s{'y[�⎈������E�{}
��]4g	�ק�`��tE��,�P��j�l���E�Q�A�ـky7>^1�q:���r�*�2��'��F�������!�;c�a�Yg16�A��不���������s/�Z��h�����;mփ*p;�W��$ vڑ��x�Șb�'�,��6��}�&�
%.�rW?æ�� ���Z����h��}�:^m���O)v"�����P~�ݗw�{���7=�(_K��w��} ���C��vĴm����/Z-N�������gt���ܬ��-���{������!�U���B�VJx���YBͲܪ;iO����D��ĎT-�������"Й���^�y7`���w霹���j�j�����Nֶo��)eQ6���7�n��/Vk�O.$���U&�`��-���w��RUڕY�{�O�BC9�QM�:҇-�9,��
疊t�(eͰ�X(�XG�s忩*2�6�ᭌu���s�Iӿ?�Ԣfe�r��Ӝb�����#�v����æX�d���h=�"U�o6y4� C�+D1uI�py�H�߲��ϟ�kNH[�����Fs��������O��U��,z O���{сg+��jb��=j/6�ܯ0�+�X(�Ԙ\(�M=\���|�6ය���>=%慁-K�ʛ��� ?o��Mn5��שF��)��.|h��>��ˆ(��\�%Y0�^��]���l�����֭�X�x���p��.�q��+�!�E^��g��S�5�_��/��c���H�_O��cM*��'��n�c�J"���%���a�D$�b_i�h �S7�R=�2�Vd��zA��݉xzF�o��Ly[J��2L��VH�qr�������:˱�-�4�ט� ����"^���zJ��h�}saq�rH��@BzKA_.l�	9]��"�je�E$��f\��#��>��[�����aL����x^�����]1�(^*S,��1�s��c(u\[�R)%.��2����\À�#�YƆ������S�-,��!⨺�g:�-�"Y�����G�׊�?��_�Zb�*�W��[KٔZb��=����X-���v(+?�[�'�H���i.��V=-U�w��/����v��J�o�R,���4��Q��M����ޯF�+K"U�o�k�h���~V���ɆQ��w^UG�    �;D-o�~w#�*l;ZU�T����[7�o���yP�u��;l!C��9RÎ�.����g, ꌿ)��WI�sr`�;��1(Y)O˝�p�aq)�'T_B֡fkM?؆����[���G�T��l�W\Yu����*tU!�	�#8��0P"�5��A'��L�������3F��s��)^p���`Y���	�V�":t�r���N`ܷX�07],�=J�V�B�;�:�kV`����Qf<�B��
���g�4�<��=��:��52_�<���x�d�@��ݬKy�3>Wo�,ecyH��iV��R$�%�t��j�xd�&�E�D�&Y^n�m�>�T�V�CA���g��S$���c��v��
=i�����엸���V��^�0�ivB��U�;�����ŕ|�YF�p�d۟
C:yy� �Y�%�w_��bgt���b�j�I�>��G,��S�[���9��h�ht��Ȭ���qCn��-�f�.$pk8���nS����(�o�Q*�Ѵ>?�����7�n#IzÝ�:�	�9
���0���K�=��@vJ��r,��6�������C,��3j�F;����X�.QM0�g5�/�ԒeH;架��k`C7	DK����UR��lv���׍�6�񙼭�0QS|R ;�aHr�����DG��{{���z�8"m�������+�V��ޞ��v�F�í��!6�ЖOٟ�h8f1$�[
rJ�܈�O������.9�Q��?�C{�4�_�˥�G�/n� �B�(d��O��Q��������)S	 ���Bn�e�F�PSd}��=�輒�{��]X�t%z�}e�^M�%Ą��e��U�SZ�L"��H�����@hrtݸ�c�����RTD��Lf���ˣwӲgPa�b�7H���)���q����#c��Z�<g��:�ǰ�S�?4!X����_I~�5���Őd��@N�C���L���7�9rR@��V(G�}^_�F�ֽ�ۀ����`k����3yħ��8*ܴft��gR�=c� �Zj��[	���~���.-*?���}��w����W�)��XSh�\�H�#�u�'�4r*	F�(�#�b�j�\Ӈ�4���(�ʔ战��2�D[k���v�3,��o��q�:ο�!Q3����_�w>��P��_�ﲏkb��M�9�r����!b��Áuw��K>�Kn��	����M���A�P�FъSx�@<����DzyFGQ�V�sS��dp�,^C 8c�x�n��#(���0{s��0<ig��mi4 W�%�$�м�7�ͪr�}��ⵧ;;�Ζ��o��g�Ñ7��.(1���3�BXg/	�_tC �T��ʁ1<�Z�6>I`��D���֩���٫]*%\UՆ�u}�r��+�(@��e �X^���1q��#���A�����gL{O�sy47��v;�L�O�d�p������.]_�扝{ډ�z��t@�>��P�P	� �>Q�ke˕rl�#���v�9�t����P��^A�[��gjB4���F�~5�6�6�U�b��@�I��5/�C}A'Lݾ�Xf�l���h�j�$����������p	tq���{�.�X��x��xG��H	�v2�ß1������D�f����I�`3��'8�ƾL)�\ł�xw�Fn��<H��� )�
��0@ԥ���@9����rZ��b�k�R3�xt�R�yȐ�3��3:zM������WM�ٍ77�I4&�3�������vv�4I��2�S��N|�^��2l��D54e���nG	mh$�B�ĝ=�͟�u*L踾��[}+:e��m�}��##��0%��?`A���*��P�$,0A%��e{���vEk�>�A��x�XY�ԏ�������Kl�#���@�?��gd�ȍ� gG�m�2ig��mV�?������J�Ųu��"_�$,�cɭ8��v�(�L�z��s���X9^��dl�X�8*��el^oW� �Gv���t|��'�5�&��Ѥ���$�La��z8E�� }3d�����s���0��G?�*E�-��a��V� ���v+�	k�S��0�!��[���&m5F���o�������ȸ�&��u�|�ȵ����LS*���쒍����r��^�76�\O�y[��iۈ�%`�OD���)}�N�(��|6�h6�L�����c��MTG�5i������ѹp���d�v���(X��-icD)d�7Cc�I٧uy�Fqd��r���~���ЯX��ii�X�h\���Ū�@O��_�i��h�Z0@��3B<�'l�z��A{�52�n��1.'���*)�E�3�6'��n("/,��q�J�j����כ��1U�f���0׼�^�rҭD��^4���gp��R־��������!�Z�3���k���s��}q2a)��}^%�m��n7v�&��GN�������O��ZRJ1�k{X&ݵݧjp�\3
��Z#�p��pdDM���+��y�^�w*X�ε��մ%`a�]?c�
/�@gC�|�&�$��l�����/I�뜩"'�or۝R�����k�j`�RJD�c�djǹ����3�P|�6�@r�B�S�Y�ʠB��%�x>E���gHݵ'@*Rx�60gR�b����K��Rt�D�U ��H��n9�\�&�bI��=�"��h���*���p�ʗ`@��R�涝��~٬��3`�d(��x�o`��^>�DA�̕Q:�Vƨ����ip!\�˺�����ã�n�K�C�\	h��y}�1Y���c���|Z"|����|��.ґ���o�������'%��4�Ii�7Տq��������g�������OWQW+��@����o��b��6��@Rʅ��#��*��#�=�G���� ���4F���F�w�y�6Ϙ�#+	�s�E�h��!G3��k6缷�C;���݇�es�n�)8	���)ٞ3��w��������1��]����{,Yv(O���\E s�7��M(�Υ��~���-6���[6%T�F���[c��
���6�j����_��g���u["ыZ�!�,�!�l�sZ�g�/"@�Lo�U�$��>'�gy�dT?���:���]���H������-g�)U��9�ϛ�n(��Qx�R�/a�C�)�C��{I5E��2jz����ђY '�h��)L�w�&Bj�#��5��F�����*q3q���]�M��)�k�e��U�<
|�U��f�$S�?����gcXme妷���Fnr� �f��N����&zj%�DQV�|C�G��M9Xő cO_XD���wNi"�"j��UNxf��c;Wy
��Xf������ F�nn�����*�ɂ�Q�d�[��[�XC�2i>����b��f���xF�����rd|��g{�N!�02ۻ�ߏSVÍ���%֚ݮ=��������U.�(:��9Nu�!�$O`���E��4�^��;��-tI<|�4>g #E0���EM��ɪ$�_34s�˴LO��&}�;�.*�VK��)��]R������,BD��ZY%Qh����OyZ_d����uo�H�g���ᠨ0���{�����R���
�,O[4�\yz[���k��+�����̛��H����t�?�d_�����fm���9�J p�W�Z(�K�e��xI����JsA+I����V{���k]��q+�;��g���ɗ�ă:��v���ѣG����.z��������À�R�J�]_�����t���
���ٖ[���kŧ��WvTG�x����vM�_��,oLQ=���j� d�[w̔�|��㾷�k!����o߫o��fZw�X�%c��w�2Cj���\��<l�Mݞ����Ò���8b��L!��o�dw��e�-�KQ|��Is�*�ѯ��A��C�M���Ip��k�ɰc���@��8j2Z��ݘK��Bm;\_�E�	� �t
�p:I�~9B�u�r���u$�k�5��M��>T���k��c��[��    XR��s�HA�,9eT�@�����l��|߼�x��o՝�7_D����ݯH����(��|��A|h]�[�/���%@f�d�0|F^')2[�wh������Q�=�x~���MZ�t��Չ��bI{X˹�l�1����p�Ν^��� h�2�Y7.ί�-�O�w7��dn�b�%.�n���'��d!�Uc��A�j�����$�O���Y��Хo]�Ki�1�-W4UKX%2�9���h�ͩ�4�S!����x`�:v�e��6'�g��E�������wlv/1�h�&Z��҇@��:|&.��1>�O������/?����˟~���W|(2;m�N@75����|��6�3�-�2l�������P�/�h/(š\j���:�k�ٯ��3@�|~@ s5��	�Nh�bv�p�á_�j4�6b�7���G4J�����G�~���ټ����?�P��k��t�%5�8&�$�����#�ꢲ��,%�]w��?��Y�p�?�Y~r�vIRH����񴋽s�_�V�&Y��
���lLX�	�y�!�����h(8;��}`����������+�����'[�Ԫ�sy��B8�
K�Mp�e�p����<�,���q7�|^r���8�	o��V�H��f�U�o�Ѣ��%�7���_��@�YS=���|��x��+�~��).�`��7�YB��f�$��B��Fkeۨ�h��1��� 6G\(v5�R��a�f7�+Ě�g8x�׆Sl�����v:�gM8�M��ݿ���˟σ{��ߛ��IM��eG\��(���?��6����9'�XU�O���/��Z�/��dIu�4E��i�A�x@՛����ukI�%��I�N�գw�o$��:����������-d�6�h�j�P����Ȭ�[�NH�5£�����z�xղ�䇖M���r�n�k�xپ;�ҥ3���n(}%�U�bCK�j�ZQ�uչ��)�"��:�S�VS����I�ѱi��~ֵ:%]3������yx��M��7�F�?J3���� �����o6�$g����c��y˱~��cMx�����˟}��w
R�+�@�ry�P��o���!#��c��a��|d%�Ku�Ҏo��e��1��W
;�-8,���2��[���8X��eZ��<,t��ѫ��_����_	��ǜ%۶��f�L*�DɻD1/�qJD��ۄG��"�Q0��GH|�)�_Lpؕ�����z��_[��ktW$��!�9
����ҡ��⳽v��(��ᕻ�z���0��u��/5@)(������$��5�NÚ.�-m�sYaj*��"�m3Ŧ��K�k�#X �c	�b/o$Q<c-Ɩ���'����fM	<0p�ک=?�Sy����nQiE��٢Ԕl*Ͳ�����{���J�?U����?�q��-�R%	Ġ`�g8�u(�^�ڦ�C��+H��l�#�M/6�tYR[�P�Y�ܢ37�L�~�h��)�Ї�����/L�c�cO��?�������D�z"�}��@h��z�K1b��Z�<]z�-0g���������^o�rM�V�n�漳���O�d���ls�A�0 ��N|��o]h�?y��c$ý'mJ�ڬ`��p���r&���������n�B�T�2�z 2q;�J�����v[�� B&ri�y��p�U����&|�	zd����b�������H��>�. ���h�<Pf��iQ�ИXV9�K8���~y`W����z�2i��tL&��8�f�A���g,t�ه�q����Zr�ǰ���/�>z��ʜ[��϶���w:�M�Q������ 7:����ͥ� ���M���^�$Z��m��X���x��>�y���}���4 ����Fr	�=�B�<�r��%�v:TR?c��k�bə�6I���x��}�~��_�Gƿ��I�'tWī�ҝ$�>wY	�K�����Ç�-��ꈅ�v8��g([@v���~ ��������d�?�@W�=iβ��=2)!�3����}=�/�����|wb���݌_����tY��7��|�G�W[��$��oǯB�ž��o�v㄀�"(�H� ��0J`�xp�AAp��I�P2 �o.���Q����p��o�߾����0��+_�F��ky�� >��n�uhG�c��`'��O���P���)E+��R�ӫ��8L��ǠMI%a�l�m���o�"m���ͽ=����U���Qq��x~���ٟ�o���N�c��I|���n�{p+�id��O�zk�uP@�(ppv>~�y-K�t�vw�I�P_�o��v���GY�U^�����Ŀ��R���vt����8u"� $��o���e;�ҹs_Kl޿������J����Gu�.y���QaF���Ϟ�M������/��j�|�ϯ��x�b��h�����������x��i7��`r������5�M�s�-s7�����M��% �쨩��V{m�}!�[�#���(F� ��R�$���7^�Ot?C ��_s���4��S?��wͽ��짓}�K�7�hH�,���`}�������	���L#1��I�@0�>�(R#�/��L���/ϥ�4gUen����w�H�㿺o��c�o�r��Mϙ�'/xI�w���|�vA������xU���uݟx�Wwٻ_��M��/︿�/�����.��_ޟ��O޿�7�b��+�Qa�.i�~�����ݒ�կ0���p���g?���t��i�̝�6��D���Hq\;ՙ1
�1�$I� HD){�<��k�����p=wa����zM��;�����x�^~�n��[7���~����N����Q�xه���w����2�,q�y|��N�(��
�w�Qb�|��ķ0�m3�8 l� �ö�2���:����$���%v
���8y�U 4����61��G�'�ۿrKv�>L�W,�~�C_1�Ww����:�f�����M=~Ţ_Qુz}c����+�^���#�Wjq��)���qڸ����w��gn����"�����1M!���o�h�;��CR 
�0��4ZH!�o�-���;N�g�?�&~��!�ǝ�����7�q7͏���x�7|��z�_Z����A���x0��ݜA	���3e?�f�}{/\>|�6���A�%T�H�N�ܛWD���(�����M����>�ȇ[A�o��p�7����H~�����H���������y��7�?��q/F���>�������4(��u"��t+�_~z�q�>�'����`�ܨ�>%G@�v�{��h���ϓ���^�,���T��(z��'܎�o��/ ?����<�U���0?8���}���ϸ��}�#��}R�Q��.w����x7�N�"����x����ާ_k���-�jv�6��~
_�	⏤աJrb���X���%E��C2�(��5O�CO=$@�C=��΋�M�3�KQ�Q1��؆l��gvf��[�n�|��3��k�z{�05�lx��54���n��|ҩ<�ؽ�g�݃Y%9�C!�k�m�����/���gy]�q��Rjƍ��ȑ��@P}��q2<�%��������䖅[>�鏋`9�t�&�7� �0j� �8��!��"!D���4�.$�08���~Ru�9�Z�9�S�����$�E�}�R}�>g,�T2�X/"Z�M4R�{h��f	�T*ǚ�C!���=�>N(���8�u��3k�/O��O{-�=#`�s����A�z�wx��XZL��B���� 8~��R�/|��O����"��!o��YT����:��g)�[F��[P����*jb�|U��Op�1�C�8�E�d�o]s�,�U-/���@���q��8bOO������^�\�k�C�6�v˂ph�e9�Qj0^���j��aJq����bO�oY-��k��kNT�Y�I��v�xv~i�2#`�p�8�   ��l��F���%*[����r��/>��e����?㪸R���Z���|�q����o�ɨt���(�y��N�*r�[�%h��Ц�"}�
���ǔ���e�+X����������8�������S��m�Ğ��3����'8[�av��Aǵm~5g{�g�巬YD�s>��X}R�p%�� ;@J0
�A@Nl.��� o@H�E��$��Y��IZ��1���8@JP�{\�"��
��:H��k��2��`������#����V����OeN�z�A&��e�2:<єI��=^��FbyX�F��%}�uS�7;~_��7e��>�o��s���9kQ�mR�7�RH��S.U��F��Q��iB��������8D�Oc����;b��y��*�!K-SA��3�U�d��6�0E5�Ƭ\0*g�&ߎ���-�J�\)7E21�����Lk��*�J���5ˉ)U���fs[��l�R�cqH������_j0b*>_w�y�����ω�E�2H�����:O;�#b�� �̖����t^�h~D��P�w�G�ŪO�r0r^�/GU��(��m���֏���F5�����}w%P[4�^q��f���ն �@���t���r=~*�nB�d��_�闳�����r��	m_}ݡU���*	.����Ys2�:�MzC��ʗ�9�ݎ�;vT�I]HW�-�hm��5���ݎ٪�/��_߲O� �&�Q�b:��wK�|��9�$Q�������?4������N�      �   g  x�5�K�1�z�	lI��%���RT�h�9Uo,k۴����+\�g�0�-|�0m+��������P·Ӣ"����>:���>�R�жpF(������:.CSq���-�����Ь��T��f$���ah*������)�X���T�:���d�ӴD�i�N����lZn˦�lZ^˦%�ik��Ӳi�-��²i+-������m�i��iںv������a�i{�i��x4m�����Ӵ��6mo�M��n���۴��6�W���Q���,B�jaw5��{�F���t�ҵJ�^V��ZOX=1 �Ā��JC:Q(5����ZC z�Hs�h�bQ����F��v!�B4��h��0�S1�%�1�1S2�=�2�I�r|� Ŝ����j�w���7B��2�(c2��2f�(c:���g�Ų>���p��π�e}�`>�L�W�\u��`s�1��V3��zW�S]� �ue�0�[e�m�B��ўZ� c�gi�j��`�����~ o����e��,>��>K�����e����{�~0���������u�ʘ/�������ˀ����e���[�2���5x�~����~�����     