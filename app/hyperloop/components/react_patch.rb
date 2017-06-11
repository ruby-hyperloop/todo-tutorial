module React
  
  module Component::ClassMethods
   def render(container = nil, *params, &block)
      if container
        container = container.type if container.is_a? React::Element
        define_method :render do
          React::RenderingContext.render(container, *params) { instance_eval(&block) if block }
        end
      else
        define_method(:render) { instance_eval(&block) }
      end
    end
  end
  
  class RenderingContext
    def remove_nodes_from_args(args)
      args.each do |arg|
        arg.each do |key, value|
          begin
            value.as_node if value.is_a?(Element)
          rescue Exception
          end
        end if arg && arg.is_a?(Hash)
      end
    end
  end
    
  
  def self.create_element(type, *properties, &block)
    React::API.create_element(type, *properties, &block)
  end
  # Provides the internal mechanisms to interface between reactrb and native components
  # the code will attempt to create a js component wrapper on any rb class that has a
  # render (or possibly _render_wrapper) method.  The mapping between rb and js components
  # is kept in the @@component_classes hash.

  # Also provides the mechanism to build react elements

  # TOOO - the code to deal with components should be moved to a module that will be included
  # in a class which will then create the JS component for that class.  That module will then
  # be included in React::Component, but can be used by any class wanting to become a react
  # component (but without other DSL characteristics.)
  class API

    def self.create_element(type, *properties, &block)
      params = []

      # Component Spec, Normal DOM, String or Native Component
      if @@component_classes[type]
        params << @@component_classes[type]
      elsif type.kind_of?(Class)
        params << create_native_react_class(type)
      elsif React::Component::Tags::HTML_TAGS.include?(type)
        params << type
      elsif type.is_a? String
        return React::Element.new(type)
      else
        raise "#{type} not implemented"
      end

      # Convert Passed in properties
      properties = convert_props(properties)
      params << properties.shallow_to_n

      # Children Nodes
      if block_given?
        [yield].flatten.each do |ele|
          params << ele.to_n
        end
      end
      React::Element.new(`React.createElement.apply(null, #{params})`, type, properties, block)
    end

    def self.convert_props(args)
      properties = {}
      args.each do |prop|
        if prop.is_a?(String)
          properties[prop] = true
        elsif prop.is_a? Hash
          properties.merge! prop
        else
          raise "Component parameters must be a hashes or symbols. Instead you sent #{prop}"
        end
      end
      #puts "processed props.  Incoming: [#{args}], outgoing: #{properties}" rescue nil # if args.count > 1
      props = {}
      properties.map do |key, value|
        if key == "class_name" && value.is_a?(Hash)
          props[lower_camelize(key)] = `React.addons.classSet(#{value.to_n})`
        elsif key == "class"
          props["className"] = value
        elsif ["style", "dangerously_set_inner_HTML"].include? key
          props[lower_camelize(key)] = value.to_n
        elsif key == 'ref' && value.is_a?(Proc)
          unless React.const_defined?(:RefsCallbackExtension)
            %x{
                console.error(
                  "Warning: Using deprecated behavior of ref callback,",
                  "require \"react/ref_callback\" to get the correct behavior."
                );
            }
          end
          props[key] = value
        elsif React::HASH_ATTRIBUTES.include?(key) && value.is_a?(Hash)
          value.each { |k, v| props["#{key}-#{k.tr('_', '-')}"] = v.to_n }
        else
          props[React.html_attr?(lower_camelize(key)) ? lower_camelize(key) : key] = value
        end
      end
      props
    end
  end
end