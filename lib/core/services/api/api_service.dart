import 'package:dio/dio.dart';
import '../../result/response_data.dart';
import '../../result/result.dart';
import 'api_urls.dart';
import 'error_handler.dart';

class ApiService {
  static Future<FinalResult> sendRequest(
      {String? url,
      dynamic body,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? pathParameters,
      HttpMethods? method,
      bool isPublic = false,
      bool havePathParameter = false,
      bool? externalService,
      bool? stringResponse}) async {
    if (havePathParameter) {
      url = "${url!}?";
      (pathParameters ?? {})
          .forEach((key, value) => url = "${url!}$key=${value.toString()}");
    }
    externalService ??= false;

    var options = BaseOptions(
        baseUrl: externalService ? "" : ApiUrls.baseUrl,
        connectTimeout: const Duration(milliseconds: 40000),
        receiveTimeout: const Duration(milliseconds: 40000),
        contentType: Headers.jsonContentType);

    var dio = Dio(options);

    late Response response;
    try {
      switch (method) {
        case HttpMethods.get:
          {
            response = await dio.get(
              url!,
              queryParameters: queryParameters,
              //options: Options(headers: header,),
            );
            break;
          }

        case HttpMethods.post:
          {
            response = await dio.post(url!,
                queryParameters: queryParameters,
                //options: Options(headers: header),
                data: body);
            break;
          }
        case HttpMethods.put:
          {
            response = await dio.put(url!,
                queryParameters: queryParameters,
                // options: Options(headers: header),
                data: body);
            break;
          }
        case HttpMethods.delete:
          {
            response = await dio.delete(url!,
                queryParameters: queryParameters,
                // options: Options(headers: header),
                data: body);
            break;
          }
        default:
          {
            break;
          }
      }
    } on DioException catch (e) {
      return ErrorHandler.handleDioError(e);
    }

    var decodedJson = response.data;

    if (decodedJson is Map<String, dynamic>) {
      return FinalResult(responseData: ResponseData.fromJson(decodedJson));
    } else {
      return FinalResult(responseData: ResponseData.setData(decodedJson));
    }
  }
}

enum HttpMethods { get, post, put, delete }
