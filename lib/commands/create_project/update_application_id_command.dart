import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:bond_cli/core/tasks/create_project/android/tasks/update_application_id_task.dart';
import 'package:bond_cli/core/utils.dart';
import 'package:bond_cli/core/validators.dart';
import 'package:native_project_manipulator/platforms/android/android.dart';

class UpdateApplicationIdCommand extends Command<void> {
  @override
  String get name => 'android_app_id';

  @override
  String get description => 'Update the Android application ID.';

  UpdateApplicationIdCommand() {
    argParser.addOption('applicationId',
        abbr: 'a', help: 'Specify the new Android application ID.');
  }

  @override
  void run() async {
    var applicationId = argResults?['applicationId'] as String?;

    applicationId ??= XInput.askValue(
      'Enter New Android Application ID:',
      null,
      validators: [
        NonEmptyValidator(),
        AndroidAppIdValidator(),
      ],
    );

    final projectDirectoryPath = Directory.current.path;
    final androidManager =
        AndroidManager(Directory('$projectDirectoryPath/android'));

    await UpdateApplicationIdTask(
      androidManager: androidManager,
      applicationId: applicationId,
    ).execute();
  }
}
