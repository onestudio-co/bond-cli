import 'package:args/command_runner.dart';

import 'auth/google_auth/add_google_auth_command.dart';

class AddCommand extends Command {
  @override
  String get description => 'Add new integrations to your Flutter Bond app.';

  @override
  String get name => 'add';

  AddCommand() {
    addSubcommand(AddGoogleAuthCommand());
  }
}
