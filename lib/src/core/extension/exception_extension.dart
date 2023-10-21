import 'package:appwrite/appwrite.dart';

extension AppwriteExtensionExtension on AppwriteException {
  void onError(dynamic err) {
    AppwriteException exception = err as AppwriteException;

    print('====> ${exception.code}');
    print('====> ${exception.message}');
  }
}

extension AA on String {
  String onException(dynamic err) {
    AppwriteException exception = err;
    return exception.message ?? '';
  }
}
