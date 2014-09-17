Rotten Tomatoes client 
===================
CodePath, Week 1

Time spent: 5 hours.

http://courses.codepath.com/courses/intro_to_ios/week/1#!module

## Implemented stories

#### Required
* User can view a list of movies from Rotten Tomatoes. Poster images must be loading asynchronously.
* User can view movie details by tapping on a cell
* User sees loading state while waiting for movies API.
* User sees error message when there's a networking error.
* User can pull to refresh the movie list. 

#### Optional
* All images fade in 
* For the large poster, load the low-res image first, switch to high-res when complete 
* Customize the navigation bar.
* Add a tab bar for Box Office and DVD.

#### Additional requirements
* Must use Cocoapods.
* Asynchronous image downloading must be implemented using the UIImageView category in the AFNetworking library.

## Remain
* All images should be cached in memory and disk. In other words, images load immediately upon cold start (optional).
* Customize the highlight and selection effect of the cell. (optional)
* Add a search bar. (optional)
