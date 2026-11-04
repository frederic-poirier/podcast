-- name: CreateEpisode :one
INSERT INTO episode (guid, feed_id, title, description, pub_date, audio_url, image_url, duration_seconds, saved)
VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?) 
RETURNING *;

-- name: GetEpisodeByGuidAndFeedId :one
SELECT * FROM episode 
WHERE guid = ? AND feed_id = ?;

-- name: GetEpisodesByFeedId :many
SELECT * FROM episode 
WHERE feed_id = ? 
ORDER BY pub_date DESC;

-- name: UpdateEpisodeSavedStatus :exec
UPDATE episode SET saved = ? 
WHERE guid = ? AND feed_id = ?;

-- name: CreateFeed :one
INSERT INTO feed (id, title, description, rss_url, image_url, updated_at, update_status, update_error)
VALUES (?, ?, ?, ?, ?, ?, ?, ?) 
ON CONFLICT(id) DO UPDATE SET title = excluded.title, description = excluded.description, rss_url = excluded.rss_url, image_url = excluded.image_url, updated_at = excluded.updated_at, update_status = excluded.update_status, update_error = excluded.update_error 
RETURNING *;

-- name: GetFeedById :one
SELECT * FROM feed 
WHERE id = ?;

-- name: GetFeedByRssUrl :one
SELECT * FROM feed 
WHERE rss_url = ?;

-- name: GetAllFeeds :many
SELECT * FROM feed 
ORDER BY updated_at DESC;

-- name: UpdateFeedUpdateStatus :exec
UPDATE feed SET update_status = ?, update_error = ?, updated_at = ?
WHERE id = ?;