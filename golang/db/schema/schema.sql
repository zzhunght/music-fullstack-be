CREATE TABLE "session" (
  "id" uuid PRIMARY KEY,
  "email" varchar NOT NULL,
  "client_agent" varchar NOT NULL,
  "refresh_token" varchar NOT NULL,
  "client_ip" varchar NOT NULL,
  "is_block" bool DEFAULT false,
  "expired_at" timestamp NOT NULL
);

CREATE TABLE "roles" (
  "id" SERIAL PRIMARY KEY,
  "name" varchar NOT NULL,
  "created_at" timestamp DEFAULT (now()),
  "updated_at" timestamp
);

CREATE TABLE "accounts" (
  "id" SERIAL PRIMARY KEY NOT NULL,
  "name" varchar NOT NULL,
  "email" varchar UNIQUE NOT NULL,
  "password" varchar NOT NULL,
  "role_id" int NOT NULL DEFAULT 1,
  "is_verify" boolean NOT NULL DEFAULT false,
  "secret_key" varchar,
  "created_at" timestamp DEFAULT (now()),
  "updated_at" timestamp
);

CREATE TABLE "songs" (
  "id" SERIAL PRIMARY KEY,
  "name" varchar NOT NULL,
  "thumbnail" varchar,
  "artist_id" int NOT NULL,
  "path" varchar,
  "lyrics" text,
  "category_id" int NOT NULL,
  "duration" int,
  "release_date" timestamp,
  "created_at" timestamp DEFAULT (now()),
  "updated_at" timestamp
);

CREATE TABLE "favorite_songs" (
  "id" SERIAL PRIMARY KEY,
  "account_id" int NOT NULL,
  "song_id" int NOT NULL,
  "created_at" timestamp DEFAULT (now())
);

CREATE TABLE "categories" (
  "id" SERIAL PRIMARY KEY,
  "name" varchar NOT NULL,
  "thumbnail" varchar,
  "color" varchar,
  "created_at" timestamp DEFAULT (now()),
  "updated_at" timestamp DEFAULT (now())
);


CREATE TABLE "song_plays" (
  "id" SERIAL PRIMARY KEY,
  "song_id" int NOT NULL,
  "user_id" int ,
  "play_at" timestamp DEFAULT (now())
);

CREATE TABLE "artist" (
  "id" SERIAL PRIMARY KEY,
  "name" varchar NOT NULL,
  "avatar_url" varchar,
  "created_at" timestamp DEFAULT (now()),
  "updated_at" timestamp DEFAULT (now())
);

CREATE TABLE "albums" (
  "id" SERIAL PRIMARY KEY,
  "artist_id" int NOT NULL,
  "name" varchar NOT NULL,
  "thumbnail" varchar NOT NULL,
  "category_id" int,
  "release_date" date NOT NULL,
  "created_at" timestamp NOT NULL DEFAULT (now())
);

CREATE TABLE "albums_songs" (
  "id" SERIAL PRIMARY KEY,
  "song_id" int NOT NULL,
  "album_id" int NOT NULL,
  "created_at" timestamp DEFAULT (now())
);

CREATE TABLE "playlist" (
  "id" SERIAL PRIMARY KEY,
  "name" varchar NOT NULL,
  "thumbnail" varchar,
  "account_id" int,
  "artist_id" int,
  "category_id" int,
  "description" varchar,
  "created_at" timestamp DEFAULT (now()),
  "updated_at" timestamp DEFAULT (now())
);

CREATE TABLE "playlist_song" (
  "id" SERIAL PRIMARY KEY,
  "playlist_id" int NOT NULL,
  "song_id" int NOT NULL,
  "created_at" timestamp DEFAULT (now())
);

CREATE TABLE "favorite_albums" (
  "id" SERIAL PRIMARY KEY,
  "account_id" int NOT NULL,
  "album_id" int NOT NULL,
  "created_at" timestamp DEFAULT (now())
);

CREATE TABLE "artist_follow" (
  "id" SERIAL PRIMARY KEY,
  "account_id" int NOT NULL,
  "artist_id" int NOT NULL,
  "created_at" timestamp DEFAULT (now())
);

CREATE TABLE "comment" (
  "id" serial,
  "content" varchar NOT NULL,
  "user_id" int NOT NULL,
  "song_id" int NOT NULL,
  "created_at" timestamp DEFAULT (now())
);

CREATE INDEX ON "songs" ("name");

ALTER TABLE "accounts" ADD FOREIGN KEY ("role_id") REFERENCES "roles" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "songs" ADD FOREIGN KEY ("artist_id") REFERENCES "artist" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "favorite_songs" ADD FOREIGN KEY ("song_id") REFERENCES "songs" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "favorite_songs" ADD FOREIGN KEY ("account_id") REFERENCES "accounts" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "songs" ADD FOREIGN KEY ("category_id") REFERENCES "categories" ("id") ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE "song_plays" ADD FOREIGN KEY ("song_id") REFERENCES "songs" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "song_plays" ADD FOREIGN KEY ("user_id") REFERENCES "accounts" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "albums" ADD FOREIGN KEY ("artist_id") REFERENCES "artist" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "albums" ADD FOREIGN KEY ("category_id") REFERENCES "categories" ("id") ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE "albums_songs" ADD FOREIGN KEY ("album_id") REFERENCES "albums" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "albums_songs" ADD FOREIGN KEY ("song_id") REFERENCES "songs" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "playlist" ADD FOREIGN KEY ("account_id") REFERENCES "accounts" ("id") ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE "playlist" ADD FOREIGN KEY ("artist_id") REFERENCES "artist" ("id") ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE "playlist" ADD FOREIGN KEY ("category_id") REFERENCES "categories" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "playlist_song" ADD FOREIGN KEY ("playlist_id") REFERENCES "playlist" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "playlist_song" ADD FOREIGN KEY ("song_id") REFERENCES "songs" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "favorite_albums" ADD FOREIGN KEY ("account_id") REFERENCES "accounts" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "favorite_albums" ADD FOREIGN KEY ("album_id") REFERENCES "albums" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "artist_follow" ADD FOREIGN KEY ("account_id") REFERENCES "accounts" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "artist_follow" ADD FOREIGN KEY ("artist_id") REFERENCES "artist" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "comment" ADD FOREIGN KEY ("song_id") REFERENCES "songs" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "comment" ADD FOREIGN KEY ("user_id") REFERENCES "accounts" ("id") ON DELETE CASCADE ON UPDATE CASCADE;
