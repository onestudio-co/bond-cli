import 'dart:io';

import 'package:dependency_manipulator/platforms/android/android.dart';

extension XAndroidManager on AndroidManager {
  Future<void> setAndroidProps({
    required Directory androidDirectory,
    required String applicationId,
    required String appName,
  }) async {
    final androidManager = AndroidManager(androidDirectory);

    await androidManager.prepareEnv(
      appName: appName,
      applicationId: applicationId,
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

      await androidManager.updateManifestNode(
        type,
        manifestParentNode,
      );
    }

    final oldPackageId = 'ps.app.bond';
    final oldPackagePath = oldPackageId.replaceAll('.', '/');
    final newPackagePath = packageId.replaceAll('.', '/');
    final oldPath = '/app/src/main/kotlin/$oldPackagePath';
    final newPath = '/app/src/main/kotlin/$newPackagePath';
    await androidManager.renameDirectory(oldPath, newPath);
    final appClassPath = '/$newPath/MainActivity.kt';
    await androidManager.replaceFileContent(
      appClassPath,
      'package $oldPackageId',
      'package $packageId',
    );
  }

  String _reverseDomainName(String domainName) =>
      domainName.split('.').reversed.join('.');
}
