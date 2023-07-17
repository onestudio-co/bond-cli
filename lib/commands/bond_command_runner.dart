import 'package:args/command_runner.dart';
import 'package:bond_cli/commands/create_project/create_model_command.dart';
import 'package:bond_cli/commands/create_project/create_project_command.dart';

class BondCommandRunner extends CommandRunner<void> {
  BondCommandRunner()
      : super(
          'bond_cli',
          'A CLI tool for efficient Flutter Bond app development, streamlining tasks like project setup and package management.',
        ) {
    addCommand(CreateProjectCommand());
    addCommand(CreateModelCommand());
  }
}
