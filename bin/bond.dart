import 'dart:io';

import 'package:bond_cli/commands/bond_command_runner.dart';
import 'package:bond_cli/core/tasks/github_example/command/github_example_command.dart';

//  dart compile exe bin/bond.dart -o bond_cli
// /Users/salahamassi/FlutterProjects/plugins/bond_cli/bond_cli
void main(List<String> arguments) async {
  try {
    final app = BondCommandRunner()..addCommand(GithubExampleCommand());
    app.run(arguments);
  } catch (err) {
    stderr.writeln(err.toString());
  }
}
