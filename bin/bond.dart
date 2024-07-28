import 'package:bond_cli/commands/bond_command_runner.dart';
import 'package:bond_cli/core/utils.dart';

void main(List<String> arguments) async {
  if (arguments.contains('--help')) {
    // ignore_for_file: avoid_print
    ConsolePrinter.warning(
        '------------------------------------------------------------------');
    ConsolePrinter.warning(
      '⚠️ You are running a local development version of BOND CLI. ⚠️',
    );
    ConsolePrinter.warning(
        '------------------------------------------------------------------');
    ConsolePrinter.warning('');
  }
  try {
    await BondCommandRunner().run(arguments);
  } catch (err) {
    ConsolePrinter.error(err.toString());
    rethrow;
  }
}
