import 'package:bond_cli/core/tasks/core/task.dart';
import 'package:native_project_manipulator/platforms/android/android.dart';

class UpdateApplicationIdTask extends Task<void> {
  final String applicationId;
  final AndroidManager androidManager;

  UpdateApplicationIdTask({
    required this.androidManager,
    required this.applicationId,
  });

  @override
  String get actionDescription => 'Update android application id :'
      '$applicationId';

  @override
  Future<void> execute() async {
    await androidManager.prepareEnv(
      applicationId: applicationId,
    );
  }
}
