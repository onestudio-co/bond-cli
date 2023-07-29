import 'package:interact/interact.dart';

extension XInput on Input {
  static Future<String> askProjectName(
      String prompt, String defaultValue) async {
    return Input(
      prompt: prompt,
      defaultValue: defaultValue,
      validator: _containsSpecialChar,
    ).interact();
  }

  static Future<String> askBundleId(String prompt, String defaultValue) async {
    return Input(
      prompt: prompt,
      defaultValue: defaultValue,
      validator: _isValidBundleOrApplicationId,
    ).interact();
  }

  static Future<String> askApplicationId(
      String prompt, String defaultValue) async {
    return Input(
      prompt: prompt,
      defaultValue: defaultValue,
      validator: _isValidBundleOrApplicationId,
    ).interact();
  }

  static bool _containsSpecialChar(String input) {
    return RegExp(r'[\^$*+?.()|{}\[\]\\]').hasMatch(input);
  }

  static bool _isValidBundleOrApplicationId(String id) {
    return RegExp(r'^[a-zA-Z][a-zA-Z0-9]*(\.[a-zA-Z][a-zA-Z0-9]*)+$')
        .hasMatch(id);
  }
}

extension XSpinner on MultiSpinner {
  Future<void> createAndRunSpinner({
    String icon = '🎉',
    required Future<void> Function() function,
    required String action,
  }) async {
    final spinner = add(Spinner(
      icon: icon,
      rightPrompt: (done) =>
          done ? ' $action successfully!' : ' $action, please wait...',
    ));

    await function();
    spinner.done();
  }
}
