class WeatherController < ApplicationController
  def index
    # Initialize tracer
    tracer = OpenTelemetry.tracer_provider.tracer('weather_app', '0.1.0')

    tracer.in_span('weather_request') do |span|
      span.set_attribute('city', params[:city])

      record_metrics do
        fetch_weather_data
      end

      respond_to do |format|
        format.html
        format.json { render json: @weather }
      end
    end
  end

  private

  def record_metrics
    # calculate request response time
    start_time = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    yield
    end_time = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    response_time = (end_time - start_time) * 1000
  
    # update tracer with new data
    span = OpenTelemetry::Trace.current_span
    span.set_attribute('response_time', response_time)
    span.set_attribute('requests_per_minute', calculate_requests_per_minute)
  end

  def fetch_weather_data
    # Add default value so we start page with something data
    @city = (params[:city] || 'Osaka').titleize
    service = WeatherService.new(ENV['OPENWEATHERMAP_API_KEY'])
    @weather = service.get_weather(@city)

    if @weather.present? && @weather['main'].present?
      @weather['main']['temp'] = convert_to_celsius(@weather['main']['temp']).round(2)
      @weather['main']['humidity'] = @weather['main']['humidity']
      @weather['wind']['speed'] = convert_to_kmh(@weather['wind']['speed']).round(2)
    end
  end

  def convert_to_celsius(kelvin)
    kelvin - 273.15
  end

  def convert_to_kmh(mps)
    mps * 3.6
  end

  def calculate_requests_per_minute
    current_time = Time.now
    recent_requests = request_timestamps.select { |timestamp| current_time - timestamp <= 60 }
    recent_requests.size
  end

  def request_timestamps
    timestamps = Rails.cache.fetch('request_timestamps') { [] }
    timestamps.reject! { |timestamp| Time.now - timestamp > 60 }
    timestamps
  end
end
