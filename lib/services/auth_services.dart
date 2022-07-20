// ignore_for_file: can_be_null_after_null_aware

part of 'services.dart';

class AuthServices {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<SignInSingUpResult> signUp(
      String email,
      String password,
      String name,
      List<String> selectedGenres,
      String selectedLanguange) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      User user = result.user.convertToUser(
          name: name,
          selectedGenres: selectedGenres,
          selectedLanguange: selectedLanguange);

      await UserServices.updateUser(user);

      return SignInSingUpResult(user: user);
    } catch (e) {
      return SignInSingUpResult(message: e.message.toString().trim());
    }
  }

  static Future<SignInSingUpResult> signIn(
      String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      User user = await result.user.fromFireStore();

      return SignInSingUpResult(user: user);
    } catch (e) {
      return SignInSingUpResult(message: e.message.toString().trim());
    }
  }

  static Future<void> signOut() async {
    _auth.signOut();
  }

  static Stream<FirebaseUser> get userStream => _auth.onAuthStateChanged;
}

class SignInSingUpResult {
  final User user;
  final String message;
  SignInSingUpResult({this.user, this.message});
}
