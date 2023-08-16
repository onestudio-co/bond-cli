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
