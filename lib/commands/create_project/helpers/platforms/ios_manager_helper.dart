import 'dart:io';

import 'package:bond_cli/utils/interact_helper.dart';
import 'package:interact/interact.dart';
import 'package:native_project_manipulator/platforms/ios/ios_manager.dart';

extension XIosManager on IosManager {
  Future<void> setIosProps({
    required Directory iosDirectory,
    required String bundleId,
    required String appName,
  }) async {
    final setupIosSpinners = MultiSpinner();

    final setupIosSpinner = setupIosSpinners.add(Spinner(
      icon: '✅',
      rightPrompt: (done) => done
          ? 'Setup $appName IOS project successfully!'
          : 'Setup $appName IOS project, please wait...',
    ));

    final buildConfigurations = [
      'Debug Production',
      'Debug Staging',
      'Release Production',
      'Release Staging',
      'Profile Production',
      'Profile Staging',
    ];

    for (final buildConfig in buildConfigurations) {
      var prefix = '';
      if (buildConfig.contains('Staging')) {
        prefix = '.staging';
      }
      await setupIosSpinners.createAndRunSpinner(
        function: () => updateBundleId(bundleId + prefix, buildConfig),
        action: 'Update $appName IOS bundleId to '
            '${bundleId + prefix} for $buildConfig',
      );
    }

    await setupIosSpinners.createAndRunSpinner(
      function: () => updateAppName(appName),
      action: 'Update IOS app name to $appName',
    );

    setupIosSpinner.done();
  }
}
