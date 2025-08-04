import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:my_website/services/portfolio_data.dart';

class AboutSection extends StatefulWidget {
  const AboutSection({super.key});

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Column(
          children: [
            // Section title
            AnimationConfiguration.staggeredList(
              duration: const Duration(milliseconds: 600),
              position: 0,
              child: SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(
                  child: Text(
                    'About Me',
                    style: TextStyle(
                      fontSize:
                          MediaQuery.of(context).size.width > 768 ? 48 : 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Section subtitle
            AnimationConfiguration.staggeredList(
              duration: const Duration(milliseconds: 600),
              position: 1,
              child: SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(
                  child: Text(
                    'Get to know me better',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white.withOpacity(0.7),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 60),

            // Content
            LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth > 768) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // About text
                      Expanded(
                        flex: 2,
                        child: AnimationConfiguration.staggeredList(
                          duration: const Duration(milliseconds: 600),
                          position: 2,
                          child: SlideAnimation(
                            horizontalOffset: -50.0,
                            child: FadeInAnimation(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    PortfolioData.aboutMe,
                                    style: TextStyle(
                                      fontSize: 16,
                                      height: 1.8,
                                      color: Colors.white.withOpacity(0.9),
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                  _InfoCard(
                                    icon: Icons.location_on,
                                    title: 'Location',
                                    subtitle: PortfolioData.location,
                                  ),
                                  const SizedBox(height: 20),
                                  _InfoCard(
                                    icon: Icons.email,
                                    title: 'Email',
                                    subtitle: PortfolioData.email,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 60),

                      // Stats
                      Expanded(
                        flex: 1,
                        child: AnimationConfiguration.staggeredList(
                          duration: const Duration(milliseconds: 600),
                          position: 3,
                          child: SlideAnimation(
                            horizontalOffset: 50.0,
                            child: FadeInAnimation(
                              child: Column(
                                children: [
                                  _StatCard(
                                    number: '3+',
                                    label: 'Years Experience',
                                    icon: Icons.work,
                                  ),
                                  const SizedBox(height: 20),
                                  _StatCard(
                                    number: '20+',
                                    label: 'Projects Completed',
                                    icon: Icons.code,
                                  ),
                                  const SizedBox(height: 20),
                                  _StatCard(
                                    number: '15+',
                                    label: 'Technologies',
                                    icon: Icons.psychology,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      AnimationConfiguration.staggeredList(
                        duration: const Duration(milliseconds: 600),
                        position: 2,
                        child: SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  PortfolioData.aboutMe,
                                  style: TextStyle(
                                    fontSize: 16,
                                    height: 1.8,
                                    color: Colors.white.withOpacity(0.9),
                                  ),
                                ),
                                const SizedBox(height: 30),
                                _InfoCard(
                                  icon: Icons.location_on,
                                  title: 'Location',
                                  subtitle: PortfolioData.location,
                                ),
                                const SizedBox(height: 20),
                                _InfoCard(
                                  icon: Icons.email,
                                  title: 'Email',
                                  subtitle: PortfolioData.email,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 40),

                      AnimationConfiguration.staggeredList(
                        duration: const Duration(milliseconds: 600),
                        position: 3,
                        child: SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(
                            child: Column(
                              children: [
                                _StatCard(
                                  number: '3+',
                                  label: 'Years Experience',
                                  icon: Icons.work,
                                ),
                                const SizedBox(height: 20),
                                _StatCard(
                                  number: '20+',
                                  label: 'Projects Completed',
                                  icon: Icons.code,
                                ),
                                const SizedBox(height: 20),
                                _StatCard(
                                  number: '15+',
                                  label: 'Technologies',
                                  icon: Icons.psychology,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _InfoCard({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: Theme.of(context).colorScheme.primary,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white.withOpacity(0.7),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String number;
  final String label;
  final IconData icon;

  const _StatCard({
    required this.number,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, size: 32, color: Theme.of(context).colorScheme.primary),
          const SizedBox(height: 12),
          Text(
            number,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.7),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
