## Chapter 4 - A Reusable Edit Component

The ability to select a title and change it is used in two places in our Todo app:  In the top bar where you add a new component, and by double clicking on a new component.

![](todo-chapter-4.png?raw=true)

So we would like create one component that will work in both places.  

Our component will take a Todo model as input.

The user may input or change the title of the Todo, and the Todo will be saved when the user hits the enter key (key 13).

If the user moves the focus out of the input box, the edit will be cancelled.

To implement this we will introduce some new concepts:

+ Reading and Writing active record models

+ Event Handlers - where you attach code to incoming browser events such as 'blur', 'change', and 'keydown'.

+ Event Emitters - which is one of several forms of callbacks supported by react.rb

Our components params will be:

+ the Todo model being edited,

+ an event emitter that will tell the calling component when the model has been saved,

+ and an event emitter for when the edit is cancelled.

You can either use the react generator like we did before, or just create a new file in the components directory and add this code:

```ruby
module Components
  class EditItem < React::Component::Base

    # Your active record models are passed like any other param
    param :todo, type: Todo
    # The prefix '_on' followed by camel case allows proc to be used as an event emitter
    param :_onCancel, type: Proc, allow_nil: true  
    param :_onSave, type: Proc, allow_nil: true

    def render
      # the component consists of an input tag (of class 'edit')
      # and three event handlers:
      input.edit(value: params.todo.title, placeholder: "what is left todo?").
      on(:blur) do
        params._onCancel                   # raise :cancel event
      end.on(:change) do |e|
        params.todo.title = e.target.value # as the user types update the title
      end.on(:key_down) do |e|
        if e.key_code == 13
          params.todo.save
          params._onSave                   # raises :save event
        end
      end
    end
  end
end
```

### Testing

run `bundle exec rspec spec/chapter-4.rb -f d`
