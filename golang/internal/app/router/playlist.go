package router

import (
	"music-app-backend/internal/app/controller"
	"music-app-backend/internal/app/services"
	"music-app-backend/pkg/middleware"

	"github.com/gin-gonic/gin"
)

func (r *Router) setPlaylistRoute(route *gin.RouterGroup) {
	playListService := services.NewPlaylistService(r.store)
	playListHandler := controller.NewPlaylistController(playListService)

	playListRoute := route.Group("/playlist")
	{
		playListRoute.GET("/", playListHandler.GetAllPlaylist)
		playListRoute.GET("/search", playListHandler.SearchPlaylist)
		playListRoute.GET("/new", playListHandler.GetNewPlaylist)
		playListRoute.GET("/songs/:playlist_id", playListHandler.GetSongInPlaylist)
		playListRoute.GET("/artist/:artist_id", playListHandler.GetPlaylistOfArtist)
		playListRoute.GET("/category/:category_id", playListHandler.GetPlaylistOfCategory)
		playListRoute.GET("/:playlist_id", playListHandler.GetPlaylistById)
		playListRoute.GET("/song-not-in/:playlist_id", playListHandler.GetSongNotInPlaylist)

		// Private routes -------------------------
		playListRoute.Use(middleware.Authentication(r.tokenMaker))
		playListRoute.Use(middleware.Authorization([]string{middleware.ADMIN}))
		playListRoute.PUT("/:playlist_id", playListHandler.UpdatePlaylist)
		playListRoute.POST("/", playListHandler.CreatePlaylist)
		playListRoute.GET("/user", playListHandler.GetUserPlaylist)
		playListRoute.POST("/user", playListHandler.CreateUserPlayList)
		playListRoute.POST("/add-song", playListHandler.AddSongToPlayList)
		playListRoute.POST("/remove-song", playListHandler.RemoveSongInPlaylist)
		playListRoute.DELETE("/admin-delete/:playlist_id", playListHandler.AdminDeletePlaylist)
	}
}
