import 'package:args/command_runner.dart';
import 'package:bond_cli/core/tasks/create_feature/create_widget_task.dart';
import 'package:bond_cli/core/utils.dart';
import 'package:bond_cli/core/validators.dart';

import '../stubs/widget_template.dart';

class CreateWidgetCommand extends Command<void> {
  @override
  String get name => 'widget';

  @override
  String get description => 'Create a new Widget.';

  CreateWidgetCommand() {
    argParser
      ..addOption('name', abbr: 'n', help: 'Specify the name of the widget.')
      ..addOption('type',
          abbr: 't',
          help:
              'Specify the type of the widget. Options: [stateless, stateful, consumer]',
          defaultsTo: 'stateless');
  }

  @override
  void run() async {
    var widgetName = argResults?['name'] as String?;
    var widgetType = argResults?['type'] as String?;

    widgetName ??= XInput.askValue(
      'Enter Widget Name:',
      null,
      validators: [
        NonEmptyValidator(),
        PascalCaseValidator(),
      ],
    );

    widgetType ??= XInput.askList<String>(
      'Select widget type:',
      ['stateless', 'stateful', 'consumer'],
      defaultAnswer: 'stateless',
    );

    await CreateWidgetTask(
      widgetName: widgetName,
      widgetType: widgetType,
      widgetContent: widgetStub(widgetName, widgetType),
    ).run();
  }
}
