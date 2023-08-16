import 'package:bond_cli/core/tasks/core/task.dart';
import 'package:bond_cli/core/tasks/core/tasks.dart';
import 'package:native_project_manipulator/platforms/android/android.dart';

import 'tasks/fix_import_task.dart';
import 'tasks/rename_directory_task.dart';
import 'tasks/update_app_name_task_for_android.dart';
import 'tasks/update_application_id_task.dart';
import 'tasks/update_manifest_node_task.dart';

class SetupAndroidProjectTask extends Tasks {
  final AndroidManager androidManager;
  final String appName;
  final String applicationId;

  SetupAndroidProjectTask({
    required this.androidManager,
    required this.appName,
    required this.applicationId,
  });

  @override
  String get actionDescription => 'Setup android project '
      'appName to: $appName, applicationId to: $applicationId';

  @override
  List<Task> get tasks => [
        UpdateAppNameTaskForAndroid(
          androidManager: androidManager,
          appName: appName,
        ),
        UpdateApplicationIdTask(
          androidManager: androidManager,
          applicationId: applicationId,
        ),
        ...['main', 'debug', 'profile'].map(
          (e) => UpdateManifestNodeTask(
            androidManager: androidManager,
            packageId: _packageId,
            type: e,
          ),
        ),
        RenameDirectoryTask(
          androidManager: androidManager,
          oldPath: _oldPath,
          newPath: _newPath,
        ),
        FixImportTask(
          androidManager: androidManager,
          oldPackageId: oldPackageId,
          appClassPath: '$_newPath/MainActivity.kt',
          packageId: _packageId,
        ),
      ];

  String get _packageId => _reverseDomainName(applicationId);

  String get _oldPackagePath => oldPackageId.replaceAll('.', '/');

  String get _newPackagePath => _packageId.replaceAll('.', '/');

  String get _oldPath => '/app/src/main/kotlin/$_oldPackagePath';

  String get _newPath => '/app/src/main/kotlin/$_newPackagePath';

  String get oldPackageId => 'ps.app.bond'; // TODO: get from android manager

  String _reverseDomainName(String domainName) =>
      domainName.split('.').reversed.join('.');
}
