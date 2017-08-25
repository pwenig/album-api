# README

This is an api that provides an index of artists, albums, and artist's albums.


* Ruby v2.3.3 & Rails v5.1.3

* To install:
  * Git clone
  * $bundle install
  * rake db:create
  * rake db:migrate
  * rake db:seed (this will load the csv file that is included)

* To run tests:
  * $bundle exec rspec
  * 18 passing tests (18 examples, 0 failures)

* Endpoints (test with Postman):

  * Title: Artists

    URL: /artists

    Method: GET

    Response Data: 
    
        [
            {
                "id": 1,
                "name": "Michael Jackson",
                "albums": 
                  [
                      {
                          "id": 1,
                          "album": "Thriller",
                          "genre": "Pop",
                          "year": "1982"
                      },
                      {
                          "id": 90,
                          "album": "Dangerous",
                          "genre": "Pop",
                          "year": "1991"
                      }
                    ]
              },
              {
                  "id": 2,
                  "name": "Future Islands",
                  "albums": 
                  [
                      {
                          "id": 2,
                          "album": "Singles",
                          "genre": "Indie",
                          "year": "2014"
                      }
                  ]
              } 
          ]
  
  * Title: Artist and Artist's Albums

    URL: /artists/artist_id

    Method: GET

    Response Data: 
    
        {
            "id": 1,
            "name": "Michael Jackson",
            "albums": 
              [
                {
                    "id": 1,
                    "album": "Thriller",
                    "genre": "Pop",
                    "year": "1982"
                },
                {
                    "id": 90,
                    "album": "Dangerous",
                    "genre": "Pop",
                    "year": "1991"
                }
              ]
        }
  
  
  * Title: Artists

    URL: /artists

    Method: POST

    Data Params : {name: string}

    Response Data: [

          {
              "id": 92,
              "name": "Keb Mo",
              "albums": []
          }

  * Title: Artist

      URL: /artists/:id

      Method: DELETE | PUT

      Response Code: 204
    
  * Title: Albums

    URL: /albums

    Method: GET

    Response Data: 
    
        [
          {
              "id": 1,
              "album": "Thriller",
              "genre": "Pop",
              "year": "1982",
              "artist": 
                {
                    "id": 1,
                    "name": "Michael Jackson"
                }
          },
          {
              "id": 2,
              "album": "Singles",
              "genre": "Indie",
              "year": "2014",
              "artist": 
                {
                  "id": 2,
                  "name": "Future Islands"
                }
          }
        ]

  * Title: Album

      URL: /albums/:id

      Method: SHOW

      Response Data:
      
          {
              "id": 1,
              "album": "Thriller",
              "genre": "Pop",
              "year": "1982",
              "artist": {
                  "id": 1,
                  "name": "Michael Jackson"
              }
          }

  * Title: Album

      URL: /albums/:id

      Method: PUT | DELETE

      Response Status Code: 204

  * Title: Album

      URL: /artists/artist_id/albums

      Method: POST

      Data Params: {album: string, genre: string, year: string}

      Response Data:

        {
            "id": 110,
            "album": "Thriller v2",
            "genre": "Rock",
            "year": "2018",
            "artist": 
              {
                  "id": 1,
                  "name": "Michael Jackson"
              }
        }
        

  

  * Title: Genre Ranking - Lists genres and the number of albums in each genre.

    URL: /albums/genre_ranking

    Method: GET

    Response Data: 
    
        {
          "Alternative": 24,
          "Rock": 20,
          "Indie": 11,
          "Pop": 9,
          "Folk": 5,
          "Reggae": 4,
          "Rap": 4,
          "Jazz": 4,
          "Dance": 4,
          "Electronica": 3,
          "New Wave": 3,
          "Country": 2,
          "Yacht Rock": 2,
          "Hip hop": 2,
          "Soul": 2,
          "Blues": 2,
          "R&B": 1,
          "Shoegaze": 1
        }

  * Title: Year Ranking - Lists the top five years with the most number of albums.

    URL: /albums/year_ranking

    Method: GET

    Response Data: 
    
        {
          "1994": 6,
          "1999": 4,
          "2010": 4,
          "2013": 4,
          "2016": 9
        }


  



