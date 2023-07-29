import 'dart:io';

import 'package:native_project_manipulator/platforms/flutter/flutter_manager.dart';
import 'package:interact/interact.dart';

import '../interact_helper.dart';

extension XFutterManager on FlutterManager {
  Future<void> setFlutterProps({
    required String appName,
    required Directory directory,
    required String projectName,
  }) async {
    final setupFlutterSpinners = MultiSpinner();

    final setupFlutterSpinner = setupFlutterSpinners.add(Spinner(
      icon: '✅',
      rightPrompt: (done) => done
          ? 'Setup $appName Flutter project successfully!'
          : 'Setup $appName Flutter project, please wait...',
    ));

    await setupFlutterSpinners.createAndRunSpinner(
      function: () => updateName(projectName),
      action: 'Update project name to $appName',
    );
    await setupFlutterSpinners.createAndRunSpinner(
      function: () => format(),
      action: 'Format $appName',
    );
    await setupFlutterSpinners.createAndRunSpinner(
      function: () => pubGet(),
      action: 'Flutter Pub get for $appName',
    );

    setupFlutterSpinner.done();
  }
}
