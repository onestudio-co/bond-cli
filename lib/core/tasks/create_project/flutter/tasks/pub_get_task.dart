import 'package:bond_cli/core/tasks/core/task.dart';
import 'package:native_project_manipulator/platforms/flutter/flutter.dart';

class PubGetTask extends Task<void> {
  final FlutterManager flutterManager;
  final String appName;

  PubGetTask({
    required this.flutterManager,
    required this.appName,
  });

  @override
  String get actionDescription => 'Flutter Pub get for $appName';

  @override
  Future<void> execute() async {
    await flutterManager.pubGet();
  }
}
