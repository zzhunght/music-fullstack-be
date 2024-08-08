package services

import (
	"context"
	db "music-app-backend/sqlc"

	"github.com/google/uuid"
)

type UserService struct {
	store *db.SQLStore
}

func NewUserService(store *db.SQLStore) *UserService {
	return &UserService{store: store}
}

func (s *UserService) CheckEmailExists(ctx context.Context, email string) (int32, error) {
	return s.store.CheckEmailExists(ctx, email)
}

func (s *UserService) UpdateName(ctx context.Context, arg db.UpdateNameParams) error {
	return s.store.UpdateName(ctx, arg)
}

func (s *UserService) GetAccount(ctx context.Context, email string) (db.GetAccountRow, error) {
	return s.store.GetAccount(ctx, email)
}

func (s *UserService) ChangePassword(ctx context.Context, arg db.ChangePasswordParams) error {
	return s.store.ChangePassword(ctx, arg)
}

func (s *UserService) CreateAccount(ctx context.Context, arg db.CreateAccountParams) (db.CreateAccountRow, error) {
	return s.store.CreateAccount(ctx, arg)
}

func (s *UserService) CreateSession(ctx context.Context, arg db.CreateSessionParams) (db.Session, error) {
	return s.store.CreateSession(ctx, arg)
}

func (s *UserService) UpdateSession(ctx context.Context, arg db.UpdateSessionIDParams) error {
	return s.store.UpdateSessionID(ctx, arg)
}

func (s *UserService) DeleteSession(ctx context.Context, id uuid.UUID) error {
	return s.store.DeleteSession(ctx, id)
}

func (s *UserService) GetSession(ctx context.Context, id uuid.UUID) (db.Session, error) {
	return s.store.GetSession(ctx, id)
}

func (s *UserService) GetSessionByRefreshToken(ctx context.Context, rf_token string) (db.Session, error) {
	return s.store.GetSessionByRfToken(ctx, rf_token)
}

func (s *UserService) GetUser(ctx context.Context, email string) (db.GetUserInfoRow, error) {
	return s.store.GetUserInfo(ctx, email)
}
