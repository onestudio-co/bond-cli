import 'package:bond_cli/core/validators.dart';
import 'package:interact/interact.dart';

extension XInput on Input {
  static String askValue(
    String prompt,
    String? defaultValue,
    Validator<String>? validator,
  ) {
    return Input(
      prompt: prompt,
      defaultValue: defaultValue,
      validator: validator == null ? null : _wrapValidator(validator),
    ).interact();
  }

  static bool Function(String) _wrapValidator(Validator<String> validator) {
    return (String value) => validator.validate(value);
  }

  static bool askYesNo(String prompt, {required bool defaultAnswer}) {
    return Select(
                prompt: prompt,
                options: ['Yes', 'No'],
                initialIndex: defaultAnswer ? 0 : 1)
            .interact() ==
        0;
  }
}
