import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:my_website/models/experience.dart';
import 'package:my_website/services/portfolio_data.dart';

class ExperienceSection extends StatefulWidget {
  const ExperienceSection({super.key});

  @override
  State<ExperienceSection> createState() => _ExperienceSectionState();
}

class _ExperienceSectionState extends State<ExperienceSection>
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
    final experiences = PortfolioData.getExperiences();

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
                    'Experience & Timeline',
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
                    'My journey so far',
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

            // Timeline
            LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth > 768) {
                  return _DesktopTimeline(experiences: experiences);
                } else {
                  return _MobileTimeline(experiences: experiences);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _DesktopTimeline extends StatelessWidget {
  final List<Experience> experiences;

  const _DesktopTimeline({required this.experiences});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Timeline line
        Expanded(
          flex: 1,
          child: Column(
            children: [
              Container(
                width: 4,
                height: 100,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.primary.withOpacity(0.3),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              ...List.generate(experiences.length - 1, (index) {
                return Container(
                  width: 4,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.primary.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                );
              }),
            ],
          ),
        ),

        const SizedBox(width: 40),

        // Timeline items
        Expanded(
          flex: 3,
          child: Column(
            children: List.generate(experiences.length, (index) {
              return AnimationConfiguration.staggeredList(
                duration: const Duration(milliseconds: 600),
                position: index,
                child: SlideAnimation(
                  horizontalOffset: 50.0,
                  child: FadeInAnimation(
                    child: _TimelineItem(
                      experience: experiences[index],
                      isLast: index == experiences.length - 1,
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}

class _MobileTimeline extends StatelessWidget {
  final List<Experience> experiences;

  const _MobileTimeline({required this.experiences});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(experiences.length, (index) {
        return AnimationConfiguration.staggeredList(
          duration: const Duration(milliseconds: 600),
          position: index,
          child: SlideAnimation(
            verticalOffset: 50.0,
            child: FadeInAnimation(
              child: _TimelineItem(
                experience: experiences[index],
                isLast: index == experiences.length - 1,
                isMobile: true,
              ),
            ),
          ),
        );
      }),
    );
  }
}

class _TimelineItem extends StatelessWidget {
  final Experience experience;
  final bool isLast;
  final bool isMobile;

  const _TimelineItem({
    required this.experience,
    required this.isLast,
    this.isMobile = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: isLast ? 0 : 40),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline dot
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
          ),

          const SizedBox(width: 20),

          // Content
          Expanded(child: _ExperienceCard(experience: experience)),
        ],
      ),
    );
  }
}

class _ExperienceCard extends StatelessWidget {
  final Experience experience;

  const _ExperienceCard({required this.experience});

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      experience.title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      experience.company,
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color:
                      experience.isCurrent
                          ? Theme.of(
                            context,
                          ).colorScheme.primary.withOpacity(0.2)
                          : Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  experience.duration,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color:
                        experience.isCurrent
                            ? Theme.of(context).colorScheme.primary
                            : Colors.white.withOpacity(0.7),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Description
          Text(
            experience.description,
            style: TextStyle(
              fontSize: 14,
              height: 1.6,
              color: Colors.white.withOpacity(0.8),
            ),
          ),

          // Achievements
          if (experience.achievements.isNotEmpty) ...[
            const SizedBox(height: 20),
            Text(
              'Key Achievements:',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.white.withOpacity(0.9),
              ),
            ),
            const SizedBox(height: 12),
            ...experience.achievements.map((achievement) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      margin: const EdgeInsets.only(top: 6, right: 12),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        achievement,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.white.withOpacity(0.7),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ],
      ),
    );
  }
}
