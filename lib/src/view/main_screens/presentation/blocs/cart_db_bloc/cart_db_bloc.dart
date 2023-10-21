import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:project3/src/view/main_screens/domain/entities/cart_db_entity.dart';
import 'package:project3/src/view/main_screens/domain/usecse/cart_db_usecase.dart';

part 'cart_db_event.dart';
part 'cart_db_state.dart';

class CartDbBloc extends Bloc<CartDbEvent, CartDbState> {
  CartDBUseCase usecase;

  CartDbBloc(this.usecase) : super(InitialCartDBState()) {
    on<InitialCartDBEvent>((event, emit) async {
      emit(LoadingCartDBState());

      List<CartDBEntity> data = await usecase.readFromBox();

      try {
        if (event is AddToCartDBEvent) usecase.addToBox(event.data);
        if (event is UpdateFromCartDBEvent) usecase.updateFromBox(event.data);
        if (event is DeleteFromCartDBEvent) usecase.deleteFromBox(event.index);
        if (event is ClearFromCartDBEvent) usecase.clearBox();

        emit(SuccessCartDBState(data: data));
      } catch (e) {
        emit(FailCartDBState(error: e.toString()));
      }
    });
  }
}
