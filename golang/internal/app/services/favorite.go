package services

import (
	"context"
	db "music-app-backend/sqlc"
)

type FavoriteService struct {
	store *db.SQLStore
}

func NewFavoriteService(store *db.SQLStore) *FavoriteService {
	return &FavoriteService{store: store}
}

func (s *FavoriteService) FavoriteSong(ctx context.Context, payload db.AddSongToFavoriteParams) error {
	return s.store.AddSongToFavorite(ctx, payload)
}

func (s *FavoriteService) RemoveFavoriteSong(ctx context.Context, payload db.RemoveSongFromFavoriteParams) error {
	return s.store.RemoveSongFromFavorite(ctx, payload)
}

func (s *FavoriteService) CheckFavorite(ctx context.Context, payload db.CheckFavoriteParams) (int32, error) {
	return s.store.CheckFavorite(ctx, payload)
}

func (s *FavoriteService) GetFavoriteSongs(ctx context.Context, accountId int32) ([]db.GetFavoriteSongsRow, error) {
	return s.store.GetFavoriteSongs(ctx, accountId)
}
