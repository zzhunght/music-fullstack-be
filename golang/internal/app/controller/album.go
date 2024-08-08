package controller

import (
	"errors"
	"music-app-backend/internal/app/response"
	"music-app-backend/internal/app/services"
	"music-app-backend/sqlc"
	"net/http"
	"strconv"
	"time"

	"github.com/gin-gonic/gin"
)

type CreateAlbumRequest struct {
	Name        string    `json:"name" binding:"required"`
	ArtistID    int32     `json:"artist_id" binding:"required"`
	Thumbnail   string    `json:"thumbnail" binding:"required"`
	ReleaseDate time.Time `json:"release_date" binding:"required"`
}
type AddorRemoveSongAlbumRequest struct {
	AlbumId int32 `json:"album_id" binding:"required"`
	SongId  int32 `json:"song_id" binding:"required"`
}

type AlbumController struct {
	albumService *services.AlbumService
}

func NewAlbumController(services *services.AlbumService) *AlbumController {
	return &AlbumController{
		albumService: services,
	}
}

func (c *AlbumController) GetNewAlbum(ctx *gin.Context) {

	albums, err := c.albumService.GetNewAlbums(ctx)
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, response.ErrorResponse(err))
		return
	}

	ctx.JSON(http.StatusOK, response.SuccessResponse(albums, "Danh sách album mới nhất"))
}

func (c *AlbumController) GetAllAlbum(ctx *gin.Context) {

	albums, err := c.albumService.GetAllAlbums(ctx)
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, response.ErrorResponse(err))
		return
	}

	ctx.JSON(http.StatusOK, response.SuccessResponse(albums, "Danh sách album mới nhất"))
}

func (c *AlbumController) CreateAlbum(ctx *gin.Context) {
	var body CreateAlbumRequest

	err := ctx.ShouldBindJSON(&body)

	if err != nil {
		ctx.JSON(http.StatusBadRequest, response.ErrorResponse(err))
		return
	}

	albums, err := c.albumService.CreateAlbum(ctx, sqlc.CreateAlbumParams{
		Name:        body.Name,
		ArtistID:    body.ArtistID,
		Thumbnail:   body.Thumbnail,
		ReleaseDate: body.ReleaseDate,
	})
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, response.ErrorResponse(err))
		return
	}

	ctx.JSON(http.StatusOK, response.SuccessResponse(albums, "Tạo album thành công"))
}
func (c *AlbumController) UpdateAlbum(ctx *gin.Context) {
	id, ok := ctx.Params.Get("album_id")

	if !ok {
		ctx.JSON(http.StatusBadRequest, response.ErrorResponse(errors.New("provide album_id")))
		return
	}
	album_id, err := strconv.Atoi(id)
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, response.ErrorResponse(err))
		return
	}
	var body CreateAlbumRequest

	err = ctx.ShouldBindJSON(&body)

	if err != nil {
		ctx.JSON(http.StatusBadRequest, response.ErrorResponse(err))
		return
	}

	albums, err := c.albumService.UpdateAlbum(ctx, sqlc.UpdateAlbumParams{
		ID:          int32(album_id),
		Name:        body.Name,
		ArtistID:    body.ArtistID,
		Thumbnail:   body.Thumbnail,
		ReleaseDate: body.ReleaseDate,
	})
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, response.ErrorResponse(err))
		return
	}

	ctx.JSON(http.StatusOK, response.SuccessResponse(albums, "Cập nhật album thành công"))
}

func (c *AlbumController) DeleteAlbum(ctx *gin.Context) {

	id, ok := ctx.Params.Get("album_id")

	if !ok {
		ctx.JSON(http.StatusBadRequest, response.ErrorResponse(errors.New("provide album_id")))
		return
	}
	album_id, err := strconv.Atoi(id)
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, response.ErrorResponse(err))
		return
	}
	err = c.albumService.DeleteAlbum(ctx, int32(album_id))
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, response.ErrorResponse(err))
		return
	}
	ctx.JSON(http.StatusOK, response.SuccessResponse(true, "Xoá album thành  công"))
}

func (c *AlbumController) GetSongNotInAlbum(ctx *gin.Context) {

	id, ok := ctx.Params.Get("album_id")

	if !ok {
		ctx.JSON(http.StatusBadRequest, response.ErrorResponse(errors.New("provide album_id")))
		return
	}
	album_id, err := strconv.Atoi(id)
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, response.ErrorResponse(err))
		return
	}
	songs, err := c.albumService.GetSongNotInAlbum(ctx, int32(album_id))
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, response.ErrorResponse(err))
		return
	}
	ctx.JSON(http.StatusOK, response.SuccessResponse(songs, "Danh sách bài hát không ở trong album mới nhất"))
}

func (c *AlbumController) AddSongToAlbum(ctx *gin.Context) {
	var body AddorRemoveSongAlbumRequest

	err := ctx.ShouldBindJSON(&body)

	if err != nil {
		ctx.JSON(http.StatusBadRequest, response.ErrorResponse(err))
		return
	}

	err = c.albumService.AddSongToAlbum(ctx, sqlc.AddSongToAlbumParams{
		AlbumID: body.AlbumId,
		SongID:  body.SongId,
	})

	if err != nil {
		ctx.JSON(http.StatusInternalServerError, response.ErrorResponse(err))
		return
	}

	ctx.JSON(http.StatusOK, response.SuccessResponse(true, "Thêm bài hát vào album thành công"))
}

func (c *AlbumController) RemoveSongFromAlbum(ctx *gin.Context) {
	var body AddorRemoveSongAlbumRequest

	err := ctx.ShouldBindJSON(&body)

	if err != nil {
		ctx.JSON(http.StatusBadRequest, response.ErrorResponse(err))
		return
	}

	err = c.albumService.RemoveSongFromAlbum(ctx, sqlc.RemoveSongFromAlbumParams{
		AlbumID: body.AlbumId,
		SongID:  body.SongId,
	})

	if err != nil {
		ctx.JSON(http.StatusInternalServerError, response.ErrorResponse(err))
		return
	}

	ctx.JSON(http.StatusOK, response.SuccessResponse(true, "Xoá bài hát vào album thành công"))
}

func (c *AlbumController) GetAlbumSongs(ctx *gin.Context) {

	id, ok := ctx.Params.Get("album_id")

	if !ok {
		ctx.JSON(http.StatusBadRequest, response.ErrorResponse(errors.New("provide album_id")))
		return
	}
	album_id, err := strconv.Atoi(id)
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, response.ErrorResponse(err))
		return
	}

	albums, err := c.albumService.GetAlbumSongs(ctx, int32(album_id))
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, response.ErrorResponse(err))
		return
	}

	ctx.JSON(http.StatusOK, response.SuccessResponse(albums, "Danh sách album mới nhất"))
}
