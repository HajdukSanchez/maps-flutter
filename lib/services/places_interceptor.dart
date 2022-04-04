import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class PlacesInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters
        .addAll({'language': 'es', 'access_token': dotenv.env['ROUTES_API_KEY']});
    super.onRequest(options, handler);
  }
}
