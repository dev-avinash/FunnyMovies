# FunnyMovies
A Ruby on Rails application to share youtube videos. The FunnyMovies is web application where user can share youtube videos. Once the video is shared other users on the platform can cast up or down vote on them.

### Environment
* Ruby version : 2.5.1
* Rails version : 6.1.1

### Dependencies
Install bundler and run `bundle install`:
```bash
gem install bundler
bundle install
```
### Database
```bash
rake db:create
rake db:migrate
```
### Run the application
```bash
rails s
```
### Run background-job(sidekiq) service
```bash
sidekiq
```
## Features
- Authentication by Device Gem
- User can share youtube videos.
- Once the video is saved scraper will scrape video details in backgroud.
- User can cast up or down vote on each videos.
- Linting **100% covered** with rubocop.