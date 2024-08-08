

-- name: AddSongToFavorite :exec

INSERT INTO favorite_songs (account_id, song_id)
VALUES (sqlc.arg(account_id)::int, sqlc.arg(song_id)::int);

-- name: RemoveSongFromFavorite :exec

DELETE FROM favorite_songs WHERE account_id =sqlc.arg(account_id)::int AND song_id =sqlc.arg(song_id)::int;

-- name: GetFavoriteSongs :many
SELECT s.*, a.name as artist_name, a.avatar_url
FROM favorite_songs fs
INNER JOIN songs s on fs.song_id = s.id
LEFT JOIN artist a on s.artist_id = a.id
WHERE fs.account_id = sqlc.arg(account_id)::int
ORDER BY fs.created_at DESC;

-- name: CheckFavorite :one
SELECT id FROM favorite_songs
WHERE song_id = sqlc.arg(song_id)::int AND account_id = sqlc.arg(account_id)::int ;


