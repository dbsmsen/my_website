import 'package:flutter/material.dart';

class Skill {
  final String name;
  final String category;
  final double proficiency; // 0.0 to 1.0
  final String? icon;
  final Color? color;

  Skill({
    required this.name,
    required this.category,
    required this.proficiency,
    this.icon,
    this.color,
  });
}

class SkillCategory {
  final String name;
  final List<Skill> skills;
  final IconData icon;

  SkillCategory({required this.name, required this.skills, required this.icon});
}
