import 'dart:io';

import 'package:bond_cli/commands/bond_command_runner.dart';

void main(List<String> arguments) async {
  try {
    await BondCommandRunner().run(
      [
        'create',
        '--project_name',
        'my_project',
      ],
    );
  } catch (err) {
    stderr.writeln(err.toString());
    rethrow;
  }
}
