package services

import (
	"context"
	db "music-app-backend/sqlc"
)

type AlbumService struct {
	store *db.SQLStore
}

func NewAlbumServices(store *db.SQLStore) *AlbumService {
	return &AlbumService{
		store: store,
	}
}

func (s *AlbumService) CreateAlbum(ctx context.Context, arg db.CreateAlbumParams) (db.Album, error) {
	return s.store.CreateAlbum(ctx, arg)
}

func (s *AlbumService) UpdateAlbum(ctx context.Context, arg db.UpdateAlbumParams) (db.Album, error) {
	return s.store.UpdateAlbum(ctx, arg)
}

func (s *AlbumService) DeleteAlbum(ctx context.Context, id int32) error {
	return s.store.DeleteAlbum(ctx, id)
}

func (s *AlbumService) GetAllAlbums(ctx context.Context) ([]db.GetAllAlbumRow, error) {
	return s.store.GetAllAlbum(ctx)
}

func (s *AlbumService) GetNewAlbums(ctx context.Context) ([]db.GetNewAlbumRow, error) {
	return s.store.GetNewAlbum(ctx)
}

func (s *AlbumService) GetSongNotInAlbum(ctx context.Context, albumId int32) ([]db.GetSongNotInAlbumRow, error) {
	album, err := s.store.GetAlbumByID(ctx, albumId)
	if err != nil {
		return nil, err
	}
	return s.store.GetSongNotInAlbum(ctx, db.GetSongNotInAlbumParams{
		ArtistID: album.ArtistID,
		AlbumID:  album.ID,
	})
}

func (s *AlbumService) GetSongInAlbum(ctx context.Context, albumID int32) ([]db.GetAlbumSongRow, error) {
	return s.store.GetAlbumSong(ctx, albumID)
}

func (s *AlbumService) CheckSongInAlbum(ctx context.Context, arg db.CheckSongInAlbumParams) (int64, error) {
	return s.store.CheckSongInAlbum(ctx, arg)
}

func (s *AlbumService) GetAlbumSongs(ctx context.Context, album_id int32) ([]db.GetAlbumSongRow, error) {
	return s.store.GetAlbumSong(ctx, album_id)
}

func (s *AlbumService) AddSongToAlbum(ctx context.Context, arg db.AddSongToAlbumParams) error {
	return s.store.AddSongToAlbum(ctx, arg)
}

func (s *AlbumService) RemoveSongFromAlbum(ctx context.Context, arg db.RemoveSongFromAlbumParams) error {
	return s.store.RemoveSongFromAlbum(ctx, arg)
}
