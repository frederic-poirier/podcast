package main

import (
	"fmt"
	"io"
	"net/http"
	"os"
)

func DownloadAudio(url, storingPath string) error {
	tempFilePath := storingPath + ".tmp"
	response, err := http.Get(url)
	if err != nil {
		return err
	}

	defer response.Body.Close()
	if response.StatusCode != http.StatusOK {
		return fmt.Errorf("fail download: %s, status: %s", url, response.StatusCode)
	}

	f, err := os.Create(tempFilePath)
	if err != nil {
		return err
	}

	_, err = io.Copy(f, response.Body)
	closeErr := f.Close()
	if err != nil {
		os.Remove(tempFilePath)
		return err
	}

	if closeErr != nil {
		os.Remove(tempFilePath)
		return closeErr
	}

	os.Rename(tempFilePath, storingPath)
	return nil
}
