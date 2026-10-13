import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../src/core/localization/current_language.dart';
import '../../../../src/core/shared_widgets/app_button.dart';
import '../../../../src/core/utils/extensions/context_extension.dart';
import '../../../../src/core/utils/theme/app_theme.dart';
import '../../../../src/core/utils/theme/theme_controller.dart';

/// Top navigation bar: glass, scroll-aware, responsive (drawer on compact).
class NavBar extends ConsumerWidget {
  const NavBar({
    super.key,
    required this.scrolled,
    required this.activeSection,
    required this.onNavigate,
    required this.onHire,
  });

  final bool scrolled;
  final ValueListenable<int> activeSection;
  final ValueChanged<int> onNavigate;
  final VoidCallback onHire;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final useMenu = !context.isExpanded;
    final labels = [
      context.tr('nav.home'),
      context.tr('nav.about'),
      context.tr('nav.services'),
      context.tr('nav.skills'),
      context.tr('nav.experience'),
      context.tr('nav.projects'),
      context.tr('nav.contact'),
    ];

    return ValueListenableBuilder<int>(
      valueListenable: activeSection,
      builder: (context, active, _) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: scrolled
                ? (context.isDarkMode
                    ? Theme.of(context).colorScheme.surface.withValues(alpha: 0.7)
                    : Colors.white.withValues(alpha: 0.75))
                : Colors.transparent,
            border: scrolled
                ? Border(
                    bottom: BorderSide(
                      color: context.isDarkMode
                          ? Colors.white10
                          : Colors.black.withValues(alpha: 0.06),
                    ),
                  )
                : null,
          ),
          child: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1200),
                  child: Row(
                    children: [
                      Expanded(child: _Brand(onTap: () => onNavigate(0))),
                      if (useMenu)
                        IconButton(
                          tooltip: 'Menu',
                          onPressed: () => _openMenu(context),
                          icon: const Icon(Icons.menu_rounded),
                        )
                      else ...[
                        for (var i = 0; i < labels.length; i++)
                          _NavItem(
                            label: labels[i],
                            active: active == i,
                            onTap: () => onNavigate(i),
                          ),
                        const SizedBox(width: 6),
                        _ThemeToggle(ref: ref),
                        _LanguageToggle(ref: ref),
                        const SizedBox(width: 8),
                        AppButton(
                          label: context.tr('nav.hireMe'),
                          icon: Icons.chat_rounded,
                          onPressed: onHire,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _openMenu(BuildContext context) {
    showGeneralDialog<void>(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'menu',
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 360),
      pageBuilder: (context, animation, secondaryAnimation) => _MobileMenu(
        onNavigate: (index) {
          Navigator.of(context).pop();
          onNavigate(index);
        },
      ),
    );
  }
}

class _Brand extends StatelessWidget {
  const _Brand({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 40,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: AppGradients.brand,
            ),
            child: const Text(
              'MH',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 15,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Flexible(
            child: Text(
              'Mouaz Hariri',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.3,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatefulWidget {
  const _NavItem({required this.label, required this.active, required this.onTap});

  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          margin: const EdgeInsets.symmetric(horizontal: 2),
          padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 9),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: widget.active || _hover
                ? AppGradients.brand
                : null,
            color: widget.active || _hover ? null : Colors.transparent,
          ),
          child: Text(
            widget.label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: widget.active ? FontWeight.w700 : FontWeight.w500,
              color: widget.active || _hover
                  ? Colors.white
                  : (context.isDarkMode ? Colors.white70 : const Color(0xFF334155)),
            ),
          ),
        ),
      ),
    );
  }
}

class _ThemeToggle extends ConsumerWidget {
  const _ThemeToggle({required this.ref});

  final WidgetRef ref;

  @override
  Widget build(BuildContext context, WidgetRef _) {
    final mode = ref.watch(themeControllerProvider);
    final isDark = mode == ThemeMode.dark;
    return IconButton(
      tooltip: isDark ? 'Light mode' : 'Dark mode',
      onPressed: () => ref.read(themeControllerProvider.notifier).toggle(),
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (child, anim) =>
            RotationTransition(turns: anim, child: FadeTransition(opacity: anim, child: child)),
        child: Icon(
          isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
          key: ValueKey(isDark),
        ),
      ),
    );
  }
}

class _LanguageToggle extends ConsumerWidget {
  const _LanguageToggle({required this.ref});

  final WidgetRef ref;

  @override
  Widget build(BuildContext context, WidgetRef _) {
    final isArabic = ref.watch(currentLanguageProvider) == 'ar';
    return IconButton(
      tooltip: isArabic ? 'English' : 'العربية',
      onPressed: () {
        final next = isArabic ? 'en' : 'ar';
        // The locale is owned by the provider; `main.dart` keys
        // `EasyLocalization` by it, so this alone switches the language.
        ref.read(currentLanguageProvider.notifier).setLanguage(next);
      },
      icon: Text(
        isArabic ? 'EN' : 'ع',
        style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
      ),
    );
  }
}

/// Full-screen animated menu used on compact widths.
class _MobileMenu extends StatelessWidget {
  const _MobileMenu({required this.onNavigate});

  final ValueChanged<int> onNavigate;

  @override
  Widget build(BuildContext context) {
    final items = [
      ('nav.home', Icons.home_rounded),
      ('nav.about', Icons.person_rounded),
      ('nav.services', Icons.design_services_rounded),
      ('nav.skills', Icons.psychology_rounded),
      ('nav.experience', Icons.work_rounded),
      ('nav.projects', Icons.folder_rounded),
      ('nav.contact', Icons.mail_rounded),
    ];

    return Align(
      alignment: AlignmentDirectional.topEnd,
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: MediaQuery.sizeOf(context).width * 0.85,
          constraints: const BoxConstraints(maxWidth: 400),
          padding: const EdgeInsets.fromLTRB(28, 94, 28, 40),
          decoration: BoxDecoration(
            color: context.isDarkMode
                ? Theme.of(context).colorScheme.surface.withValues(alpha: 0.94)
                : Colors.white.withValues(alpha: 0.96),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(28),
              bottomLeft: Radius.circular(28),
            ),
            boxShadow: [
              BoxShadow(color: Colors.black.withValues(alpha: 0.25), blurRadius: 40),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              for (var i = 0; i < items.length; i++)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(14),
                      onTap: () => onNavigate(i),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 13),
                        child: Row(
                          children: [
                            Icon(items[i].$2, size: 20, color: Theme.of(context).colorScheme.primary),
                            const SizedBox(width: 14),
                            Text(
                              context.tr(items[i].$1),
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ).animate().fadeIn(duration: 300.ms).slideX(begin: 0.06, end: 0),
        ),
      ),
    );
  }
}