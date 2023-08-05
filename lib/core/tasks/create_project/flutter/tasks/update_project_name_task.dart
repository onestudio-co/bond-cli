import 'package:bond_cli/core/tasks/core/task.dart';
import 'package:native_project_manipulator/platforms/flutter/flutter.dart';

class UpdateProjectNameTask extends Task<void> {
  final FlutterManager flutterManager;
  final String projectName;

  UpdateProjectNameTask({
    required this.flutterManager,
    required this.projectName,
  });

  @override
  String get actionDescription => 'Update project name to $projectName';

  @override
  Future<void> execute() async {
    await flutterManager.updateName(projectName);
  }
}
