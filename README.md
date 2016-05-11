## Chapter 6 - Putting it all together

Now we will combine our EditItem component, our TodoItem component, and our Footer component into our top level app.

For our last component we need a couple of new concepts:

+ We need a "global" state variable, that is accessible as a class level variable.
+ We need to initialize our component before its first rendering cycle.

#### Exported States, aka class level state variables, aka *Stores*

React.rb provides the `export_state` macro that like `define_state` creates a state variable.   Exported states work just like normal state variables, with two differences.

1. They exist at the class level (so they are like class instance variables) and
2. they can be accessed globally.

Exported state variables are just like flux or redux *stores* and the underlying react.rb state system takes care of the registering and dispatching automatically, when the store (or exported_state) changes.

We will have one exported state variable called `filter` that will hold the current filter.  We will update the FooterLink component to update the value of `filter` when a user clicks one of the filter links.   This will cause a cascade of renders from our top level component down.

*Note: in an upcoming react.rb release the export_state macro will be deprecated in favor of a more descriptive terminology, however the underlying semantics will not change.*

#### Life Cycle call backs

React has a number of lifecycle call backs that your components can hook into.  We will use the `before_mount` callback which is very similar to a classes' initialize method.  The `before_mount` callbacks are run after a component has received any parameters, but *before* the first render cycle.  

We will use a `before_mount` callback to initialize our state variables.

Lets do it!

```ruby
module Components
  # We will call our top level component Index following rails tradition.
  class Index < React::Component::Base

    define_state :new_todo  # new_todo will always hold an empty unsaved todo
    export_state :filter    # filter will now act like a redux store

    before_mount do
      # initialize our state/stores
      state.new_todo! Todo.new
      Index.filter! :all
    end

    def render
      section.todo_app do
        header.header do
          h1 { "Todos" }
          # Display an EditItem component in the header, and
          # as each Todo is saved, update the value of the new_todo state
          EditItem(todo: state.new_todo).
          on(:save) { state.new_todo! Todo.new }
        end
        ul.todo_list do
          # send the current filter name to the Todo class to get the
          # current todos for that scope
          Todo.send(Index.filter).each do |todo|
            TodoItem todo: todo
          end
        end
        # pass the current value of filter, and the active todo count down to the footer
        Footer current_filter: Index.filter, incomplete_count: Todo.active.count
      end
    end
  end
end
```

Now we need to close the flux cycle by updating the Footer component so `Index.filter` is
updated with the current filter.  Add the following event handler to the anchor tag:

```ruby
  on(:click) { Index.filter! params.filter }
```

Finally we need to add a todo route and a controller to our rails app:

```ruby
#app/config/routes.rb
Rails.application.routes.draw do
  get 'todos' => 'todos#index'
  ...
end
```

```ruby
#app/controllers/todos_controller.rb
class TodosController < ApplicationController
  def index
    render_component  # by default render_component will expect a component named 'Index'
  end
end
```

Wow we are done... lets test it out...

### Testing

run `bundle exec rspec spec/chapter-7.rb -f d`

This test is an integration test you can find it in `spec/integration/index_spec.rb`

Once you have the test passing you will want to try out your app:  Just

run `bundle exec rails s` as normal.

As you play with your app you will want to watch the network log and see how reactive-record keeps the server and your client synced.

But what happens if you view the data from two different browser windows?

Checkout the last chapter and learn about the `syncromesh` gem!
