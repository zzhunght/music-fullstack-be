package router

import (
	"music-app-backend/internal/app/controller"
	"music-app-backend/internal/app/services"
	"music-app-backend/pkg/middleware"

	"github.com/gin-gonic/gin"
)

func (r *Router) setUpFavoriteRoute(route *gin.RouterGroup) {
	favoriteService := services.NewFavoriteService(r.store)
	favoriteHandler := controller.NewFavoriteController(favoriteService)

	favoriteRoute := route.Group("/favorite").Use(middleware.Authentication(r.tokenMaker))
	{
		favoriteRoute.GET("/songs", favoriteHandler.GetFavoriteSongs)
		favoriteRoute.POST("/add/:song_id", favoriteHandler.AddSongToFavorite)
		favoriteRoute.POST("/remove/:song_id", favoriteHandler.RemoveSongFromFavorite)
		favoriteRoute.POST("/check/:song_id", favoriteHandler.CheckSongInFavorite)
	}
}
