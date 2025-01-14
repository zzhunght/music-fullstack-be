-- name: GetArtistById :one
SELECT a.*,  COUNT(af.artist_id) AS follow_count FROM artist a
LEFT JOIN artist_follow af ON a.id = af.artist_id
WHERE a.id = $1
GROUP BY a.id;

-- name: GetAllArtistForAdmin :many
SELECT * FROM artist ORDER BY updated_at DESC;

-- name: SearchArtist :many
SELECT a.*,  COUNT(af.artist_id) AS follow_count FROM artist a
LEFT JOIN artist_follow af ON a.id = af.artist_id
WHERE name ilike sqlc.arg(search)::text || '%'
GROUP BY a.id;;

-- name: GetRecommentArtist :many
SELECT * FROM artist 
ORDER BY RANDOM()
OFFSET 0
LIMIT 5;

-- name: CreateArtist :one
INSERT INTO artist (
    name,
    avatar_url
) VALUES ( $1, $2 ) RETURNING *;

-- name: UpdateArtist :one
UPDATE artist 
SET name = $2, avatar_url = $3, updated_at = NOW()
WHERE  id = $1 
RETURNING *;

-- name: CountListArtists :one
SELECT count(*) as total_rows
FROM artist 
WHERE name ILIKE sqlc.arg(name_search) || '%';

-- name: GetListArtists :many
SELECT * 
FROM artist 
WHERE name ILIKE sqlc.arg(name_search) || '%'

UNION

SELECT a.*
FROM songs s
INNER JOIN artist a on a.id = s.artist_id
where s.name ilike sqlc.arg(name_search) || '%'

ORDER BY created_at DESC;

-- name: DeleteArtist :exec

DELETE from artist WHERE id = $1;

-- name: DeleteManyArtist :exec

DELETE from artist WHERE id in (sqlc.slice(ids));