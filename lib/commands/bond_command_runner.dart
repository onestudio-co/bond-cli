import 'package:args/command_runner.dart';
import 'package:bond_cli/commands/create_command.dart';

import 'update_command.dart';

class BondCommandRunner extends CommandRunner<void> {
  BondCommandRunner()
      : super(
          'bond',
          'A CLI tool for efficient Flutter Bond app development, streamlining tasks like project setup and package management.',
        ) {
    addCommand(CreateCommand());
    addCommand(UpdateCommand());
  }
}
