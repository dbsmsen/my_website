import 'package:flutter/material.dart';
import 'package:my_website/widgets/navigation_bar.dart';
import 'package:my_website/widgets/hero_section.dart';
import 'package:my_website/widgets/about_section.dart';
import 'package:my_website/widgets/projects_section.dart';
import 'package:my_website/widgets/skills_section.dart';
import 'package:my_website/widgets/experience_section.dart';
import 'package:my_website/widgets/contact_section.dart';
import 'package:my_website/widgets/particles_background.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final List<GlobalKey> _sectionKeys = [
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
  ];

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void scrollToSection(int index) {
    if (_sectionKeys[index].currentContext != null) {
      Scrollable.ensureVisible(
        _sectionKeys[index].currentContext!,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Animated background
          const ParticlesBackground(),

          // Main content
          CustomScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            slivers: [
              // Navigation bar
              SliverPersistentHeader(
                pinned: true,
                delegate: NavigationBarDelegate(
                  child: CustomNavigationBar(onSectionTap: scrollToSection),
                ),
              ),

              // Hero section
              SliverToBoxAdapter(child: HeroSection(key: _sectionKeys[0])),

              // About section
              SliverToBoxAdapter(child: AboutSection(key: _sectionKeys[1])),

              // Skills section
              SliverToBoxAdapter(child: SkillsSection(key: _sectionKeys[2])),

              // Projects section
              SliverToBoxAdapter(child: ProjectsSection(key: _sectionKeys[3])),

              // Experience section
              SliverToBoxAdapter(
                child: ExperienceSection(key: _sectionKeys[4]),
              ),

              // Contact section
              SliverToBoxAdapter(child: ContactSection(key: _sectionKeys[5])),
            ],
          ),
        ],
      ),
    );
  }
}

class NavigationBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  NavigationBarDelegate({required this.child});

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface.withOpacity(0.95),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }

  @override
  double get maxExtent => 80;

  @override
  double get minExtent => 80;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
