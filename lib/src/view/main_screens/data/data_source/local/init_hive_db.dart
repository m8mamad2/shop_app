import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:project3/src/view/main_screens/data/model/chat_mdoel.dart';
import 'package:project3/src/view/main_screens/data/model/local/contact_db_model.dart';
import 'package:project3/src/view/main_screens/data/model/local/payment_card_model.dart';
import 'package:project3/src/view/main_screens/domain/entities/cart_db_entity.dart';
import 'package:project3/src/view/main_screens/domain/entities/chat_entity.dart';
import 'package:project3/src/view/main_screens/domain/entities/concats_db_entity.dart';
import 'package:project3/src/view/main_screens/domain/entities/favorite_db_entity.dart';
import 'package:project3/src/view/main_screens/domain/entities/payment_card_entity.dart';

import '../../model/local/cart_db_model.dart';
import '../../model/local/favorite_db_model.dart';


List<Box> boxList = [];

Future<List<Box>> openBoxes() async {
  var directory = await getApplicationDocumentsDirectory();

  Hive.init(directory.path);
  Hive.registerAdapter(CartDBModelAdapter());
  Hive.registerAdapter(FavoriteDBModelAdapter());
  Hive.registerAdapter(ConcatsDBModelAdapter());
  Hive.registerAdapter(PaymentCardModelAdapter());
  Hive.registerAdapter(ChatModelAdapter());

  var cartBox = await Hive.openBox<CartDBEntity>('cart_box');
  var favoriteBox = await Hive.openBox<FavoriteDBEntity>('favorite_box');
  var contactBox = await Hive.openBox<ContactDBEntity>('contact_box');
  var paymentCardBox = await Hive.openBox<PaymentCardEntity>('payment_card_box');
  var chatBox = await Hive.openBox<ChatEntity>('chat_box');

  boxList.add(cartBox);
  boxList.add(favoriteBox);
  boxList.add(contactBox);
  boxList.add(paymentCardBox);
  boxList.add(chatBox);
  
  return boxList;
}
