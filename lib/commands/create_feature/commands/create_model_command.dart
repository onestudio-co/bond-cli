import 'package:args/command_runner.dart';
import 'package:bond_cli/utils/command_runner.dart';
import 'package:bond_cli/utils/file_utils.dart';
import 'package:bond_cli/utils/interact_helper.dart';
import 'package:bond_cli/utils/print_utils.dart';
import 'package:bond_cli/utils/string_extensions.dart';
import 'package:interact/interact.dart';

import '../stubs/model_template.dart';

class CreateModelCommand extends Command<void> {
  @override
  final name = 'model';
  @override
  final description = 'Create a new Model.';

  CreateModelCommand() {
    /// Add an option to specify the name of the model.
    argParser
      ..addOption('name', abbr: 'n', help: 'Specify the name of the model.')

      /// Add a flag to specify if the model should be JsonSerializable.
      ..addFlag(
        'jsonSerializable',
        abbr: 'j',
        help: 'Generate code for Json Serialization',
        negatable: false,
      )

      /// Add a flag to specify if the model should be Equatable.
      ..addFlag(
        'equatable',
        abbr: 'e',
        help: 'Make the model equatable',
        negatable: false,
      );
  }

  @override
  void run() async {
    // Add a spinner to show progress
    final createModelSpinner = MultiSpinner();

    // Get the model name from command arguments.
    var modelName = argResults?['name'];
    modelName ??= XInput.askModelName(
      'Enter Model Name:',
    );

    if (modelName == null || (modelName as String).isEmpty) {
      ConsolePrinter.error('Model name is required.');
      return;
    }

    // Validate the model name
    if (!modelName.isValidModelName()) {
      ConsolePrinter.error(
        'Invalid model name. Model name should be in PascalCase. e.g. User or UserDetail',
      );
      return;
    }

    modelName = modelName.toSnakeCase();
    final createdModel = createModelSpinner.add(
      Spinner(
        icon: '📦',
        rightPrompt: (done) => done
            ? 'Model $modelName created successfully'
            : 'Creating $modelName model...',
      ),
    );

    final bool isJsonSerializable = argResults?['jsonSerializable'] == true;
    final bool isEquatable = argResults?['equatable'] == true;

    // Define the paths.
    final modelDirectoryPath = 'lib/$modelName/data/models/';
    final modelFilePath = '$modelDirectoryPath$modelName.dart';

    // Create the directories if they don't exist.
    await createModelSpinner.createAndRunSpinner(
      function: () => createNewDirectory(modelDirectoryPath),
      action: 'Create directory: $modelDirectoryPath',
    );

    // Generate content based on templates
    String modelContent = modelStub(
      modelName,
      isJsonSerializable,
      isEquatable,
    );

    // Create the model file.
    await createModelSpinner.createAndRunSpinner(
      function: () => createNewFile(modelFilePath, modelContent),
      action: 'Create file: $modelFilePath',
    );

    // Run the build runner to generate the model.g.dart file.
    await createModelSpinner.createAndRunSpinner(
      function: () => CommandRunnerHelper.runBuildRunner(modelDirectoryPath),
      action: 'Run build runner to generate the $modelName.g.dart file.',
    );

    createdModel.done();
  }
}
