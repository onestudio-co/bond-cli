import 'package:bond_network/bond_network.dart';
import 'package:json_annotation/json_annotation.dart';

part '{0}_model.g.dart';

@JsonSerializable(explicitToJson: true)
class {1} extends Model {
  const {1}({
    required int id,
  }) : super(id: id);

  factory {1}.fromJson(Map<String, dynamic> json) => _${1}FromJson(json);

  @override
  Map<String, dynamic> toJson() => _${1}ToJson(this);

  @override
  List<Object?> get props => [id];
}
