
-- name: GetSongByID :one

SELECT s.*, a.name as artist_name, a.avatar_url
FROM songs s
LEFT JOIN artist a on s.artist_id = a.id
WHERE s.id = $1;

-- name: GetSongs :many

SELECT s.*, a.name as artist_name, a.avatar_url
FROM songs s
LEFT JOIN artist a on s.artist_id = a.id
OFFSET COALESCE(sqlc.arg(start)::int, 0)
LIMIT COALESCE(sqlc.arg(size)::int, 50);


-- name: GetNewSongs :many

SELECT s.*, a.name as artist_name, a.avatar_url
FROM songs s
LEFT JOIN artist a on s.artist_id = a.id
ORDER BY s.created_at DESC
OFFSET 0
LIMIT 15;


-- name: AdminGetSongs :many

SELECT s.*, a.name as artist_name, a.avatar_url
FROM songs s
LEFT JOIN artist a on s.artist_id = a.id
ORDER BY s.updated_at DESC;


-- name: GetSongById :one

SELECT s.*, a.name as artist_name, a.avatar_url
FROM songs s 
LEFT JOIN artist a on s.artist_id = a.id
WHERE s.id = $1;


-- name: GetSongOfArtist :many
SELECT s.*, a.name as artist_name, a.avatar_url
FROM songs s
LEFT JOIN artist a on s.artist_id = a.id
WHERE a.id = $1;



-- name: GetSongOfPlaylist :many
SELECT s.*, a.name as artist_name, a.avatar_url
FROM songs s
LEFT JOIN artist a on s.artist_id = a.id
WHERE s.id IN (
    SELECT song_id
    FROM playlist_song
    WHERE playlist_id = $1
);


-- name: GetRandomSong :many
SELECT s.*, a.name as artist_name, a.avatar_url
FROM songs s
LEFT JOIN artist a on a.id = s.artist_id
Order by RANDOM()
limit 15;

-- name: SearchSong :many
SELECT s.*, a.name as artist_name, a.avatar_url
FROM songs s
LEFT JOIN artist a on a.id = s.artist_id
where s.name ilike sqlc.narg(search)::varchar || '%'
OFFSET COALESCE(sqlc.arg(start)::int, 0)
LIMIT COALESCE(sqlc.arg(size)::int, 50);

-- name: CreateSong :one
INSERT INTO songs (
    name,
    thumbnail,
    path,
    lyrics,
    duration,
    release_date,
    artist_id,
    category_id
) VALUES (
    $1, 
    $2, 
    $3, 
    $4, 
    $5, 
    $6,
    $7,
    $8
) RETURNING * ;

-- name: UpdateSong :exec

UPDATE songs 
SET name = sqlc.arg(name), thumbnail = sqlc.arg(thumbnail), 
path = sqlc.arg(path), lyrics = sqlc.arg(lyrics), duration = sqlc.arg(duration), 
release_date = sqlc.arg(release_date), artist_id = sqlc.arg(artist_id),category_id = sqlc.arg(category_id),
updated_at = NOW()
WHERE id = sqlc.arg(id);

-- name: PlaySong :exec
INSERT INTO song_plays (song_id, user_id)
VALUES (sqlc.arg(song_id), sqlc.narg(user_id));

-- name: GetSongByAlbum :many
SELECT s.*, a.name as artist_name, a.avatar_url
FROM songs s
LEFT JOIN artist a on s.artist_id = a.id
WHERE s.id in (
    SELECT song_id from albums_songs WHERE album_id = $1
) 
LIMIT COALESCE(sqlc.arg(size)::int, 50)
OFFSET COALESCE(sqlc.arg(start)::int, 0);

-- name: DeleteSong :exec
DELETE FROM songs  WHERE id = $1;
