import 'dart:io';

import 'package:bond_cli/core/tasks/core/task.dart';

class IntegrateIosTask extends Task {
  @override
  String get actionDescription => 'Integrate Google Sign-In for iOS.';

  @override
  Future<void> execute() async {
    final iosPaths = ['ios/Runner/Info.plist'];

    for (var path in iosPaths) {
      final infoPlistFile = File(path);
      if (infoPlistFile.existsSync()) {
        var content = await infoPlistFile.readAsString();
        final googleSignInConfig = '''
<!-- Google Sign-in Section -->
<key>GIDClientID</key>
<string>\${GOOGLE_CLIENT_ID}</string>
<key>GIDServerClientID</key>
<string>\${GOOGLE_SERVER_CLIENT_ID}</string>
<key>CFBundleURLTypes</key>
<array>
  <dict>
    <key>CFBundleTypeRole</key>
    <string>Editor</string>
    <key>CFBundleURLSchemes</key>
    <array>
      <string>\${GOOGLE_REVERSED_CLIENT_ID}</string>
    </array>
  </dict>
</array>
<!-- End of the Google Sign-in Section -->
''';

        if (!content.contains('<key>GIDClientID</key>')) {
          content = content.replaceFirst(
              '</dict>\n</plist>', '$googleSignInConfig\n</dict>\n</plist>');
          await infoPlistFile.writeAsString(content);
        } else {
          print(
              'Info.plist at $path already contains Google Sign-In configuration.');
        }
      }
    }
  }
}
