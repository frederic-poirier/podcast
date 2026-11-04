CREATE TABLE IF NOT EXISTS feed (
    id TEXT PRIMARY KEY,
    title TEXT NOT NULL,
    description TEXT,
    rss_url TEXT NOT NULL UNIQUE,
    image_url TEXT,

    updated_at TEXT NOT NULL,
    update_status TEXT NOT NULL DEFAULT 'idle', 
    update_error TEXT,

    CONSTRAINT update_status_check CHECK (update_status IN ('idle', 'updating', 'error')),
    CONSTRAINT update_error_check CHECK (update_error IS NULL OR update_status = 'error')
);

CREATE TABLE IF NOT EXISTS episode (
    guid TEXT NOT NULL,
    feed_id TEXT NOT NULL,
    title TEXT NOT NULL,
    description TEXT,
    pub_date TEXT NOT NULL,
    audio_url TEXT NOT NULL,
    image_url TEXT,
    duration_seconds INTEGER,
    saved BOOLEAN NOT NULL DEFAULT FALSE,

    PRIMARY KEY (guid, feed_id),
    FOREIGN KEY (feed_id) REFERENCES feed(id) ON DELETE CASCADE
);

CREATE INDEX idx_episode_feed_id ON episode (feed_id);
CREATE INDEX idx_episode_pub_date ON episode (pub_date);
CREATE INDEX idx_episode_saved ON episode (saved);