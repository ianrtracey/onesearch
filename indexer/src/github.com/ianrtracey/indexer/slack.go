package main

import (
	"fmt"
	"net/http"
	"io/ioutil"
	"os"
	"encoding/json"
)


type File struct {
	name string
	title string
	filetype string
	url_private_download string
}

type FileListAPIResponse struct {
	FileList []File `json:"files"`
}

func getFiles(body []byte) (*FileListResponse, error) {
	var fileList = new(FileListAPIResponse)
	err := json.
}

func main() {
	token := // moved to external file
	page_num := 1
	uri := fmt.Sprintf("https://slack.com/api/files.list?token=%s&page=%d", token, page_num)
	resp, err := http.Get(uri)
	if err != nil {
		fmt.Println("Error!")
		panic(err.Error())
	}


}