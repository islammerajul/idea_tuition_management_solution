import 'dart:io';

import 'package:appwrite/appwrite.dart';
import 'package:dio/dio.dart';

import 'network_exceptions.dart';

class AppwriteErrorUtil {
  // general methods:------------------------------------------------------------
  static NetworkException handleError(AppwriteException exception) {


    String errorDescription = "";
    NetworkException networkException =new NetworkException();
    if (exception!=null) {
      switch (exception.code) {
        case 400:
          errorDescription = "Bad Request";
          networkException=NetworkException(message: exception.message, statusCode: exception.code);
          break;
        case 401:
          errorDescription = "Unauthorized";
          networkException=NetworkException(message: exception.message, statusCode: exception.code);
          break;
        case 403:
          errorDescription = "Forbidden";
          break;
        case 403:
          errorDescription = "Forbidden";
          break;
        case 404:
          errorDescription = "Not Found";
          break;
        case 408:
          errorDescription = "Request Timeout";
          break;
        case 417:
          errorDescription = "Expectation Failed";
          break;
        case 500:
          errorDescription = "Internal Server Error";
          break;
        case 502:
          errorDescription = "Bad Gateway";
          break;
        case 503:
          errorDescription = "Service Unavailable";
          break;
        case 429:
          errorDescription = "Request Limit Cross please Try Again Later";
          networkException=NetworkException(message: errorDescription, statusCode: exception.code);
          break;
      }
    } else {
      errorDescription = "Unexpected error occurred";
    }
    return networkException;
  }
}