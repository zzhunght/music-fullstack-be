package controller

import (
	"errors"
	"music-app-backend/internal/app/helper"
	"music-app-backend/internal/app/response"
	"music-app-backend/internal/app/services"
	"music-app-backend/pkg/middleware"
	db "music-app-backend/sqlc"
	"net/http"
	"strconv"

	"github.com/gin-gonic/gin"
	"github.com/jackc/pgx/v5"
)

type FavoriteController struct {
	favoriteService *services.FavoriteService
}

func NewFavoriteController(services *services.FavoriteService) *FavoriteController {
	return &FavoriteController{
		favoriteService: services,
	}
}

func (c *FavoriteController) AddSongToFavorite(ctx *gin.Context) {
	id, ok := ctx.Params.Get("song_id")
	authPayload := ctx.MustGet(middleware.AuthorizationPayloadKey).(*helper.TokenPayload)
	if !ok {
		ctx.JSON(http.StatusBadRequest, response.ErrorResponse(errors.New("invalid song_id")))
		return
	}
	songID, err := strconv.Atoi(id)

	if err != nil {
		ctx.JSON(http.StatusInternalServerError, response.ErrorResponse(err))
		return
	}
	_, errCheck := c.favoriteService.CheckFavorite(ctx, db.CheckFavoriteParams{
		SongID:    int32(songID),
		AccountID: authPayload.UserID,
	})

	if errCheck == nil {
		ctx.JSON(http.StatusConflict, response.ErrorResponse(errors.New("song already in your favorites list")))
		return
	}

	if errCheck != nil && errCheck != pgx.ErrNoRows {
		ctx.JSON(http.StatusConflict, response.ErrorResponse(err))
		return
	}

	err = c.favoriteService.FavoriteSong(ctx, db.AddSongToFavoriteParams{
		SongID:    int32(songID),
		AccountID: authPayload.UserID,
	})

	if err != nil {
		ctx.JSON(http.StatusInternalServerError, response.ErrorResponse(err))
		return
	}

	ctx.JSON(http.StatusCreated, response.SuccessResponse(true, "Song added to favorite successfully"))

}

func (c *FavoriteController) RemoveSongFromFavorite(ctx *gin.Context) {
	id, ok := ctx.Params.Get("song_id")
	authPayload := ctx.MustGet(middleware.AuthorizationPayloadKey).(*helper.TokenPayload)
	if !ok {
		ctx.JSON(http.StatusBadRequest, response.ErrorResponse(errors.New("invalid song_id")))
		return
	}
	songID, err := strconv.Atoi(id)

	if err != nil {
		ctx.JSON(http.StatusInternalServerError, response.ErrorResponse(err))
		return
	}

	err = c.favoriteService.RemoveFavoriteSong(ctx, db.RemoveSongFromFavoriteParams{
		SongID:    int32(songID),
		AccountID: authPayload.UserID,
	})

	if err != nil {
		ctx.JSON(http.StatusInternalServerError, response.ErrorResponse(err))
		return
	}

	ctx.JSON(http.StatusCreated, response.SuccessResponse(true, "remove Song from favorite successfully"))

}
func (c *FavoriteController) CheckSongInFavorite(ctx *gin.Context) {
	id, ok := ctx.Params.Get("song_id")
	authPayload := ctx.MustGet(middleware.AuthorizationPayloadKey).(*helper.TokenPayload)
	if !ok {
		ctx.JSON(http.StatusBadRequest, response.ErrorResponse(errors.New("invalid song_id")))
		return
	}
	songID, err := strconv.Atoi(id)

	if err != nil {
		ctx.JSON(http.StatusInternalServerError, response.ErrorResponse(err))
		return
	}

	_, err = c.favoriteService.CheckFavorite(ctx, db.CheckFavoriteParams{
		SongID:    int32(songID),
		AccountID: authPayload.UserID,
	})

	if err != nil {
		if err == pgx.ErrNoRows {
			ctx.JSON(http.StatusCreated, response.SuccessResponse(false, "Song not favorite"))
			return
		}

		ctx.JSON(http.StatusInternalServerError, response.ErrorResponse(err))
		return
	}

	ctx.JSON(http.StatusCreated, response.SuccessResponse(true, "Song already favorited"))

}

func (c *FavoriteController) GetFavoriteSongs(ctx *gin.Context) {
	authPayload := ctx.MustGet(middleware.AuthorizationPayloadKey).(*helper.TokenPayload)
	data, err := c.favoriteService.GetFavoriteSongs(ctx, authPayload.UserID)
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, response.ErrorResponse(err))
		return
	}

	ctx.JSON(http.StatusCreated, response.SuccessResponse(data, "Songs"))

}
