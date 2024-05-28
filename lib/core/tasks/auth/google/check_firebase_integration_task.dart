import 'dart:io';

import 'package:bond_cli/core/tasks/core/task.dart';

class CheckFirebaseIntegrationTask extends Task<bool> {
  @override
  String get actionDescription => 'Check Firebase integration.';

  @override
  Future<bool> execute() async {
    final androidPaths = [
      'android/app/google-services.json',
      'android/app/src/production/google-services.json',
      'android/app/src/staging/google-services.json',
    ];

    final iosPaths = [
      'ios/Runner/GoogleService-Info.plist',
      'ios/Runner/production/GoogleService-Info.plist',
      'ios/Runner/staging/GoogleService-Info.plist',
    ];

    final androidIntegrated =
        androidPaths.any((path) => File(path).existsSync());
    final iosIntegrated = iosPaths.any((path) => File(path).existsSync());

    return androidIntegrated && iosIntegrated;
  }
}
