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
	"github.com/jackc/pgx/v5/pgtype"
)

type ArtistController struct {
	artistService *services.ArtistService
}

type CreateArtistRequest struct {
	Name      string `json:"name" binding:"required"`
	AvatarUrl string `json:"avatar_url" binding:"required"`
}

type UpdateArtistRequest struct {
	Name      string `json:"name" binding:"required"`
	AvatarUrl string `json:"avatar_url" binding:"required"`
}

func NewArtistController(service *services.ArtistService) *ArtistController {
	return &ArtistController{
		artistService: service,
	}
}

func (c *ArtistController) GetAllArtist(ctx *gin.Context) {

	data, err := c.artistService.GetAllArtist(ctx)
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, response.ErrorResponse(err))
		return
	}
	ctx.JSON(http.StatusOK, response.SuccessResponse(data, "get all artists successfully"))
}

func (c *ArtistController) GetFollowedArtist(ctx *gin.Context) {
	authPayload := ctx.MustGet(middleware.AuthorizationPayloadKey).(*helper.TokenPayload)

	data, err := c.artistService.GetFollowedArtist(ctx, authPayload.UserID)
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, response.ErrorResponse(err))
		return
	}
	ctx.JSON(http.StatusOK, response.SuccessResponse(data, "get followed artists successfully"))
}

func (c *ArtistController) FollowArtist(ctx *gin.Context) {
	authPayload := ctx.MustGet(middleware.AuthorizationPayloadKey).(*helper.TokenPayload)
	artistID, err := strconv.Atoi(ctx.Param("artist_id"))
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, response.ErrorResponse(err))
		return
	}
	err = c.artistService.FollowArtist(ctx, db.FollowParams{
		AccountID: authPayload.UserID,
		ArtistID:  int32(artistID),
	})
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, response.ErrorResponse(err))
		return
	}
	ctx.JSON(http.StatusOK, response.SuccessResponse(true, "follow artists successfully"))
}

func (c *ArtistController) UnFollowArtist(ctx *gin.Context) {
	authPayload := ctx.MustGet(middleware.AuthorizationPayloadKey).(*helper.TokenPayload)
	artistID, err := strconv.Atoi(ctx.Param("artist_id"))
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, response.ErrorResponse(err))
		return
	}
	err = c.artistService.UnFollowArtist(ctx, db.UnFollowParams{
		AccountID: authPayload.UserID,
		ArtistID:  int32(artistID),
	})

	if err != nil {
		ctx.JSON(http.StatusInternalServerError, response.ErrorResponse(err))
		return
	}
	ctx.JSON(http.StatusOK, response.SuccessResponse(true, "un follow artists successfully"))
}

func (c *ArtistController) CheckFollow(ctx *gin.Context) {
	authPayload := ctx.MustGet(middleware.AuthorizationPayloadKey).(*helper.TokenPayload)
	artistID, err := strconv.Atoi(ctx.Param("artist_id"))
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, response.ErrorResponse(err))
		return
	}
	_, err = c.artistService.CheckFollowArtist(ctx, db.CheckFollowParams{
		AccountID: authPayload.UserID,
		ArtistID:  int32(artistID),
	})

	if err == pgx.ErrNoRows {
		ctx.JSON(http.StatusOK, response.SuccessResponse(false, "check follow artists successfully"))
		return
	}

	if err != nil {
		ctx.JSON(http.StatusInternalServerError, response.ErrorResponse(err))
		return
	}
	ctx.JSON(http.StatusOK, response.SuccessResponse(true, "check follow artists successfully"))
}

func (c *ArtistController) SearchArtist(ctx *gin.Context) {
	search := ctx.Param("search")
	artists, err := c.artistService.SearchArtist(ctx, search)
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, response.ErrorResponse(err))
		return
	}
	ctx.JSON(http.StatusOK, response.SuccessResponse(artists, "search artists successfully"))
}

func (c *ArtistController) GetRecommendArtist(ctx *gin.Context) {
	artists, err := c.artistService.RecommendedArtist(ctx)
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, response.ErrorResponse(err))
		return
	}
	ctx.JSON(http.StatusOK, response.SuccessResponse(artists, "Get recommended artists"))
}

func (c *ArtistController) GetArtistSong(ctx *gin.Context) {
	id, ok := ctx.Params.Get("artist_id")
	if !ok {
		ctx.JSON(http.StatusBadRequest, response.ErrorResponse(errors.New("provide artist_id")))
		return
	}
	artistID, err := strconv.Atoi(id)
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, response.ErrorResponse(err))
		return
	}

	songs, _ := c.artistService.GetArtistSong(ctx, artistID)
	artist, err := c.artistService.GetArtistById(ctx, artistID)
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, response.ErrorResponse(err))
		return
	}

	data := struct {
		Songs  []db.GetSongOfArtistRow `json:"songs"`
		Artist db.GetArtistByIdRow     `json:"artist"`
	}{
		Songs:  songs,
		Artist: artist,
	}
	ctx.JSON(http.StatusOK, response.SuccessResponse(data, "Get artist songs"))
}

func (c *ArtistController) GetArtistAlbum(ctx *gin.Context) {
	id, ok := ctx.Params.Get("artist_id")
	if !ok {
		ctx.JSON(http.StatusBadRequest, response.ErrorResponse(errors.New("provide artist_id")))
		return
	}
	artistID, err := strconv.Atoi(id)
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, response.ErrorResponse(err))
		return
	}

	data, _ := c.artistService.GetArtistAlbum(ctx, artistID)
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, response.ErrorResponse(err))
		return
	}

	ctx.JSON(http.StatusOK, response.SuccessResponse(data, "Get artist album"))
}

func (c *ArtistController) CreateArtist(ctx *gin.Context) {

	var body CreateArtistRequest
	err := ctx.ShouldBindJSON(&body)
	if err != nil {
		ctx.JSON(http.StatusBadRequest, response.ErrorResponse(err))
		return
	}

	new_art, err := c.artistService.CreateArtist(ctx, db.CreateArtistParams{
		Name: body.Name,
		AvatarUrl: pgtype.Text{
			String: body.AvatarUrl,
			Valid:  true,
		},
	})
	if err != nil {
		ctx.JSON(http.StatusBadRequest, response.ErrorResponse(err))
		return
	}

	ctx.JSON(http.StatusCreated, response.SuccessResponse(new_art, "Tạo nghệ sĩ thành công"))
}

func (c *ArtistController) UpdateArtist(ctx *gin.Context) {
	artist_id, _ := ctx.Params.Get("id")
	id, err := strconv.Atoi(artist_id)

	if err != nil {
		ctx.JSON(http.StatusInternalServerError, response.ErrorResponse(err))
		return
	}
	var body UpdateArtistRequest
	err = ctx.ShouldBindJSON(&body)
	if err != nil {
		ctx.JSON(http.StatusBadRequest, response.ErrorResponse(err))
		return
	}

	new_art, err := c.artistService.UpdateArtist(ctx, db.UpdateArtistParams{
		ID:   int32(id),
		Name: body.Name,
		AvatarUrl: pgtype.Text{
			String: body.AvatarUrl,
			Valid:  true,
		},
	})
	if err != nil {
		ctx.JSON(http.StatusBadRequest, response.ErrorResponse(err))
		return
	}

	ctx.JSON(http.StatusCreated, response.SuccessResponse(new_art, "Cập nhật nghệ sĩ thành công"))
}

func (c *ArtistController) DeleteArtist(ctx *gin.Context) {
	artist_id, _ := ctx.Params.Get("id")
	id, err := strconv.Atoi(artist_id)

	if err != nil {
		ctx.JSON(http.StatusInternalServerError, response.ErrorResponse(err))
		return
	}

	err = c.artistService.DeleteArtist(ctx, int32(id))
	if err != nil {
		ctx.JSON(http.StatusBadRequest, response.ErrorResponse(err))
		return
	}

	ctx.JSON(http.StatusCreated, response.SuccessResponse(true, "Xoá nghệ sĩ thành công"))
}
