require 'capybara/cucumber'
require 'sinatra/base'

class DillApp < Sinatra::Base; end

module WebApp
  def define_page_body(html, path = "/test")
    define_page <<-HTML, path
      <html>
      <body>
        #{html}
      </body>
      </html>
    HTML
  end

  def define_page(html, path = "/test")
    DillApp.get(path) { html }
  end
end

World WebApp

After do
  DillApp.reset!
end
