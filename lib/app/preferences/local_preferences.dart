import 'package:get_storage/get_storage.dart';

class LocalPreferences {
  static final box = GetStorage();

  static void saveCurrentLogin(String email, String token, String acountType) {
    box.write('email', email);
    box.write('token', token);
    box.write('acountType', acountType);
  }

  static LocalLoginInformationModel getCurrentLoginInfo() {
    return LocalLoginInformationModel(
        email: box.read('email'),
        token: box.read('token'),
        acountType: box.read('acountType'));
  }
}

class LocalLoginInformationModel {
  String email;
  String token;
  String acountType;

  LocalLoginInformationModel(
      {required this.email, required this.token, required this.acountType});
}
