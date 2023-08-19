import 'package:args/command_runner.dart';
import 'package:bond_cli/core/tasks/create_feature/create_dto_task.dart';
import 'package:bond_cli/core/utils.dart';
import 'package:bond_cli/core/validators.dart';

import '../stubs/dto_template.dart';

class CreateDtoCommand extends Command<void> {
  @override
  String get name => 'dto';

  @override
  String get description => 'Create a new Data Transfer Object (DTO).';

  CreateDtoCommand() {
    argParser.addOption('name',
        abbr: 'n', help: 'Specify the name of the DTO.');
  }

  @override
  void run() async {
    var dtoName = argResults?['name'] as String?;

    dtoName ??= XInput.askValue(
      'Enter DTO Name:',
      null,
      validators: [NonEmptyValidator(), PascalCaseValidator()],
    );

    await CreateDtoTask(
      dtoName: dtoName,
      dtoContent: dtoStub(dtoName),
    ).run();
  }
}
