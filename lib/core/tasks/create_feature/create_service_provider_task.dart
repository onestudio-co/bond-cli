import 'package:bond_cli/core/tasks/core/task.dart';
import 'package:bond_cli/core/tasks/core/tasks.dart';

import 'common_tasks/create_directory_task.dart';
import 'common_tasks/create_file_task.dart';

class CreateServiceProviderTask extends Tasks {
  final String serviceProviderName;
  final String serviceProviderContent;

  CreateServiceProviderTask({
    required this.serviceProviderName,
    required this.serviceProviderContent,
  });

  @override
  String get actionDescription =>
      'Creating $serviceProviderName service provider';

  @override
  List<Task> get tasks {
    final serviceProviderDirectoryPath = 'lib/$serviceProviderName/';
    final serviceProviderFilePath =
        '$serviceProviderDirectoryPath${serviceProviderName}_service_provider.dart';
    return [
      CreateDirectoryTask(serviceProviderDirectoryPath),
      CreateFileTask(serviceProviderFilePath, serviceProviderContent),
    ];
  }
}
