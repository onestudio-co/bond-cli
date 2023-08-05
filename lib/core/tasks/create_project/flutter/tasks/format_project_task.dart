import 'package:bond_cli/core/tasks/core/task.dart';
import 'package:native_project_manipulator/platforms/flutter/flutter.dart';

class FormatProjectTask extends Task<void> {
  final FlutterManager flutterManager;
  final String appName;

  FormatProjectTask({
    required this.flutterManager,
    required this.appName,
  });

  @override
  String get actionDescription => 'format project $appName';

  @override
  Future<void> execute() async {
    await flutterManager.format();
  }
}
