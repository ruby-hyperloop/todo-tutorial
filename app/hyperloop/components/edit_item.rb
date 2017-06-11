# app/hyperloop/components/edit_item.rb
class EditItem < Hyperloop::Component
  param :todo
  param :on_save, type: Proc               # add
  param :on_cancel, type: Proc             # add
  param :className
  after_mount { Element[dom_node].focus }  # add

  render do
    INPUT(
      class: params.className, 
      defaultValue: params.todo.title,
      key: params.todo.object_id,
      placeholder: "What is left to do today?"
    ).on(:key_down) do |evt|
      next unless evt.key_code == 13
      params.todo.update(title: evt.target.value)
      params.on_save                       # add
    end
    .on(:blur) { params.on_cancel }
  end
end