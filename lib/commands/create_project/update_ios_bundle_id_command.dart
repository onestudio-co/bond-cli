import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:bond_cli/core/tasks.dart';
import 'package:bond_cli/core/utils.dart';
import 'package:bond_cli/core/validators.dart';
import 'package:native_project_manipulator/platforms/ios/ios_manager.dart';

class UpdateIOSBundleIdCommand extends Command<void> {
  @override
  String get name => 'ios_bundle_id';

  @override
  String get description =>
      'Update the iOS bundle ID for each build configuration.';

  UpdateIOSBundleIdCommand() {
    argParser.addOption('bundleId',
        abbr: 'b', help: 'Specify the new bundle ID.');
  }

  @override
  void run() async {
    final bundleId = argResults?['bundleId'] as String? ??
        XInput.askValue(
          'Enter New iOS Bundle ID:',
          null,
          validators: [
            NonEmptyValidator(),
            IosBundleIdValidator(),
          ],
        );

    final projectDirectoryPath = Directory.current.path;
    final iosManager = IosManager(Directory('$projectDirectoryPath/ios'));

    for (final buildConfig in _getBuildConfigs()) {
      await UpdateBundleIdTask(
        iosManager: iosManager,
        bundleId: bundleId,
        buildConfig: buildConfig,
      ).execute();
    }
  }

  List<String> _getBuildConfigs() {
    return [
      'Debug Production',
      'Debug Staging',
      'Release Production',
      'Release Staging',
      'Profile Production',
      'Profile Staging',
    ];
  }
}
