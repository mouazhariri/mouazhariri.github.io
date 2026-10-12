import 'package:flutter_test/flutter_test.dart';
import 'package:profile_page/features/portfolio/data/datasources/portfolio_local_data_source.dart';
import 'package:profile_page/features/portfolio/data/repositories/portfolio_repository_impl.dart';
import 'package:profile_page/features/portfolio/domain/entities/portfolio_content.dart';
import 'package:profile_page/features/portfolio/domain/entities/portfolio_enums.dart';

/// Data source that always fails, to verify error normalization.
class _ThrowingDataSource implements PortfolioLocalDataSource {
  const _ThrowingDataSource();

  @override
  Future<PortfolioContent> fetchContent() async =>
      throw const FormatException('malformed json');
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('PortfolioLocalDataSource', () {
    const dataSource = PortfolioLocalDataSource();

    test('parses every bundled asset into domain entities', () async {
      final content = await dataSource.fetchContent();

      // Profile
      expect(content.profile.name, 'Mouaz Hariri');
      expect(content.profile.monogram, 'MH');
      expect(content.profile.email, contains('@'));
      expect(content.profile.phoneLink, isNotEmpty);
      expect(content.profile.roleTitles, hasLength(3));
      expect(content.profile.stats, isNotEmpty);

      // Social links
      expect(content.socialLinks, hasLength(5));
      expect(
        content.socialLinks.map((l) => l.type),
        containsAll(<SocialLinkType>[
          SocialLinkType.github,
          SocialLinkType.linkedin,
          SocialLinkType.whatsapp,
          SocialLinkType.telegram,
          SocialLinkType.email,
        ]),
      );

      // Stats reflect the CV (20+ projects, 5+ clients).
      final statsByKey = {
        for (final s in content.profile.stats) s.labelKey: s.value,
      };
      expect(statsByKey['stats.projects'], 20);
      expect(statsByKey['stats.clients'], 5);

      // Project links target an exact store page, never a search page.
      final projectLinks = content.projects.expand((p) => p.links).toList();
      expect(projectLinks, isNotEmpty);
      expect(
        projectLinks.every((l) => !l.url.contains('/search?')),
        isTrue,
        reason: 'store links must point at a specific app, not a search page',
      );

      // Projects
      expect(content.projects, hasLength(19));
      expect(content.projects.every((p) => p.id.isNotEmpty), isTrue);
      expect(content.projects.every((p) => p.titleKey.isNotEmpty), isTrue);
      expect(content.projects.every((p) => p.tech.isNotEmpty), isTrue);

      // Services / skills / experience
      expect(content.services, hasLength(6));
      expect(content.skills, hasLength(8));
      expect(content.skills.every((s) => s.items.isNotEmpty), isTrue);
      expect(content.experience.where((e) => e.isEducation), hasLength(1));
      expect(content.experience.where((e) => !e.isEducation), hasLength(4));
    });
  });

  group('PortfolioRepositoryImpl', () {
    test('returns content from the data source', () async {
      const repository =
          PortfolioRepositoryImpl(PortfolioLocalDataSource());

      final content = await repository.getContent();

      expect(content.profile.name, 'Mouaz Hariri');
      expect(content.projects, isNotEmpty);
    });

    test('normalizes data-source errors into PortfolioLoadException', () async {
      const repository = PortfolioRepositoryImpl(_ThrowingDataSource());

      await expectLater(
        repository.getContent(),
        throwsA(isA<PortfolioLoadException>()),
      );
    });
  });
}