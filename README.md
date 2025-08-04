# Debsoomonto Sen - Portfolio Website

A modern, animated portfolio website built with Flutter featuring a dark theme, smooth animations, and responsive design.

## Features

### 🎨 Design
- **Dark Theme**: Modern dark color scheme with accent colors (deep blue, teal, purple)
- **Responsive Design**: Optimized for both desktop and mobile devices
- **Smooth Animations**: Page transitions, hover effects, and staggered animations
- **Custom Fonts**: Google Fonts integration for beautiful typography

### 📱 Sections
1. **Hero Section**: Animated introduction with typewriter effect
2. **About Me**: Personal bio with contact information and statistics
3. **Skills**: Categorized skills with animated progress bars
4. **Projects**: GitHub integration with project cards and stats
5. **Experience**: Timeline showing work and education history
6. **Contact**: Contact form with social media links

### 🚀 Technical Features
- **GitHub API Integration**: Fetches real project data from GitHub
- **State Management**: Provider pattern for theme management
- **URL Launcher**: Direct links to social media and email
- **Animated Background**: Custom particles animation
- **Responsive Navigation**: Sticky navigation bar with mobile menu

## Getting Started

### Prerequisites
- Flutter SDK (latest stable version)
- Dart SDK
- Chrome browser (for web development)

### Installation

1. Clone the repository:
```bash
git clone https://github.com/dbsmsen/my_website.git
cd my_website
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the application:
```bash
# For web
flutter run -d chrome

# For mobile
flutter run
```

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── models/                   # Data models
│   ├── project.dart         # Project data model
│   ├── skill.dart           # Skill data model
│   └── experience.dart      # Experience data model
├── providers/               # State management
│   └── theme_provider.dart  # Theme provider
├── screens/                 # Main screens
│   └── home_screen.dart     # Home screen with all sections
├── services/                # API services
│   ├── github_service.dart  # GitHub API integration
│   └── portfolio_data.dart  # Static portfolio data
├── utils/                   # Utility functions
└── widgets/                 # Reusable widgets
    ├── about_section.dart   # About section widget
    ├── contact_section.dart # Contact section widget
    ├── experience_section.dart # Experience timeline
    ├── hero_section.dart    # Hero section widget
    ├── navigation_bar.dart  # Navigation bar widget
    ├── particles_background.dart # Animated background
    ├── projects_section.dart # Projects grid
    └── skills_section.dart  # Skills display
```

## Customization

### Personal Information
Update your personal information in `lib/services/portfolio_data.dart`:
- Name, title, and bio
- Contact information
- Social media links
- Skills and experience data

### GitHub Integration
The app automatically fetches projects from your GitHub profile. Update the username in `lib/services/github_service.dart`:
```dart
static const String _username = 'your-github-username';
```

### Styling
- Colors: Update the color scheme in `lib/main.dart`
- Fonts: Modify Google Fonts in the theme configuration
- Animations: Adjust animation durations and curves in individual widgets

## Dependencies

- `flutter_staggered_animations`: For staggered list and grid animations
- `animated_text_kit`: For typewriter and animated text effects
- `google_fonts`: For custom typography
- `provider`: For state management
- `http`: For GitHub API calls
- `url_launcher`: For opening external links
- `shared_preferences`: For theme persistence

## Browser Support

- Chrome (recommended)
- Firefox
- Safari
- Edge

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## License

This project is open source and available under the [MIT License](LICENSE).

## Contact

- **Email**: debsoomonto.sen@gmail.com
- **GitHub**: [@dbsmsen](https://github.com/dbsmsen)
- **LinkedIn**: [Debsoomonto Sen](https://linkedin.com/in/dbsmsen)

---

Built with ❤️ using Flutter
