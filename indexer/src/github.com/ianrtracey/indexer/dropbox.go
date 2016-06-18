package main

import (
	"fmt"
	"net/http"
	"io/ioutil"
	"os"
	"encoding/json"
	"sync"
	"time"
)


type Resource struct {
	Path string `json:"path"`
	IsDir string `json:"is_dir"`
}

type DropboxToken struct {
	Token string `json:"dropbox"`
}

type DropboxAPIResponse struct {
	Path string `json:"path"`
	IsDir bool `json:"is_dir"`
	Contents []Resource `json:"contents"`
	
}


func GetToken() DropboxToken {
	raw, err := ioutil.ReadFile("./test_tokens.json")
	if err != nil {
		fmt.Println(err.Error())
		os.Exit(1)
	}
	var token DropboxToken
	json.Unmarshal(raw, &token)
	return token
}

func getFiles(body []byte) (*DropboxAPIResponse, error) {
	var d = new(DropboxAPIResponse)
	err := json.Unmarshal(body, &d)
	if (err != nil) {
		fmt.Println("Something thing went wrong: %s", err)
	}
	return d, err
}





func main() {
	token := GetToken()
	fmt.Println(token.Token)
	page_num := 1
	
	uri := fmt.Sprintf("https://slack.com/api/files.list?token=%s&page=%d", token.Token, page_num)
	fmt.Println(uri)
	res, err := http.Get(uri)
	if err != nil {
		fmt.Println("Error!")
		panic(err.Error())
	}
	body, err := ioutil.ReadAll(res.Body)
	if err != nil {
		panic(err.Error())
	}

	slackResp, err := getFiles([]byte(body))
	fmt.Println(slackResp.Paging.Pages)

	var wg sync.WaitGroup
	wg.Add(slackResp.Paging.Pages) // number of worker to add? (not sure)
	start := time.Now()
	for page := 1; page <= slackResp.Paging.Pages; page++ {
		fmt.Println("Checking: Page #%s", page)
		uri := fmt.Sprintf("https://slack.com/api/files.list?token=%s&page=%d", token.Token, page)
		go func(uri string) {
			defer wg.Done()
			res, err := http.Get(uri)
			if err != nil {
				fmt.Println("Error!")
				panic(err.Error())
			}
			body, err := ioutil.ReadAll(res.Body)
			if err != nil {
				panic(err.Error())
			}

			slackResp, err := getFiles([]byte(body))
			fmt.Println(slackResp.Paging.Count)
		}(uri)
	}
	wg.Wait()
	fmt.Printf("Time Elapsed: %s", time.Since(start))

