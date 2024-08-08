package services

import (
	"context"
	db "music-app-backend/sqlc"
)

type PlaylistService struct {
	store *db.SQLStore
}

func NewPlaylistService(store *db.SQLStore) *PlaylistService {
	return &PlaylistService{store: store}
}

func (s *PlaylistService) CreateUserPlaylist(ctx context.Context, payload db.CreateUserPlaylistParams) (db.Playlist, error) {

	return s.store.CreateUserPlaylist(ctx, payload)
}

func (s *PlaylistService) AddSongToPlaylist(ctx context.Context, payload db.AddSongToPlaylistParams) (db.GetSongByIdRow, error) {

	err := s.store.AddSongToPlaylist(ctx, payload)
	if err != nil {
		return db.GetSongByIdRow{}, err
	}

	data, err := s.store.GetSongById(ctx, payload.SongID)
	return data, err
}

func (s *PlaylistService) RemoveSongFromPlaylist(ctx context.Context, payload db.RemoveSongFromPlaylistParams) error {

	return s.store.RemoveSongFromPlaylist(ctx, payload)
}

func (s *PlaylistService) CheckOwnerPlaylist(ctx context.Context, payload db.CheckOwnerPlaylistParams) (db.CheckOwnerPlaylistRow, error) {

	return s.store.CheckOwnerPlaylist(ctx, payload)
}

func (s *PlaylistService) GetPlaylistSongs(ctx context.Context, playlist_id int32) ([]db.GetSongInPlaylistRow, error) {

	return s.store.GetSongInPlaylist(ctx, playlist_id)
}

func (s *PlaylistService) GetSongNotInPlaylist(ctx context.Context, arg db.GetSongNotInPlaylistParams) ([]db.GetSongNotInPlaylistRow, error) {

	return s.store.GetSongNotInPlaylist(ctx, arg)
}

func (s *PlaylistService) GetNewPlaylist(ctx context.Context) ([]db.Playlist, error) {

	return s.store.GetNewPlaylist(ctx)
}

func (s *PlaylistService) GetPlaylistByArtist(ctx context.Context, artist_id int32) ([]db.Playlist, error) {

	return s.store.GetPlaylistByArtist(ctx, artist_id)
}

func (s *PlaylistService) GetPlaylistByCategoryID(ctx context.Context, category_id int32) ([]db.Playlist, error) {

	return s.store.GetPlaylistByCategories(ctx, category_id)
}
func (s *PlaylistService) GetPlaylistByUserId(ctx context.Context, user_id int32) ([]db.GetPlaylistByUserIdRow, error) {

	return s.store.GetPlaylistByUserId(ctx, user_id)
}

func (s *PlaylistService) GetPlaylistById(ctx context.Context, id int32) (db.Playlist, error) {

	return s.store.GetPlaylistById(ctx, id)
}

func (s *PlaylistService) CreatePlaylist(ctx context.Context, arg db.CreatePlaylistParams) (db.Playlist, error) {

	return s.store.CreatePlaylist(ctx, arg)
}

func (s *PlaylistService) UpdatePlaylist(ctx context.Context, arg db.UpdatePlaylistParams) (db.Playlist, error) {

	return s.store.UpdatePlaylist(ctx, arg)
}

func (s *PlaylistService) GetAllPlaylist(ctx context.Context) ([]db.Playlist, error) {

	return s.store.GetAllPlaylist(ctx)
}

func (s *PlaylistService) SearchPlaylist(ctx context.Context, search string) ([]db.Playlist, error) {

	return s.store.SearchPlaylist(ctx, search)
}

func (s *PlaylistService) AdminDeletePlaylist(ctx context.Context, playlistID int32) error {

	return s.store.AdminDeletePlaylist(ctx, playlistID)
}
