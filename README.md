# Welcome to Hyperloop

Clone this repo onto your local machine and you will be ready to code up a full stack Hyperloop app.  You will need to have [ruby](https://www.ruby-lang.org/en/documentation/installation/) and [the mysql database](https://dev.mysql.com/doc/refman/5.7/en/installing.html) installed.  

You can also clone the repo into a [Cloud9 virtual IDE](https://c9.io) workspace for an even quicker install [details here.](/cloud9-setup.md)(

To finish the install run ./bin/setup.

Then make sure mysql2 is running and do `bundle exec rails db:create`

*On cloud9 workspaces you start mysql2 by doing a `mysql-ctl start`.*

## Hyperloop Quick Start

#### Adding a new component:

`bundle exec rails g hyper:component Show` will add a component template and place it in the `app/hyperloop/components` directory.  Details on the structure of Hyperloop components can be found [here.](http://ruby-hyperloop.io/docs/components/dsl-overview/)

#### Routing to your component:

You can route directly to your top level hyperloop component by adding this to your routes file:

`get '/(*other)', to: 'hyperloop#show'`

This will send all requests to the `Show` component, which would typically be a Hyperloop Router.  See the [hyper-router gem](https://github.com/ruby-hyperloop/hyper-router) for more info.

#### Models

Move your rails models to the `app/hyperloop/models` directory to make them accessible to the client.  Access permissions are controlled by policies found in the `app/policies` directory.  More info on Hyperloop models [here.](http://ruby-hyperloop.io/start/models/)

#### Stores

Complex reactive state information should be kept in stores, which should be placed in the `app/hyperloop/stores` directory.  More info on Stores [here.](http://ruby-hyperloop.io/start/stores/)

#### Operations

Hyperloop Operations keep Stores and Components separated, provides a central place to put business logic, and can run isomorphically on the client or server.  More info on Operations [here.](http://ruby-hyperloop.io/start/operations/)

#### Have Fun!
