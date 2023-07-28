import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:bond_cli/commands/create_project/helpers/android_manager_helper.dart';
import 'package:bond_cli/commands/create_project/helpers/ios_manager_helper.dart';
import 'package:dependency_manipulator/platforms/android/android_manager.dart';
import 'package:dependency_manipulator/platforms/flutter/flutter_manager.dart';
import 'package:dependency_manipulator/platforms/ios/ios_manager.dart';

import 'helpers/interact_helper.dart';
import 'helpers/project_cloner.dart';

class CreateProjectCommand extends Command {
  @override
  String get description => 'Creates a new Flutter Bond project';

  @override
  String get name => 'create';

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
      'Enter project name:',
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
    final directory = await projectCloner.clone(projectName);


    print('directory path: ${directory.path}');
    final flutterManager =
        FlutterManager(File('${directory.path}/pubspec.yaml'));
    await flutterManager.updateName(projectName);
    await flutterManager.format();
    await flutterManager.pubGet();

    final iosPath = '${directory.path}/ios';
    final iosManager = IosManager(Directory(iosPath));
    await iosManager.setIosProps(
      iosDirectory: Directory(iosPath),
      bundleId: iosBundleId,
      appName: appName,
    );

    final androidManager =
        AndroidManager(Directory('${directory.path}/android'));
    await androidManager.setAndroidProps(
      androidDirectory: Directory('${directory.path}/android'),
      applicationId: androidApplicationId,
      appName: appName,
    );
  }
}
