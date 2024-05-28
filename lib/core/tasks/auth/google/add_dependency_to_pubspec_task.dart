import 'dart:io';

import 'package:bond_cli/core/tasks/core/task.dart';

class AddDependencyToPubspecTask extends Task {
  @override
  String get actionDescription =>
      'Add google_sign_in dependency to pubspec.yaml.';

  @override
  Future<void> execute() async {
    final pubspecPath = 'pubspec.yaml';
    final pubspecFile = File(pubspecPath);

    if (!pubspecFile.existsSync()) {
      print('Error: pubspec.yaml not found.');
      return;
    }

    final content = pubspecFile.readAsStringSync();
    if (!content.contains('google_sign_in:')) {
      final updatedContent = content.replaceFirst(
        'dependencies:',
        'dependencies:\n  google_sign_in: ^6.2.1',
      );
      pubspecFile.writeAsStringSync(updatedContent);
      print('google_sign_in dependency has been added to pubspec.yaml.');
    } else {
      print('google_sign_in dependency already exists in pubspec.yaml.');
    }
  }
}
