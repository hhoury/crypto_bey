// import 'package:dio/dio.dart';

// class Api {
//   Dio api = Dio();
//   String? accessToken;
//   Api() {
//     api.interceptors
//         .add(InterceptorsWrapper(onRequest: (options, handler) async {
//       if (!options.path.contains('http') || !options.path.contains('https')) {
//         options.path = 'https://api.cryptobey.net' + options.path;
//       }
//       options.headers['Authorization'] = 'Bearer $accessToken';
//       return handler.next(options);
//     }, onError: (DioError error, handler) async {
//       if(error.response?.statusCode == 401 && error.response?.data['detail']['error_message'].toString() == 'Token verification failed') {
//         if()
//       }
//     } ));
//   }
// }
