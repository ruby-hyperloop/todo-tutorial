## Chapter 3 - The Footer Component

Now that we have a FooterLink component we can use it to build a Footer component.  

![](todo-chapter-3.png?raw=true)

Again we will use the generator to build our component template:

run `bundle exec rails g reactrb:component Footer`

The Footer component needs to know the number of incomplete items, and the currently selected link, so these will become the params to the component.

The render method will display count, and each of the links.

The resulting component will look like this:

```ruby
module Components
  class Footer < React::Component::Base

    param :current_filter,    type: Symbol
    param :incomplete_count,  type: Integer

    def render
      footer(class: :footer) do # render a footer tag
        # display the todo count
        #   notice we can shorten span(class: 'todo-count') haml style
        span.todo_count do
          "#{params.incomplete_count} item#{'s' unless params.incomplete_count == 1} left"
        end
        # then display an unsorted list of the three footer links.
        #   again we pass the 'filter' class 'haml style'
        ul.filters do
          li { FooterLink(filter: :all, current_filter: params.current_filter) }
          li { FooterLink(filter: :completed, current_filter: params.current_filter) }
          li { FooterLink(filter: :active, current_filter: params.current_filter) }
        end
      end
    end
  end
end
```

Notice how the param `current_scope`  is getting passed from higher level components down to lower level components.  This is the class react pattern *data moves from the top most component down*.


### Testing

run `bundle exec rspec spec/chapter-3.rb -f d`
