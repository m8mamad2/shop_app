import 'package:project3/src/view/main_screens/domain/entities/payment_card_entity.dart';
import 'package:project3/src/view/main_screens/domain/repo/payment_card_repo_header.dart';

class PaymentCardUsecase{
  final PaymentCardRepoHeader repo;
  PaymentCardUsecase(this.repo);

  Future<void> addToBox(PaymentCardEntity data) async => await repo.addtoBox(data);
  Future<void> delteFromBox(int index) async => await repo.deleteFromBox(index);
  Future<List<PaymentCardEntity>> getFromBox() async => repo.getBox();

  }