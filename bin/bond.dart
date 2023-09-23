import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:bond_cli/core/tasks/github_example/command/GithubExampleCommand.dart';

//  dart compile exe bin/bond.dart -o bond_cli
// /Users/salahamassi/FlutterProjects/plugins/bond_cli/bond_cli
void main(List<String> arguments) async {
  final app = CommandRunner('bond', 'Bond CLI Description')
    ..addCommand(MySampleCommand());
  app.run(arguments);
}
