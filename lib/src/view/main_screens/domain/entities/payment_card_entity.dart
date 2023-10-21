
class PaymentCardEntity{
  String? id;
  final String? number;
  final String? date;
  final String? cvv;
  final String? holder;

  PaymentCardEntity({
    this.id,
    this.number,
    this.date,
    this.cvv,
    this.holder,
  });
}