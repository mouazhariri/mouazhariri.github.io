import 'experience_entity.dart';
import 'profile_entity.dart';
import 'project_entity.dart';
import 'service_entity.dart';
import 'skill_entity.dart';
import 'social_link_entity.dart';

/// Aggregate returned by the portfolio repository — everything the UI needs
/// in one immutable bundle.
class PortfolioContent {
  const PortfolioContent({
    required this.profile,
    required this.socialLinks,
    required this.projects,
    required this.services,
    required this.skills,
    required this.experience,
  });

  final ProfileEntity profile;
  final List<SocialLinkEntity> socialLinks;
  final List<ProjectEntity> projects;
  final List<ServiceEntity> services;
  final List<SkillGroupEntity> skills;
  final List<ExperienceEntity> experience;

  /// Jobs (timeline) and education entries.
  List<ExperienceEntity> get jobs =>
      experience.where((e) => !e.isEducation).toList();

  List<ExperienceEntity> get education =>
      experience.where((e) => e.isEducation).toList();
}