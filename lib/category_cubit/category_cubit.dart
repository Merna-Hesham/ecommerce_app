import 'package:ecommerce_app/category_cubit/category_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../category_service.dart';

class CategoryCubit extends Cubit<CategoryState>{
  final CategoryService service;
  CategoryCubit(this.service) : super(CategoryInitial());

  void fetchCategories() async{
    emit(CategoryLoading());
    try{
      final categories = await service.getCategories();
      emit(CategorySuccess(categories: categories));
    }
    catch(e){
      emit(CategoryFailure(error: e.toString()));
    }
  }
}
