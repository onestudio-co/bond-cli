import 'dart:developer';
import 'dart:io';

import 'package:args/command_runner.dart';

class CreateProjectCommand extends Command {
  @override
  String get description => 'Creates a new Flutter Bond project';

  @override
  String get name => 'create';

  CreateProjectCommand() {
    argParser.addOption('project_name',
        abbr: 'n', help: 'Name of the new project');
  }

  @override
  void run() async {
    // Access the project_name argument
    var projectName = argResults?['project_name'];
    log('projectName $projectName');
  }
}
