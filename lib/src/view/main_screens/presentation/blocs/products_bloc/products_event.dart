part of 'products_bloc.dart';

@immutable
abstract class ProductsEvent {}


class ApiCallProductsEvent extends ProductsEvent {
  final String endPoint;
  ApiCallProductsEvent({required this.endPoint});
}

class ApiCallSearchProductEvent extends ProductsEvent{
  final String endPoint;
  ApiCallSearchProductEvent({required this.endPoint});
}


