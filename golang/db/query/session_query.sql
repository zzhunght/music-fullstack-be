
-- name: CreateSession :one
INSERT INTO session (
    id,
    email,
    refresh_token,
    client_agent,
    client_ip,
    expired_at
) VALUES ($1, $2, $3, $4, $5, $6) RETURNING *;

-- name: UpdateSessionID :exec
UPDATE session SET id = sqlc.arg(new_id) WHERE id = sqlc.arg(old_id);

-- name: GetSession :one
SELECT * FROM session WHERE id = $1;

-- name: GetSessionByRfToken :one
SELECT * FROM session WHERE refresh_token = $1;


-- name: DeleteSession :exec
DELETE FROM session WHERE id = $1;

