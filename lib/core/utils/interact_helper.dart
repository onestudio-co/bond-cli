import 'package:interact/interact.dart';

extension XInput on Input {
  static String askValue(
    String prompt,
    String? defaultValue,
    bool Function(String)? validator,
  ) {
    return Input(
      prompt: prompt,
      defaultValue: defaultValue,
      validator: validator,
    ).interact();
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
