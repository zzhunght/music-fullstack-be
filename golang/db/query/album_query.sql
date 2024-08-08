
-- name: CreateAlbum :one
INSERT INTO albums (
    name,
    artist_id,
    thumbnail,
    release_date
) VALUES (
    $1,
    $2,
    $3,
    sqlc.arg(release_date)::date
) RETURNING *;

-- name: GetAlbumByID :one
SELECT * FROM albums WHERE id = $1;

-- name: CountAlbumsByArtistID :one
SELECT COUNT(*) AS total_rows FROM albums WHERE artist_id = $1;
-- name: GetAlbumByArtistID :many
SELECT * FROM albums WHERE artist_id = $1;

-- name: CountAlbums :one
SELECT COUNT(*) AS total_rows FROM albums;
-- name: GetAlbums :many
SELECT ab.*, a.name as artist_name FROM albums ab
INNER JOIN artist a ON ab.artist_id = a.id
OFFSET COALESCE(sqlc.arg(start)::int, 0)
LIMIT COALESCE(sqlc.arg(size)::int, 50);


-- name: CountSearchAlbums :one
SELECT COUNT(*) AS total_rows FROM albums WHERE name ILIKE sqlc.arg(search) || '%';

-- name: SearchAlbums :many
SELECT albums.id, albums.name, albums.thumbnail, albums.release_date FROM albums where name ilike sqlc.arg(search) || '%'
OFFSET COALESCE(sqlc.arg(start)::int, 0)
LIMIT COALESCE(sqlc.arg(size)::int, 50);

-- name: UpdateAlbum :one
UPDATE albums SET
    name = $2,
    artist_id = $3,
    thumbnail = $4,
    release_date = $5
WHERE id = $1 RETURNING *;

-- name: DeleteAlbum :exec
DELETE FROM albums WHERE id = $1;

-- name: AddSongToAlbum :exec
INSERT INTO albums_songs (
    album_id,
    song_id
) VALUES($1, $2);

-- name: AddManySongToAlbum :exec
INSERT INTO albums_songs (
    album_id,
    song_id
)  VALUES (  
  $1,  
  unnest(@song_ids::int[])  
);

-- name: RemoveSongFromAlbum :exec
DELETE FROM albums_songs 
WHERE album_id = $1 AND song_id =sqlc.arg(song_id);


-- name: GetAlbumSong :many
SELECT s.*, a.name as artist_name, a.avatar_url 
from albums_songs
INNER JOIN songs s ON albums_songs.song_id = s.id 
LEFT JOIN artist a on a.id = s.artist_id
WHERE albums_songs.album_id = $1;

-- name: CheckSongInAlbum :one
SELECT count(*) from albums_songs
WHERE album_id = sqlc.arg(album_id) AND song_id = sqlc.arg(song_id);

-- name: GetSongNotInAlbum :many
SELECT s.*, a.name as artist_name, a.avatar_url from songs s
LEFT JOIN artist a on a.id = s.artist_id
where s.id not in (
    SELECT als.song_id FROM albums_songs als WHERE als.album_id = $1
) and s.artist_id = sqlc.arg(artist_id)
order by s.created_at desc;


-- name: GetAlbumInfoFromSongID :one
SELECT al.id, al.name , al.thumbnail, al.release_date from albums al
INNER JOIN albums_songs abs on al.id = abs.album_id
WHERE abs.song_id = $1 LIMIT 1;


-- name: GetNewAlbum :many
SELECT al.* , a.name as artist_name from albums al
INNER JOIN artist a ON a.id = al.artist_id
ORDER BY al.created_at DESC
OFFSET 0
LIMIT 7;

-- name: GetAllAlbum :many
SELECT al.* , a.name as artist_name from albums al
INNER JOIN artist a ON a.id = al.artist_id
ORDER BY al.created_at DESC;