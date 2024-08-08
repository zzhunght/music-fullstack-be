package controller

import (
	"music-app-backend/internal/app/helper"
	"music-app-backend/internal/app/response"
	"music-app-backend/internal/app/services"
	"music-app-backend/internal/app/utils"
	"music-app-backend/pkg/middleware"
	db "music-app-backend/sqlc"
	"net/http"
	"strconv"

	"github.com/gin-gonic/gin"
)

type CreateUserPlaylistBody struct {
	Name string `json:"name"`
}
type PlaylistCUBody struct {
	Name        string `json:"name"`
	Thumbnail   string `json:"thumbnail" required:"true"`
	Description string `json:"description" required:"true"`
	ArtistID    int32  `json:"artist_id"`
	CategoryID  int32  `json:"category_id"`
}

type PlaylistSongBody struct {
	SongID     int32 `json:"song_id"`
	PlaylistID int32 `json:"playlist_id"`
}

type PlaylistController struct {
	playlistService *services.PlaylistService
}

func NewPlaylistController(service *services.PlaylistService) *PlaylistController {
	return &PlaylistController{
		playlistService: service,
	}
}

func (c *PlaylistController) GetAllPlaylist(ctx *gin.Context) {
	playlists, err := c.playlistService.GetAllPlaylist(ctx)
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, response.ErrorResponse(err))
		return
	}

	ctx.JSON(http.StatusOK, response.SuccessResponse(playlists, "danh sách playlist mới"))
}

func (c *PlaylistController) SearchPlaylist(ctx *gin.Context) {
	search := ctx.DefaultQuery("search", "")
	playlists, err := c.playlistService.SearchPlaylist(ctx, search)
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, response.ErrorResponse(err))
		return
	}

	ctx.JSON(http.StatusOK, response.SuccessResponse(playlists, "search thành công"))
}

func (c *PlaylistController) GetNewPlaylist(ctx *gin.Context) {
	playlists, err := c.playlistService.GetNewPlaylist(ctx)
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, response.ErrorResponse(err))
		return
	}

	ctx.JSON(http.StatusOK, response.SuccessResponse(playlists, "danh sách  playlist mới"))
}

func (c *PlaylistController) GetPlaylistOfArtist(ctx *gin.Context) {
	artist_id, _ := ctx.Params.Get("artist_id")
	id, err := strconv.Atoi(artist_id)
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, response.ErrorResponse(err))
		return
	}
	playlists, err := c.playlistService.GetPlaylistByArtist(ctx, int32(id))
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, response.ErrorResponse(err))
		return
	}

	ctx.JSON(http.StatusOK, response.SuccessResponse(playlists, "danh sách  playlist của nghệ sĩ"))
}

func (c *PlaylistController) GetPlaylistOfCategory(ctx *gin.Context) {
	category_id, _ := ctx.Params.Get("category_id")
	id, err := strconv.Atoi(category_id)
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, response.ErrorResponse(err))
		return
	}
	playlists, err := c.playlistService.GetPlaylistByCategoryID(ctx, int32(id))
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, response.ErrorResponse(err))
		return
	}

	ctx.JSON(http.StatusOK, response.SuccessResponse(playlists, "danh sách  playlist theo danh mục"))
}

func (c *PlaylistController) GetSongInPlaylist(ctx *gin.Context) {
	playlist_id, _ := ctx.Params.Get("playlist_id")
	id, err := strconv.Atoi(playlist_id)
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, response.ErrorResponse(err))
		return
	}
	playlists, err := c.playlistService.GetPlaylistSongs(ctx, int32(id))
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, response.ErrorResponse(err))
		return
	}

	ctx.JSON(http.StatusOK, response.SuccessResponse(playlists, "danh sách bài hát trong playlist"))
}

func (c *PlaylistController) GetSongNotInPlaylist(ctx *gin.Context) {
	playlist_id, _ := ctx.Params.Get("playlist_id")
	page, _ := strconv.Atoi(ctx.DefaultQuery("page", "1"))
	size, _ := strconv.Atoi(ctx.DefaultQuery("size", "999"))
	search := ctx.DefaultQuery("search", "")

	id, err := strconv.Atoi(playlist_id)
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, response.ErrorResponse(err))
		return
	}
	playlists, err := c.playlistService.GetSongNotInPlaylist(ctx, db.GetSongNotInPlaylistParams{
		PlaylistID: int32(id),
		Size:       int32(size),
		Start:      int32(size) * int32(page-1),
		Search:     search,
	})
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, response.ErrorResponse(err))
		return
	}

	ctx.JSON(http.StatusOK, response.SuccessResponse(playlists, "playlist "))
}

func (c *PlaylistController) GetPlaylistById(ctx *gin.Context) {
	playlist_id, _ := ctx.Params.Get("playlist_id")
	id, err := strconv.Atoi(playlist_id)
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, response.ErrorResponse(err))
		return
	}
	playlists, err := c.playlistService.GetPlaylistById(ctx, int32(id))
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, response.ErrorResponse(err))
		return
	}

	ctx.JSON(http.StatusOK, response.SuccessResponse(playlists, "playlist "))
}

func (c *PlaylistController) CreateUserPlayList(ctx *gin.Context) {
	authPayload := ctx.MustGet(middleware.AuthorizationPayloadKey).(*helper.TokenPayload)
	var body CreateUserPlaylistBody
	err := ctx.ShouldBindJSON(&body)
	if err != nil {
		ctx.JSON(http.StatusBadRequest, response.ErrorResponse(err))
		return
	}

	data, err := c.playlistService.CreateUserPlaylist(ctx, db.CreateUserPlaylistParams{
		UserID: authPayload.UserID,
		Name:   body.Name,
	})
	if err != nil {
		ctx.JSON(http.StatusBadRequest, response.ErrorResponse(err))
		return
	}
	ctx.JSON(http.StatusOK, response.SuccessResponse(data, "Tạo play list thành công"))
}

func (c *PlaylistController) GetUserPlaylist(ctx *gin.Context) {
	authPayload := ctx.MustGet(middleware.AuthorizationPayloadKey).(*helper.TokenPayload)

	data, err := c.playlistService.GetPlaylistByUserId(ctx, authPayload.UserID)
	if err != nil {
		ctx.JSON(http.StatusBadRequest, response.ErrorResponse(err))
		return
	}
	ctx.JSON(http.StatusOK, response.SuccessResponse(data, "playlist của user"))
}

func (c *PlaylistController) AddSongToPlayList(ctx *gin.Context) {
	var body PlaylistSongBody
	err := ctx.ShouldBindJSON(&body)

	if err != nil {
		ctx.JSON(http.StatusBadRequest, response.ErrorResponse(err))
		return
	}

	data, err := c.playlistService.AddSongToPlaylist(ctx, db.AddSongToPlaylistParams{
		SongID:     body.SongID,
		PlaylistID: body.PlaylistID,
	})
	if err != nil {
		ctx.JSON(http.StatusBadRequest, response.ErrorResponse(err))
		return
	}
	ctx.JSON(http.StatusOK, response.SuccessResponse(data, "thêm bài hát vào playlist thành công"))
}

func (c *PlaylistController) RemoveSongInPlaylist(ctx *gin.Context) {
	var body PlaylistSongBody
	err := ctx.ShouldBindJSON(&body)
	if err != nil {
		ctx.JSON(http.StatusBadRequest, response.ErrorResponse(err))
		return
	}

	err = c.playlistService.RemoveSongFromPlaylist(ctx, db.RemoveSongFromPlaylistParams{
		SongID:     body.SongID,
		PlaylistID: body.PlaylistID,
	})
	if err != nil {
		ctx.JSON(http.StatusBadRequest, response.ErrorResponse(err))
		return
	}
	ctx.JSON(http.StatusOK, response.SuccessResponse(true, "Xoá bài hát khỏi playlist thành công"))
}

func (c *PlaylistController) CreatePlaylist(ctx *gin.Context) {
	var body PlaylistCUBody
	err := ctx.ShouldBindJSON(&body)

	if err != nil {
		ctx.JSON(http.StatusBadRequest, response.ErrorResponse(err))
		return
	}

	data, err := c.playlistService.CreatePlaylist(ctx, db.CreatePlaylistParams{
		Name:        body.Name,
		Thumbnail:   utils.StringToPGType(body.Thumbnail),
		Description: utils.StringToPGType(body.Description),
		ArtistID:    utils.Int32ToPGType(body.ArtistID),
		CategoryID:  utils.Int32ToPGType(body.CategoryID),
	})
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, response.ErrorResponse(err))
		return
	}
	ctx.JSON(http.StatusOK, response.SuccessResponse(data, "Tạo playlist thành công"))
}

func (c *PlaylistController) UpdatePlaylist(ctx *gin.Context) {
	playlist_id, _ := ctx.Params.Get("playlist_id")
	id, err := strconv.Atoi(playlist_id)
	var body PlaylistCUBody
	err = ctx.ShouldBindJSON(&body)
	if err != nil {
		ctx.JSON(http.StatusBadRequest, response.ErrorResponse(err))
		return
	}

	data, err := c.playlistService.UpdatePlaylist(ctx, db.UpdatePlaylistParams{
		ID:          int32(id),
		Name:        body.Name,
		Thumbnail:   utils.StringToPGType(body.Thumbnail),
		Description: utils.StringToPGType(body.Description),
		ArtistID:    utils.Int32ToPGType(body.ArtistID),
		CategoryID:  utils.Int32ToPGType(body.CategoryID),
	})
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, response.ErrorResponse(err))
		return
	}
	ctx.JSON(http.StatusOK, response.SuccessResponse(data, "Cập nhật playlist thành công"))
}

func (c *PlaylistController) AdminDeletePlaylist(ctx *gin.Context) {
	artist_id, _ := ctx.Params.Get("playlist_id")
	id, err := strconv.Atoi(artist_id)
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, response.ErrorResponse(err))
		return
	}
	err = c.playlistService.AdminDeletePlaylist(ctx, int32(id))
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, response.ErrorResponse(err))
		return
	}

	ctx.JSON(http.StatusOK, response.SuccessResponse(true, "xoá playlist thành công"))
}
