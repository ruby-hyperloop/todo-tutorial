## Chapter 5 - The TodoItem - Adding State

We will now combine our EditItem component with a checkbox and delete button, to display and update a
Todo model.

![](todo-chapter-5.png?raw=true)

The checkbox will indicate the state of the todo's completed field, and the delete button will delete the Todo.  

When the user double clicks on the title of the Todo the component will go into "edit" mode and use the EditItem component.

To implement this we will introduce the concept of *state variables*.

A *state variable* works just like an instance variable, except that when it changes, any components depending on that state will be re-rerendered.

In our case we will have a state_variable called `editing` that tracks whether the user is editing this Todo or not.

```ruby
module Components
  class TodoItem < React::Component::Base

    param :todo, type: Todo
    define_state editing: false

    def render
      li.todo_item do
        # change what we render depending on the state of editing
        if state.editing
          # the EditItem will emit either the save or cancel events
          # when editing completes.  We use this to stop editing
          EditItem(todo: todo).
          on(:save) { state.editing! false }.
          on(:cancel) { state.editing! false }
        else
          input.toggle(type: :checkbox, checked: params.todo.completed).
          on(:click) do
            # update our todo param's completed value and save it
            params.todo.completed = !params.todo.completed
            params.todo.save
          end
          # when the user double clicks on the todo tile change our state to editing
          label { params.todo.title }.on(:doubleClick) { state.editing! true }
          # and when the user clicks on the destroy anchor tag, destroy the todo
          a.destroy.on(:click) { params.todo.destroy }
        end
      end
    end
  end
end
```

To update a state variable use the name followed by a bang (!).  Notice that we do not need any explicit
logic to cause rendering to occur.

### Testing

run `bundle exec rspec spec/chapter-5.rb -f d`
