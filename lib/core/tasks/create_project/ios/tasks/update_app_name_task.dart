import 'package:bond_cli/core/tasks/core/task.dart';
import 'package:native_project_manipulator/platforms/ios/ios_manager.dart';

class UpdateAppNameTask extends Task<void> {
  final IosManager iosManager;
  final String appName;

  UpdateAppNameTask({
    required this.iosManager,
    required this.appName,
  });

  @override
  String get actionDescription => 'Update IOS app name to $appName';

  @override
  Future<void> execute() async {
    await iosManager.updateAppName(appName);
  }
}
