import 'package:bond_cli/core/tasks/core/task.dart';
import 'package:bond_cli/core/tasks/core/tasks.dart';
import 'package:bond_cli/core/utils.dart';

import 'common_tasks/create_directory_task.dart';
import 'common_tasks/create_file_task.dart';

class CreateWidgetTask extends Tasks {
  final String widgetName;
  final String widgetType;
  final String widgetContent;

  CreateWidgetTask({
    required this.widgetName,
    required this.widgetType,
    required this.widgetContent,
  });

  @override
  String get actionDescription => 'Creating $widgetName widget';

  @override
  List<Task> get tasks {
    final widgetDirectoryPath = 'lib/presentation/widgets/';
    final widgetFilePath =
        '$widgetDirectoryPath${widgetName.toSnakeCase()}.dart';
    return [
      CreateDirectoryTask(widgetDirectoryPath),
      CreateFileTask(widgetFilePath, widgetContent),
    ];
  }
}
