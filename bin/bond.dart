import 'dart:io';

import 'package:bond_cli/commands/bond_command_runner.dart';

//  dart compile exe bin/bond.dart -o bond_cli
// /Users/salahamassi/FlutterProjects/plugins/bond_cli/bond_cli
void main(List<String> arguments) async {
  // await BondCommandRunner().run(
  //   [
  //     'create_model',
  //     '--name',
  //     'post',
  //   ],
  // ).catchError((error) {
  //   if (error is! UsageException) throw error;
  //   stderr.writeln(error);
  //   stderr.writeln(error.toString());
  //   exit(64); // Exit code 64 indicates a software error.
  // });
  try {
    await BondCommandRunner().run(arguments);
  } catch (err) {
    stderr.writeln(err.toString());
    rethrow;
  }
}
