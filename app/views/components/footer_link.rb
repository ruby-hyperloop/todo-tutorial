module Components
  class FooterLink < React::Component::Base

    # Params are how data gets passed into the component

    # In our case we need to know the current active filter,
    # and the filter to display

    param :current_filter, type: Symbol
    param :filter, type: Symbol

    # Every component must have a render method.  This method
    # will be called whenever things change, and the component needs to
    # rerender.

    # There is a method corresponding to every html tag, that is used to
    # generate that tag.  In this case we are going to generate an anchor
    # tag using the "a" method.

    # Tag attributes are passed as hash params to the method.  In this case we
    # are going to pass the class, which is either 'selected' or blank depending
    # on the value of params.filter

    # The inner html of a tag is provided by an optional block passed to the tag.
    # In this case we pass the camelcased filter, which will be automatically
    # wrapped in a <span> tag.

    # During the component lifecycle whenever the params change the component's
    # render method will be called to generate the new version of the html as needed.

    def render
      a(class: (params.filter == params.current_filter ? :selected : '')) do
        params.filter.camelcase
      end
    end

  end
end
