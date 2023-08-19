import 'package:bond_cli/core/tasks/core/task.dart';
import 'package:bond_cli/core/tasks/core/tasks.dart';
import 'package:bond_cli/core/utils.dart';

import 'common_tasks/create_directory_task.dart';
import 'common_tasks/create_file_task.dart';

class CreateDtoTask extends Tasks {
  final String dtoName;
  final String dtoContent;

  CreateDtoTask({
    required this.dtoName,
    required this.dtoContent,
  });

  @override
  String get actionDescription => 'Creating $dtoName DTO';

  @override
  List<Task> get tasks {
    final dtoDirectoryPath = 'lib/data/dto/';
    final dtoFilePath = '$dtoDirectoryPath${dtoName.toSnakeCase()}.dart';
    return [
      CreateDirectoryTask(dtoDirectoryPath),
      CreateFileTask(dtoFilePath, dtoContent),
    ];
  }
}
