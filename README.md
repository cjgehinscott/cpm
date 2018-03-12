# cpm

  Upon tackling this problem I spent a good amount of time reading the requirements before actually diggin into any code as to know where to best focus my efforts. Given that I was only afforded ~1.5 days to complete the assignment I focused hard on quality over quantity and tried to show where my direction would be going should I have had more time to complete other parts of the exam. I'll highlight my design/architecture desicions and a few roadblocks that required some tending to. 

  I decided to lay out my project using the MVC pattern with an API manager to handle all the networking requests. The view is dumb and just responds to user input while the controller handles all the business logic. The model layer is dumb as well with the controller facilitating the interactions between all parties involved. Given more time I set up the model layer in a way that it would be very easy to convert over to Realm objects and persist data for offline mode and between sessions. 
  
  The major contraint for me was time while working on this so I opted to not use any libraries I didn't know because I wouldn't have had any time to get up to speed to be effective. With that said I also did not have any time to implement a login flow to authenticate any user so that they can interact with GitHub as themselves. Because of this, I used a static personal auth token during development and noted where someone testing this code would need to insert a valid OAuth/personal GitHub tokent to operate as an authenticated user. One road block I ran into was that even as an authenticated user GitHub's rate limit for the search api is 30 requests per minute which quickly gets reached when using live search as the user types. I made the decision to solve this by only allowing the search request to be fired off when the search button is pressed from the keyboard. 
  
  I wrote a unit test for the API manager to demonstrate my ability to write unit tests even with an async task, but there would need to be more written for the MVC components. By implememting a strict MVC pattern testing becomes very easy and it also becomes very easy to swap out models and views onto the controller for the future. 
  
  All in all I think this project is a good representation of what I can do in a ver very short period of time. I would love more time to continue on the other parts, but as it stands I only had time to complete Part One which was the required piece according to the test requirements.
  
  -CJ

