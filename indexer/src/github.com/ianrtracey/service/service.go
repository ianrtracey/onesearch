package main

import (
    "github.com/jinzhu/gorm"
    _ "github.com/jinzhu/gorm/dialects/postgres"
    "encoding/json"
    "fmt"
    "io/ioutil"
    "os"
)

type DBConfig struct {
	Database string `json:"database"`
	Dbname   string `json:"dbname"`
	Username string `json:"username"`
	Password string `json:"password"`
	Hostname string `json:"hostname"`
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
}

