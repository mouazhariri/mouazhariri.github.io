import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repositories/portfolio_repository_impl.dart';
import '../../domain/usecases/get_portfolio_content.dart';
import 'portfolio_state.dart';

part 'portfolio_controller.g.dart';

/// Loads the portfolio bundle and exposes it as [AsyncValue<PortfolioState>].
@riverpod
class PortfolioController extends _$PortfolioController {
  @override
  FutureOr<PortfolioState> build() => _load();

  Future<PortfolioState> _load() async {
    final content = await GetPortfolioContent(
      ref.read(portfolioRepositoryProvider),
    ).call();
    return PortfolioState(content: content);
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_load);
  }
}