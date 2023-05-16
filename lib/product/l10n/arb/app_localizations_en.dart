import 'app_localizations.dart';

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get loginWithApple => 'Login with Apple';

  @override
  String get loginWithGoogle => 'Login with Google';

  @override
  String get account => 'Account';

  @override
  String get logout => 'Logout';

  @override
  String get loading => 'Loading...';

  @override
  String get createAccount => 'Create Account';

  @override
  String get enterEmailOrPhone => 'Enter email or phone';

  @override
  String get enterPassword => 'Enter your password';

  @override
  String get confirmPassword => 'Confirm your password';

  @override
  String get next => 'Next';

  @override
  String get invalidEmailOrPhone => 'Invalid email or phone';

  @override
  String get invalidPasswordMessage => 'Password security rules:\n - 8 characters long minimum\n - include minimum 1 uppercase or lowercase\n - include minimum 1 number\n - not include any other special character than @\\\$!%*#?&.~[]';

  @override
  String get passwordsDoNotMatch => 'Passwords do not match';

  @override
  String get verifyPhoneNumber => 'Verify your phone number';

  @override
  String get enterVerificationCode => 'Enter the verification code';

  @override
  String get resendCode => 'Resend code';

  @override
  String get verifyYourEmail => 'Verify your email';

  @override
  String get verifyYourEmailMessage => 'We sent you an email with a link to verify your email address. Please click on the link to verify your email address.';

  @override
  String get openEmailApp => 'Open email app';

  @override
  String get userNotFoundTitle => 'User not found';

  @override
  String get userNotFoundMessage => 'The user with the provided credentials does not exist. Make sure you create an account with your Phone number first.';

  @override
  String get weakPasswordTitle => 'Weak password';

  @override
  String get weakPasswordMessage => 'The password is too weak. Please choose a stronger password.';

  @override
  String get invalidEmailTitle => 'Invalid email';

  @override
  String get invalidEmailMessage => 'Please double check your email and try again!';

  @override
  String get emailAlreadyInUseTitle => 'Email already in use';

  @override
  String get emailAlreadyInUseMessage => 'The email address is already in use by another account.';

  @override
  String get requiresRecentLoginTitle => 'Requires recent login';

  @override
  String get requiresRecentLoginMessage => 'You need to log out and log back in again in order to perform this operation';

  @override
  String get operationNotAllowedTitle => 'Operation not allowed';

  @override
  String get operationNotAllowedMessage => 'You cannot register using this method at this moment!';

  @override
  String get unknownAuthErrorTitle => 'Authentication error';

  @override
  String get unknownAuthErrorMessage => 'An unknown authentication error occurred. Please try again later.';

  @override
  String get noCurrentUserTitle => 'No current user';

  @override
  String get noCurrentUserMessage => 'There is no current user. Please log in again.';

  @override
  String get wrongPasswordTitle => 'Wrong password';

  @override
  String get wrongPasswordMessage => 'The password is invalid or the user does not have a password.';

  @override
  String get tooManyRequestsTitle => 'Too many requests';

  @override
  String get tooManyRequestsMessage => 'Access to this account has been temporarily disabled due to many failed login attempts. You can immediately restore it by resetting your password or you can try again later.';

  @override
  String get credentialAlreadyInUseTitle => 'Credential already in use';

  @override
  String get credentialAlreadyInUseMessage => 'This credential is already associated with a different user account.';

  @override
  String get sessionExpiredTitle => 'Session expired';

  @override
  String get sessionExpiredMessage => 'Your session has expired. Please log in again.';

  @override
  String get login => 'Login';

  @override
  String get email => 'Email';

  @override
  String get invalidEmail => 'Invalid email';

  @override
  String get forgetPassword => 'Forget password';

  @override
  String get finishProfile => 'Finish your profile';

  @override
  String get yourName => 'Your name';

  @override
  String get yourSurname => 'Your surname';

  @override
  String get yourPhone => 'Your phone';

  @override
  String get yourEmail => 'Your email';

  @override
  String get invalidPhoneNumber => 'Invalid phone number';

  @override
  String get requiredField => 'This field is required';

  @override
  String get enterName => 'Enter your name';

  @override
  String get enterSurname => 'Enter your surname';

  @override
  String get enterEmail => 'Enter your email address';

  @override
  String get enterPhone => 'Enter your phone number';

  @override
  String get verify => 'Verify';

  @override
  String get accountSettingsPage => 'Account settings';

  @override
  String get authenticationOptions => 'Authentication options';

  @override
  String get userPage => 'User page';

  @override
  String get close => 'Close';

  @override
  String get unlinkProviderDialogTitle => 'Unlink provider';

  @override
  String get unlinkProviderDialogMessage => 'Are you sure you want to unlink this provider?';

  @override
  String get unlink => 'Unlink';
}
