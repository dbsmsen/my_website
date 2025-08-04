class Experience {
  final String title;
  final String company;
  final String description;
  final DateTime startDate;
  final DateTime? endDate;
  final bool isCurrent;
  final List<String> achievements;
  final String? logoUrl;

  Experience({
    required this.title,
    required this.company,
    required this.description,
    required this.startDate,
    this.endDate,
    this.isCurrent = false,
    this.achievements = const [],
    this.logoUrl,
  });

  String get duration {
    if (isCurrent) {
      return '${startDate.year} - Present';
    } else if (endDate != null) {
      return '${startDate.year} - ${endDate!.year}';
    }
    return '${startDate.year}';
  }
}
