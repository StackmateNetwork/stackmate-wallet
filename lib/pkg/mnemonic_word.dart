import 'package:flutter/services.dart' show rootBundle;
import 'package:stackmate_wallet/app/common/models/result_model.dart';

class MnemonicWords {
  Future<R<List<String>?>> loadWordList() async {
    try {
      final i = await rootBundle.loadString('assets/bip39_english.txt');
      final words = i.split('\n');
      return R(result: words);
    } catch (e) {
      return R(error: e.toString());
    }
  }
}
