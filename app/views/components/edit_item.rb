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
