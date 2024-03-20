# Weather Application

## Overview

The Weather Application is a simple web-based tool designed to provide users with real-time weather data for a specified city. Its primary purpose is to allow users to easily access current weather information for any location globally. This application can be useful for a variety of scenarios, including travel planning, outdoor activities, and general weather monitoring.

## API Endpoint

### Endpoint:
```
GET /weather/:city
```

### Request Format:

- Method: GET
- Path: `/weather/:city`
- Parameters:
  - `city`: The name of the city for which weather data is requested.

### Response Format:

The application provides weather data in JSON format with the following structure:

```json
{
  "city": "CityName",
  "temperature": "Temperature in Celsius",
  "humidity": "Humidity percentage",
  "wind_speed": "Wind speed in meters per second"
}
```

### Example Usage:
```
GET /weather/London
```
### response
```
{
  "city": "London",
  "temperature": 15,
  "humidity": 65,
  "wind_speed": 3.5
}
```

## Setting Up and Running Locally
### Prerequisites:

- Ruby (version 2.6 or higher)
- Rails (version 5.0.7.2)
- OpenTelemetry Gems
- OpenWeatherMap

### Steps

1. Clone the repository to your preferred location
2. Navigate to the project directory:
```
cd weather_app
```

3. Install gem dependencies:
```
bundle install
```

4. Set up environment variables:
> Add your OpenWeatherMap API key to the corresponding environment file:
```
OPENWEATHERMAP_API_KEY=your_api_key_here
```

5. Run the Rails server:
```
bundle exec rails s
```

6. Access the application in your web browser at:
```
http://localhost:3000
```

## Navigating Using API Endpoint
To retrieve weather data for a specific city using the API endpoint, you can make a GET request to the following URL:
```
GET http://localhost:3000/weather/CityName
```



.
.
.

### Suggestions for improvement
Error Handling:
Implement a robust error handling to manage unforeseen errors, especially considering reliance on third-party vendors. This includes anticipating API rate limits, network issues, and service downtime, providing informative error messages, and implementing retry strategies to mitigate failures, along with logging errors for troubleshooting and monitoring.

Geolocation Integration:
Enhance user experience by integrating geolocation functionality to detect the user's location automatically. Use browser-based geolocation APIs and geocoding services to translate coordinates into human-readable location information, automatically populating the default city value in the weather search form. Allow users to override the detected location manually for privacy and preference considerations.

Historical Weather Data:
Offer users the ability to access historical weather data for a specific city. Define the scope of historical data and provide an interface for users to specify the date range. Retrieve and display historical weather records, facilitating data interpretation and analysis, potentially integrating with other features such as trend analysis or predictive modeling for added value.

Scalability Considerations:
Ensure scalability as the application evolves and introduces new features. Evaluate scalability requirements based on anticipated user traffic and data volume, design the architecture with scalability in mind, and implement scalable components such as cloud-based infrastructure and distributed databases. Use caching mechanisms, monitoring tools, and auto-scaling policies for dynamic resource allocation and optimal performance as the application grows. Regularly review and update scalability strategies to support long-term scalability and success.
By incorporating these enhancements, the app can cater to a broader audience with diverse needs and preferences, offering a more comprehensive and user-friendly weather forecasting solution.
