
-- name: Statistics :one
SELECT
    (SELECT COUNT(*) FROM artist) AS total_artists,
    (SELECT COUNT(*) FROM accounts) AS total_users,
    (SELECT COUNT(*) FROM songs) AS total_songs,
    (SELECT COUNT(*) FROM albums) AS total_albums,
    (SELECT COUNT(*) FROM playlist) AS total_playlist;



-- name: GetSongViewStatistics :many
SELECT DATE_TRUNC('day', play_at)::date AS play_date, COUNT(*) AS view_count
FROM song_plays
WHERE play_at BETWEEN sqlc.arg(start_date) AND sqlc.arg(end_date)
GROUP BY play_date
ORDER BY play_date;