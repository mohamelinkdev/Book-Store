import 'package:book_store/core/utils/app_validator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppValidator.isEmailValid', () {
    test('returns false for null or empty', () {
      expect(AppValidator.isEmailValid(null), isFalse);
      expect(AppValidator.isEmailValid(''), isFalse);
    });

    test('returns true for valid emails', () {
      expect(AppValidator.isEmailValid('test@example.com'), isTrue);
      expect(AppValidator.isEmailValid('user.name@domain.co'), isTrue);
    });

    test('returns false for invalid emails', () {
      expect(AppValidator.isEmailValid('test'), isFalse);
      expect(AppValidator.isEmailValid('test@'), isFalse);
      expect(AppValidator.isEmailValid('test@domain'), isFalse);
      expect(AppValidator.isEmailValid('test@domain.'), isFalse);
    });
  });

  group('AppValidator.isPasswordValid', () {
    test('returns false for null or empty', () {
      expect(AppValidator.isPasswordValid(null), isFalse);
      expect(AppValidator.isPasswordValid(''), isFalse);
    });

    test('returns false for passwords shorter than 6 characters', () {
      expect(AppValidator.isPasswordValid('12345'), isFalse);
      expect(AppValidator.isPasswordValid('abcde'), isFalse);
    });

    test('returns true for passwords 6 characters or more', () {
      expect(AppValidator.isPasswordValid('123456'), isTrue);
      expect(AppValidator.isPasswordValid('abcdef'), isTrue);
      expect(AppValidator.isPasswordValid('abc123!'), isTrue);
    });
  });
}
