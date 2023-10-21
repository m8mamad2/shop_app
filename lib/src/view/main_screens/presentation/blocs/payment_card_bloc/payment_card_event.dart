part of 'payment_card_bloc.dart';

@immutable
abstract class PaymentCardEvent {}

class InitialPaymentCardEvent extends PaymentCardEvent{}

class AddToPaymenctCardEvent extends InitialPaymentCardEvent{
  final PaymentCardEntity data;
  AddToPaymenctCardEvent(this.data);
}

class DeleteFromPaymenctCardEvent extends InitialPaymentCardEvent{
  final int index;
  DeleteFromPaymenctCardEvent(this.index);
}
