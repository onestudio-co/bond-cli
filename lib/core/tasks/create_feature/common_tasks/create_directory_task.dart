import 'dart:io';

import 'package:bond_cli/core/tasks/core/task.dart';

class CreateDirectoryTask extends Task<void> {
  final String path;

  CreateDirectoryTask(this.path);

  @override
  String get actionDescription => 'Create directory: $path';

  @override
  Future<void> execute() async {
    final directory = Directory(path);
    await directory.create(recursive: true);
  }
}
