import 'package:freezed_annotation/freezed_annotation.dart';
part 'master_key_model.freezed.dart';
part 'master_key_model.g.dart';

@freezed
class MasterKey with _$MasterKey {
  const factory MasterKey({
    String? seed,
    String? root,
    String? fingerprint,
    String? network,
    bool? backedUp,
  }) = _MasterKey;

  factory MasterKey.fromJson(Map<String, dynamic> json) =>
      _$MasterKeyFromJson(json);
}
