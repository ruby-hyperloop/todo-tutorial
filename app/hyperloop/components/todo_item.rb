# app/hyperloop/components/todo_item.rb
class TodoItem < Hyperloop::Component
  param :todo
  state editing: false
  render(LI, class: 'todo-item') do
    if state.editing
      EditItem(todo: params.todo, className: :edit)
      .on(:save, :cancel) { mutate.editing false }
    else
      INPUT(type: :checkbox, class: :toggle, checked: params.todo.completed)
      .on(:click) { params.todo.update(completed: !params.todo.completed) }
      LABEL { params.todo.title }
      .on(:double_click) { mutate.editing true }
      A(class: :destroy)
      .on(:click) { params.todo.destroy }
    end
  end
end

