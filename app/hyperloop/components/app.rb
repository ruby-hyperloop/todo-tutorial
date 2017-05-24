module Components
  class RenderSomeChildren < Hyperloop::Component
    param :pc
    render(DIV) do
      params.pc.render; puts "params.pc = #{params.pc}, children.first = #{children.first}"
      children.each do |child|
        child.render(style: {fontStyle: :italic})
      end
    end
  end


  class App < Hyperloop::Router

    history :browser # use normal browser URL history

    route do
      SECTION(class: 'todo-app') do

        # DIV(id: "div1", style: {width: 350, height: 70, padding: 10, border: '1px solid #aaaaaa'})
        # .on(:drop) do |ev|
        #   ev.prevent_default
        #   element = `#{ev.native_event}.native.dataTransfer.getData("text")`
        #   `#{ev.target}.native.appendChild(document.getElementById(data))`
        # end
        # .on(:drag_over) { |ev| ev.prevent_default }
        #
        # IMG(id: "drag1", src: "https://www.w3schools.com/html/img_logo.gif", draggable: "true", width: 336, height: 69)
        # .on(:drag_start) do |ev|
        #   `#{ev.native_event}.native.dataTransfer.setData("element", #{self})`
        # end

        Header()
        Route('/', exact: true) { Redirect('/all') }
        Route('/:filter', mounts: Index) # maybe pass block to validate here...
        Footer()
      end
    end
  end
end

# module Components
#   class App < Hyperloop::Router
#
#     history :browser # use normal browser URL history
#
#     route do
#       SECTION(class: 'todo_app') do
#         Header()
#         Index()
#         # Route('/', exact: true) { Redirect('/all') }
#         # Route('/:filter', mounts: Index) # maybe pass block to validate here...
#         Footer()
#       end
#     end
#   end
# end
