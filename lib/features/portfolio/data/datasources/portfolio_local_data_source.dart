import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import '../../domain/entities/experience_entity.dart';
import '../../domain/entities/portfolio_content.dart';
import '../../domain/entities/profile_entity.dart';
import '../../domain/entities/project_entity.dart';
import '../../domain/entities/service_entity.dart';
import '../../domain/entities/skill_entity.dart';
import '../../domain/entities/social_link_entity.dart';

/// Raw local I/O: reads the bundled JSON data files and decodes them into
/// domain entities. This is the only place that knows about assets/JSON.
class PortfolioLocalDataSource {
  const PortfolioLocalDataSource();

  static const String profileAsset = 'assets/data/profile.json';
  static const String socialAsset = 'assets/data/social.json';
  static const String projectsAsset = 'assets/data/projects.json';
  static const String servicesAsset = 'assets/data/services.json';
  static const String skillsAsset = 'assets/data/skills.json';
  static const String experienceAsset = 'assets/data/experience.json';

  Future<PortfolioContent> fetchContent() async {
    final profile = ProfileEntity.fromJson(await _readMap(profileAsset));
    final social = (await _readList(socialAsset))
        .map(SocialLinkEntity.fromJson)
        .toList();
    final projects = (await _readList(projectsAsset))
        .map(ProjectEntity.fromJson)
        .toList();
    final services = (await _readList(servicesAsset))
        .map(ServiceEntity.fromJson)
        .toList();
    final skills =
        (await _readList(skillsAsset)).map(SkillGroupEntity.fromJson).toList();
    final experience = (await _readList(experienceAsset))
        .map(ExperienceEntity.fromJson)
        .toList();

    return PortfolioContent(
      profile: profile,
      socialLinks: social,
      projects: projects,
      services: services,
      skills: skills,
      experience: experience,
    );
  }

  Future<Map<String, dynamic>> _readMap(String path) async {
    final raw = await rootBundle.loadString(path);
    return jsonDecode(raw) as Map<String, dynamic>;
  }

  Future<List<Map<String, dynamic>>> _readList(String path) async {
    final raw = await rootBundle.loadString(path);
    return (jsonDecode(raw) as List<dynamic>)
        .cast<Map<String, dynamic>>();
  }
}