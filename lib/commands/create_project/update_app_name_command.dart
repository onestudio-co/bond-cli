import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:bond_cli/core/tasks.dart';
import 'package:bond_cli/core/tasks/create_project/android/tasks/update_app_name_task_for_android.dart';
import 'package:bond_cli/core/utils.dart';
import 'package:bond_cli/core/validators.dart';
import 'package:native_project_manipulator/platforms/android/android.dart';
import 'package:native_project_manipulator/platforms/ios/ios_manager.dart';

class UpdateAppNameCommand extends Command<void> {
  @override
  String get name => 'updateAppName';

  @override
  String get description => 'Update the app name for iOS or Android.';

  UpdateAppNameCommand() {
    argParser.addOption('name', abbr: 'n', help: 'Specify the new app name.');
  }

  @override
  void run() async {
    /// appName is the new app name.
    var appName = argResults?['name'] as String?;

    /// If the user didn't specify the app name, ask for it.
    appName ??= XInput.askValue(
      'Enter New App Name:',
      null,
      validators: [
        NonEmptyValidator(),
      ],
    );

    // projectDirectory is the directory of the project.
    var projectDirectoryPath = Directory.current.path;

    /// Update the app name for iOS
    await UpdateIOSAppNameTaskForIOS(
      iosManager: IosManager(
        Directory(
          '$projectDirectoryPath/ios',
        ),
      ),
      appName: appName,
    ).execute();

    /// Update the app name for Android
    await UpdateAppNameTaskForAndroid(
      androidManager: AndroidManager(
        Directory(
          '$projectDirectoryPath/android',
        ),
      ),
      appName: appName,
    ).execute();
  }
}
