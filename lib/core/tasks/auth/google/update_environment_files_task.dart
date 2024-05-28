import 'dart:convert';
import 'dart:io';

import 'package:bond_cli/core/tasks/core/task.dart';

class UpdateEnvironmentFilesTask extends Task {
  @override
  String get actionDescription =>
      'Update env.json and env.staging.json with Google Sign-In variables.';

  @override
  Future<void> execute() async {
    final envFiles = ['env.json', 'env.staging.json'];
    final Map<String, String> variables = {
      'GOOGLE_CLIENT_ID': 'Your-Google-Client-ID',
      'GOOGLE_SCOPES': 'email,profile',
      'GOOGLE_SERVER_CLIENT_ID': 'Your-Google-Server-Client-ID',
      'GOOGLE_REVERSED_CLIENT_ID':
          'com.googleusercontent.apps.your-reversed-client-id'
    };

    for (var filePath in envFiles) {
      final file = File(filePath);
      if (file.existsSync()) {
        final content =
            json.decode(await file.readAsString()) as Map<String, dynamic>;
        content.addAll(variables);
        final encoder = JsonEncoder.withIndent('  ');
        final formattedContent = encoder.convert(content);
        await file.writeAsString(formattedContent);
        print('$filePath has been updated with Google Sign-In variables.');
      } else {
        throw Exception('Error: $filePath not found.');
      }
    }
  }
}
