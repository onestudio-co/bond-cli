import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:bond_cli/commands/bond_command_runner.dart';

void main(List<String> arguments) async {
  await BondCommandRunner().run(
    [
      'create',
      '--project_name',
      'my_project',
    ],
  ).catchError((error) {
    if (error is! UsageException) throw error;
    print(error);
    stderr.writeln(error.toString());
    exit(64); // Exit code 64 indicates a software error.
  });
}
