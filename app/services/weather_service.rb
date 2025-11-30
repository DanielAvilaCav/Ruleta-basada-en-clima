class WeatherService
  include HTTParty
  base_uri 'https://api.openweathermap.org'

  def initialize
    # Carga la clave desde el archivo .env
    @api_key = ENV['OPENWEATHERMAP_API_KEY']
    @city = 'Santiago,CL'
  end

  def current_weather
    # Si no hay API key, usamos datos por defecto para no romper la app
    return default_weather unless @api_key

    response = self.class.get('/data/2.5/weather', query: {
      q: @city, appid: @api_key, units: 'metric'
    })

    response.success? ? parse_weather(response) : default_weather
  rescue => e
    Rails.logger.error "Error fetching weather: #{e.message}"
    default_weather
  end

  private

  def parse_weather(response)
    {
      condition: response['weather'][0]['main'],
      description: response['weather'][0]['description'],
      temperature: response['main']['temp'].round,
      humidity: response['main']['humidity']
    }
  end

  def default_weather
    { condition: 'Clear', description: 'simulado (sin api)', temperature: 20, humidity: 50 }
  end
end