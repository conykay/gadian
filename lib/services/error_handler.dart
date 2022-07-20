import 'package:firebase_auth/firebase_auth.dart';

enum AuthStatus {
  successful,
  wrongPassword,
  emailAlreadyExists,
  invalidEmail,
  userNotFound,
  unknown,
}

class AuthExceptionHandler {
  static handleAuthException(FirebaseAuthException e) {
    AuthStatus status;
    switch (e.code) {
      case 'invalid-email':
        status = AuthStatus.invalidEmail;
        break;
      case 'wrong-password':
        status = AuthStatus.wrongPassword;
        break;
      case 'email-already-in-use':
        status = AuthStatus.emailAlreadyExists;
        break;
      case 'user-not-found':
        status = AuthStatus.userNotFound;
        break;
      default:
        status = AuthStatus.unknown;
    }
    return status;
  }

  static String generateErrorMessage(error) {
    String errorMessage;
    switch (error) {
      case AuthStatus.invalidEmail:
        errorMessage = 'There was a problem with your email address.';
        break;
      case AuthStatus.wrongPassword:
        errorMessage = 'Your email or password is wrong.';
        break;
      case AuthStatus.emailAlreadyExists:
        errorMessage =
            'The email address is already in use by another account.';
        break;
      case AuthStatus.userNotFound:
        errorMessage = 'We cannot find a user with that email.';
        break;
      default:
        errorMessage = 'An error occurred. Please try again later.';
    }
    return errorMessage;
  }
}
