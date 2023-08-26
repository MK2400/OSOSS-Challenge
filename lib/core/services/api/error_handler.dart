import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:ososs/core/resources/app_strings.dart';
import '../../result/result.dart';
import 'error_types.dart';

class ErrorHandler {
  static FinalResult handleDioError<T>(DioException error) {
    debugPrint("Dio error : ${error.message ??''}");

    if (error.type == DioExceptionType.unknown ||
        error.type == DioExceptionType.badResponse) {
      if (error is SocketException) {
        return FinalResult(error: BaseError(code: error.response!.statusCode));
      }

      if (error.type == DioExceptionType.badResponse) {
        if(error.response==null)
          {
            return FinalResult(
                error: BaseError(
                    code: 503,
                    msg: AppStrings.somethingWentWrong));
          }
        if (error.response!.statusCode == 400) {
          return FinalResult(
              error: BaseError(
                  code: error.response!.statusCode,
                  msg: error.response!.data.toString().contains('message')
                      ? error.response!.data["message"]
                      : error.response!.data.toString()));
        } else {
          return FinalResult(
              error: BaseError(
                  code: error.response!.statusCode,
                  msg: (error.response!.data != null &&
                          error.response!.data is Map)
                      ? error.response!.data["message"] ??
                      AppStrings.somethingWentWrong
                      : AppStrings.somethingWentWrong));
        }
      } else if (error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.sendTimeout ||
          error.type == DioExceptionType.receiveTimeout) {
        return FinalResult(
            error: BaseError(errorType: ErrorType.internetConnectionError));
      } else if (error.type == DioExceptionType.cancel) {
        return FinalResult(
            error: BaseError(errorType: ErrorType.internetConnectionError));
      } else {
        return FinalResult(
            error: BaseError(errorType: ErrorType.internetConnectionError));
      }
    }
    return FinalResult(
        error: BaseError(errorType: ErrorType.internetConnectionError));
  }
}
