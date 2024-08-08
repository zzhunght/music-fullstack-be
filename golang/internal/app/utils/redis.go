package utils

import (
	"context"
	"encoding/json"
	"fmt"
	"log"
	"time"

	"github.com/redis/go-redis/v9"
)

type RedisClient struct {
	rdb *redis.Client
}

func NewRedisClient(url string) *RedisClient {
	rdb := redis.NewClient(&redis.Options{
		Addr:             url,
		Password:         "", // no password set
		DB:               0,  // use default DB
		DisableIndentity: true,
	})
	pong, err := rdb.Ping(context.Background()).Result()
	if err != nil {
		log.Fatalf("Error connecting to Redis: %v", err)
	}
	fmt.Println("Connected to Redis:", pong)
	return &RedisClient{rdb: rdb}
}

func (redis *RedisClient) Set(ctx context.Context, key string, value interface{}, expiration time.Duration) *redis.StatusCmd {
	return redis.rdb.Set(ctx, key, value, expiration)
}

func (redis *RedisClient) Close() {
	defer redis.rdb.Close()
}

func (redis *RedisClient) Get(ctx context.Context, key string) *redis.StringCmd {
	return redis.rdb.Get(ctx, key)
}

func (client *RedisClient) GetOrSet(
	ctx context.Context,
	key string,
	GetData func() (interface{}, error),

) (interface{}, error) {
	var result interface{}
	value, err := client.Get(ctx, key).Result()
	if err == redis.Nil {
		data, err := GetData()

		if err != nil {
			return nil, err
		}
		val, err := json.Marshal(data)
		if err != nil {
			return nil, err
		}
		err = client.Set(ctx, key, val, time.Second*300).Err()
		if err != nil {
			return nil, err
		}
		return data, nil
	} else if err != nil {
		return nil, err
	}
	err = json.Unmarshal([]byte(value), &result)
	if err != nil {
		return nil, err
	}
	return result, nil
}
