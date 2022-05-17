import 'package:crypto_bey/constants/api_constants.dart';
import 'package:crypto_bey/models/http_exception.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Api with ChangeNotifier {
  Dio api = Dio();
  String accessToken = '';
  String refreshToken = '';
  final _storage = const FlutterSecureStorage();

  Future<void> saveTokens(String accessToken, String refreshToken) async {
    await _storage.write(key: 'accessToken', value: accessToken);
    await _storage.write(key: 'refreshToken', value: refreshToken);
  }

  Future<Map<String, String>> getTokens() async {
    accessToken = await _storage.read(key: 'accessToken') ?? '';
    refreshToken = await _storage.read(key: 'refreshToken') ?? '';
    return {'refreshToken': refreshToken, 'accessToken': accessToken};
  }

  Future<void> removeTokens() async {
    await _storage.deleteAll();
  }

  Api() {
    api.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      options.headers['access-token'] = accessToken;
      handler.next(options);
    }, onError: (error, handler) async {
      if (error.response?.statusCode == 401 &&
          error.response?.data["detail"]["error_description"].toString() ==
              'Token verification failed') {
        await refreshAccessToken();
        return handler.resolve(await _retry(error.requestOptions));
      }
      return handler.next(error);
    }));
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return api.request<dynamic>(requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options);
  }

  Future<void> refreshAccessToken() async {
    try {
      final tokens = await getTokens();
      refreshToken = tokens['refreshToken'] ?? '';
      final url = Uri.parse('$USER_API/refresh_access_token');
      final response = await api.postUri(
        url,
        options: Options(
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            'refresh-token': refreshToken,
          },
          contentType: 'application/json',
        ),
      );

      if (response.statusCode == 201) {
        // successfully got the new access token
        accessToken = response.data;
        await saveTokens(accessToken, refreshToken);
      } else {
        // refresh token is wrong so log out user.
        accessToken = '';
        refreshToken = '';
        _storage.deleteAll();
      }
    } on DioError catch (error) {
      throw HttpException(
          error.response!.data['detail']['error_description'].toString());
    } catch (error) {
      rethrow;
    }
  }
}
