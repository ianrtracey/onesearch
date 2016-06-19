package main

import (
  "io/ioutil"
  "github.com/ianrtracey/gdrive"
  "fmt"
  "log"
  "golang.org/x/oauth2/google"
  "golang.org/x/net/context"
  "google.golang.org/api/drive/v3"
)

func main() {

  fmt.Println("Starting indexers...")


  ctx := context.Background()

  b, err := ioutil.ReadFile("client_secret.json")
  if err != nil {
    log.Fatalf("Unable to read client secret file: %v", err)
  }

  // If modifying these scopes, delete your previously saved credentials
  // at ~/.credentials/drive-go-quickstart.json
  config, err := google.ConfigFromJSON(b, drive.DriveMetadataReadonlyScope)
  if err != nil {
    log.Fatalf("Unable to parse client secret file to config: %v", err)
  }
  client := gdrive.GetClient(ctx, config)

  srv, err := drive.New(client)
  if err != nil {
    log.Fatalf("Unable to retrieve drive Client %v", err)
  }

  r, err := srv.Files.List().PageSize(1000).
    Fields("nextPageToken, files(id, name)").Do()
  if err != nil {
    log.Fatalf("Unable to retrieve files.", err)
  }
  fmt.Println("PageSize:")
  fmt.Println(r.NextPageToken)
  fmt.Println("Files:")

pageToken := r.NextPageToken

PageLoop:
  for {
    if len(r.NextPageToken) == 0 {
      break PageLoop
    }
    r, err := srv.Files.List().PageSize(1000).
    Fields("nextPageToken, files(id, name)").PageToken(pageToken).Do()  
    if err != nil {
      log.Fatalf("Unable to retrieve files.", err)
    }
    fmt.Println(r.Files)
    pageToken = r.NextPageToken
  }




  if len(r.Files) > 0 {
    for _, i := range r.Files {
      fmt.Printf("%s (%s)\n", i.Name, i.Id)
    }
  } else {
    fmt.Print("No files found.")
  }
  fmt.Printf("%s\n", r.NextPageToken)

}