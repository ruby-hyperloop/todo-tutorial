# app/hyperloop/components/footer.rb
class Footer < Hyperloop::Component
  include HyperRouter::ComponentMethods
  def link_item(path)
    LI { NavLink("/#{path}", active_class: :selected) { path.camelize } }
  end
  render(DIV, class: :footer) do
    SPAN(class: 'todo-count') do
      "#{Todo.active.count} item#{'s' if Todo.active.count != 1} left"
    end
    UL(class: :filters) do
      link_item(:all)
      link_item(:active)
      link_item(:completed)
    end
  end
end