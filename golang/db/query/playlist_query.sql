
-- name: CreateUserPlaylist :one
INSERT INTO playlist (account_id, name)
VALUES(sqlc.arg(user_id)::int, sqlc.arg(name)) RETURNING *;

-- name: CreatePlaylist :one
INSERT INTO playlist (name, thumbnail, artist_id, description,category_id)
VALUES(
    sqlc.arg(name), 
    sqlc.narg(thumbnail),
    sqlc.narg(artist_id),
    sqlc.arg(description),
    sqlc.narg(category_id)
) RETURNING *;

-- name: UpdatePlaylist :one
UPDATE playlist
SET name = sqlc.arg(name), 
thumbnail = sqlc.arg(thumbnail), 
artist_id = sqlc.narg(artist_id), 
description = sqlc.arg(description),
category_id = sqlc.narg(category_id),
updated_at = NOW()
WHERE id = sqlc.arg(id)
RETURNING *;

-- name: GetPlaylistofUser :many
SELECT * FROM playlist where account_id = $1 ORDER by created_at DESC;

-- name: SearchPlaylist :many
SELECT * FROM playlist where name ILIKE sqlc.arg(search)::varchar || '%' 
ORDER by created_at DESC;

-- name: GetSongInPlaylist :many
SELECT s.* , a.name as artist_name, a.avatar_url 
from playlist_song p 
INNER JOIN songs s ON p.song_id = s.id 
LEFT JOIN artist a on s.artist_id = a.id
WHERE p.playlist_id = $1;



-- name: GetSongNotInPlaylist :many
SELECT s.* , a.name as artist_name, a.avatar_url 
from songs s 
LEFT JOIN artist a on s.artist_id = a.id
WHERE s.id NOT IN (
    SELECT song_id from playlist_song p WHERE p.playlist_id = $1
) AND s.name ILIKE sqlc.arg(search)::varchar || '%'
OFFSET COALESCE(sqlc.arg(start)::int, 0)
LIMIT COALESCE(sqlc.arg(size)::int, 50);

-- name: CheckOwnerPlaylist :one
SELECT account_id, id FROM playlist WHERE account_id = $1 and id = $2;


-- name: DeletePlaylist :exec
DELETE FROM playlist where account_id = sqlc.arg(user_id)::int and id = sqlc.arg(playlist_id)::int;

-- name: AdminDeletePlaylist :exec
DELETE FROM playlist where id = sqlc.arg(playlist_id)::int;

-- name: AddSongToPlaylist :exec
INSERT INTO playlist_song (song_id, playlist_id)
VALUES (sqlc.arg(song_id)::int, sqlc.arg(playlist_id)::int);

-- name: CheckSongInPlaylist :one
SELECT count(*) 
FROM playlist_song
where song_id = sqlc.arg(song_id)::int and playlist_id = sqlc.arg(playlist_id)::int;


-- name: GetPlaylistByArtist :many
SELECT p.* 
FROM playlist p WHERE p.artist_id = sqlc.arg(artist_id)::int;

-- name: GetPlaylistByCategories :many
SELECT p.* 
FROM playlist p WHERE p.category_id = sqlc.arg(category_id)::int;

-- name: GetPlaylistById :one
SELECT p.* 
FROM playlist p WHERE p.id = sqlc.arg(id)::int;

-- name: GetPlaylistByUserId :many
SELECT p.id, p.name
FROM playlist p WHERE p.account_id = sqlc.arg(account_id)::int
ORDER BY p.created_at DESC;


-- name: GetNewPlaylist :many
SELECT p.* 
FROM playlist p 
WHERE p.account_id is null
ORDER BY p.created_at DESC
OFFSET 0
LIMIT 7;

-- name: GetAllPlaylist :many
SELECT p.* 
FROM playlist p 
WHERE p.account_id is null
ORDER BY p.updated_at DESC;


-- name: RemoveSongFromPlaylist :exec
DELETE FROM playlist_song WHERE playlist_id = sqlc.arg(playlist_id)::int AND song_id = sqlc.arg(song_id)::int;