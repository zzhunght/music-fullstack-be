package router

import (
	"music-app-backend/internal/app/config"
	"music-app-backend/internal/app/helper"
	"music-app-backend/internal/app/utils"
	"music-app-backend/message"
	db "music-app-backend/sqlc"
	"music-app-backend/worker"
	"net/http"

	"github.com/gin-gonic/gin"
)

type Router struct {
	route        *gin.Engine
	store        *db.SQLStore
	task_client  *worker.DeliveryTaskClient
	messageQueue *message.RabbitMQProvider
	rdb          *utils.RedisClient
	tokenMaker   *helper.Token
	config       *config.Config
}

func NewRouter(
	config *config.Config,
	route *gin.Engine,
	store *db.SQLStore,
	task_client *worker.DeliveryTaskClient,
	messageQueue *message.RabbitMQProvider,
	rdb *utils.RedisClient,
	tokenMaker *helper.Token,
) *Router {
	return &Router{
		route:        route,
		store:        store,
		task_client:  task_client,
		messageQueue: messageQueue,
		rdb:          rdb,
		tokenMaker:   tokenMaker,
		config:       config,
	}
}

func (r *Router) SetupRouter() {
	v1 := r.route.Group("/api/v1")
	v1.GET("/health-check", healthCheck)
	r.setUpSongRouter(v1)
	r.setUpAlbumRouter(v1)
	r.setUpArtistRouter(v1)
	r.setPlaylistRoute(v1)
	r.setUpCommentRoute(v1)
	r.setUpCategoriesRouter(v1)
	r.setUpUserRouter(v1)
	r.setUpFavoriteRoute(v1)
	r.setUpStatisticRoute(v1)
}
func healthCheck(ctx *gin.Context) {
	ctx.JSON(http.StatusOK, gin.H{"message": "OK"})
}
