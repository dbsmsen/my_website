import 'package:flutter/material.dart';
import 'package:my_website/models/skill.dart';
import 'package:my_website/models/experience.dart';

class PortfolioData {
  static const String name = 'Debsoomonto Sen';
  static const String title = 'A Computer Science Engineer';
  static const String subtitle =
      'Passionate about creating innovative digital solutions';
  static const String email = 'sendebsoomonto7149@gmail.com';
  static const String location = 'Jamshedpur, Jharkhand';

  static const String aboutMe = '''
I'm a passionate Full Stack Developer with expertise in modern web technologies and mobile development. 
I love creating user-friendly applications that solve real-world problems. With a strong foundation in 
both frontend and backend development, I enjoy working on projects that challenge me to learn and grow.

When I'm not coding, you can find me exploring new technologies, contributing to open-source projects, 
or sharing knowledge with the developer community.
''';

  static const String githubUrl = 'https://github.com/dbsmsen';
  static const String linkedinUrl = 'https://linkedin.com/in/dbsmsen';
  static const String twitterUrl = 'https://twitter.com/dbsmsen';
  static const String instagramUrl = 'https://instagram.com/_dbsm.in';

  static List<SkillCategory> getSkillCategories() {
    return [
      SkillCategory(
        name: 'Frontend Development',
        icon: Icons.web,
        skills: [
                     Skill(
             name: 'Flutter',
             category: 'Frontend',
             proficiency: 0.9,
             color: const Color(0xFF00B4D8), // Vibrant blue
           ),
                     Skill(
             name: 'React',
             category: 'Frontend',
             proficiency: 0.85,
             color: const Color(0xFF61DAFB), // React blue
           ),
                     Skill(
             name: 'Vue.js',
             category: 'Frontend',
             proficiency: 0.8,
             color: const Color(0xFF4FC08D), // Vue green
           ),
                     Skill(
             name: 'HTML/CSS',
             category: 'Frontend',
             proficiency: 0.95,
             color: const Color(0xFFE34F26), // HTML orange
           ),
          Skill(
            name: 'JavaScript',
            category: 'Frontend',
            proficiency: 0.9,
            color: const Color(0xFFF7DF1E),
          ),
          Skill(
            name: 'TypeScript',
            category: 'Frontend',
            proficiency: 0.85,
            color: const Color(0xFF3178C6),
          ),
        ],
      ),
      SkillCategory(
        name: 'Backend Development',
        icon: Icons.storage,
        skills: [
          Skill(
            name: 'Node.js',
            category: 'Backend',
            proficiency: 0.85,
            color: const Color(0xFF339933),
          ),
          Skill(
            name: 'Python',
            category: 'Backend',
            proficiency: 0.8,
            color: const Color(0xFF3776AB),
          ),
          Skill(
            name: 'Django',
            category: 'Backend',
            proficiency: 0.75,
            color: const Color(0xFF092E20),
          ),
          Skill(
            name: 'Express.js',
            category: 'Backend',
            proficiency: 0.8,
            color: const Color(0xFF000000),
          ),
          Skill(
            name: 'MongoDB',
            category: 'Backend',
            proficiency: 0.75,
            color: const Color(0xFF47A248),
          ),
          Skill(
            name: 'PostgreSQL',
            category: 'Backend',
            proficiency: 0.7,
            color: const Color(0xFF336791),
          ),
        ],
      ),
      SkillCategory(
        name: 'Mobile Development',
        icon: Icons.phone_android,
        skills: [
          Skill(
            name: 'Flutter',
            category: 'Mobile',
            proficiency: 0.9,
            color: const Color(0xFF02569B),
          ),
          Skill(
            name: 'React Native',
            category: 'Mobile',
            proficiency: 0.75,
            color: const Color(0xFF61DAFB),
          ),
          Skill(
            name: 'Android',
            category: 'Mobile',
            proficiency: 0.7,
            color: const Color(0xFF3DDC84),
          ),
          Skill(
            name: 'iOS',
            category: 'Mobile',
            proficiency: 0.65,
            color: const Color(0xFF000000),
          ),
        ],
      ),
      SkillCategory(
        name: 'Tools & Others',
        icon: Icons.build,
        skills: [
          Skill(
            name: 'Git',
            category: 'Tools',
            proficiency: 0.9,
            color: const Color(0xFFF05032),
          ),
          Skill(
            name: 'Docker',
            category: 'Tools',
            proficiency: 0.75,
            color: const Color(0xFF2496ED),
          ),
          Skill(
            name: 'AWS',
            category: 'Tools',
            proficiency: 0.7,
            color: const Color(0xFF232F3E),
          ),
          Skill(
            name: 'Firebase',
            category: 'Tools',
            proficiency: 0.8,
            color: const Color(0xFFFFCA28),
          ),
          Skill(
            name: 'Figma',
            category: 'Tools',
            proficiency: 0.75,
            color: const Color(0xFFF24E1E),
          ),
        ],
      ),
    ];
  }

  static List<Experience> getExperiences() {
    return [
      Experience(
        title: 'Senior Full Stack Developer',
        company: 'Tech Solutions Inc.',
        description:
            'Leading development of enterprise-level applications using modern technologies. Mentoring junior developers and implementing best practices.',
        startDate: DateTime(2023, 1),
        isCurrent: true,
        achievements: [
          'Led a team of 5 developers in building a scalable e-commerce platform',
          'Improved application performance by 40% through optimization',
          'Implemented CI/CD pipelines reducing deployment time by 60%',
        ],
      ),
      Experience(
        title: 'Full Stack Developer',
        company: 'Digital Innovations Ltd.',
        description:
            'Developed and maintained multiple web applications using React, Node.js, and MongoDB. Collaborated with cross-functional teams.',
        startDate: DateTime(2021, 6),
        endDate: DateTime(2022, 12),
        achievements: [
          'Built 10+ client applications with 99.9% uptime',
          'Reduced bug reports by 50% through improved testing',
          'Mentored 3 junior developers',
        ],
      ),
      Experience(
        title: 'Frontend Developer',
        company: 'WebCraft Studios',
        description:
            'Specialized in creating responsive and interactive user interfaces using modern frontend technologies.',
        startDate: DateTime(2020, 3),
        endDate: DateTime(2021, 5),
        achievements: [
          'Developed 15+ responsive websites',
          'Improved user engagement by 35%',
          'Optimized loading times by 45%',
        ],
      ),
      Experience(
        title: 'Computer Science Degree',
        company: 'University of Technology',
        description:
            'Bachelor\'s degree in Computer Science with focus on software engineering and web development.',
        startDate: DateTime(2016, 9),
        endDate: DateTime(2020, 6),
        achievements: [
          'Graduated with First Class Honours',
          'Final year project: AI-powered recommendation system',
          'Active member of coding clubs and hackathons',
        ],
      ),
    ];
  }
}
