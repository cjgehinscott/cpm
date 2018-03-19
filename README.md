# cpm

  Upon tackling this problem I spent a good amount of time reading the requirements before actually digging into any code as to know where to best focus my efforts. I figured focusing on quality over quantity would be a better representation of my abilities and tried to show where my direction would be going should I have had more time to complete other parts of the exam. I'll highlight my design/architecture desicions and a few roadblocks that required some tending to. 

  I decided to lay out my project using the MVC pattern with an API manager to handle all the networking requests. The view is dumb and just responds to user input while the controller handles all the business logic. The model layer is dumb as well with the controller facilitating the interactions between all parties involved. I set up the model layer in a way that it would be very easy to convert over to Realm objects and persist data for offline mode and between sessions. 
  
  The major contraint for me was time while working on this so I opted to not use any libraries I didn't know because I wouldn't have had any time to get up to speed to be effective. I wrote the OAuth authorization flow into the API manager since I didn't have a lot of time to research OAuth libraries that didn't break the rules of the test. My primary choice would have been to use Alamofire as the networking wrapper which makes for an easier time building and handling the networking layer. One road block I ran into was that even as an authenticated user GitHub's rate limit for the search api is 30 requests per minute which quickly gets reached when using live search as the user types. I made the decision to solve this by only allowing the search request to be fired off when the search button is pressed from the keyboard. 
  
  I wrote unit tests for the API manager and the Search Controller (business logic) to demonstrate my ability to write unit tests even with an async task. By implememting a strict MVC pattern testing becomes very easy and it also welcomes the ability to swap out models and views onto the controller for the future. 
  
  All in all I think this project is a good representation of what I can do in a ver very short period of time.
  
  -CJ

