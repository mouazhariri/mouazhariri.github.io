import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/portfolio_content.dart';
import '../../domain/repositories/portfolio_repository.dart';
import '../datasources/portfolio_local_data_source.dart';

part 'portfolio_repository_impl.g.dart';

/// Concrete repository — normalizes any data-source errors into a typed
/// [PortfolioLoadException] so presentation never sees raw JSON errors.
class PortfolioRepositoryImpl implements PortfolioRepository {
  const PortfolioRepositoryImpl(this._dataSource);

  final PortfolioLocalDataSource _dataSource;

  @override
  Future<PortfolioContent> getContent() async {
    try {
      return await _dataSource.fetchContent();
    } on PortfolioLoadException {
      rethrow;
    } catch (error, stackTrace) {
      throw PortfolioLoadException(error, stackTrace);
    }
  }
}

/// Typed failure thrown when the portfolio content cannot be loaded.
class PortfolioLoadException implements Exception {
  const PortfolioLoadException(this.cause, this.stackTrace);

  final Object cause;
  final StackTrace stackTrace;

  @override
  String toString() => 'PortfolioLoadException: $cause';
}

@Riverpod(keepAlive: true)
PortfolioRepository portfolioRepository(Ref ref) =>
    const PortfolioRepositoryImpl(PortfolioLocalDataSource());