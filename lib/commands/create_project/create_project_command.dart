import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:bond_cli/core/tasks.dart';
import 'package:bond_cli/core/utils.dart';
import 'package:bond_cli/core/validators.dart';
import 'package:native_project_manipulator/platforms/android/android_manager.dart';
import 'package:native_project_manipulator/platforms/flutter/flutter_manager.dart';
import 'package:native_project_manipulator/platforms/ios/ios_manager.dart';

class CreateProjectCommand extends Command {
  @override
  String get description => 'Creates a new Flutter Bond project';

  @override
  String get name => 'project';

  CreateProjectCommand() {
    argParser.addOption(
      'projectName',
      help: 'Name of the new project',
      valueHelp: 'my_dream_project',
    );
    argParser.addOption(
      'bundleId',
      help: 'IOS Bundle Id of the new project',
      valueHelp: 'sa.bond.com',
    );
    argParser.addOption(
      'applicationId',
      help: 'Android Application Id of the new project',
      valueHelp: 'sa.bond.com',
    );
  }

  @override
  void run() async {
    var projectName = argResults?['projectName'];
    var iosBundleId = argResults?['bundleId'];
    var androidApplicationId = argResults?['applicationId'];

    projectName ??= XInput.askValue(
      'Enter Project Name:',
      'my_dream_project',
      validators: [
        ProjectNameValidator(),
      ],
    );

    iosBundleId ??= XInput.askValue(
      'Enter IOS Bundle Id:',
      'sa.bond.com',
      validators: [
        BundleIdOrApplicationIdValidator(isIOS: true),
      ],
    );

    androidApplicationId ??= XInput.askValue(
      'Enter Android Application Id:',
      'sa.bond.com',
      validators: [
        BundleIdOrApplicationIdValidator(isIOS: false),
      ],
    );

    final appName = projectName.replaceAll(' ', '_').toLowerCase();

    final projectDirectory = await ProjectCloningTask(
      projectName: projectName,
    ).run();

    await SetupIosProjectTask(
      iosManager: IosManager(
        Directory(
          '${projectDirectory.path}/ios',
        ),
      ),
      bundleId: iosBundleId,
      appName: appName,
    ).run();

    await SetupAndroidProjectTask(
      androidManager: AndroidManager(
        Directory('${projectDirectory.path}/android'),
      ),
      appName: appName,
      applicationId: androidApplicationId,
    ).run();

    await SetupFlutterProjectTask(
      flutterManager: FlutterManager(
        projectDirectory,
        printToConsole: false,
      ),
      appName: appName,
      projectName: projectName,
    ).run();
  }
}
