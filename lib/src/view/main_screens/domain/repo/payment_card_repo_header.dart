import 'package:project3/src/view/main_screens/domain/entities/payment_card_entity.dart';

abstract class PaymentCardRepoHeader{
  Future<void> addtoBox(PaymentCardEntity data);
  Future<void> deleteFromBox(int index);
  Future<List<PaymentCardEntity>> getBox();
}