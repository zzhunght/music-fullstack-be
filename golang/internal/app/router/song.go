package router

import (
	"music-app-backend/internal/app/controller"
	"music-app-backend/internal/app/services"
	"music-app-backend/pkg/middleware"

	"github.com/gin-gonic/gin"
)

func (r *Router) setUpSongRouter(route *gin.RouterGroup) {
	services := services.NewSongService(r.store)
	handler := controller.NewSongController(services, r.messageQueue, r.rdb)

	song_routes := route.Group("/song")
	{
		song_routes.GET("/all", handler.GetAll)
		song_routes.GET("/search/:search", handler.SearchSong)
		song_routes.GET("/new-song", handler.GetNewsSong)
		song_routes.GET("/admin", handler.AdminGetSong)
		song_routes.POST("/play/:song_id", middleware.OptionAuthentication(r.tokenMaker), handler.PlaySong)

		// Private routes -------------------------
		song_routes.Use(middleware.Authentication(r.tokenMaker))
		song_routes.Use(middleware.Authorization([]string{middleware.ADMIN}))
		song_routes.POST("/", handler.CreateSong)
		song_routes.PUT("/:song_id", handler.UpdateSong)
		song_routes.DELETE("/:song_id", handler.DeleteSong)
	}
}
