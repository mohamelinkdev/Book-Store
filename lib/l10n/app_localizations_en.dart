// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get register => 'Register';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get alreadyHaveAccount => 'Already have an account? Login';

  @override
  String get enterEmail => 'Please enter email';

  @override
  String get invalidEmail => 'Invalid email';

  @override
  String get enterPassword => 'Please enter password';

  @override
  String get passwordMinLength => 'Password must be at least 6 characters';

  @override
  String get login => 'Login';

  @override
  String get dontHaveAccount => 'Don\'t have an account? Register';

  @override
  String get generalErrorMessage => 'Some Thing Went Wrong';

  @override
  String get home => 'Home';

  @override
  String get loading => 'Loading...';

  @override
  String get books => 'Books';

  @override
  String get searchBooksHint => 'Search books...';

  @override
  String get noBooksFound => 'No books found. Try a different search.';

  @override
  String get noItemsFound => 'No items found';

  @override
  String get retry => 'Retry';

  @override
  String get noBookmarks => 'No bookmarks yet';

  @override
  String get bookmarks => 'Bookmarks';

  @override
  String get imageHistory => 'Image History';

  @override
  String get noImagesFoundInHistory => 'No images found in history.';

  @override
  String get errorLoadingHistory => 'Error loading history: ';

  @override
  String get newUpload => 'New Upload';

  @override
  String get useIconsToPickImages => 'Use the icons above to pick images';

  @override
  String get uploadComplete => 'Upload Complete!';

  @override
  String get uploadAllSelectedImages => 'Upload All Selected Images';
}
