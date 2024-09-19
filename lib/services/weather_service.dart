import 'package:dio/dio.dart';
import 'package:weather_app/models/weather_model.dart';

class WeatherService {
  Dio dio;
  WeatherService(this.dio);
  final String baseUrl = "http://api.weatherapi.com/v1";
  final String apiKey = "2e5d2983deaf44d6823154238240409";
  Future<WeatherModel> getCurrentWeather({required String cityName}) async {
    try {
      Response response = await dio
          .get("$baseUrl/forecast.json?key=$apiKey&q=$cityName&days=1");

      WeatherModel weatherModel = WeatherModel.fromJson(response.data);

      return weatherModel;
    } on DioException catch (e) {
      final String errorMessage = e.response?.data['error']['message'] ??
          'oops , there was an error , try later';
      throw Exception(errorMessage);
    } catch (e) {
      throw Exception('oops, there was an error');
    }
  }
}
