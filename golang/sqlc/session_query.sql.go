// Code generated by sqlc. DO NOT EDIT.
// versions:
//   sqlc v1.26.0
// source: session_query.sql

package sqlc

import (
	"context"

	"github.com/google/uuid"
	"github.com/jackc/pgx/v5/pgtype"
)

const createSession = `-- name: CreateSession :one
INSERT INTO session (
    id,
    email,
    refresh_token,
    client_agent,
    client_ip,
    expired_at
) VALUES ($1, $2, $3, $4, $5, $6) RETURNING id, email, client_agent, refresh_token, client_ip, is_block, expired_at
`

type CreateSessionParams struct {
	ID           uuid.UUID        `json:"id"`
	Email        string           `json:"email"`
	RefreshToken string           `json:"refresh_token"`
	ClientAgent  string           `json:"client_agent"`
	ClientIp     string           `json:"client_ip"`
	ExpiredAt    pgtype.Timestamp `json:"expired_at"`
}

func (q *Queries) CreateSession(ctx context.Context, arg CreateSessionParams) (Session, error) {
	row := q.db.QueryRow(ctx, createSession,
		arg.ID,
		arg.Email,
		arg.RefreshToken,
		arg.ClientAgent,
		arg.ClientIp,
		arg.ExpiredAt,
	)
	var i Session
	err := row.Scan(
		&i.ID,
		&i.Email,
		&i.ClientAgent,
		&i.RefreshToken,
		&i.ClientIp,
		&i.IsBlock,
		&i.ExpiredAt,
	)
	return i, err
}

const deleteSession = `-- name: DeleteSession :exec
DELETE FROM session WHERE id = $1
`

func (q *Queries) DeleteSession(ctx context.Context, id uuid.UUID) error {
	_, err := q.db.Exec(ctx, deleteSession, id)
	return err
}

const getSession = `-- name: GetSession :one
SELECT id, email, client_agent, refresh_token, client_ip, is_block, expired_at FROM session WHERE id = $1
`

func (q *Queries) GetSession(ctx context.Context, id uuid.UUID) (Session, error) {
	row := q.db.QueryRow(ctx, getSession, id)
	var i Session
	err := row.Scan(
		&i.ID,
		&i.Email,
		&i.ClientAgent,
		&i.RefreshToken,
		&i.ClientIp,
		&i.IsBlock,
		&i.ExpiredAt,
	)
	return i, err
}

const getSessionByRfToken = `-- name: GetSessionByRfToken :one
SELECT id, email, client_agent, refresh_token, client_ip, is_block, expired_at FROM session WHERE refresh_token = $1
`

func (q *Queries) GetSessionByRfToken(ctx context.Context, refreshToken string) (Session, error) {
	row := q.db.QueryRow(ctx, getSessionByRfToken, refreshToken)
	var i Session
	err := row.Scan(
		&i.ID,
		&i.Email,
		&i.ClientAgent,
		&i.RefreshToken,
		&i.ClientIp,
		&i.IsBlock,
		&i.ExpiredAt,
	)
	return i, err
}

const updateSessionID = `-- name: UpdateSessionID :exec
UPDATE session SET id = $1 WHERE id = $2
`

type UpdateSessionIDParams struct {
	NewID uuid.UUID `json:"new_id"`
	OldID uuid.UUID `json:"old_id"`
}

func (q *Queries) UpdateSessionID(ctx context.Context, arg UpdateSessionIDParams) error {
	_, err := q.db.Exec(ctx, updateSessionID, arg.NewID, arg.OldID)
	return err
}
