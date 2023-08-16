import 'package:args/command_runner.dart';
import 'package:bond_cli/commands/create_project/update_app_name_command.dart';

import 'create_project/update_application_id_command.dart';
import 'create_project/update_ios_bundle_id_command.dart';

class UpdateCommand extends Command {
  @override
  String get description => 'Update an exist Flutter Bond component';

  @override
  String get name => 'update';

  UpdateCommand() {
    addSubcommand(UpdateAppNameCommand());
    addSubcommand(UpdateIOSBundleIdCommand());
    addSubcommand(UpdateApplicationIdCommand());
  }
}
