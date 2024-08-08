package router

import (
	"music-app-backend/internal/app/controller"
	"music-app-backend/internal/app/services"
	"music-app-backend/pkg/middleware"

	"github.com/gin-gonic/gin"
)

func (r *Router) setUpArtistRouter(route *gin.RouterGroup) {

	artistService := services.NewArtistService(r.store)
	artistHandler := controller.NewArtistController(artistService)

	artistRoute := route.Group("/artist")
	{
		artistRoute.GET("/search/:search", artistHandler.SearchArtist)
		artistRoute.GET("/recommendations", artistHandler.GetRecommendArtist)
		artistRoute.GET("/song/:artist_id", artistHandler.GetArtistSong)
		artistRoute.GET("/album/:artist_id", artistHandler.GetArtistAlbum)
		artistRoute.GET("/all", artistHandler.GetAllArtist)

		// Private routes -------------------------
		artistRoute.Use(middleware.Authentication(r.tokenMaker))
		artistRoute.GET("/followed", artistHandler.GetFollowedArtist)
		artistRoute.POST("/follow/:artist_id", artistHandler.FollowArtist)
		artistRoute.POST("/un-follow/:artist_id", artistHandler.UnFollowArtist)
		artistRoute.POST("/check-follow/:artist_id", artistHandler.CheckFollow)

		//  admin --------------------------
		artistRoute.Use(middleware.Authorization([]string{middleware.ADMIN}))
		artistRoute.POST("/", artistHandler.CreateArtist)
		artistRoute.PUT("/:id", artistHandler.UpdateArtist)
		artistRoute.DELETE("/:id", artistHandler.DeleteArtist)
	}
}
