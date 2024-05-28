import 'package:args/command_runner.dart';
import 'package:bond_cli/core/tasks/auth/add_google_auth_task.dart';
import 'package:bond_cli/core/tasks/auth/google/check_firebase_integration_task.dart';
import 'package:native_project_manipulator/util/console.dart';

class AddGoogleAuthCommand extends Command {
  @override
  String get name => 'google_auth';

  @override
  String get description =>
      'Automates the process of adding Google Sign-In to a Flutter app.';

  AddGoogleAuthCommand();

  @override
  void run() async {
    final firebaseIntegrated = await CheckFirebaseIntegrationTask().execute();
    if (!firebaseIntegrated) {
      printError(
        'Firebase is not integrated. Please integrate Firebase first.',
      );
      return;
    }
    await AddGoogleAuthTask().run();
  }
}
