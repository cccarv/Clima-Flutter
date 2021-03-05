import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

const apiKey = 'f0060b47028a54500c466c7288e41d31';
const baseUrl = 'api.openweathermap.org';
const moreUrl = '/data/2.5/weather';
const units = 'metric';
const lang = 'pt_br';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    var finalUrl = Uri.https(baseUrl, moreUrl, {
      'q': '$cityName',
      'appid': '$apiKey',
      'units': '$units',
      'lang': '$lang',
    });

    NetworkHelper networkHelper = NetworkHelper(finalUrl);
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    var finalUrl = Uri.https(baseUrl, moreUrl, {
      'lat': '${location.latitude}',
      'lon': '${location.longitude}',
      'appid': '$apiKey',
      'units': '$units',
      'lang': '$lang',
    });

    NetworkHelper networkHelper = NetworkHelper(finalUrl);

    var weatherData = await networkHelper.getData();

    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
