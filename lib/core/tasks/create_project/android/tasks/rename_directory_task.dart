import 'package:bond_cli/core/tasks/core/task.dart';
import 'package:native_project_manipulator/platforms/android/android.dart';

class RenameDirectoryTask extends Task<void> {
  final AndroidManager androidManager;
  final String oldPath;
  final String newPath;

  RenameDirectoryTask({
    required this.androidManager,
    required this.oldPath,
    required this.newPath,
  });

  @override
  String get actionDescription =>
      'Update $oldPath to $newPath in android project';

  @override
  Future<void> execute() async {
    await androidManager.renameDirectory(oldPath, newPath);
  }
}
