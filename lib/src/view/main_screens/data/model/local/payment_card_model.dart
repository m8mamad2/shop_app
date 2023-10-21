import 'package:hive/hive.dart';
import 'package:project3/src/view/main_screens/domain/entities/payment_card_entity.dart';


part 'payment_card_model.g.dart';

@HiveType(typeId: 4)
class PaymentCardModel extends PaymentCardEntity{

  @HiveField(0)
  String? id;

  @HiveField(1)
  final String? number;
  
  @HiveField(2)
  final String? date;
  
  @HiveField(3)
  final String? cvv;
  
  @HiveField(4)
  final String? holder;

  PaymentCardModel(
    this.id,
    this.number,
    this.date,
    this.cvv,
    this.holder,)
  :super(
    id:id,
    number:number,
    date:date,
    cvv:cvv,
    holder:holder,);


    factory PaymentCardModel.fromEntity(PaymentCardEntity entity)=> PaymentCardModel(
     entity.id, 
     entity.number, 
     entity.date, 
     entity.cvv, 
     entity.holder);


}