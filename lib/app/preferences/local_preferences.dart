import 'package:get_storage/get_storage.dart';

class LocalPreferences {
  static final box = GetStorage();

  static void saveCurrentLogin(
      String email, String password, String token, String accountType) {
    box.write('email', email);
    box.write('password', password);
    box.write('token', token);
    box.write('accountType', accountType);
  }

  static LocalLoginInformationModel getCurrentLoginInfo() {
    return LocalLoginInformationModel(
        email: box.read('email'),
        password: box.read('password'),
        token: box.read('token'),
        accountType: box.read('accountType'));
  }
}

class LocalLoginInformationModel {
  String email;
  String password;
  String token;
  String accountType;

  LocalLoginInformationModel(
      {required this.email,
      required this.password,
      required this.token,
      required this.accountType});
}
