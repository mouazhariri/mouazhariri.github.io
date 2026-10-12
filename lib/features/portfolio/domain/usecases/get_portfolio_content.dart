import '../entities/portfolio_content.dart';
import '../repositories/portfolio_repository.dart';

/// One business action: fetch the full portfolio content.
class GetPortfolioContent {
  const GetPortfolioContent(this._repository);

  final PortfolioRepository _repository;

  Future<PortfolioContent> call() => _repository.getContent();
}