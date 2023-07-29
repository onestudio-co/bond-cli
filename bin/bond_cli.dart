import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:bond_cli/commands/bond_command_runner.dart';

void main(List<String> arguments) async {
  await BondCommandRunner().run(
    [
      'create_model',
      '--name',
      'post',
      '--jsonSerializable',
    ],
  ).catchError((error) {
    if (error is! UsageException) throw error;
    stderr.writeln(error);
    stderr.writeln(error.toString());
    exit(64); // Exit code 64 indicates a software error.
  });
  try {
    await BondCommandRunner().run(
      [
        'create',
        '--projectName',
        'fahman',
        '--bundleId',
        'sa.fahman.ai',
        '--applicationId',
        'sa.fahman.ai',
      ],
    );
  } catch (err) {
    stderr.writeln(err.toString());
    rethrow;
  }
}
