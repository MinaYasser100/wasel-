import 'package:wasel/core/helper_network/dio_helper.dart';
import 'package:wasel/core/helper_network/model/product_model.dart';
import 'package:wasel/features/product/data/repo/product_repo.dart';

class ProductRepoImpl implements ProductRepo {
  final DioHelper _dioHelper = DioHelper();
  @override
  Future<List<Product>> fetchProducts() async {
    try {
      final response = await _dioHelper.getData(url: 'products');
      final List<dynamic> data = response.data['products'];
      return data.map((json) => Product.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to fetch products');
    }
  }
}
