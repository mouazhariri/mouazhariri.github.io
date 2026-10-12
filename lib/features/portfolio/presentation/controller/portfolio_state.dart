import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/portfolio_content.dart';

part 'portfolio_state.freezed.dart';

/// Controller state — content plus a page-level async marker.
@freezed
abstract class PortfolioState with _$PortfolioState {
  const factory PortfolioState({
    PortfolioContent? content,
    @Default(AsyncData<void>(null)) AsyncValue<void> pageState,
  }) = _PortfolioState;

  const PortfolioState._();

  bool get isLoading => pageState.isLoading;
  bool get hasError => pageState.hasError;
  bool get isReady => content != null && !hasError;
}