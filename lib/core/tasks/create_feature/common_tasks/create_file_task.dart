import 'dart:io';

import 'package:bond_cli/core/tasks/core/task.dart';

class CreateFileTask extends Task<void> {
  final String path;
  final String content;

  CreateFileTask(this.path, this.content);

  @override
  String get actionDescription => 'Create file: $path';

  @override
  Future<void> execute() async {
    final file = File(path);
    await file.create(recursive: true);
    await file.writeAsString(content);
  }
}
