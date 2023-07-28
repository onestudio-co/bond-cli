import 'dart:io';

class ProjectCloner {
  Future<Directory> clone(String projectName) async {
    final gitUrl = 'https://github.com/onestudio-co/flutter-bond.git';
    final projectDir = Directory('${Directory.current}/$projectName');

    if (await projectDir.exists()) {
      throw Exception(
          'Project with this name already exists in current directory!');
    }

    final result = await Process.run('git', ['clone', gitUrl, projectName]);

    if (result.exitCode != 0) {
      throw Exception('Failed to clone project: ${result.stderr}');
    }

    return projectDir;
  }
}
