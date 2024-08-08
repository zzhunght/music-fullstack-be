package services

import (
	"context"
	db "music-app-backend/sqlc"
)

type ArtistService struct {
	store *db.SQLStore
}

func NewArtistService(store *db.SQLStore) *ArtistService {
	return &ArtistService{
		store: store,
	}
}

func (s *ArtistService) RecommendedArtist(ctx context.Context) ([]db.Artist, error) {
	return s.store.GetRecommentArtist(ctx)
}

func (s *ArtistService) GetAllArtist(ctx context.Context) ([]db.Artist, error) {
	return s.store.GetAllArtistForAdmin(ctx)
}

func (s *ArtistService) GetArtistSong(ctx context.Context, artist_id int) ([]db.GetSongOfArtistRow, error) {
	return s.store.GetSongOfArtist(ctx, int32(artist_id))
}
func (s *ArtistService) GetArtistAlbum(ctx context.Context, artist_id int) ([]db.Album, error) {
	return s.store.GetAlbumByArtistID(ctx, int32(artist_id))
}

func (s *ArtistService) GetArtistById(ctx context.Context, artist_id int) (db.GetArtistByIdRow, error) {
	return s.store.GetArtistById(ctx, int32(artist_id))
}

func (s *ArtistService) SearchArtist(ctx context.Context, search string) ([]db.SearchArtistRow, error) {
	return s.store.SearchArtist(ctx, search)
}

func (s *ArtistService) FollowArtist(ctx context.Context, arg db.FollowParams) error {
	return s.store.Follow(ctx, arg)
}

func (s *ArtistService) UnFollowArtist(ctx context.Context, arg db.UnFollowParams) error {
	return s.store.UnFollow(ctx, arg)
}

func (s *ArtistService) CheckFollowArtist(ctx context.Context, arg db.CheckFollowParams) (db.ArtistFollow, error) {
	return s.store.CheckFollow(ctx, arg)
}

func (s *ArtistService) GetFollowedArtist(ctx context.Context, UserID int32) ([]db.GetFollowedArtistRow, error) {
	return s.store.GetFollowedArtist(ctx, UserID)
}

func (s *ArtistService) UpdateArtist(ctx context.Context, arg db.UpdateArtistParams) (db.Artist, error) {
	return s.store.UpdateArtist(ctx, arg)
}

func (s *ArtistService) CreateArtist(ctx context.Context, arg db.CreateArtistParams) (db.Artist, error) {
	return s.store.CreateArtist(ctx, arg)
}

func (s *ArtistService) DeleteArtist(ctx context.Context, id int32) error {
	return s.store.DeleteArtist(ctx, id)
}
