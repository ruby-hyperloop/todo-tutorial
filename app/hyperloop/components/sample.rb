class Chatapp < Hyperloop::Router::Component
  render(:div) do
    ul do
      li do
        Link('/helloworld') { 'Link it' }
      end
    end
    AppRouter()
  end
end

class Helloworld < Hyperloop::Router::Component
  render(:div) do
    'helloworld'
  end
end

class AppRouter < Hyperloop::Router
  prerender_path :url_path, default: '/'
  history :browser

  route do
    div do
      Route('/helloworld', exact: true, mounts: Helloworld)
    end
  end
end
