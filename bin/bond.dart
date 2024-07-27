import 'package:bond_cli/commands/bond_command_runner.dart';
import 'package:bond_cli/core/utils.dart';


/// The entry point for the Bond CLI application.
///
/// This function is responsible for parsing command-line arguments and
/// executing the appropriate command. In case of an error, it will print
/// the error message to the console and rethrow the error.
///
/// To compile the Dart script into a standalone executable:
///
/// 1. Open your terminal or command prompt.
/// 2. Navigate to the directory containing your Dart project.
/// 3. Use the following command to compile the Dart script:
///
/// ```sh
/// dart compile exe bin/bond.dart -o bond_cli
/// ```
///
/// - `dart compile exe`: This command compiles the Dart script to an executable.
/// - `bin/bond.dart`: The path to the Dart script you want to compile.
/// - `-o bond_cli`: The output file name for the compiled executable.
///
/// To run the compiled executable:
///
/// 1. Ensure you are in the directory containing the `bond_cli` executable, or provide the full path to the executable.
/// 2. Use the following command to run the executable:
///
/// ```sh
/// ./bond_cli
/// ```
///
/// - `./bond_cli`: This runs the compiled executable. On Windows, you might need to use `bond_cli.exe` instead.
///
/// Example usage after running the executable:
///
/// ```sh
/// ./bond_cli <command> [arguments]
/// ```
///
/// - `<command>`: The specific command you want to run within your Bond CLI application.
/// - `[arguments]`: Any arguments or options you want to pass to the command.
///
void main(List<String> arguments) async {
  try {
    await BondCommandRunner().run(arguments);
  } catch (err) {
    ConsolePrinter.error(err.toString());
    rethrow;
  }
}
