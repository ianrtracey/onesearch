package main

import (
	"fmt"
	"net/http"
	"io/ioutil"
	"os"
	"encoding/json"
	"sync"
	"time"
	"github.com/jinzhu/gorm"
    _ "github.com/jinzhu/gorm/dialects/postgres"
)


type File struct {
	Name string `json:"name"`
	Title string `json:"title"`
	Filetype string `json:"filetype"`
	Url_private_download string `json:"url_private_download"`
}

type DBConfig struct {
	Database string `json:"database"`
	Dbname   string `json:"dbname"`
	Username string `json:"username"`
	Password string `json:"password"`
	Hostname string `json:"hostname"`
}

type SlackToken struct {
	Token string `json:"slack"`
}

type SlackAPIResponse struct {
	Files []File `json:"files"`
	Paging Page `json:"paging"`
	Warning string `json:"warning"`
	Ok bool `json:"ok"`
}

type Page struct {
	Count int `json:"count"`
	Total int `json:"total"`
	Page int `json:"page"`
	Pages int `json:"pages"`
}

type Document struct {
	gorm.Model
	Name string 
	Kind string 
	Icon string 
	Url string
}

func GetSlackToken() SlackToken {
	raw, err := ioutil.ReadFile("./test_tokens.json")
	if err != nil {
		fmt.Println(err.Error())
		os.Exit(1)
	}
	var token SlackToken
	json.Unmarshal(raw, &token)
	return token
}

func getFiles(body []byte) (*SlackAPIResponse, error) {
	var slackApiResp = new(SlackAPIResponse)
	err := json.Unmarshal(body, &slackApiResp)
	if (err != nil) {
		fmt.Println("Something thing went wrong: %s", err)
	}
	return slackApiResp, err
}
func getDbConfig() DBConfig {
	raw, err := ioutil.ReadFile("./db_creds.json")
	if err != nil {
		fmt.Println(err.Error())
		os.Exit(1)
	}
	fmt.Println(raw)
	var dbconfig DBConfig
	json.Unmarshal(raw, &dbconfig)
	return dbconfig
}





func main() {
  dbconfig := getDbConfig()
  fmt.Println(dbconfig.Username)
  databaseUri := fmt.Sprintf("host=%s user=%s dbname=%s sslmode=disable password=%s",
  				dbconfig.Hostname, dbconfig.Username, 
  				dbconfig.Dbname, dbconfig.Password)
  db, err := gorm.Open(dbconfig.Database, databaseUri)
  fmt.Println(db)
  fmt.Println(err)
  db.AutoMigrate(&Document{})
	token := GetSlackToken()
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
			for _, element := range slackResp.Files {
				document := Document{
					Name: element.Name,
					Kind: element.Filetype,
					Icon: "foo",
					Url:  "yO",
				}
				db.Create(&document)
			}
		}(uri)
	}
	wg.Wait()
	fmt.Printf("Time Elapsed: %s", time.Since(start))


}