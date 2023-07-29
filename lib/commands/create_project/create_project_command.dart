import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:bond_cli/commands/create_project/helpers/android_manager_helper.dart';
import 'package:bond_cli/commands/create_project/helpers/ios_manager_helper.dart';
import 'package:dependency_manipulator/platforms/android/android_manager.dart';
import 'package:dependency_manipulator/platforms/flutter/flutter_manager.dart';
import 'package:dependency_manipulator/platforms/ios/ios_manager.dart';
import 'package:interact/interact.dart';

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

    final cloning = Spinner(
      icon: '✅',
      rightPrompt: (done) => done
          ? 'Project cloned successfully!'
          : 'Cloning project, please wait...',
    ).interact();

    final projectCloner = ProjectCloner();
    final directory = await projectCloner.clone(projectName);
    cloning.done();

    final setupFlutter = Spinner(
      icon: '✅',
      rightPrompt: (done) => done
          ? 'Setup $appName project successfully!'
          : 'Setup $appName project, please wait...',
    ).interact();

    final flutterManager = FlutterManager(directory, printToConsole: false);
    await flutterManager.updateName(projectName);
    await flutterManager.format();
    await flutterManager.pubGet();

    setupFlutter.done();

    final setupIos = Spinner(
      icon: '✅',
      rightPrompt: (done) => done
          ? 'Setup ios project successfully!'
          : 'Setup ios project, please wait...',
    ).interact();

    final iosDirectory = Directory('${directory.path}/ios');
    final iosManager = IosManager(iosDirectory);
    await iosManager.setIosProps(
      iosDirectory: iosDirectory,
      bundleId: iosBundleId,
      appName: appName,
    );
    setupIos.done();

    final setupAndroid = Spinner(
      icon: '✅',
      rightPrompt: (done) => done
          ? 'Setup android project successfully!'
          : 'Setup android project, please wait...',
    ).interact();

    final androidDirectory = Directory('${directory.path}/android');
    final androidManager = AndroidManager(androidDirectory);
    await androidManager.setAndroidProps(
      androidDirectory: androidDirectory,
      applicationId: androidApplicationId,
      appName: appName,
    );
    setupAndroid.done();
  }
}
