import 'package:flutter/services.dart';
import 'package:stackmate_wallet/app/common/cubits/logger_cubit.dart';
import 'package:stackmate_wallet/app/common/models/result_model.dart';
import 'package:stackmate_wallet/pkg/_locator.dart';
import 'package:stackmate_wallet/pkg/interface/vibrate.dart';

class Vibrate implements IVibrate {
  @override
  R<bool> vibe() {
    try {
      HapticFeedback.selectionClick();
      return const R(result: true);
    } catch (e, s) {
      locator<Logger>().logException(e, '', s);
      return R(error: e.toString());
    }
  }
}
