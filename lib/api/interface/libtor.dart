import 'package:stackmate_wallet/app/common/models/result_model.dart';

abstract class IStackMateTor {
  R<String> torStart({
    required String path,
    required String socks5Port,
    required String httpProxy,
  });

  R<String> torStatus({
    required String controlPort,
    required String controlKey,
  });

  R<String> torStop({
    required String controlPort,
    required String controlKey,
  });
}
