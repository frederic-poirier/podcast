package main

import (
	"encoding/xml"
	"io"
)

type RSS struct {
	Channel Channel `xml:"channel"`
}

type Channel struct {
	Language    string `xml:"language"`
	Title       string `xml:"title"`
	Link        string `xml:"link"`
	Description string `xml:"description"`
	Items       []Item `xml:"item"`
}

type Item struct {
	Title     string    `xml:"title"`
	ID        string    `xml:"guid"`
	Enclosure Enclosure `xml:"enclosure"`
}

type Enclosure struct {
	URL    string `xml:"url,attr"`
	Type   string `xml:"type,attr"`
	Length int    `xml:"length,attr"`
}

func ParseRSS(feed io.Reader) (*RSS, error) {
	var rss RSS
	err := xml.NewDecoder(feed).Decode(&rss)
	if err != nil {
		return nil, err
	}

	return &rss, nil
}
