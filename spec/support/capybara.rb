Capybara.register_driver :selenium_chrome_headless do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument('--headless')
  options.add_argument('--window-size=1400,1400')
  options.add_argument('--no-sandbox')
  options.add_argument('--disable-gpu')
  options.add_argument('--enable-javascript')
  if ENV['SELENIUM_REMOTE_HOST']
    Capybara::Selenium::Driver.new(app,
                                   browser: :remote,
                                   url: "http://#{ENV['SELENIUM_REMOTE_HOST']}:4444/wd/hub",
                                   options:)
  else
    Capybara::Selenium::Driver.new(app, browser: :chrome, options:)
  end
end

RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :selenium_chrome_headless

    Capybara.app_host = "http://#{IPSocket.getaddress(Socket.gethostname)}:3000"
    Capybara.server_host = IPSocket.getaddress(Socket.gethostname)
    Capybara.server_port = 3000
  end
end
