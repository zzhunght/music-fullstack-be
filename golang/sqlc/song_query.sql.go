// Code generated by sqlc. DO NOT EDIT.
// versions:
//   sqlc v1.26.0
// source: song_query.sql

package sqlc

import (
	"context"

	"github.com/jackc/pgx/v5/pgtype"
)

const adminGetSongs = `-- name: AdminGetSongs :many

SELECT s.id, s.name, s.thumbnail, s.artist_id, s.path, s.lyrics, s.category_id, s.duration, s.release_date, s.created_at, s.updated_at, a.name as artist_name, a.avatar_url
FROM songs s
LEFT JOIN artist a on s.artist_id = a.id
ORDER BY s.updated_at DESC
`

type AdminGetSongsRow struct {
	ID          int32            `json:"id"`
	Name        string           `json:"name"`
	Thumbnail   pgtype.Text      `json:"thumbnail"`
	ArtistID    int32            `json:"artist_id"`
	Path        pgtype.Text      `json:"path"`
	Lyrics      pgtype.Text      `json:"lyrics"`
	CategoryID  int32            `json:"category_id"`
	Duration    pgtype.Int4      `json:"duration"`
	ReleaseDate pgtype.Timestamp `json:"release_date"`
	CreatedAt   pgtype.Timestamp `json:"created_at"`
	UpdatedAt   pgtype.Timestamp `json:"updated_at"`
	ArtistName  pgtype.Text      `json:"artist_name"`
	AvatarUrl   pgtype.Text      `json:"avatar_url"`
}

func (q *Queries) AdminGetSongs(ctx context.Context) ([]AdminGetSongsRow, error) {
	rows, err := q.db.Query(ctx, adminGetSongs)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	items := []AdminGetSongsRow{}
	for rows.Next() {
		var i AdminGetSongsRow
		if err := rows.Scan(
			&i.ID,
			&i.Name,
			&i.Thumbnail,
			&i.ArtistID,
			&i.Path,
			&i.Lyrics,
			&i.CategoryID,
			&i.Duration,
			&i.ReleaseDate,
			&i.CreatedAt,
			&i.UpdatedAt,
			&i.ArtistName,
			&i.AvatarUrl,
		); err != nil {
			return nil, err
		}
		items = append(items, i)
	}
	if err := rows.Err(); err != nil {
		return nil, err
	}
	return items, nil
}

const createSong = `-- name: CreateSong :one
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
) RETURNING id, name, thumbnail, artist_id, path, lyrics, category_id, duration, release_date, created_at, updated_at
`

type CreateSongParams struct {
	Name        string           `json:"name"`
	Thumbnail   pgtype.Text      `json:"thumbnail"`
	Path        pgtype.Text      `json:"path"`
	Lyrics      pgtype.Text      `json:"lyrics"`
	Duration    pgtype.Int4      `json:"duration"`
	ReleaseDate pgtype.Timestamp `json:"release_date"`
	ArtistID    int32            `json:"artist_id"`
	CategoryID  int32            `json:"category_id"`
}

func (q *Queries) CreateSong(ctx context.Context, arg CreateSongParams) (Song, error) {
	row := q.db.QueryRow(ctx, createSong,
		arg.Name,
		arg.Thumbnail,
		arg.Path,
		arg.Lyrics,
		arg.Duration,
		arg.ReleaseDate,
		arg.ArtistID,
		arg.CategoryID,
	)
	var i Song
	err := row.Scan(
		&i.ID,
		&i.Name,
		&i.Thumbnail,
		&i.ArtistID,
		&i.Path,
		&i.Lyrics,
		&i.CategoryID,
		&i.Duration,
		&i.ReleaseDate,
		&i.CreatedAt,
		&i.UpdatedAt,
	)
	return i, err
}

const deleteSong = `-- name: DeleteSong :exec
DELETE FROM songs  WHERE id = $1
`

func (q *Queries) DeleteSong(ctx context.Context, id int32) error {
	_, err := q.db.Exec(ctx, deleteSong, id)
	return err
}

const getNewSongs = `-- name: GetNewSongs :many

SELECT s.id, s.name, s.thumbnail, s.artist_id, s.path, s.lyrics, s.category_id, s.duration, s.release_date, s.created_at, s.updated_at, a.name as artist_name, a.avatar_url
FROM songs s
LEFT JOIN artist a on s.artist_id = a.id
ORDER BY s.created_at DESC
OFFSET 0
LIMIT 15
`

type GetNewSongsRow struct {
	ID          int32            `json:"id"`
	Name        string           `json:"name"`
	Thumbnail   pgtype.Text      `json:"thumbnail"`
	ArtistID    int32            `json:"artist_id"`
	Path        pgtype.Text      `json:"path"`
	Lyrics      pgtype.Text      `json:"lyrics"`
	CategoryID  int32            `json:"category_id"`
	Duration    pgtype.Int4      `json:"duration"`
	ReleaseDate pgtype.Timestamp `json:"release_date"`
	CreatedAt   pgtype.Timestamp `json:"created_at"`
	UpdatedAt   pgtype.Timestamp `json:"updated_at"`
	ArtistName  pgtype.Text      `json:"artist_name"`
	AvatarUrl   pgtype.Text      `json:"avatar_url"`
}

func (q *Queries) GetNewSongs(ctx context.Context) ([]GetNewSongsRow, error) {
	rows, err := q.db.Query(ctx, getNewSongs)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	items := []GetNewSongsRow{}
	for rows.Next() {
		var i GetNewSongsRow
		if err := rows.Scan(
			&i.ID,
			&i.Name,
			&i.Thumbnail,
			&i.ArtistID,
			&i.Path,
			&i.Lyrics,
			&i.CategoryID,
			&i.Duration,
			&i.ReleaseDate,
			&i.CreatedAt,
			&i.UpdatedAt,
			&i.ArtistName,
			&i.AvatarUrl,
		); err != nil {
			return nil, err
		}
		items = append(items, i)
	}
	if err := rows.Err(); err != nil {
		return nil, err
	}
	return items, nil
}

const getRandomSong = `-- name: GetRandomSong :many
SELECT s.id, s.name, s.thumbnail, s.artist_id, s.path, s.lyrics, s.category_id, s.duration, s.release_date, s.created_at, s.updated_at, a.name as artist_name, a.avatar_url
FROM songs s
LEFT JOIN artist a on a.id = s.artist_id
Order by RANDOM()
limit 15
`

type GetRandomSongRow struct {
	ID          int32            `json:"id"`
	Name        string           `json:"name"`
	Thumbnail   pgtype.Text      `json:"thumbnail"`
	ArtistID    int32            `json:"artist_id"`
	Path        pgtype.Text      `json:"path"`
	Lyrics      pgtype.Text      `json:"lyrics"`
	CategoryID  int32            `json:"category_id"`
	Duration    pgtype.Int4      `json:"duration"`
	ReleaseDate pgtype.Timestamp `json:"release_date"`
	CreatedAt   pgtype.Timestamp `json:"created_at"`
	UpdatedAt   pgtype.Timestamp `json:"updated_at"`
	ArtistName  pgtype.Text      `json:"artist_name"`
	AvatarUrl   pgtype.Text      `json:"avatar_url"`
}

func (q *Queries) GetRandomSong(ctx context.Context) ([]GetRandomSongRow, error) {
	rows, err := q.db.Query(ctx, getRandomSong)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	items := []GetRandomSongRow{}
	for rows.Next() {
		var i GetRandomSongRow
		if err := rows.Scan(
			&i.ID,
			&i.Name,
			&i.Thumbnail,
			&i.ArtistID,
			&i.Path,
			&i.Lyrics,
			&i.CategoryID,
			&i.Duration,
			&i.ReleaseDate,
			&i.CreatedAt,
			&i.UpdatedAt,
			&i.ArtistName,
			&i.AvatarUrl,
		); err != nil {
			return nil, err
		}
		items = append(items, i)
	}
	if err := rows.Err(); err != nil {
		return nil, err
	}
	return items, nil
}

const getSongByAlbum = `-- name: GetSongByAlbum :many
SELECT s.id, s.name, s.thumbnail, s.artist_id, s.path, s.lyrics, s.category_id, s.duration, s.release_date, s.created_at, s.updated_at, a.name as artist_name, a.avatar_url
FROM songs s
LEFT JOIN artist a on s.artist_id = a.id
WHERE s.id in (
    SELECT song_id from albums_songs WHERE album_id = $1
) 
LIMIT COALESCE($3::int, 50)
OFFSET COALESCE($2::int, 0)
`

type GetSongByAlbumParams struct {
	AlbumID int32 `json:"album_id"`
	Start   int32 `json:"start"`
	Size    int32 `json:"size"`
}

type GetSongByAlbumRow struct {
	ID          int32            `json:"id"`
	Name        string           `json:"name"`
	Thumbnail   pgtype.Text      `json:"thumbnail"`
	ArtistID    int32            `json:"artist_id"`
	Path        pgtype.Text      `json:"path"`
	Lyrics      pgtype.Text      `json:"lyrics"`
	CategoryID  int32            `json:"category_id"`
	Duration    pgtype.Int4      `json:"duration"`
	ReleaseDate pgtype.Timestamp `json:"release_date"`
	CreatedAt   pgtype.Timestamp `json:"created_at"`
	UpdatedAt   pgtype.Timestamp `json:"updated_at"`
	ArtistName  pgtype.Text      `json:"artist_name"`
	AvatarUrl   pgtype.Text      `json:"avatar_url"`
}

func (q *Queries) GetSongByAlbum(ctx context.Context, arg GetSongByAlbumParams) ([]GetSongByAlbumRow, error) {
	rows, err := q.db.Query(ctx, getSongByAlbum, arg.AlbumID, arg.Start, arg.Size)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	items := []GetSongByAlbumRow{}
	for rows.Next() {
		var i GetSongByAlbumRow
		if err := rows.Scan(
			&i.ID,
			&i.Name,
			&i.Thumbnail,
			&i.ArtistID,
			&i.Path,
			&i.Lyrics,
			&i.CategoryID,
			&i.Duration,
			&i.ReleaseDate,
			&i.CreatedAt,
			&i.UpdatedAt,
			&i.ArtistName,
			&i.AvatarUrl,
		); err != nil {
			return nil, err
		}
		items = append(items, i)
	}
	if err := rows.Err(); err != nil {
		return nil, err
	}
	return items, nil
}

const getSongByID = `-- name: GetSongByID :one

SELECT s.id, s.name, s.thumbnail, s.artist_id, s.path, s.lyrics, s.category_id, s.duration, s.release_date, s.created_at, s.updated_at, a.name as artist_name, a.avatar_url
FROM songs s
LEFT JOIN artist a on s.artist_id = a.id
WHERE s.id = $1
`

type GetSongByIDRow struct {
	ID          int32            `json:"id"`
	Name        string           `json:"name"`
	Thumbnail   pgtype.Text      `json:"thumbnail"`
	ArtistID    int32            `json:"artist_id"`
	Path        pgtype.Text      `json:"path"`
	Lyrics      pgtype.Text      `json:"lyrics"`
	CategoryID  int32            `json:"category_id"`
	Duration    pgtype.Int4      `json:"duration"`
	ReleaseDate pgtype.Timestamp `json:"release_date"`
	CreatedAt   pgtype.Timestamp `json:"created_at"`
	UpdatedAt   pgtype.Timestamp `json:"updated_at"`
	ArtistName  pgtype.Text      `json:"artist_name"`
	AvatarUrl   pgtype.Text      `json:"avatar_url"`
}

func (q *Queries) GetSongByID(ctx context.Context, id int32) (GetSongByIDRow, error) {
	row := q.db.QueryRow(ctx, getSongByID, id)
	var i GetSongByIDRow
	err := row.Scan(
		&i.ID,
		&i.Name,
		&i.Thumbnail,
		&i.ArtistID,
		&i.Path,
		&i.Lyrics,
		&i.CategoryID,
		&i.Duration,
		&i.ReleaseDate,
		&i.CreatedAt,
		&i.UpdatedAt,
		&i.ArtistName,
		&i.AvatarUrl,
	)
	return i, err
}

const getSongById = `-- name: GetSongById :one

SELECT s.id, s.name, s.thumbnail, s.artist_id, s.path, s.lyrics, s.category_id, s.duration, s.release_date, s.created_at, s.updated_at, a.name as artist_name, a.avatar_url
FROM songs s 
LEFT JOIN artist a on s.artist_id = a.id
WHERE s.id = $1
`

type GetSongByIdRow struct {
	ID          int32            `json:"id"`
	Name        string           `json:"name"`
	Thumbnail   pgtype.Text      `json:"thumbnail"`
	ArtistID    int32            `json:"artist_id"`
	Path        pgtype.Text      `json:"path"`
	Lyrics      pgtype.Text      `json:"lyrics"`
	CategoryID  int32            `json:"category_id"`
	Duration    pgtype.Int4      `json:"duration"`
	ReleaseDate pgtype.Timestamp `json:"release_date"`
	CreatedAt   pgtype.Timestamp `json:"created_at"`
	UpdatedAt   pgtype.Timestamp `json:"updated_at"`
	ArtistName  pgtype.Text      `json:"artist_name"`
	AvatarUrl   pgtype.Text      `json:"avatar_url"`
}

func (q *Queries) GetSongById(ctx context.Context, id int32) (GetSongByIdRow, error) {
	row := q.db.QueryRow(ctx, getSongById, id)
	var i GetSongByIdRow
	err := row.Scan(
		&i.ID,
		&i.Name,
		&i.Thumbnail,
		&i.ArtistID,
		&i.Path,
		&i.Lyrics,
		&i.CategoryID,
		&i.Duration,
		&i.ReleaseDate,
		&i.CreatedAt,
		&i.UpdatedAt,
		&i.ArtistName,
		&i.AvatarUrl,
	)
	return i, err
}

const getSongOfArtist = `-- name: GetSongOfArtist :many
SELECT s.id, s.name, s.thumbnail, s.artist_id, s.path, s.lyrics, s.category_id, s.duration, s.release_date, s.created_at, s.updated_at, a.name as artist_name, a.avatar_url
FROM songs s
LEFT JOIN artist a on s.artist_id = a.id
WHERE a.id = $1
`

type GetSongOfArtistRow struct {
	ID          int32            `json:"id"`
	Name        string           `json:"name"`
	Thumbnail   pgtype.Text      `json:"thumbnail"`
	ArtistID    int32            `json:"artist_id"`
	Path        pgtype.Text      `json:"path"`
	Lyrics      pgtype.Text      `json:"lyrics"`
	CategoryID  int32            `json:"category_id"`
	Duration    pgtype.Int4      `json:"duration"`
	ReleaseDate pgtype.Timestamp `json:"release_date"`
	CreatedAt   pgtype.Timestamp `json:"created_at"`
	UpdatedAt   pgtype.Timestamp `json:"updated_at"`
	ArtistName  pgtype.Text      `json:"artist_name"`
	AvatarUrl   pgtype.Text      `json:"avatar_url"`
}

func (q *Queries) GetSongOfArtist(ctx context.Context, id int32) ([]GetSongOfArtistRow, error) {
	rows, err := q.db.Query(ctx, getSongOfArtist, id)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	items := []GetSongOfArtistRow{}
	for rows.Next() {
		var i GetSongOfArtistRow
		if err := rows.Scan(
			&i.ID,
			&i.Name,
			&i.Thumbnail,
			&i.ArtistID,
			&i.Path,
			&i.Lyrics,
			&i.CategoryID,
			&i.Duration,
			&i.ReleaseDate,
			&i.CreatedAt,
			&i.UpdatedAt,
			&i.ArtistName,
			&i.AvatarUrl,
		); err != nil {
			return nil, err
		}
		items = append(items, i)
	}
	if err := rows.Err(); err != nil {
		return nil, err
	}
	return items, nil
}

const getSongOfPlaylist = `-- name: GetSongOfPlaylist :many
SELECT s.id, s.name, s.thumbnail, s.artist_id, s.path, s.lyrics, s.category_id, s.duration, s.release_date, s.created_at, s.updated_at, a.name as artist_name, a.avatar_url
FROM songs s
LEFT JOIN artist a on s.artist_id = a.id
WHERE s.id IN (
    SELECT song_id
    FROM playlist_song
    WHERE playlist_id = $1
)
`

type GetSongOfPlaylistRow struct {
	ID          int32            `json:"id"`
	Name        string           `json:"name"`
	Thumbnail   pgtype.Text      `json:"thumbnail"`
	ArtistID    int32            `json:"artist_id"`
	Path        pgtype.Text      `json:"path"`
	Lyrics      pgtype.Text      `json:"lyrics"`
	CategoryID  int32            `json:"category_id"`
	Duration    pgtype.Int4      `json:"duration"`
	ReleaseDate pgtype.Timestamp `json:"release_date"`
	CreatedAt   pgtype.Timestamp `json:"created_at"`
	UpdatedAt   pgtype.Timestamp `json:"updated_at"`
	ArtistName  pgtype.Text      `json:"artist_name"`
	AvatarUrl   pgtype.Text      `json:"avatar_url"`
}

func (q *Queries) GetSongOfPlaylist(ctx context.Context, playlistID int32) ([]GetSongOfPlaylistRow, error) {
	rows, err := q.db.Query(ctx, getSongOfPlaylist, playlistID)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	items := []GetSongOfPlaylistRow{}
	for rows.Next() {
		var i GetSongOfPlaylistRow
		if err := rows.Scan(
			&i.ID,
			&i.Name,
			&i.Thumbnail,
			&i.ArtistID,
			&i.Path,
			&i.Lyrics,
			&i.CategoryID,
			&i.Duration,
			&i.ReleaseDate,
			&i.CreatedAt,
			&i.UpdatedAt,
			&i.ArtistName,
			&i.AvatarUrl,
		); err != nil {
			return nil, err
		}
		items = append(items, i)
	}
	if err := rows.Err(); err != nil {
		return nil, err
	}
	return items, nil
}

const getSongs = `-- name: GetSongs :many

SELECT s.id, s.name, s.thumbnail, s.artist_id, s.path, s.lyrics, s.category_id, s.duration, s.release_date, s.created_at, s.updated_at, a.name as artist_name, a.avatar_url
FROM songs s
LEFT JOIN artist a on s.artist_id = a.id
OFFSET COALESCE($1::int, 0)
LIMIT COALESCE($2::int, 50)
`

type GetSongsParams struct {
	Start int32 `json:"start"`
	Size  int32 `json:"size"`
}

type GetSongsRow struct {
	ID          int32            `json:"id"`
	Name        string           `json:"name"`
	Thumbnail   pgtype.Text      `json:"thumbnail"`
	ArtistID    int32            `json:"artist_id"`
	Path        pgtype.Text      `json:"path"`
	Lyrics      pgtype.Text      `json:"lyrics"`
	CategoryID  int32            `json:"category_id"`
	Duration    pgtype.Int4      `json:"duration"`
	ReleaseDate pgtype.Timestamp `json:"release_date"`
	CreatedAt   pgtype.Timestamp `json:"created_at"`
	UpdatedAt   pgtype.Timestamp `json:"updated_at"`
	ArtistName  pgtype.Text      `json:"artist_name"`
	AvatarUrl   pgtype.Text      `json:"avatar_url"`
}

func (q *Queries) GetSongs(ctx context.Context, arg GetSongsParams) ([]GetSongsRow, error) {
	rows, err := q.db.Query(ctx, getSongs, arg.Start, arg.Size)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	items := []GetSongsRow{}
	for rows.Next() {
		var i GetSongsRow
		if err := rows.Scan(
			&i.ID,
			&i.Name,
			&i.Thumbnail,
			&i.ArtistID,
			&i.Path,
			&i.Lyrics,
			&i.CategoryID,
			&i.Duration,
			&i.ReleaseDate,
			&i.CreatedAt,
			&i.UpdatedAt,
			&i.ArtistName,
			&i.AvatarUrl,
		); err != nil {
			return nil, err
		}
		items = append(items, i)
	}
	if err := rows.Err(); err != nil {
		return nil, err
	}
	return items, nil
}

const playSong = `-- name: PlaySong :exec
INSERT INTO song_plays (song_id, user_id)
VALUES ($1, $2)
`

type PlaySongParams struct {
	SongID int32       `json:"song_id"`
	UserID pgtype.Int4 `json:"user_id"`
}

func (q *Queries) PlaySong(ctx context.Context, arg PlaySongParams) error {
	_, err := q.db.Exec(ctx, playSong, arg.SongID, arg.UserID)
	return err
}

const searchSong = `-- name: SearchSong :many
SELECT s.id, s.name, s.thumbnail, s.artist_id, s.path, s.lyrics, s.category_id, s.duration, s.release_date, s.created_at, s.updated_at, a.name as artist_name, a.avatar_url
FROM songs s
LEFT JOIN artist a on a.id = s.artist_id
where s.name ilike $1::varchar || '%'
OFFSET COALESCE($2::int, 0)
LIMIT COALESCE($3::int, 50)
`

type SearchSongParams struct {
	Search pgtype.Text `json:"search"`
	Start  int32       `json:"start"`
	Size   int32       `json:"size"`
}

type SearchSongRow struct {
	ID          int32            `json:"id"`
	Name        string           `json:"name"`
	Thumbnail   pgtype.Text      `json:"thumbnail"`
	ArtistID    int32            `json:"artist_id"`
	Path        pgtype.Text      `json:"path"`
	Lyrics      pgtype.Text      `json:"lyrics"`
	CategoryID  int32            `json:"category_id"`
	Duration    pgtype.Int4      `json:"duration"`
	ReleaseDate pgtype.Timestamp `json:"release_date"`
	CreatedAt   pgtype.Timestamp `json:"created_at"`
	UpdatedAt   pgtype.Timestamp `json:"updated_at"`
	ArtistName  pgtype.Text      `json:"artist_name"`
	AvatarUrl   pgtype.Text      `json:"avatar_url"`
}

func (q *Queries) SearchSong(ctx context.Context, arg SearchSongParams) ([]SearchSongRow, error) {
	rows, err := q.db.Query(ctx, searchSong, arg.Search, arg.Start, arg.Size)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	items := []SearchSongRow{}
	for rows.Next() {
		var i SearchSongRow
		if err := rows.Scan(
			&i.ID,
			&i.Name,
			&i.Thumbnail,
			&i.ArtistID,
			&i.Path,
			&i.Lyrics,
			&i.CategoryID,
			&i.Duration,
			&i.ReleaseDate,
			&i.CreatedAt,
			&i.UpdatedAt,
			&i.ArtistName,
			&i.AvatarUrl,
		); err != nil {
			return nil, err
		}
		items = append(items, i)
	}
	if err := rows.Err(); err != nil {
		return nil, err
	}
	return items, nil
}

const updateSong = `-- name: UpdateSong :exec

UPDATE songs 
SET name = $1, thumbnail = $2, 
path = $3, lyrics = $4, duration = $5, 
release_date = $6, artist_id = $7,category_id = $8,
updated_at = NOW()
WHERE id = $9
`

type UpdateSongParams struct {
	Name        string           `json:"name"`
	Thumbnail   pgtype.Text      `json:"thumbnail"`
	Path        pgtype.Text      `json:"path"`
	Lyrics      pgtype.Text      `json:"lyrics"`
	Duration    pgtype.Int4      `json:"duration"`
	ReleaseDate pgtype.Timestamp `json:"release_date"`
	ArtistID    int32            `json:"artist_id"`
	CategoryID  int32            `json:"category_id"`
	ID          int32            `json:"id"`
}

func (q *Queries) UpdateSong(ctx context.Context, arg UpdateSongParams) error {
	_, err := q.db.Exec(ctx, updateSong,
		arg.Name,
		arg.Thumbnail,
		arg.Path,
		arg.Lyrics,
		arg.Duration,
		arg.ReleaseDate,
		arg.ArtistID,
		arg.CategoryID,
		arg.ID,
	)
	return err
}
