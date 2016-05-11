## Chapter 2 - A simple component

In this chapter we are going to build our first react component.

We will build a component that will be used to display each of the *filter* links.  

![](todo-chapter-2.png?raw=true)

For now our `FooterLink` component has one simple requirements:

*Display the link with the `selected` css class if that is the currently selected filter.*

So lets get started:

#### Use the generator to add a component template

Make sure you are in the root directory of your app, then

run `bundle exec rails g reactrb:component FooterLink`

Now look in the `app/views/components` directory and you will see that our new component has been added.

It looks like this:

```ruby
module Components
  class FooterLink < React::Component::Base

    # param :my_param
    # param param_with_default: "default value"
    # param :param_with_default2, default: "default value" # alternative syntax
    # param :param_with_type, type: Hash
    # param :array_of_hashes, type: [Hash]
    # collect_all_other_params_as :attributes  #collects all other params into a hash

    # The following are the most common lifecycle call backs,
    # the following are the most common lifecycle call backs# delete any that you are not using.
    # call backs may also reference an instance method i.e. before_mount :my_method

    before_mount do
      # any initialization particularly of state variables goes here.
      # this will execute on server (prerendering) and client.
    end

    after_mount do
      # any client only post rendering initialization goes here.
      # i.e. start timers, HTTP requests, and low level jquery operations etc.
    end

    before_update do
      # called whenever a component will be re-rerendered
    end

    before_unmount do
      # cleanup any thing (i.e. timers) before component is destroyed
    end

    def render
      div do
        "FooterLink"
      end
    end
  end
end

```

The generator has created a nice template for us, with a few of the most common macros that you will need.  

Notice that by default we keep components name spaced in the `Components` module.  This is not required.

Also notice that a ruby react component is just a subclass of `React::Component::Base`.

#### Update the Code

Lets update the class so it looks like this:

```ruby
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
```

### Testing

run `bundle exec rspec spec/chapter-2.rb -f d`

Have a look at spec/components/footer_link_spec.rb to see how easy testing is with react.rb
