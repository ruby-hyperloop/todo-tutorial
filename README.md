# Getting started with React.rb and Rails

## How this tutorial works.

This tutorial will cover the steps in adding [react.rb](http://reactrb.org) and react components (written in Ruby of course) to a simple rails Todo app.

The tutorial is organized as a series of tagged branches in this repo.  You are currently on the `master` branch, which is the introduction (i.e. chapter 1).

The remaining branches are named `chapter-2`, `chapter-3`, etc.

In each branch the `README` file will be the next chapter of the tutorial.

As you complete each chapter there is a test spec, which will pass if you have completed the instructions in the chapter.

At the end of each chapter you can move to the next tagged branch, where the changes described in the previous chapter will be stored

For example in this chapter we are going to add the `reactive_ruby_generator` gem to the app, and use it to install react.rb, reactive-record and reactive-router.

To see the results of these changes you can view the `02-adding-a-react-component` chapter.

Of course for best results follow along yourself:

1. make sure you have rails v4 installed,
2. clone this repo to your computer,
3. follow the instructions for each chapter,
4. Then run the test specs for the chapter: `bundle exec rspec spec/chapter-xx.rb -f d`

Some chapters (like this one) have extra notes at the end of the page with details you may be interested in.

## Chapter 1 - Introduction

In this chapter we are going to:

1. create a new rails app
2. add the `reactive_rails_generator` gem, as well as set of gems used in testing
3. use the `reactive_rails_generator` gem to add everything we need to use react.rb
4. add a simple Todo model to our app
5. test our work

#### Create a New Rails App

`cd` into the directory that you have just cloned from github.  If you do an `ls` You should see something like the following:

`COPY-THESE-TO-YOUR-GEM-FILE	LICENSE				README.md			app				spec`

Now create a new rails in the directory with this command:

`rails new -T --skip-spring .`

The `-T` option will skip creating the unit-test directory, and the `--skip-spring` skips installing spring which does not seem to work well
with some of the test harnesses.

#### Adding the Gems

Now we want to edit the Gemfile and add the reactive_rails_generator gem plus a bunch of gems used for driving the testing in this tutorial.  Make the end of the Gemfile look like this:

```ruby
group :development do
  gem 'reactive_rails_generator'
end

group :test do
  gem "rspec"
  gem "rspec-rails"
  gem "rspec-mocks"
  gem "rspec-expectations"
  gem "pry"
  gem 'pry-rescue'#, git: "https://github.com/joallard/pry-rescue.git"
  gem 'pry-stack_explorer'
  gem "factory_girl_rails"
  gem 'shoulda'
  gem 'shoulda-matchers'
  gem 'rspec-its'
  gem 'rspec-collection_matchers'
  gem 'database_cleaner', git: "https://github.com/DatabaseCleaner/database_cleaner.git"
  gem 'capybara'
  gem 'selenium-webdriver'
  gem "poltergeist"
  gem 'spring-commands-rspec'
  gem 'chromedriver-helper'
  gem 'rspec-steps'
  gem 'parser'
  gem 'unparser'
end
```

#### Run the Reactive Rails Generator

Okay lets update our gems, and use the reactive_rails_generator to add everything you need to begin react.rb development:

1. make sure you added `gem 'reactive_rails_generator'` to the development section of your app Gemfile (per above instructions)
2. run `bundle install`
3. run `bundle exec rails g reactrb:install --all`
4. run `bundle update`

You will now find that you have

* a `components` directory inside of `app/views` where your react components (which are simply react views written in ruby) will live, and

* a `public` directory inside of `app/models` where any models that you want accessible to your components (which will run on the browser) will live.
*Don't worry!  Access to model data is protected by a [Hobo style permissions system](http://hobocentral.net/manual/permissions).*

#### Adding the Todo Model

Great!  Now seeing as we are going to make a Todo app, we need a Todo model to hold our data:  Run the following command:

1. run `rails generate model Todo title:string completed:boolean`
2. run `rake db:migrate`
3. run `rake db:test:prepare`

Now that we have the Todo model, lets add a couple of *scopes* to the model:  Edit `app/models/todo.rb` so it looks like this:

```ruby
class Todo < ActiveRecord::Base
  scope :completed, -> () { where(completed: true)  }
  scope :active,    -> () { where(completed: false) }
end
```

Finally we will be accessing our Todo data on client, so we want to *move* the `todo.rb` file into the `app/models/public` directory

In our case we are going to make the `Todo` model public by moving it from  `app/models` to `app/models/public/`.

#### Running the test

If all has gone well you should be able to run:

`bundle exec rspec spec/chapter-1.rb -f d`

which will check that everything was installed, and that the Todo model is accessible on the client!

For the next instructions : [Chapter 2 - Our first React.rb Component](/README_CHAPTER_2.md)


### How it works :

#### `rails g reactrb:install -all` options:


`--reactive-router` to install reactive-router
`--reactive-record` to install reactive-record
`--opal-jquery` to install opal-jquery in the js application manifest
`--all` to do all the above

Its recommend to install `--all`.  You can easily remove things later!

#### How it works:

In case you are interested, or perhaps want to customize the install here is what happens:

1. It requires `'components'` and `'react_ujs'` at the start of your `application.js` file.  `components` is your manifest of react.rb components, and `react_ujs` is part of the react-rails prerendering system.

2. It adds the js code `Opal.load('components')` to the end of the `application.js` file.  This code will initialize all the ruby (opal) code referenced in the `components` manifest.

3. If you are using reactive-record it adds
`route "mount ReactiveRecord::Engine => "/rr"`
to your routes file.  This is how reactive record will send and receive active record model updates from the client.  *Note - you can change the mount path from `rr` to whatever you want if necessary*.

4. It adds the `components` directory to `app/views`.  This is the directory that all your components will be stored in.

5. If you are using reactive-record, then it also adds the `public` directory to `app/models`.  Any models in this directory will have reactive-record proxies loaded on the client.

6. It creates the `app/views/components.rb` manifest file.  This file is a set of requires for all your ruby component code.  The manifest ends with a `require_tree './components'`
which in most cases should be sufficient to load all your component code from the `views/components` directory.  If you have specific component load ordering needs (which is rare) you can simply require specific files before the require_tree.  *Note - this manifest is loaded both on the client and in the prerendering engine.  Code that depends on browser specific data and functions can be conditionally loaded in the manifest so it will not load during prerendering.*

7. If you are using reactive-record the `components.rb` file will also require `app/models/_react_public_models.rb` which is the manifest file for the public models, and simply contains a `require_tree './public'` directive. If you need to order how the models are loaded you can add explicit requires to this file before the require_tree.

9. It adds these lines to `application.rb`
`config.assets.paths << ::Rails.root.join('app', 'views').to_s`
If you are using reactive-record it will also add
`config.assets.paths << ::Rails.root.join('app', 'models').to_s`
`config.eager_load_paths += %W(#{config.root}/app/models/public)`
`config.autoload_paths += %W(#{config.root}/app/models/public)`
The effect of these lines is that the asset pipeline can load components from the views folder, and
isomorphic models can be found by both the server and asset pipeline in the models/public folder.

8. Finally it adds the following gems to your `Gemfile`:
  `gem 'reactive-ruby'`
  `gem 'react-rails', '~> 1.3.0'`
  `gem 'opal-rails', '>= 0.8.1' `
  `gem 'therubyracer', platforms: :ruby`
  `gem 'react-router-rails', '~>0.13.3' ` (if using reactive-router)
  `gem 'reactive-router'` (if using reactive router)
  `gem 'reactive-record'` (if using reactive-record)
