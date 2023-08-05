import 'dart:io';

import 'package:bond_cli/commands/bond_command_runner.dart';

//  dart compile exe bin/bond.dart -o bond_cli
// /Users/salahamassi/FlutterProjects/plugins/bond_cli/bond_cli
void main(List<String> arguments) async {
  try {
    await BondCommandRunner().run(arguments);
  } catch (err) {
    stderr.writeln(err.toString());
    rethrow;
  }
}
