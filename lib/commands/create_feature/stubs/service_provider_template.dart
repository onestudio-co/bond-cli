import 'package:bond_cli/core/utils.dart';

String serviceProviderStub(String serviceProviderName) {
  return '''
import 'package:bond_core/bond_core.dart';
import 'package:get_it/get_it.dart';

class ${serviceProviderName.toTitleCase()}ServiceProvider extends ServiceProvider {
  @override
  Future<void> register(GetIt it) async {
    /// TODO: implement register
  }

  @override
  T? responseConvert<T>(Map<String, dynamic> json) {
    /// TODO: implement responseConvert
    return null;
  }
}
''';
}
