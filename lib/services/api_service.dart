import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';
import '../config/config.dart';

class ApiService {
  Future<List<Product>> fetchProducts() async {
    print('Starting API call');
    final config = Config();
    await config.load();

    final url = Uri.parse('${config.baseUrl}/products?organization_id=${config.organizationId}&Appid=${config.appId}&Apikey=${config.apiKey}');
    print('Fetching products from URL: $url');

    final response = await http.get(url);
    print('API response status code: ${response.statusCode}');

    if (response.statusCode == 200) {
      print('API response body: ${response.body}');
      try {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        final List<dynamic> items = jsonResponse['items']; // Extract the 'items' array
        return items.map((item) => Product.fromJson(item)).toList();
      } catch (e) {
        print('Error parsing response: $e');
        throw Exception('Failed to parse products');
      }
    } else {
      print('API response error: ${response.body}');
      throw Exception('Failed to load products');
    }
  }
}