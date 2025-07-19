import 'package:hive_flutter/hive_flutter.dart';
import 'package:wasel/core/helper_network/app_const.dart';
import 'package:wasel/core/helper_network/dio_helper.dart';
import 'package:wasel/core/helper_network/model/product_model.dart';
import 'package:wasel/features/product/data/product_hive_helper.dart';
import 'package:wasel/features/product/data/repo/product_repo/product_repo.dart';

class ProductRepoImpl implements ProductRepo {
  final DioHelper _dioHelper = DioHelper();
  final Future<Box<Product>> _productsBoxFuture = ProductHiveHelper.box;

  @override
  Future<List<Product>> fetchProducts() async {
    try {
      final productsBox = await _productsBoxFuture;

      if (productsBox.isNotEmpty) {
        return productsBox.values.toList();
      }

      final response = await _dioHelper.getData(url: AppConst.products);
      final List<dynamic> data = response.data['products'];
      final products = data.map((json) => Product.fromJson(json)).toList();

      for (var product in products) {
        await productsBox.put(product.id.toString(), product);
      }

      return products;
    } catch (e) {
      throw Exception('Failed to fetch products: $e');
    }
  }
}
