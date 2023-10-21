import 'package:bloc/bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';
import 'package:project3/src/view/main_screens/data/model/product_model.dart';
import 'package:project3/src/view/main_screens/domain/entities/products_entity.dart';
import 'package:project3/src/view/main_screens/domain/usecse/products_usecase.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState>{
  final ProductsUseCase useCase;

  ProductsBloc(this.useCase) : super(InitialProductsState()) {
    
    on<ApiCallProductsEvent>((event, emit) async {
      emit(LoadingProductsState());

      try {
          List<ProductsEntity> data =await useCase.result(event.endPoint);
          emit(SuccessProductsState(data: data));
      } catch (e) {
        emit(FailProductsState(error: e.toString()));
      }
    });

  }
  
}


