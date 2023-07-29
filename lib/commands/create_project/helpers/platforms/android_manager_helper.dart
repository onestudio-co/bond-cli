import 'dart:io';

import 'package:native_project_manipulator/platforms/android/android.dart';
import 'package:interact/interact.dart';

import '../interact_helper.dart';

extension XAndroidManager on AndroidManager {
  Future<void> setAndroidProps({
    required Directory androidDirectory,
    required String applicationId,
    required String appName,
  }) async {
    final setupAndroidSpinners = MultiSpinner();

    final setupAndroid = setupAndroidSpinners.add(Spinner(
      icon: '✅',
      rightPrompt: (done) => done
          ? 'Setup $appName Android project successfully!'
          : 'Setup $appName Android project, please wait...',
    ));

    final androidManager = AndroidManager(androidDirectory);

    await setupAndroidSpinners.createAndRunSpinner(
      function: () => androidManager.prepareEnv(
        appName: appName,
        applicationId: applicationId,
      ),
      action: 'Update $appName android project with '
          'applicationId: $applicationId and appName: $appName',
    );

    final types = ['main', 'debug', 'profile'];

    final packageId = _reverseDomainName(applicationId);
    for (final type in types) {
      final manifest = androidManager.getManifest(type);
      final manifestParentNode = manifest.filterByName('manifest').first;
      final newProps = manifestParentNode.props
        ..remove(
          manifestParentNode.props.firstWhere(
            (element) => element.key == 'package',
          ),
        )
        ..add(
          ManifestProp(
            'package',
            packageId,
          ),
        );
      manifestParentNode.props = newProps;

      await setupAndroidSpinners.createAndRunSpinner(
        function: () => androidManager.updateManifestNode(
          type,
          manifestParentNode,
        ),
        action: 'Update $type manifest with packageId: $packageId',
      );
    }

    final oldPackageId = 'ps.app.bond';
    final oldPackagePath = oldPackageId.replaceAll('.', '/');
    final newPackagePath = packageId.replaceAll('.', '/');
    final oldPath = '/app/src/main/kotlin/$oldPackagePath';
    final newPath = '/app/src/main/kotlin/$newPackagePath';

    await setupAndroidSpinners.createAndRunSpinner(
      function: () => androidManager.renameDirectory(oldPath, newPath),
      action: 'Update $oldPath to $newPath',
    );
    final appClassPath = '/$newPath/MainActivity.kt';

    await setupAndroidSpinners.createAndRunSpinner(
      function: () => androidManager.replaceFileContent(
        appClassPath,
        'package $oldPackageId',
        'package $packageId',
      ),
      action: 'Update $appClassPath packageId to $packageId',
    );
    setupAndroid.done();
  }

  String _reverseDomainName(String domainName) =>
      domainName.split('.').reversed.join('.');
}
