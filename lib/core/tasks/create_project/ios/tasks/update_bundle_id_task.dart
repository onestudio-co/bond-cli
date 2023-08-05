import 'package:bond_cli/core/tasks/core/task.dart';
import 'package:native_project_manipulator/platforms/ios/ios_manager.dart';

class UpdateBundleIdTask extends Task<void> {
  final IosManager iosManager;
  final String bundleId;
  final String buildConfig;

  UpdateBundleIdTask({
    required this.iosManager,
    required this.bundleId,
    required this.buildConfig,
  });

  @override
  String get actionDescription =>
      'Update IOS bundleId to $bundleId for $buildConfig';

  @override
  Future<void> execute() async {
    var prefix = '';
    if (buildConfig.contains('Staging')) {
      prefix = '.staging';
    }
    await iosManager.updateBundleId(bundleId + prefix, buildConfig);
  }
}
