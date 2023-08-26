import 'package:ososs/core/resources/app_strings.dart';

enum ErrorType {
  serviceUnavailableError,
  unauthorizedError,
  notFoundError,
  forbiddenError,
  conflictError,
  internalServerError,
  badRequestError,
  internetConnectionError,
  noError,
  internetError,
}

Map<int, ErrorType> errorCodeType = {
  400: ErrorType.badRequestError,
  409: ErrorType.conflictError,
  403: ErrorType.forbiddenError,
  500: ErrorType.internalServerError,
  404: ErrorType.notFoundError,
  503: ErrorType.serviceUnavailableError,
  401: ErrorType.unauthorizedError,
  -1: ErrorType.internetConnectionError
};

Map<ErrorType, int> errorTypeCodes = {
  ErrorType.badRequestError: 400,
  ErrorType.conflictError: 409,
  ErrorType.forbiddenError: 403,
  ErrorType.internalServerError: 500,
  ErrorType.notFoundError: 404,
  ErrorType.serviceUnavailableError: 503,
  ErrorType.unauthorizedError: 401,
  ErrorType.internetConnectionError: -1
};

Map<ErrorType, String> errorTypeMsg = {
  ErrorType.badRequestError: AppStrings.badRequestError,
  ErrorType.conflictError: AppStrings.conflictError,
  ErrorType.forbiddenError: AppStrings.forbiddenError,
  ErrorType.internalServerError: AppStrings.internalServerError,
  ErrorType.notFoundError: AppStrings.notFoundError,
  ErrorType.serviceUnavailableError: AppStrings.serviceUnavailableError,
  ErrorType.unauthorizedError: AppStrings.unauthorizedError,
  ErrorType.internetConnectionError: AppStrings.noInternetError,
  ErrorType.noError: "",
  ErrorType.internetError: AppStrings.somethingWentWrong
};


class BaseError {
  late int? code;
  late ErrorType errorType;
  late String msg;

  BaseError(
      {int? code, ErrorType errorType = ErrorType.noError, this.msg = ''}) {
    if (code == null) {
      this.errorType = errorType;
      this.code = errorTypeCodes[errorType]!;
    } else {
      this.code = code;
      this.errorType = errorCodeType[code]!;
    }
    if (msg.isEmpty) {
      msg = errorTypeMsg[errorType]!;
    }
  }
}

const int SUCCESS_CODE = 200;
