require 'models/todo'
module Components
  class EditItem < Hyperloop::Component

    # Your active record models are passed like any other param
    param :todo, type: Todo
    # The prefix '_on' followed by camel case allows proc to be used as an event emitter
    param on_cancel: nil, type: Proc, allow_nil: true
    param on_save: nil, type: Proc, allow_nil: true

    def render
      # the component consists of an input tag (of class 'edit')
      # and three event handlers:
      input.edit(value: params.todo.title, placeholder: "what is left todo?").
      on(:blur) do
        params.on_cancel                   # raise :cancel event
      end.on(:change) do |e|
        params.todo.title = e.target.value # as the user types update the title
      end.on(:key_down) do |e|
        if e.key_code == 13
          params.todo.save
          params.on_save                   # raises :save event
        end
      end
    end
  end
end
