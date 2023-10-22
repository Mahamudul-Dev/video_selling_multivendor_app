import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';

class LoginController extends GetxController {
  final _googleSignIn = GoogleSignIn();
  Rx<GoogleSignInAccount?> googleAccount = Rx<GoogleSignInAccount?>(null);

  Future<void> signInWithGoogle() async {
    try {
      googleAccount.value = await _googleSignIn.signIn();
      Logger().i({"logged in account": googleAccount.value?.displayName});
    } catch (e) {
      Logger().e(e);
    }
  }

  @override
  void onClose() {
    googleAccount.close();
    super.onClose();
  }
}
