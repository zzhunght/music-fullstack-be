package services

import (
	"context"
	db "music-app-backend/sqlc"
)

type CategoriesService struct {
	store *db.SQLStore
}

func NewCategoriesService(store *db.SQLStore) *CategoriesService {
	return &CategoriesService{
		store: store,
	}
}

func (s *CategoriesService) GetCategories(ctx context.Context) (categories []db.Category, err error) {

	categories, err = s.store.GetSongCategories(ctx)
	return
}

func (s *CategoriesService) GetSongInCategory(ctx context.Context, arg db.GetSongInCategoryParams) (categories []db.GetSongInCategoryRow, err error) {

	categories, err = s.store.GetSongInCategory(ctx, arg)
	return
}

func (s *CategoriesService) CreateCategory(ctx context.Context, arg db.CreateCategoriesParams) (category db.Category, err error) {

	category, err = s.store.CreateCategories(ctx, arg)
	return
}

func (s *CategoriesService) UpdateCategory(ctx context.Context, body db.UpdateCategoriesParams) (category db.Category, err error) {
	category, err = s.store.UpdateCategories(ctx, body)
	return
}

func (s *CategoriesService) DeleteCategory(ctx context.Context, id int32) (err error) {
	err = s.store.DeleteCategories(ctx, id)
	return
}
