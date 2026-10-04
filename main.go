package main

import (
	"fmt"
	"log"
	"os"
)

func main() {
	f, err := os.Open("./cbc.xml")
	if err != nil {
		log.Fatal("could not open the cbc xml file exemple.")
	}

	rss, err := ParseRSS(f)
	if err != nil {
		log.Fatal(err)
	}

	fmt.Printf("title: %v\n", rss.Channel.Title)
	fmt.Printf("number of items: %v\n", len(rss.Channel.Items))
	fmt.Printf("item 40 title: %v\n", rss.Channel.Items[40-1].Title)
	fmt.Printf("item 40 url: %v\n", rss.Channel.Items[40-1].Enclosure.URL)
}
