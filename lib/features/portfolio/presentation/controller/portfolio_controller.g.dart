// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portfolio_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Loads the portfolio bundle and exposes it as [AsyncValue<PortfolioState>].

@ProviderFor(PortfolioController)
final portfolioControllerProvider = PortfolioControllerProvider._();

/// Loads the portfolio bundle and exposes it as [AsyncValue<PortfolioState>].
final class PortfolioControllerProvider
    extends $AsyncNotifierProvider<PortfolioController, PortfolioState> {
  /// Loads the portfolio bundle and exposes it as [AsyncValue<PortfolioState>].
  PortfolioControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'portfolioControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$portfolioControllerHash();

  @$internal
  @override
  PortfolioController create() => PortfolioController();
}

String _$portfolioControllerHash() =>
    r'2ddafee25d95e2db194e85e91c8005e67bfc2af3';

/// Loads the portfolio bundle and exposes it as [AsyncValue<PortfolioState>].

abstract class _$PortfolioController extends $AsyncNotifier<PortfolioState> {
  FutureOr<PortfolioState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<PortfolioState>, PortfolioState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<PortfolioState>, PortfolioState>,
              AsyncValue<PortfolioState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
