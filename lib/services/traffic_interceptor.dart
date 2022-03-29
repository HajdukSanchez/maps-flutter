import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class TrafficInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters.addAll({
      'steps': false,
      'alternatives': false,
      'overview': 'simplified',
      'geometries': 'polyline6',
      'access_token': dotenv.env['ROUTES_API_KEY']
    });
    super.onRequest(options, handler);
  }
}
