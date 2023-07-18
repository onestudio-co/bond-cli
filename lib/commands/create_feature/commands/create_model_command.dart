import 'package:args/command_runner.dart';
import 'package:bond_cli/utils/file_utils.dart';
import 'package:bond_cli/utils/print_utils.dart';

import '../stubs/model_template.dart';

class CreateModelCommand extends Command<void> {
  @override
  final name = 'create_model';
  @override
  final description = 'Create a new Model.';

  CreateModelCommand() {
    argParser.addOption('name',
        abbr: 'n', help: 'Specify the name of the model.');
  }

  @override
  void run() async {
    // Get the model name from command arguments.
    final String? modelName = argResults?['name'];
    if (modelName == null) {
      ConsolePrinter.error('Model name is required.');
      return;
    }

    // Define the paths.
    final modelDirectoryPath = '$modelName/data/models/';
    final modelFilePath = '$modelDirectoryPath$modelName.dart';

    // Create the directories if they don't exist.
    bool dirCreated = await createNewDirectory(modelDirectoryPath);
    if (dirCreated) {
      ConsolePrinter.success('Created directory: $modelDirectoryPath');
    }

    // Generate content based on templates
    final modelContent = modelStub(modelName: modelName);

    // Create the model file.
    bool fileCreated = await createNewFile(modelFilePath, modelContent);
    if (fileCreated) {
      ConsolePrinter.success('Created file: $modelFilePath');
    }
  }
}
