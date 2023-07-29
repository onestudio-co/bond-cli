import 'dart:io';

import 'package:dependency_manipulator/platforms/ios/ios_manager.dart';

extension XIosManager on IosManager {
  Future<void> setIosProps({
    required Directory iosDirectory,
    required String bundleId,
    required String appName,
  }) async {
    var iosManager = IosManager(iosDirectory);

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
      await iosManager.updateBundleId(bundleId + prefix, buildConfig);
    }
  }
}
