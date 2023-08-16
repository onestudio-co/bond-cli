import 'package:bond_cli/core/tasks/core/task.dart';
import 'package:bond_cli/core/tasks/core/tasks.dart';
import 'package:native_project_manipulator/platforms/ios/ios_manager.dart';

import 'tasks/update_app_name_task_for_ios.dart';
import 'tasks/update_bundle_id_task.dart';

class SetupIosProjectTask extends Tasks {
  final IosManager iosManager;
  final String appName;
  final String bundleId;

  SetupIosProjectTask({
    required this.iosManager,
    required this.appName,
    required this.bundleId,
  });

  @override
  String get actionDescription => 'Setup $appName IOS project';

  @override
  List<Task> get tasks => [
        ...[
          'Debug Production',
          'Debug Staging',
          'Release Production',
          'Release Staging',
          'Profile Production',
          'Profile Staging',
        ].map(
          (e) => UpdateBundleIdTask(
            iosManager: iosManager,
            bundleId: bundleId,
            buildConfig: e,
          ),
        ),
        UpdateIOSAppNameTaskForIOS(
          iosManager: iosManager,
          appName: appName,
        ),
      ];
}
