package services

import (
	"context"
	db "music-app-backend/sqlc"
)

type StaticService struct {
	store *db.SQLStore
}

func NewStatisticService(store *db.SQLStore) *StaticService {
	return &StaticService{store: store}
}

func (s *StaticService) GetStatistics(ctx context.Context) (db.StatisticsRow, error) {
	return s.store.Statistics(ctx)
}

func (s *StaticService) GetSongViewStatistics(ctx context.Context, arg db.GetSongViewStatisticsParams) ([]db.GetSongViewStatisticsRow, error) {
	return s.store.GetSongViewStatistics(ctx, arg)
}
