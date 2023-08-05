import 'package:bond_cli/core/tasks/core/task.dart';
import 'package:native_project_manipulator/platforms/android/android.dart';

class UpdateManifestNodeTask extends Task<void> {
  final AndroidManager androidManager;
  final String packageId;
  final String type;

  UpdateManifestNodeTask({
    required this.androidManager,
    required this.packageId,
    required this.type,
  });

  @override
  String get actionDescription =>
      'Update $type manifest with application: $packageId';

  @override
  Future<void> execute() async {
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
    await androidManager.updateManifestNode(type, manifestParentNode);
  }
}
