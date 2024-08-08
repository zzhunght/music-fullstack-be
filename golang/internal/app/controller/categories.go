package controller

import (
	"music-app-backend/internal/app/response"
	"music-app-backend/internal/app/services"
	"music-app-backend/sqlc"
	"net/http"
	"strconv"

	"github.com/gin-gonic/gin"
	"github.com/jackc/pgx/v5/pgtype"
)

type CreateCategory struct {
	Name      string `json:"name" binding:"required"`
	Thumbnail string `json:"thumbnail" binding:"required"`
	Color     string `json:"color" binding:"required"`
}

type UpdateCategory struct {
	Name      string `json:"name" binding:"required"`
	ID        int    `json:"id" binding:"required"`
	Thumbnail string `json:"thumbnail" binding:"required"`
	Color     string `json:"color" binding:"required"`
}
type CategoriesController struct {
	categoriesService *services.CategoriesService
}

func NewCategoriesController(categoriesService *services.CategoriesService) *CategoriesController {
	return &CategoriesController{
		categoriesService: categoriesService,
	}
}

func (s *CategoriesController) GetCategories(ctx *gin.Context) {

	categories, err := s.categoriesService.GetCategories(ctx)
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, response.ErrorResponse(err))
		return
	}

	ctx.JSON(http.StatusOK, response.SuccessResponse(categories, "Danh sách danh mục"))
}

func (s *CategoriesController) GetSongByCategory(ctx *gin.Context) {
	page, _ := strconv.Atoi(ctx.DefaultQuery("page", "1"))
	size, _ := strconv.Atoi(ctx.DefaultQuery("size", "50"))
	categories_id, _ := ctx.Params.Get("category_id")
	id, err := strconv.Atoi(categories_id)

	if err != nil {
		ctx.JSON(http.StatusInternalServerError, response.ErrorResponse(err))
		return
	}

	songs, err := s.categoriesService.GetSongInCategory(ctx, sqlc.GetSongInCategoryParams{
		CategoryID: int32(id),
		Size:       int32(size),
		Start:      (int32(page) - 1) * int32(size),
	})
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, response.ErrorResponse(err))
		return
	}
	ctx.JSON(http.StatusOK, response.SuccessResponse(songs, "Bài hát trong danh mục"))
}

func (s *CategoriesController) CreateCategory(ctx *gin.Context) {
	var body CreateCategory

	err := ctx.ShouldBindJSON(&body)

	if err != nil {
		ctx.JSON(http.StatusInternalServerError, response.ErrorResponse(err))
		return
	}

	data, err := s.categoriesService.CreateCategory(ctx, sqlc.CreateCategoriesParams{
		Name:      body.Name,
		Thumbnail: pgtype.Text{String: body.Thumbnail, Valid: true},
		Color:     pgtype.Text{String: body.Color, Valid: true},
	})
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, response.ErrorResponse(err))
		return
	}

	ctx.JSON(http.StatusCreated, response.SuccessResponse(data, "Create category successfully"))

}

func (s *CategoriesController) UpdateCategory(ctx *gin.Context) {
	var body UpdateCategory

	err := ctx.ShouldBindJSON(&body)

	if err != nil {
		ctx.JSON(http.StatusInternalServerError, response.ErrorResponse(err))
		return
	}
	data, err := s.categoriesService.UpdateCategory(ctx, sqlc.UpdateCategoriesParams{
		ID:        int32(body.ID),
		Name:      body.Name,
		Thumbnail: pgtype.Text{String: body.Thumbnail, Valid: true},
		Color:     pgtype.Text{String: body.Color, Valid: true},
	})
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, response.ErrorResponse(err))
		return
	}

	ctx.JSON(http.StatusCreated, response.SuccessResponse(data, "Update category successfully"))

}

func (s *CategoriesController) DeleteCategory(ctx *gin.Context) {
	categories_id, _ := ctx.Params.Get("category_id")
	id, err := strconv.Atoi(categories_id)

	if err != nil {
		ctx.JSON(http.StatusInternalServerError, response.ErrorResponse(err))
		return
	}
	err = s.categoriesService.DeleteCategory(ctx, int32(id))
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, response.ErrorResponse(err))
	}

	ctx.JSON(http.StatusCreated, response.SuccessResponse(true, "Delete category successfully"))

}
