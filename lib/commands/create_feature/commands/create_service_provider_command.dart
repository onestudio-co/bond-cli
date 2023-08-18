import 'package:args/command_runner.dart';
import 'package:bond_cli/core/tasks/create_feature/create_service_provider_task.dart';
import 'package:bond_cli/core/utils.dart';
import 'package:bond_cli/core/validators.dart';

import '../stubs/service_provider_template.dart';

class CreateServiceProviderCommand extends Command<void> {
  @override
  String get name => 'service_provider';

  @override
  String get description => 'Create a new Service Provider.';

  CreateServiceProviderCommand() {
    argParser.addOption(
      'name',
      abbr: 'n',
      help: 'Specify the name of the service provider.',
    );
  }

  @override
  void run() async {
    var serviceProviderName = argResults?['name'] as String?;

    serviceProviderName ??= XInput.askValue(
      'Enter Service Provider Name:',
      null,
      validators: [
        NonEmptyValidator(),
        PascalCaseValidator(),
        NotReservedWordValidator(),
      ],
    );

    await CreateServiceProviderTask(
      serviceProviderName: serviceProviderName,
      serviceProviderContent: serviceProviderStub(serviceProviderName),
    ).run();
  }
}
