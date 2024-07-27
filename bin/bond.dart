import 'package:bond_cli/commands/bond_command_runner.dart';
import 'package:bond_cli/core/utils.dart';

void main(List<String> arguments) async {
  try {
    await BondCommandRunner().run(arguments);
  } catch (err) {
    ConsolePrinter.error(err.toString());
    rethrow;
  }
}
