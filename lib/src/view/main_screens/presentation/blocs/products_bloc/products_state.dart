part of 'products_bloc.dart';

@immutable
abstract class ProductsState {}

class InitialProductsState extends ProductsState {}

class LoadingProductsState extends ProductsState {}

class SuccessProductsState extends ProductsState {
  List<ProductsEntity> data;
  SuccessProductsState({required this.data});
}

class FailProductsState extends ProductsState {
  String error;
  FailProductsState({required this.error});
}
