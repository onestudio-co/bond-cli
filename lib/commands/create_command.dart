import 'package:args/command_runner.dart';
import 'package:bond_cli/commands/create_project/create_project_command.dart';

import 'create_feature/commands/create_model_command.dart';

class CreateCommand extends Command {
  @override
  String get description => 'Creates a new Flutter Bond component';

  @override
  String get name => 'create';

  CreateCommand() {
    addSubcommand(CreateProjectCommand());
    addSubcommand(CreateModelCommand());
  }
}
