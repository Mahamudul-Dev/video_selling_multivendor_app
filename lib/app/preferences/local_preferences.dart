import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';

class LocalPreferences {
  static final box = GetStorage();

  static void saveCurrentLogin(
      String id, String email, String token, String accountType) {
    box.write('id', id);
    box.write('email', email);
    box.write('token', token);
    box.write('accountType', accountType);
  }

  static clearPrefrences(){
    box.remove('id');
    box.remove('email');
    box.remove('token');
    box.remove('accountType');
  }

  static void saveThemeMode(bool isDark){
    box.write('themeMode', isDark);
  }

  static bool getThemeMode(){
    bool themeMode = true;
    try {
     themeMode = box.read('themeModel');
    } catch (e) {
      Logger().e(e);
    }
    return themeMode;
  }

  static LocalLoginInformationModel getCurrentLoginInfo() {
    return LocalLoginInformationModel(
        id: box.read('id'),
        email: box.read('email'),
        token: box.read('token'),
        accountType: box.read('accountType'));
  }
}

class LocalLoginInformationModel {
  String? id;
  String? email;
  String? token;
  String? accountType;

  LocalLoginInformationModel(
      {this.id, this.email, this.token, this.accountType});
}
