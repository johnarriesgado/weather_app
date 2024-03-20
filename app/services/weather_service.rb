class WeatherService
  include HTTParty
  base_uri 'https://api.openweathermap.org/data/2.5'

  def initialize(api_key)
    @options = { query: { appid: api_key } }
  end

  def get_weather(city)
    self.class.get("/weather?q=#{city}&units=metric", @options)
  end
end
