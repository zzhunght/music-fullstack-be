package controller

import (
	"fmt"
	"music-app-backend/internal/app/response"
	"music-app-backend/internal/app/services"
	"music-app-backend/sqlc"
	"net/http"
	"time"

	"github.com/gin-gonic/gin"
	"github.com/jackc/pgx/v5/pgtype"
)

type StatisticsController struct {
	service *services.StaticService
}

func NewStatisticController(service *services.StaticService) *StatisticsController {
	return &StatisticsController{
		service: service,
	}
}
func (c *StatisticsController) GetStatistics(ctx *gin.Context) {
	data, err := c.service.GetStatistics(ctx)
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, response.ErrorResponse(err))
		return
	}

	ctx.JSON(http.StatusOK, response.SuccessResponse(data, "Thống kê"))
}

func (c *StatisticsController) GetSongViewStatistics(ctx *gin.Context) {
	const layout = "2006-01-02"
	start_date := ctx.Query("start_date")
	end_date := ctx.Query("end_date")

	var start time.Time
	var end time.Time
	var err error

	if start_date == "" {
		start = time.Now().Add(-time.Hour * 24 * 7) // Lùi 7 ngày từ ngày hiện tại
	} else {
		fmt.Println("scan")
		start, err = time.Parse(layout, start_date)
		if err != nil {
			ctx.JSON(http.StatusBadRequest, response.ErrorResponse(err))
			return
		}
	}

	if end_date == "" {
		end = time.Now()
	} else {
		end, err = time.Parse(layout, end_date)
		if err != nil {
			ctx.JSON(http.StatusBadRequest, response.ErrorResponse(err))
			return
		}
	}
	data, err := c.service.GetSongViewStatistics(ctx, sqlc.GetSongViewStatisticsParams{
		StartDate: pgtype.Timestamp{Time: start, Valid: true},
		EndDate:   pgtype.Timestamp{Time: end, Valid: true},
	})
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, response.ErrorResponse(err))
		return
	}

	ctx.JSON(http.StatusOK, response.SuccessResponse(data, "Số lượng view"))
}
