import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'node_model.freezed.dart';
part 'node_model.g.dart';

@freezed
class Node with _$Node {
  @HiveType(typeId: 3, adapterName: 'NodeClassAdapter')
  const factory Node({
    @HiveField(1) required String address,
    @HiveField(2) required String name,
  }) = _Node;
  const Node._();

  factory Node.fromJson(Map<String, dynamic> json) => _$NodeFromJson(json);
}
