import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:bond_cli/commands/create_project/helpers/platforms/android_manager_helper.dart';
import 'package:bond_cli/commands/create_project/helpers/platforms/flutter_manager_helper.dart';
import 'package:bond_cli/commands/create_project/helpers/platforms/ios_manager_helper.dart';
import 'package:bond_cli/utils/interact_helper.dart';
import 'package:native_project_manipulator/platforms/android/android_manager.dart';
import 'package:native_project_manipulator/platforms/flutter/flutter_manager.dart';
import 'package:native_project_manipulator/platforms/ios/ios_manager.dart';

import 'helpers/project_cloner.dart';

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

    projectName ??= await XInput.askProjectName(
      'Enter Project Name:',
      'my_dream_project',
    );
    iosBundleId ??= await XInput.askBundleId(
      'Enter IOS Bundle Id:',
      'sa.bond.com',
    );
    androidApplicationId ??= await XInput.askApplicationId(
      'Enter Android Application Id:',
      'sa.bond.com',
    );

    final appName = projectName.replaceAll(' ', '_').toLowerCase();

    final projectCloner = ProjectCloner();
    final projectDirectory = await projectCloner.clone(projectName);

    final iosDirectory = Directory('${projectDirectory.path}/ios');
    final iosManager = IosManager(iosDirectory);
    await iosManager.setIosProps(
      iosDirectory: iosDirectory,
      bundleId: iosBundleId,
      appName: appName,
    );

    final androidDirectory = Directory('${projectDirectory.path}/android');
    final androidManager = AndroidManager(androidDirectory);
    await androidManager.setAndroidProps(
      androidDirectory: androidDirectory,
      applicationId: androidApplicationId,
      appName: appName,
    );

    final flutterManager = FlutterManager(
      projectDirectory,
      printToConsole: false,
    );
    await flutterManager.setFlutterProps(
      appName: appName,
      directory: projectDirectory,
      projectName: projectName,
    );
  }
}
