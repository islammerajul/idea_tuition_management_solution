import 'dart:io';

import 'package:dio/dio.dart';

import 'package:http/http.dart' as http;
import 'package:idea_tuition_managment_app/data/exceptions/network_exceptions.dart';


class HttpErrorUtil {
  // general methods:------------------------------------------------------------
  static NetworkException handleError(http.Response response) {


    String errorDescription = "";
    NetworkException networkException =new NetworkException();
    if (response!=null) {
      switch (response.statusCode) {
        case 400:
          errorDescription = "Bad Request";
          networkException=NetworkException(message: 'Error fetching data from server', statusCode: response.statusCode);
          break;
        case 401:
          errorDescription = "Unauthorized";
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
      }
    } else {
      errorDescription = "Unexpected error occurred";
    }
    return networkException;
  }
}