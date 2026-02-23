// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get register => 'إنشاء حساب';

  @override
  String get email => 'البريد الإلكتروني';

  @override
  String get password => 'كلمة المرور';

  @override
  String get alreadyHaveAccount => 'لديك حساب بالفعل؟ تسجيل الدخول';

  @override
  String get enterEmail => 'الرجاء إدخال البريد الإلكتروني';

  @override
  String get invalidEmail => 'بريد إلكتروني غير صالح';

  @override
  String get enterPassword => 'الرجاء إدخال كلمة المرور';

  @override
  String get passwordMinLength => 'يجب أن تكون كلمة المرور 6 أحرف على الأقل';

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get dontHaveAccount => 'ليس لديك حساب؟ إنشاء حساب';

  @override
  String get generalErrorMessage => 'حدث خطأ ما';

  @override
  String get home => 'الرئيسية';

  @override
  String get loading => 'جاري التحميل...';

  @override
  String get books => 'الكتب';

  @override
  String get searchBooksHint => 'ابحث عن الكتب...';

  @override
  String get noBooksFound => 'لم يتم العثور على كتب. جرب بحثًا مختلفًا.';

  @override
  String get noItemsFound => 'لم يتم العثور على عناصر';

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String get noBookmarks => 'لا توجد إشارات مرجعية بعد';

  @override
  String get bookmarks => 'الإشارات المرجعية';

  @override
  String get imageHistory => 'سجل الصور';

  @override
  String get noImagesFoundInHistory => 'لم يتم العثور على صور في السجل.';

  @override
  String get errorLoadingHistory => 'خطأ في تحميل السجل: ';

  @override
  String get newUpload => 'رفع جديد';

  @override
  String get useIconsToPickImages => 'استخدم الأيقونات أعلاه لاختيار الصور';

  @override
  String get uploadComplete => 'اكتمل الرفع!';

  @override
  String get uploadAllSelectedImages => 'رفع كل الصور المحددة';
}
