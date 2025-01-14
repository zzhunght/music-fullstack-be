// Code generated by sqlc. DO NOT EDIT.
// versions:
//   sqlc v1.26.0

package sqlc

import (
	"time"

	"github.com/google/uuid"
	"github.com/jackc/pgx/v5/pgtype"
)

type Account struct {
	ID        int32            `json:"id"`
	Name      string           `json:"name"`
	Email     string           `json:"email"`
	Password  string           `json:"password"`
	RoleID    int32            `json:"role_id"`
	IsVerify  bool             `json:"is_verify"`
	SecretKey pgtype.Text      `json:"secret_key"`
	CreatedAt pgtype.Timestamp `json:"created_at"`
	UpdatedAt pgtype.Timestamp `json:"updated_at"`
}

type Album struct {
	ID          int32            `json:"id"`
	ArtistID    int32            `json:"artist_id"`
	Name        string           `json:"name"`
	Thumbnail   string           `json:"thumbnail"`
	CategoryID  pgtype.Int4      `json:"category_id"`
	ReleaseDate time.Time        `json:"release_date"`
	CreatedAt   pgtype.Timestamp `json:"created_at"`
}

type AlbumsSong struct {
	ID        int32            `json:"id"`
	SongID    int32            `json:"song_id"`
	AlbumID   int32            `json:"album_id"`
	CreatedAt pgtype.Timestamp `json:"created_at"`
}

type Artist struct {
	ID        int32            `json:"id"`
	Name      string           `json:"name"`
	AvatarUrl pgtype.Text      `json:"avatar_url"`
	CreatedAt pgtype.Timestamp `json:"created_at"`
	UpdatedAt pgtype.Timestamp `json:"updated_at"`
}

type ArtistFollow struct {
	ID        int32            `json:"id"`
	AccountID int32            `json:"account_id"`
	ArtistID  int32            `json:"artist_id"`
	CreatedAt pgtype.Timestamp `json:"created_at"`
}

type Category struct {
	ID        int32            `json:"id"`
	Name      string           `json:"name"`
	Thumbnail pgtype.Text      `json:"thumbnail"`
	Color     pgtype.Text      `json:"color"`
	CreatedAt pgtype.Timestamp `json:"created_at"`
	UpdatedAt pgtype.Timestamp `json:"updated_at"`
}

type Comment struct {
	ID        pgtype.Int4      `json:"id"`
	Content   string           `json:"content"`
	UserID    int32            `json:"user_id"`
	SongID    int32            `json:"song_id"`
	CreatedAt pgtype.Timestamp `json:"created_at"`
}

type FavoriteAlbum struct {
	ID        int32            `json:"id"`
	AccountID int32            `json:"account_id"`
	AlbumID   int32            `json:"album_id"`
	CreatedAt pgtype.Timestamp `json:"created_at"`
}

type FavoriteSong struct {
	ID        int32            `json:"id"`
	AccountID int32            `json:"account_id"`
	SongID    int32            `json:"song_id"`
	CreatedAt pgtype.Timestamp `json:"created_at"`
}

type Playlist struct {
	ID          int32            `json:"id"`
	Name        string           `json:"name"`
	Thumbnail   pgtype.Text      `json:"thumbnail"`
	AccountID   pgtype.Int4      `json:"account_id"`
	ArtistID    pgtype.Int4      `json:"artist_id"`
	CategoryID  pgtype.Int4      `json:"category_id"`
	Description pgtype.Text      `json:"description"`
	CreatedAt   pgtype.Timestamp `json:"created_at"`
	UpdatedAt   pgtype.Timestamp `json:"updated_at"`
}

type PlaylistSong struct {
	ID         int32            `json:"id"`
	PlaylistID int32            `json:"playlist_id"`
	SongID     int32            `json:"song_id"`
	CreatedAt  pgtype.Timestamp `json:"created_at"`
}

type Role struct {
	ID        int32            `json:"id"`
	Name      string           `json:"name"`
	CreatedAt pgtype.Timestamp `json:"created_at"`
	UpdatedAt pgtype.Timestamp `json:"updated_at"`
}

type Session struct {
	ID           uuid.UUID        `json:"id"`
	Email        string           `json:"email"`
	ClientAgent  string           `json:"client_agent"`
	RefreshToken string           `json:"refresh_token"`
	ClientIp     string           `json:"client_ip"`
	IsBlock      pgtype.Bool      `json:"is_block"`
	ExpiredAt    pgtype.Timestamp `json:"expired_at"`
}

type Song struct {
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
}

type SongPlay struct {
	ID     int32            `json:"id"`
	SongID int32            `json:"song_id"`
	UserID pgtype.Int4      `json:"user_id"`
	PlayAt pgtype.Timestamp `json:"play_at"`
}
