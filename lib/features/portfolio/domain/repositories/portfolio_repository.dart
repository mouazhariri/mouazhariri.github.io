import '../entities/portfolio_content.dart';

/// Contract for portfolio data access (lives in domain, impl in data).
abstract interface class PortfolioRepository {
  Future<PortfolioContent> getContent();
}