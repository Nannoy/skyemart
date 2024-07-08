import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';
import '../config/config.dart';

class ApiService {
  Future<List<Product>> fetchProducts() async {
    print('Starting API call');
    final config = Config();
    await config.load();

    final url = Uri.parse(
        '${config.baseUrl}/products?organization_id=${config.organizationId}&Appid=${config.appId}&Apikey=${config.apiKey}');
    //print('Fetching products from URL: $url');

    try {
      final response = await http.get(url);
      print('API response status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        //print('API response body: ${response.body}');
        try {
          final jsonResponse = json.decode(response.body) as Map<String, dynamic>;
          final items = jsonResponse['items'] as List<dynamic>;
          return items.map((item) => Product.fromJson(item)).toList();
        } catch (e) {
          print('Error parsing response');
          throw FetchProductsException('Failed to parse products');
        }
      } else {
        return _handleHttpError(response);
      }
    } catch (e) {
      print('Error fetching products');
      throw FetchProductsException('Failed to fetch products');
    }
  }

  List<Product> _handleHttpError(http.Response response) {
    switch (response.statusCode) {
      case 400:
        print('Bad request: ${response.body}');
        throw BadRequestException('Invalid request: ${response.body}');
      case 401:
        print('Unauthorized: ${response.body}');
        throw UnauthorizedException('Unauthorized: ${response.body}');
      case 403:
        print('Forbidden: ${response.body}');
        throw ForbiddenException('Forbidden: ${response.body}');
      case 404:
        print('Not found: ${response.body}');
        throw NotFoundException('Not found: ${response.body}');
      case 500:
        print('Server error: ${response.body}');
        throw ServerErrorException('Server error: ${response.body}');
      default:
        print('Unknown error: ${response.body}');
        throw HttpException('Failed to load products: Check phone internet connection and retry');
    }
  }
}

class FetchProductsException implements Exception {
  final String message;
  final dynamic cause;
  FetchProductsException(this.message, [this.cause]);
}

class BadRequestException extends FetchProductsException {
  BadRequestException(String message) : super(message);
}

class UnauthorizedException extends FetchProductsException {
  UnauthorizedException(String message) : super(message);
}

class ForbiddenException extends FetchProductsException {
  ForbiddenException(String message) : super(message);
}

class NotFoundException extends FetchProductsException {
  NotFoundException(String message) : super(message);
}

class ServerErrorException extends FetchProductsException {
  ServerErrorException(String message) : super(message);
}

class HttpException extends FetchProductsException {
  HttpException(String message) : super(message);
}
