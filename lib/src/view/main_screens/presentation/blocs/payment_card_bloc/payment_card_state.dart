part of 'payment_card_bloc.dart';

@immutable
abstract class PaymentCardState {}

class InitialPaymentCardState extends PaymentCardState {}

class LoadingPaymentCardState extends PaymentCardState {}

class SuccessPaymentCardState extends PaymentCardState {
  final List<PaymentCardEntity> data;
  SuccessPaymentCardState(this.data);
}

class FailPaymentCardState extends PaymentCardState {
  final String error;
  FailPaymentCardState(this.error);
}
