import 'package:firebase_auth/firebase_auth.dart';

enum AuthStatus {
  successful,
  wrongPassword,
  emailAlreadyExists,
  invalidEmail,
  userNotFound,
  unknown,
}

enum ExceptionStatus {
  successful,
  invalidArgument,
  unAuthenticated,
  alreadyExists,
  aborted,
  cancelled,
  dataLoss,
  unavailable,
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

class ExceptionHandler {
  static handleException(FirebaseException e) {
    ExceptionStatus status;
    switch (e.code) {
      case 'invalid-argument':
        status = ExceptionStatus.invalidArgument;
        break;
      case 'unauthenticated':
        status = ExceptionStatus.unAuthenticated;
        break;
      case 'already-exists':
        status = ExceptionStatus.alreadyExists;
        break;
      case 'aborted':
        status = ExceptionStatus.aborted;
        break;
      case 'cancelled':
        status = ExceptionStatus.cancelled;
        break;
      case 'data-loss':
        status = ExceptionStatus.dataLoss;
        break;
      case 'unavailable':
        status = ExceptionStatus.unavailable;
        break;
      default:
        status = ExceptionStatus.unknown;
    }
    return status;
  }

  static String generateErrorMessage(error) {
    String errorMessage;
    switch (error) {
      case ExceptionStatus.invalidArgument:
        errorMessage = 'Failed due to invalid argument.';
        break;
      case ExceptionStatus.unAuthenticated:
        errorMessage = 'Unauthorized, please login and try again.';
        break;
      case ExceptionStatus.alreadyExists:
        errorMessage = 'Failed because ,This information already exists.';
        break;
      case ExceptionStatus.aborted:
        errorMessage = 'The operation was aborted.';
        break;
      case ExceptionStatus.cancelled:
        errorMessage = 'Request cancelled.';
        break;
      case ExceptionStatus.dataLoss:
        errorMessage = 'Unrecoverable data loss or data corruption.';
        break;
      case ExceptionStatus.unavailable:
        errorMessage = 'Network error , the server is temporarily down.';
        break;
      default:
        errorMessage = 'An error occurred , Please try again later.';
    }
    return errorMessage;
  }
}
