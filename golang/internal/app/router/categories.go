package router

import (
	"music-app-backend/internal/app/controller"
	"music-app-backend/internal/app/services"
	"music-app-backend/pkg/middleware"

	"github.com/gin-gonic/gin"
)

func (r *Router) setUpCategoriesRouter(route *gin.RouterGroup) {

	categoriesService := services.NewCategoriesService(r.store)
	categoriesHandler := controller.NewCategoriesController(categoriesService)

	categoriesRoute := route.Group("/categories")
	{
		categoriesRoute.GET("/", categoriesHandler.GetCategories)
		categoriesRoute.GET("/song/:category_id", categoriesHandler.GetSongByCategory)

		// ADMIN--------------------------
		categoriesRoute.Use(middleware.Authentication(r.tokenMaker))
		categoriesRoute.Use(middleware.Authorization([]string{middleware.ADMIN}))
		categoriesRoute.POST("/", categoriesHandler.CreateCategory)
		categoriesRoute.PUT("/", categoriesHandler.UpdateCategory)
		categoriesRoute.DELETE("/:category_id", categoriesHandler.DeleteCategory)
	}
}
