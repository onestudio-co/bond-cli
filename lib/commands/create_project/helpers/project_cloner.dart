import 'dart:io';

import 'package:interact/interact.dart';

class ProjectCloner {
  Future<Directory> clone(String projectName) async {
    final cloning = Spinner(
      icon: '✅',
      rightPrompt: (done) => done
          ? 'Project cloned successfully!'
          : 'Cloning project, please wait...',
    ).interact();

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

    cloning.done();

    return projectDirectory;
  }
}
