
import 'package:socket_io_client/socket_io_client.dart';

class ChatInitial{
 static final Socket socket = 
  io('http://localhost:3031',<String,dynamic>{'transport':['websocket']});
}