package router

import (
	"music-app-backend/internal/app/controller"
	"music-app-backend/internal/app/services"

	"github.com/gin-gonic/gin"
)

func (r *Router) setUpStatisticRoute(route *gin.RouterGroup) {

	services := services.NewStatisticService(r.store)
	controller := controller.NewStatisticController(services)

	statisticRoute := route.Group("/statistic")
	{
		statisticRoute.GET("/", controller.GetStatistics)
		statisticRoute.GET("/song-view-statistic", controller.GetSongViewStatistics)
	}
}
