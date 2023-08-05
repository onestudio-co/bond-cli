import 'package:bond_cli/core/tasks/core/task.dart';
import 'package:native_project_manipulator/platforms/android/android.dart';

class FixImportTask extends Task<void> {
  final AndroidManager androidManager;
  final String appClassPath;
  final String oldPackageId;
  final String packageId;

  FixImportTask({
    required this.androidManager,
    required this.appClassPath,
    required this.oldPackageId,
    required this.packageId,
  });

  @override
  String get actionDescription =>
      'fix import $appClassPath packageId to $packageId,';

  @override
  Future<void> execute() async {
    await androidManager.replaceFileContent(
      appClassPath,
      'import $oldPackageId',
      'import $packageId',
    );
  }
}
