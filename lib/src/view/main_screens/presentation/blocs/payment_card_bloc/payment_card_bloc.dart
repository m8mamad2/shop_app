import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:project3/src/view/main_screens/domain/entities/payment_card_entity.dart';
import 'package:project3/src/view/main_screens/domain/usecse/payment_card_usecase.dart';

part 'payment_card_event.dart';
part 'payment_card_state.dart';

class PaymentCardBloc extends Bloc<PaymentCardEvent, PaymentCardState> {

  PaymentCardUsecase usecase;
  PaymentCardBloc(this.usecase) : super(InitialPaymentCardState()) {
    on<InitialPaymentCardEvent>((event, emit) async {

      emit(LoadingPaymentCardState());

      List<PaymentCardEntity> data = await usecase.getFromBox();

      try{
        if(event is AddToPaymenctCardEvent)usecase.addToBox(event.data);
        if(event is DeleteFromPaymenctCardEvent)usecase.delteFromBox(event.index);

        emit(SuccessPaymentCardState(data));
      }
      catch(e){emit(FailPaymentCardState(e.toString()));}
      
    });
  }
}
