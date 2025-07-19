import 'package:hive_flutter/hive_flutter.dart';
import 'package:wasel/core/helper_network/model/product_model.dart';

class ProductHiveHelper {
  static const String boxName = 'productsBox';
  static Box<Product>? _box;

  static Future<Box<Product>> get box async {
    if (_box == null || !_box!.isOpen) {
      await initProductHiveHelper();
    }
    return _box!;
  }

  static Future<void> initProductHiveHelper() async {
    if (!Hive.isAdapterRegistered(ProductAdapter().typeId)) {
      Hive.registerAdapter(ProductAdapter());
    }
    try {
      await Hive.initFlutter();
      _box = await Hive.openBox<Product>(boxName);
      print('Hive box opened successfully: $_box');
    } catch (e) {
      print('Error initializing Hive: $e');
      rethrow;
    }
  }

  static Future<void> closeBox() async {
    if (_box?.isOpen ?? false) {
      await _box!.close();
    }
  }
}
