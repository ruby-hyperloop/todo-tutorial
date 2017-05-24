# app/hyperloop/components/app.rb
class App < Hyperloop::Router  
  # usually the top level component is Router which is a kind of Hyperloop component
  
  history :browser
  
  after_mount do
    every(1) { force_update! }
  end
  
  route do
    
    SPAN { "Hyperloop at your service! - The time is #{Time.now}" }
    
    # add routes anywhere in this block... any route matching will be displayed
    # here are some samples (note you can mix Routes with other components)
    
    # Route('/hello', mounts: Hello) match /hello and mount the 'Hello' component here
    # Route('/', exact: true) { Home() } # match / (and only /) and mount the Home component
    # Route('/', exact: true) { Redirect('/all') } # or redirect to some other url
    # Route('/:scope', mounts: Index) # match /... and then mount Index passing the matched url segment as the scope param
    # See https://github.com/ruby-hyperloop/hyper-router for details
    
  end
end