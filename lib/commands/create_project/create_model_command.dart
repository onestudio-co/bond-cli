import 'dart:io';

import 'package:args/command_runner.dart';

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
    final modelName = argResults?['name'];
    if (modelName == null) {
      print('Model name is required.');
      return;
    }

    // Define the paths.
    final modelDirectoryPath = '$modelName/data/models/';
    final modelFilePath = '$modelDirectoryPath$modelName.dart';
    final generatedFilePath = '$modelDirectoryPath$modelName.g.dart';

    // Create the directories if they don't exist.
    final modelDirectory = Directory(modelDirectoryPath);
    if (!modelDirectory.existsSync()) {
      modelDirectory.createSync(recursive: true);
    }

    // Read templates and generate model content
    final modelTemplateContent =
        await File('lib/stubs/model_template.dart').readAsString();
    final genModelTemplateContent =
        await File('lib/stubs/model_gen_template.dart').readAsString();

    final modelContent = modelTemplateContent
        .replaceAll('{0}', modelName)
        .replaceAll('{1}', toCamelCase(modelName));
    final genModelContent = genModelTemplateContent
        .replaceAll('{0}', modelName)
        .replaceAll('{1}', toCamelCase(modelName));

    // Create the model file.
    final modelFile = File(modelFilePath);
    if (!modelFile.existsSync()) {
      modelFile.createSync();
      await modelFile.writeAsString(modelContent);
    }

    // Create the generated model file.
    final generatedFile = File(generatedFilePath);
    if (!generatedFile.existsSync()) {
      generatedFile.createSync();
      await generatedFile.writeAsString(genModelContent);
    }
  }

  // Converts a string to CamelCase.
  String toCamelCase(String str) {
    return str[0].toUpperCase() + str.substring(1);
  }
}
