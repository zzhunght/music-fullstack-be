package router

import (
	"music-app-backend/internal/app/controller"
	"music-app-backend/internal/app/services"
	"music-app-backend/pkg/middleware"

	"github.com/gin-gonic/gin"
)

func (r *Router) setUpAlbumRouter(route *gin.RouterGroup) {
	albumService := services.NewAlbumServices(r.store)
	albumHandler := controller.NewAlbumController(albumService)

	albumRoute := route.Group("/album")
	{
		albumRoute.GET("/", albumHandler.GetAllAlbum)
		albumRoute.GET("/new", albumHandler.GetNewAlbum)
		albumRoute.GET("/song/:album_id", albumHandler.GetAlbumSongs)
		albumRoute.GET("/song-not-in/:album_id", albumHandler.GetSongNotInAlbum)

		// Private routes -------------------------
		// ADMIN--------------------------
		albumRoute.Use(middleware.Authentication(r.tokenMaker))
		albumRoute.Use(middleware.Authorization([]string{middleware.ADMIN}))
		albumRoute.POST("/", albumHandler.CreateAlbum)
		albumRoute.PUT("/:album_id", albumHandler.UpdateAlbum)
		albumRoute.POST("/song/add", albumHandler.AddSongToAlbum)
		albumRoute.POST("/song/remove", albumHandler.RemoveSongFromAlbum)
		albumRoute.DELETE("/:album_id", albumHandler.DeleteAlbum)
	}
}
