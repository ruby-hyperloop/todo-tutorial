# Running Hyperloop in Cloud9

This is probably the easiest way to get started doing full stack development with Hyperloop if you don't already have
Rails setup on your machine. 

Even if you are an experienced Rails developer there are some advantages to doing your first experiments on cloud 9:

+ You will get a consistent setup, which will avoid any possible configuration problems between linux/mac/windows OS versions, etc.
+ Cloud9 supports co-development, so if you hit a snag it makes it even easier to get help from others.
+ Your development environment can be accessed by others so you can immediately show people on other machines the Hyperloop multi-client syncronization.

Once you are comfortable with Hyperloop, transitioning your app back to your normal development environment is as easy as doing a git pull of your saved repo.

### Step 1: Get a Cloud9 account

Go to [cloud 9's website](https://c9.io/?redirect=0) and signup for an account (you can use your github account for signup.)  You will have to supply a credit card, but to our knowledge Cloud9 can be trusted!

### Step 2: Create Your New Workspace

You will be invited to create your first workspace.  Cloud9 gives you one private workspace and any number of public workspaces.  We recommend you use the public option for your first experiments.

Put `git@github.com:ruby-hyperloop/rails-clone-and-go.git` into the field titled titled `Clone from Git or Mercurial URL (optional)`.

Select the "Ruby on Rails" template type, and 

Create Your Workspace!

### Step 3: Run the Setup Script

Once your workspace is created you should the readme displayed.  Just follow the directions and run

`./bin/setup` to complete the initialization process.

### Step 4: Make sure you start MySQL

run `mysql-ctl start`

### Step 5: Fire Up The Server

run `./bin/hyperloop` or use the cloud9 run command (along the nav top bar)

### Step 6: Visit the App

You can see the App running right in the IDE window by clicking on `preview` in the top nav bar,
or by pasting your unique cloud9 url into another browser window
