import 'package:freezed_annotation/freezed_annotation.dart';

part 'recovered_key_model.g.dart';
part 'recovered_key_model.freezed.dart';

@freezed
class RecoveredKey with _$RecoveredKey {
  const factory RecoveredKey({
    String? seed,
    String? root,
    String? fingerprint,
    String? network,
  }) = _RecoveredKey;

  factory RecoveredKey.fromJson(Map<String, dynamic> json) =>
      _$RecoveredKeyFromJson(json);
}
