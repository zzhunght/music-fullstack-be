
-- name: GetSongCategories :many
SELECT * FROM categories ORDER BY updated_at DESC;

-- name: CreateCategories :one
INSERT INTO categories (name, thumbnail, color) VALUES ($1, $2, $3) RETURNING *;


-- name: UpdateCategories :one

UPDATE categories 
SET name = $1, thumbnail = $2, color = $3, updated_at = NOW()
WHERE id = $4
RETURNING *;


-- name: GetSongInCategory :many
SELECT s.*, a.name as artist_name, a.avatar_url
FROM songs s
LEFT JOIN artist a on s.artist_id = a.id
WHERE s.category_id = $1
LIMIT COALESCE(sqlc.arg(size)::int, 50)
OFFSET COALESCE(sqlc.arg(start)::int, 0);

-- name: DeleteCategories :exec
DELETE FROM categories WHERE id = $1;

