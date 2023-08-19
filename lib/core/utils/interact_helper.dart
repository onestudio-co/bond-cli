import 'package:bond_cli/core/validators.dart';
import 'package:interact/interact.dart';

extension XInput on Input {
  static String askValue(
    String prompt,
    String? defaultValue, {
    required List<Validator<String>> validators,
  }) {
    return Input(
      prompt: prompt,
      defaultValue: defaultValue,
      validator: _checkValidation(validators),
    ).interact();
  }

  static bool Function(String) _checkValidation(
    List<Validator<String>> validators,
  ) {
    final composite = CompositeValidator<String>(validators);
    return (input) => composite.validate(input);
  }

  static bool askYesNo(String prompt, {required bool defaultAnswer}) {
    return Select(
                prompt: prompt,
                options: ['Yes', 'No'],
                initialIndex: defaultAnswer ? 0 : 1)
            .interact() ==
        0;
  }

  static T askList<T>(
    String prompt,
    List<T> list, {
    required T defaultAnswer,
  }) {
    int index = Select(
      prompt: prompt,
      options: list.map((item) => item.toString()).toList(),
      initialIndex: list.indexOf(defaultAnswer),
    ).interact();

    return list[index];
  }
}
