import 'dart:io';

enum AuthMode { SignUp, Login }

class AuthFormData {
  String name = "";
  String email = "";
  String passord = "";
  File? image;
  AuthMode _mode = AuthMode.Login;

  bool get isLoging {
    return _mode == AuthMode.Login;
  }

  bool get isSingUp {
    return _mode == AuthMode.SignUp;
  }
}
