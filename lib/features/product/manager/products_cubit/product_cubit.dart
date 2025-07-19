import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasel/core/helper_network/model/product_model.dart';
import 'package:wasel/core/internet_check/cubit/internet_check__cubit.dart';
import 'package:wasel/core/internet_check/ui/internet_dialge.dart';
import 'package:wasel/features/product/data/repo/product_repo/product_repo.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepo _productRepo;
  final ConnectivityCubit _connectivityCubit;
  final BuildContext _context;
  ProductCubit(this._productRepo, this._connectivityCubit, this._context)
    : super(ProductInitial());

  Future<void> loadProducts() async {
    emit(ProductLoading());
    try {
      final connectivityState = _connectivityCubit.state;
      if (connectivityState is ConnectivityDisconnected) {
        showNoInternetDialog(_context);
        emit(ProductError('No internet connection'));
        return;
      }

      final products = await _productRepo.fetchProducts();
      emit(ProductLoaded(products));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  @override
  void onChange(Change<ProductState> change) {
    super.onChange(change);
    if (change.nextState is ProductError) {
      showNoInternetDialog(_context); // عرض الديالوج عند الخطأ
    }
  }
}
