import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_website/models/project.dart';

class GitHubService {
  static const String _baseUrl = 'https://api.github.com';
  static const String _username = 'dbsmsen';

  Future<List<Project>> getRepositories() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/users/$_username/repos'),
        headers: {
          'Accept': 'application/vnd.github.v3+json',
          'User-Agent': 'Portfolio-App',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> repos = json.decode(response.body);
        return repos
            .map((repo) => Project.fromJson(repo))
            .where(
              (project) =>
                  project.description.isNotEmpty &&
                  !project.name.toLowerCase().contains('test') &&
                  !project.name.toLowerCase().contains('demo'),
            )
            .take(6)
            .toList();
      } else {
        throw Exception('Failed to load repositories');
      }
    } catch (e) {
      // Return hardcoded projects if API fails
      return _getHardcodedProjects();
    }
  }

  List<Project> _getHardcodedProjects() {
    return [
      Project(
        name: 'Flutter Portfolio',
        description:
            'A modern, animated portfolio website built with Flutter featuring dark theme, smooth animations, and responsive design.',
        language: 'Dart',
        url: 'https://github.com/dbsmsen/my_website',
        technologies: ['Flutter', 'Dart', 'Material Design', 'Animations'],
        stars: 5,
        forks: 2,
      ),
      Project(
        name: 'E-Commerce App',
        description:
            'A full-stack e-commerce application with user authentication, product management, and payment integration.',
        language: 'JavaScript',
        url: 'https://github.com/dbsmsen/ecommerce-app',
        technologies: ['React', 'Node.js', 'MongoDB', 'Stripe'],
        stars: 12,
        forks: 8,
      ),
      Project(
        name: 'Task Management System',
        description:
            'A collaborative task management system with real-time updates, team collaboration, and progress tracking.',
        language: 'TypeScript',
        url: 'https://github.com/dbsmsen/task-manager',
        technologies: ['TypeScript', 'React', 'Firebase', 'Tailwind CSS'],
        stars: 8,
        forks: 3,
      ),
      Project(
        name: 'Weather Dashboard',
        description:
            'A beautiful weather dashboard with location-based forecasts, interactive maps, and weather alerts.',
        language: 'Python',
        url: 'https://github.com/dbsmsen/weather-dashboard',
        technologies: ['Python', 'Flask', 'OpenWeather API', 'Chart.js'],
        stars: 15,
        forks: 6,
      ),
      Project(
        name: 'AI Chat Assistant',
        description:
            'An intelligent chat assistant powered by machine learning with natural language processing capabilities.',
        language: 'Python',
        url: 'https://github.com/dbsmsen/ai-chat-assistant',
        technologies: ['Python', 'TensorFlow', 'NLP', 'FastAPI'],
        stars: 20,
        forks: 12,
      ),
      Project(
        name: 'Mobile Fitness Tracker',
        description:
            'A cross-platform mobile app for tracking fitness activities, workouts, and health metrics.',
        language: 'Dart',
        url: 'https://github.com/dbsmsen/fitness-tracker',
        technologies: ['Flutter', 'Firebase', 'Health APIs', 'Charts'],
        stars: 18,
        forks: 9,
      ),
    ];
  }
}
