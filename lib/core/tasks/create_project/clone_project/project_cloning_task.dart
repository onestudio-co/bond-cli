import 'dart:io';

import 'package:bond_cli/core/tasks/core/task.dart';
import 'package:meta/meta.dart';

class ProjectCloningTask extends Task<Directory> {
  final String projectName;

  ProjectCloningTask({
    required this.projectName,
  });

  @override
  String get actionDescription => 'Cloning project from github...';

  @protected
  @override
  Future<Directory> execute() async {
    final gitUrl = 'https://github.com/onestudio-co/flutter-bond.git';
    final projectDirectory =
        Directory('${Directory.current.path}/$projectName');

    if (await projectDirectory.exists()) {
      throw Exception(
          'Project with this name already exists in current directory!');
    }

    final result = await Process.run('git', ['clone', gitUrl, projectName]);

    if (result.exitCode != 0) {
      throw Exception('Failed to clone project: ${result.stderr}');
    }

    final gitDir = Directory('${projectDirectory.path}/.git');
    if (await gitDir.exists()) {
      await gitDir.delete(recursive: true);
    }
    await Process.run('git', ['init'], workingDirectory: projectDirectory.path);
    await Process.run('git', ['add', '.'],
        workingDirectory: projectDirectory.path);

    return projectDirectory;
  }
}
