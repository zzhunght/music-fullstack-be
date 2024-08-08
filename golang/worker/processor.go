package worker

import (
	"music-app-backend/internal/app/utils"
	"music-app-backend/sqlc"

	"github.com/hibiken/asynq"
)

type ProcessorRedisTasks struct {
	client *asynq.Server
	mailer *utils.MailSender
	store  *sqlc.SQLStore
	rdb    *utils.RedisClient
}

func NewProcessorTaskClient(
	opts asynq.RedisClientOpt,
	mailer *utils.MailSender,
	store *sqlc.SQLStore,
	rdb *utils.RedisClient,
) *ProcessorRedisTasks {
	client := asynq.NewServer(opts, asynq.Config{})
	return &ProcessorRedisTasks{
		client: client,
		mailer: mailer,
		store:  store,
		rdb:    rdb,
	}
}

func (process *ProcessorRedisTasks) Start() error {

	mux := asynq.NewServeMux()

	mux.HandleFunc(TypeEmailDeliveryTask, process.HandleEmailDeliveryTask)
	mux.HandleFunc(TypeEmailDeliveryForgetPasswordRequest, process.HandleEmailDeliveryForgetPasswordRequestTask)
	mux.HandleFunc(TypeEmailDeliveryNewPassword, process.HandleEmailDeliveryNewtPasswordTask)

	return process.client.Start(mux)
}
