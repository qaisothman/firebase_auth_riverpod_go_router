import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'arb/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en')
  ];

  /// No description provided for @loginWithApple.
  ///
  /// In en, this message translates to:
  /// **'Login with Apple'**
  String get loginWithApple;

  /// No description provided for @loginWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Login with Google'**
  String get loginWithGoogle;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// No description provided for @enterEmailOrPhone.
  ///
  /// In en, this message translates to:
  /// **'Enter email or phone'**
  String get enterEmailOrPhone;

  /// No description provided for @enterPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get enterPassword;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm your password'**
  String get confirmPassword;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @invalidEmailOrPhone.
  ///
  /// In en, this message translates to:
  /// **'Invalid email or phone'**
  String get invalidEmailOrPhone;

  /// No description provided for @invalidPasswordMessage.
  ///
  /// In en, this message translates to:
  /// **'Password security rules:\n - 8 characters long minimum\n - include minimum 1 uppercase or lowercase\n - include minimum 1 number\n - not include any other special character than @\\\$!%*#?&.~[]'**
  String get invalidPasswordMessage;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  /// No description provided for @verifyPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Verify your phone number'**
  String get verifyPhoneNumber;

  /// No description provided for @enterVerificationCode.
  ///
  /// In en, this message translates to:
  /// **'Enter the verification code'**
  String get enterVerificationCode;

  /// No description provided for @resendCode.
  ///
  /// In en, this message translates to:
  /// **'Resend code'**
  String get resendCode;

  /// No description provided for @verifyYourEmail.
  ///
  /// In en, this message translates to:
  /// **'Verify your email'**
  String get verifyYourEmail;

  /// No description provided for @verifyYourEmailMessage.
  ///
  /// In en, this message translates to:
  /// **'We sent you an email with a link to verify your email address. Please click on the link to verify your email address.'**
  String get verifyYourEmailMessage;

  /// No description provided for @openEmailApp.
  ///
  /// In en, this message translates to:
  /// **'Open email app'**
  String get openEmailApp;

  /// No description provided for @userNotFoundTitle.
  ///
  /// In en, this message translates to:
  /// **'User not found'**
  String get userNotFoundTitle;

  /// No description provided for @userNotFoundMessage.
  ///
  /// In en, this message translates to:
  /// **'The user with the provided credentials does not exist. Make sure you create an account with your Phone number first.'**
  String get userNotFoundMessage;

  /// No description provided for @weakPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Weak password'**
  String get weakPasswordTitle;

  /// No description provided for @weakPasswordMessage.
  ///
  /// In en, this message translates to:
  /// **'The password is too weak. Please choose a stronger password.'**
  String get weakPasswordMessage;

  /// No description provided for @invalidEmailTitle.
  ///
  /// In en, this message translates to:
  /// **'Invalid email'**
  String get invalidEmailTitle;

  /// No description provided for @invalidEmailMessage.
  ///
  /// In en, this message translates to:
  /// **'Please double check your email and try again!'**
  String get invalidEmailMessage;

  /// No description provided for @emailAlreadyInUseTitle.
  ///
  /// In en, this message translates to:
  /// **'Email already in use'**
  String get emailAlreadyInUseTitle;

  /// No description provided for @emailAlreadyInUseMessage.
  ///
  /// In en, this message translates to:
  /// **'The email address is already in use by another account.'**
  String get emailAlreadyInUseMessage;

  /// No description provided for @requiresRecentLoginTitle.
  ///
  /// In en, this message translates to:
  /// **'Requires recent login'**
  String get requiresRecentLoginTitle;

  /// No description provided for @requiresRecentLoginMessage.
  ///
  /// In en, this message translates to:
  /// **'You need to log out and log back in again in order to perform this operation'**
  String get requiresRecentLoginMessage;

  /// No description provided for @operationNotAllowedTitle.
  ///
  /// In en, this message translates to:
  /// **'Operation not allowed'**
  String get operationNotAllowedTitle;

  /// No description provided for @operationNotAllowedMessage.
  ///
  /// In en, this message translates to:
  /// **'You cannot register using this method at this moment!'**
  String get operationNotAllowedMessage;

  /// No description provided for @unknownAuthErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'Authentication error'**
  String get unknownAuthErrorTitle;

  /// No description provided for @unknownAuthErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'An unknown authentication error occurred. Please try again later.'**
  String get unknownAuthErrorMessage;

  /// No description provided for @noCurrentUserTitle.
  ///
  /// In en, this message translates to:
  /// **'No current user'**
  String get noCurrentUserTitle;

  /// No description provided for @noCurrentUserMessage.
  ///
  /// In en, this message translates to:
  /// **'There is no current user. Please log in again.'**
  String get noCurrentUserMessage;

  /// No description provided for @wrongPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Wrong password'**
  String get wrongPasswordTitle;

  /// No description provided for @wrongPasswordMessage.
  ///
  /// In en, this message translates to:
  /// **'The password is invalid or the user does not have a password.'**
  String get wrongPasswordMessage;

  /// No description provided for @tooManyRequestsTitle.
  ///
  /// In en, this message translates to:
  /// **'Too many requests'**
  String get tooManyRequestsTitle;

  /// No description provided for @tooManyRequestsMessage.
  ///
  /// In en, this message translates to:
  /// **'Access to this account has been temporarily disabled due to many failed login attempts. You can immediately restore it by resetting your password or you can try again later.'**
  String get tooManyRequestsMessage;

  /// No description provided for @credentialAlreadyInUseTitle.
  ///
  /// In en, this message translates to:
  /// **'Credential already in use'**
  String get credentialAlreadyInUseTitle;

  /// No description provided for @credentialAlreadyInUseMessage.
  ///
  /// In en, this message translates to:
  /// **'This credential is already associated with a different user account.'**
  String get credentialAlreadyInUseMessage;

  /// No description provided for @sessionExpiredTitle.
  ///
  /// In en, this message translates to:
  /// **'Session expired'**
  String get sessionExpiredTitle;

  /// No description provided for @sessionExpiredMessage.
  ///
  /// In en, this message translates to:
  /// **'Your session has expired. Please log in again.'**
  String get sessionExpiredMessage;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Invalid email'**
  String get invalidEmail;

  /// No description provided for @forgetPassword.
  ///
  /// In en, this message translates to:
  /// **'Forget password'**
  String get forgetPassword;

  /// No description provided for @finishProfile.
  ///
  /// In en, this message translates to:
  /// **'Finish your profile'**
  String get finishProfile;

  /// No description provided for @yourName.
  ///
  /// In en, this message translates to:
  /// **'Your name'**
  String get yourName;

  /// No description provided for @yourSurname.
  ///
  /// In en, this message translates to:
  /// **'Your surname'**
  String get yourSurname;

  /// No description provided for @yourPhone.
  ///
  /// In en, this message translates to:
  /// **'Your phone'**
  String get yourPhone;

  /// No description provided for @yourEmail.
  ///
  /// In en, this message translates to:
  /// **'Your email'**
  String get yourEmail;

  /// No description provided for @invalidPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Invalid phone number'**
  String get invalidPhoneNumber;

  /// No description provided for @requiredField.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get requiredField;

  /// No description provided for @enterName.
  ///
  /// In en, this message translates to:
  /// **'Enter your name'**
  String get enterName;

  /// No description provided for @enterSurname.
  ///
  /// In en, this message translates to:
  /// **'Enter your surname'**
  String get enterSurname;

  /// No description provided for @enterEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter your email address'**
  String get enterEmail;

  /// No description provided for @enterPhone.
  ///
  /// In en, this message translates to:
  /// **'Enter your phone number'**
  String get enterPhone;

  /// No description provided for @verify.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verify;

  /// No description provided for @accountSettingsPage.
  ///
  /// In en, this message translates to:
  /// **'Account settings'**
  String get accountSettingsPage;

  /// No description provided for @authenticationOptions.
  ///
  /// In en, this message translates to:
  /// **'Authentication options'**
  String get authenticationOptions;

  /// No description provided for @userPage.
  ///
  /// In en, this message translates to:
  /// **'User page'**
  String get userPage;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @unlinkProviderDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Unlink provider'**
  String get unlinkProviderDialogTitle;

  /// No description provided for @unlinkProviderDialogMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to unlink this provider?'**
  String get unlinkProviderDialogMessage;

  /// No description provided for @unlink.
  ///
  /// In en, this message translates to:
  /// **'Unlink'**
  String get unlink;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
