import 'package:ecommerce_app/product_cubit/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../product_service.dart';

class ProductCubit extends Cubit<ProductState>{
  final ProductService service;
  ProductCubit(this.service) : super(ProductInitial());

  void fetchProducts() async{
    emit(ProductLoading());
    try{
      final products = await service.getProducts();
      emit(ProductSuccess(products: products));
    }
    catch(e){
      emit(ProductFailure(error: e.toString()));
    }
  }

  Future<void> fetchProductsByCategory(String category) async {
    emit(ProductLoading());
    try{
      final products = await service.getProductsByCategory(category);
      emit(ProductSuccess(products: products));
    }
    catch(e){
      emit(ProductFailure(error: e.toString()));
    }
  }
}
