import 'package:bond_cli/core/tasks/core/task.dart';
import 'package:bond_cli/core/tasks/core/tasks.dart';

import 'common_tasks/create_directory_task.dart';
import 'common_tasks/create_file_task.dart';
import 'common_tasks/run_build_runner_task.dart';

class CreateModelTasks extends Tasks {
  final String modelName;
  final String modelContent;
  final bool isJsonSerializable;
  final bool isEquatable;

  CreateModelTasks({
    required this.modelName,
    required this.modelContent,
    required this.isJsonSerializable,
    required this.isEquatable,
  });

  @override
  String get actionDescription => 'Creating $modelName model';

  @override
  List<Task> get tasks {
    final modelDirectoryPath = 'lib/$modelName/data/models/';
    final modelFilePath = '$modelDirectoryPath$modelName.dart';
    return [
      CreateDirectoryTask(modelDirectoryPath),
      CreateFileTask(modelFilePath, modelContent),
      RunBuildRunnerTask(modelDirectoryPath, modelName),
    ];
  }
}
