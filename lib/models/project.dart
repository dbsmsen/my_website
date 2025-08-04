class Project {
  final String name;
  final String description;
  final String? language;
  final String? url;
  final String? imageUrl;
  final List<String> technologies;
  final bool isStarred;
  final int? stars;
  final int? forks;

  Project({
    required this.name,
    required this.description,
    this.language,
    this.url,
    this.imageUrl,
    this.technologies = const [],
    this.isStarred = false,
    this.stars,
    this.forks,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      language: json['language'],
      url: json['html_url'],
      technologies: json['topics']?.cast<String>() ?? [],
      stars: json['stargazers_count'],
      forks: json['forks_count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'language': language,
      'url': url,
      'imageUrl': imageUrl,
      'technologies': technologies,
      'isStarred': isStarred,
      'stars': stars,
      'forks': forks,
    };
  }
}
