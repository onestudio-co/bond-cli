import 'package:args/command_runner.dart';
import 'add_command.dart';
import 'create_command.dart';
import 'update_command.dart';
import 'package:bond_cli/core/utils.dart';

class BondCommandRunner extends CommandRunner<void> {
  BondCommandRunner()
      : super(
          'bond',
          'A CLI tool for efficient Flutter Bond app development, streamlining tasks like project setup and package management.',
        ) {
    addCommand(CreateCommand());
    addCommand(UpdateCommand());
    addCommand(AddCommand());

    const asciiArt = '''
 ____   ___  _   _ ____  
| __ ) / _ \\| \\ | |  _ \\ 
|  _ \\| | | |  \\| | | | |
| |_) | |_| | |\\  | |_| |
|____/ \\___/|_| \\_|____/ 
''';

    const message =
        'Info from https://github.com/onestudio-co/flutter-bond: #FreePalestine 🇵🇸\n';
    ConsolePrinter.info(asciiArt);
    ConsolePrinter.info(message);
  }
}
