import 'package:interact/interact.dart';

import 'base_validator.dart';

class NonEmptyValidator implements Validator<String> {
  @override
  bool validate(String value) {
    if (value.isEmpty) {
      throw ValidationError('Value is required.');
    }
    return true;
  }
}

class PascalCaseValidator implements Validator<String> {
  @override
  bool validate(String value) {
    if (!value.startsWith(RegExp(r'^[A-Z][a-zA-Z]*$'))) {
      throw ValidationError(
          'Value should be in PascalCase. e.g. User or UserDetail');
    }
    return true;
  }
}

class NotReservedWordValidator implements Validator<String> {
  static const reservedWords = ['do', 'if', 'in', 'for', 'new', 'var'];

  @override
  bool validate(String value) {
    if (reservedWords.contains(value)) {
      throw ValidationError('Value should not be a Dart reserved word.');
    }
    return true;
  }
}

class ProjectNameValidator implements Validator<String> {
  @override
  bool validate(String value) {
    final result = RegExp(r'[\^$*+?.()|{}\[\]\\]').hasMatch(value);
    if (result) {
      throw ValidationError('Project name cannot contain special characters');
    }
    return true;
  }
}

class BundleIdOrApplicationIdValidator implements Validator<String> {
  final bool isIOS;

  BundleIdOrApplicationIdValidator({this.isIOS = false});

  @override
  bool validate(String value) {
    final result = RegExp(r'^[a-zA-Z][a-zA-Z0-9]*(\.[a-zA-Z][a-zA-Z0-9]*)+$')
        .hasMatch(value);
    if (!result) {
      throw ValidationError(
          'Invalid ${isIOS ? 'Bundle Id' : 'Application Id'}');
    }

    return true;
  }
}

class IosBundleIdValidator extends ReverseDnsValidator {
  IosBundleIdValidator()
      : super(reservedWords: [
          "apple",
          "com",
          "net",
          "edu",
          "org",
          "gov",
          "mil",
          "co",
          "uk",
          "us",
          "ps",
          "sa"
        ]);
}

class AndroidAppIdValidator extends ReverseDnsValidator {
  AndroidAppIdValidator()
      : super(
          allowUpperCase: true,
        ); // Android application IDs can contain uppercase characters
}

class ReverseDnsValidator implements Validator<String> {
  final List<String> reservedWords;
  final bool allowUpperCase;

  ReverseDnsValidator({
    this.reservedWords = const [], // Default to an empty list
    this.allowUpperCase = false, // Default to disallow uppercase
  });

  @override
  bool validate(String value) {
    var segments = value.split('.');

    if (segments.length < 2) {
      throw ValidationError(
          'Must have at least two segments separated by dots.');
    }

    for (var segment in segments) {
      if (!segment.contains(allowUpperCase
          ? RegExp(r'^[a-zA-Z0-9]+$')
          : RegExp(r'^[a-z0-9]+$'))) {
        throw ValidationError(
            'Each segment can only contain ${allowUpperCase ? "alphanumeric" : "lowercase alphanumeric"} characters.');
      }

      if (segment.startsWith(RegExp(r'[0-9]'))) {
        throw ValidationError('Each segment must not start with a number.');
      }

      if (_isReservedWord(segment)) {
        throw ValidationError('Contains reserved word: $segment.');
      }
    }

    return true;
  }

  bool _isReservedWord(String segment) {
    return reservedWords.contains(segment);
  }
}
