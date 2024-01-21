import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:stackmate_wallet/app/common/cubits/logger_cubit.dart';
import 'package:stackmate_wallet/app/common/models/blockchain_model.dart';
import 'package:stackmate_wallet/pkg/interface/storage.dart';
import 'package:stackmate_wallet/pkg/storage.dart';

part 'chain_select_cubit.freezed.dart';

@freezed
class BlockchainState with _$BlockchainState {
  const factory BlockchainState({
    @Default(Blockchain.main) Blockchain blockchain,
  }) = _BlockchainState;
}

class ChainSelectCubit extends Cubit<BlockchainState> {
  ChainSelectCubit(
    this._storage,
    this._logger,
  ) : super(const BlockchainState());

  final IStorage _storage;
  final Logger _logger;

  void init() async {
    final blockchain =
        _storage.getFirstItem<Blockchain>(StoreKeys.Blockchain.name);
    if (blockchain.hasError) {
      if (blockchain.error! == 'empty') {
        emit(const BlockchainState());
        await Future.delayed(const Duration(milliseconds: 50));
      } else
        return;
    } else {
      emit(BlockchainState(blockchain: blockchain.result!));
      await Future.delayed(const Duration(milliseconds: 50));
    }
  }

  void changeBlockchain(Blockchain blockchain) async {
    try {
      emit(BlockchainState(blockchain: blockchain));
      await _storage.saveItemAt<Blockchain>(
        StoreKeys.Blockchain.name,
        0,
        blockchain,
      );
      await Future.delayed(const Duration(milliseconds: 200));
    } catch (e, s) {
      _logger.logException(e, 'BlockchainCubit.changeBlockchain', s);
    }
  }
}
