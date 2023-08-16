import 'package:args/command_runner.dart';
import 'package:bond_cli/core/tasks.dart';
import 'package:bond_cli/core/utils.dart';
import 'package:bond_cli/core/validators.dart';

import '../stubs/model_template.dart';

class CreateModelCommand extends Command<void> {
  @override
  String get name => 'model';

  @override
  String get description => 'Create a new Model.';

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
    var modelName = argResults?['name'] as String?;
    var isJsonSerializable = argResults?['jsonSerializable'] as bool?;
    var isEquatable = argResults?['equatable'] as bool?;

    modelName ??= XInput.askValue(
      'Enter Model Name:',
      null,
      validators: [
        NonEmptyValidator(),
        PascalCaseValidator(),
        NotReservedWordValidator(),
      ],
    );

    isJsonSerializable ??= XInput.askYesNo(
      'Do you want to make the model JsonSerializable?',
      defaultAnswer: true,
    );

    isEquatable ??= XInput.askYesNo(
      'Do you want to make the model Equatable?',
      defaultAnswer: true,
    );

    await CreateModelTasks(
      modelName: modelName.toSnakeCase(),
      isJsonSerializable: isJsonSerializable,
      isEquatable: isEquatable,
      modelContent: modelStub(
        modelName.toSnakeCase(),
        isJsonSerializable,
        isEquatable,
      ),
    ).run();
  }
}
