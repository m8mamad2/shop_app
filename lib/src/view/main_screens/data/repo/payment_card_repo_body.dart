import 'package:project3/src/view/main_screens/data/data_source/local/init_hive_db.dart';
import 'package:project3/src/view/main_screens/data/model/local/payment_card_model.dart';
import 'package:project3/src/view/main_screens/domain/entities/payment_card_entity.dart';
import 'package:project3/src/view/main_screens/domain/repo/payment_card_repo_header.dart';
import 'package:uuid/uuid.dart';

class PaymentCardRepoBody implements PaymentCardRepoHeader{
  
  @override
  Future<void> addtoBox(PaymentCardEntity data) async {
    final model = PaymentCardModel.fromEntity(data);
    model.id =const Uuid().v1().toString();
    print(model.id);
    await boxList[3].put(model.id,model).then((value) => print('success')).catchError((e)=>print(e));
  }

  @override
  Future<void> deleteFromBox(int index)async =>await boxList[3].deleteAt(index).then((value) => print('success')).catchError((e)=>print(e));
  

  @override
  Future<List<PaymentCardEntity>> getBox() async => boxList[3].values.toList() as List<PaymentCardEntity>;
  
}