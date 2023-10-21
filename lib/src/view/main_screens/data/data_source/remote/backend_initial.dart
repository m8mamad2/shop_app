import 'package:appwrite/appwrite.dart';
import 'package:project3/src/core/common/constans/texts.dart';

class BackendInitial {
  static final BackendInitial instance = BackendInitial._init();
  late final Client client;

  BackendInitial._init() {
    client = Client()
        .setEndpoint(kBackendUri)
        .setProject(kBackendKey)
        .setSelfSigned(status: true);
  }
}
