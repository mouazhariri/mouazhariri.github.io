import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../src/core/shared_widgets/animated_background.dart';
import '../../../../src/core/shared_widgets/app_error_widget.dart';
import '../../../../src/core/shared_widgets/app_loader.dart';
import '../../../../src/core/utils/functions/launch_utils.dart';
import '../../domain/entities/portfolio_enums.dart';
import '../controller/portfolio_controller.dart';
import '../controller/portfolio_state.dart';
import '../widgets/about_section.dart';
import '../widgets/contact_section.dart';
import '../widgets/experience_section.dart';
import '../widgets/footer_section.dart';
import '../widgets/hero_section.dart';
import '../widgets/nav_bar.dart';
import '../widgets/projects_section.dart';
import '../widgets/services_section.dart';
import '../widgets/skills_section.dart';

/// Section indices — order matters (used for nav + scroll-spy).
enum PortfolioSection { home, about, services, skills, experience, projects, contact }

/// Full single-page portfolio shell.
class PortfolioScreen extends ConsumerStatefulWidget {
  const PortfolioScreen({super.key});

  @override
  ConsumerState<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends ConsumerState<PortfolioScreen> {
  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<int> _activeSection = ValueNotifier<int>(0);
  late final List<GlobalKey> _sectionKeys;
  bool _scrolled = false;

  @override
  void initState() {
    super.initState();
    _sectionKeys = List.generate(PortfolioSection.values.length, (_) => GlobalKey());
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _activeSection.dispose();
    super.dispose();
  }

  void _onScroll() {
    final offset = _scrollController.offset;
    final scrolled = offset > 56;
    if (scrolled != _scrolled) setState(() => _scrolled = scrolled);

    final lineY = offset + MediaQuery.sizeOf(context).height * 0.42;
    var active = 0;
    for (var i = 0; i < _sectionKeys.length; i++) {
      final renderBox = _sectionKeys[i].currentContext?.findRenderObject() as RenderBox?;
      if (renderBox == null || !renderBox.hasSize) continue;
      final top = renderBox.localToGlobal(Offset.zero).dy;
      if (top <= lineY) active = i;
    }
    _activeSection.value = active;
  }

  void _scrollToSection(int index) {
    final context2 = _sectionKeys[index].currentContext;
    if (context2 == null) return;
    Scrollable.ensureVisible(
      context2,
      duration: const Duration(milliseconds: 900),
      curve: Curves.easeInOutCubic,
      alignment: index == PortfolioSection.home.index ? 0 : 0.12,
    );
  }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(portfolioControllerProvider);
    final content = async.value?.content;

    return Scaffold(
      body: Stack(
        children: [
          AnimatedBackground(
            child: async.when(
              loading: () => const AppLoader(),
              error: (error, _) => AppErrorWidget(
                message: error.toString(),
                onRetry: ref.read(portfolioControllerProvider.notifier).refresh,
              ),
              data: _buildContent,
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: NavBar(
              scrolled: _scrolled,
              activeSection: _activeSection,
              onNavigate: _scrollToSection,
              onHire: () {
                final link = (content?.socialLinks ?? const [])
                    .where((l) => l.type == SocialLinkType.whatsapp)
                    .firstOrNull;
                if (link != null) LaunchUtils.open(link.url);
              },
            ),
          ),
          Positioned(
            right: 24,
            bottom: 32,
            child: _BackToTopButton(
              visible: _activeSection.value > 0,
              onTap: () => _scrollToSection(PortfolioSection.home.index),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(PortfolioState state) {
    final content = state.content;
    if (content == null) return const AppLoader();

    return SingleChildScrollView(
      controller: _scrollController,
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          HeroSection(
            key: _sectionKeys[PortfolioSection.home.index],
            profile: content.profile,
            socialLinks: content.socialLinks,
            onContact: () => _scrollToSection(PortfolioSection.contact.index),
            onExplore: () => _scrollToSection(PortfolioSection.about.index),
          ),
          AboutSection(
            key: _sectionKeys[PortfolioSection.about.index],
            profile: content.profile,
          ),
          ServicesSection(
            key: _sectionKeys[PortfolioSection.services.index],
            services: content.services,
            onHire: () => _scrollToSection(PortfolioSection.contact.index),
          ),
          SkillsSection(
            key: _sectionKeys[PortfolioSection.skills.index],
            skills: content.skills,
          ),
          ExperienceSection(
            key: _sectionKeys[PortfolioSection.experience.index],
            experience: content.experience,
          ),
          ProjectsSection(
            key: _sectionKeys[PortfolioSection.projects.index],
            projects: content.projects,
          ),
          ContactSection(
            key: _sectionKeys[PortfolioSection.contact.index],
            profile: content.profile,
            socialLinks: content.socialLinks,
          ),
          FooterSection(
            onNavigate: _scrollToSection,
            socialLinks: content.socialLinks,
          ),
          const SizedBox(height: 48),
        ],
      ),
    );
  }
}

class _BackToTopButton extends StatelessWidget {
  const _BackToTopButton({required this.visible, required this.onTap});

  final bool visible;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: visible ? 1 : 0,
      duration: const Duration(milliseconds: 240),
      curve: Curves.easeOutBack,
      child: Material(
        color: Theme.of(context).colorScheme.primary,
        shape: const CircleBorder(),
        elevation: 8,
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onTap,
          child: const Padding(
            padding: EdgeInsets.all(12),
            child: Icon(
              Icons.arrow_upward_rounded,
              color: Colors.white,
              size: 22,
            ),
          ),
        ),
      ),
    );
  }
}