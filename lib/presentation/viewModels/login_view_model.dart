import 'package:could_be/domain/useCases/login_use_case.dart';

class LoginViewModel{

  var loginUseCase = LoginUseCase();

  Future<void> signInWithGoogle() async {
    await loginUseCase.signInWithGoogle();
  }
}