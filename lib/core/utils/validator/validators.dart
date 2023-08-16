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
