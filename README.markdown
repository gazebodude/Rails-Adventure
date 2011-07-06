# Rails-Adventure

This is a choose your own adventure style storytelling app based on Ruby on Rails.
That said, this is mainly a personal project to get my feet wet with RoR, Github, etc.

## Project Aims

* Allow users to dynamically create and navigate through a narrative tree.

* Get my head around Ruby on Rails, github & related stuff.

## Where to find it

* Official GitHub repository: https://github.com/gazebodude/Rails-Adventure
* Official Heroku deployment: http://radiant-beach-804.heroku.com/

Please feel free to fork & deploy whenever and wherever you want to _**BUT**_ please make sure to update the contact details both below and in the function ```contact_us_path``` found in _app/helpers/application_helper.rb_.

## Get it running

To get it running first do a git clone to get a local copy of the repo.
```
git clone git://github.com/gazebodude/Rails-Adventure.git
```
Then run bundle to get all of the gems.
```
bundle
```
Then set up the database. Note that you need to seed the database to get the root node of the story tree. (You can edit the content of the root node via the browser or in db/seeds.rb if you like.)
```
rake db:migrate
rake db:seed
```
And
```
rake db:test:prepare
```
to get the test database & the specs working. Now you're ready to go.

## Contact

Author: Michael Brown < michael.brown6@my.jcu.edu.au >
