class AppStrings {
  static final AppStrings _appStrings = AppStrings._internal();

  factory AppStrings() {
    return _appStrings;
  }

  AppStrings._internal();

  String get howWorks => 'How Works';

  String get getStarted => 'Get Started';

  String get skip => 'Skip';

  String get forgotPassword => 'Forgot password';

  String get rememberMe => 'Remember me';

  get next => 'Next';

  String get login => 'Login';

  String get newTotheApp => 'New to the App?';

  String get alreadyHaveAnAccount => 'Already have an account?';

  String get signUpNow => 'Signup Now';

  String get sendLink => 'Send Link';

  get resendLink => 'Resend Link';

  String get resetPassword => 'Reset Password';

  String get save => 'Save';

  String get checkInternet => 'Please check Internet';

  String get noInternet => 'No Internet Available';

  String get ok => 'Ok';

  String get customer => 'Customer';

  String get signUp => 'Sign Up';

  String get exitWarning => 'Please press back button again';

  String get draft => 'Draft';

  String get fontFamily => 'helvetica';
}

AppStrings appStrings = AppStrings();
