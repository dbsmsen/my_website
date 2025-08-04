import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:my_website/services/portfolio_data.dart';
import 'package:my_website/models/skill.dart';

class SkillsSection extends StatefulWidget {
  const SkillsSection({super.key});

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection>
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
    final skillCategories = PortfolioData.getSkillCategories();

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
                    'Skills & Technologies',
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
                    'Technologies I work with',
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

            // Skills grid
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: MediaQuery.of(context).size.width > 768 ? 2 : 1,
                crossAxisSpacing: 30,
                mainAxisSpacing: 30,
                childAspectRatio:
                    MediaQuery.of(context).size.width > 768 ? 1.2 : 1.0,
              ),
              itemCount: skillCategories.length,
              itemBuilder: (context, index) {
                return AnimationConfiguration.staggeredGrid(
                  duration: const Duration(milliseconds: 600),
                  position: index,
                  columnCount: MediaQuery.of(context).size.width > 768 ? 2 : 1,
                  child: ScaleAnimation(
                    child: FadeInAnimation(
                      child: _SkillCategoryCard(
                        category: skillCategories[index],
                        index: index,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _SkillCategoryCard extends StatefulWidget {
  final SkillCategory category;
  final int index;

  const _SkillCategoryCard({required this.category, required this.index});

  @override
  State<_SkillCategoryCard> createState() => _SkillCategoryCardState();
}

class _SkillCategoryCardState extends State<_SkillCategoryCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _progressAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // Delay animation based on index
    Future.delayed(Duration(milliseconds: widget.index * 200), () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF0A1929).withOpacity(0.8),
            const Color(0xFF001B3D).withOpacity(0.6),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF00B4D8).withOpacity(0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF00B4D8).withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category header
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      const Color(0xFF00B4D8).withOpacity(0.2),
                      const Color(0xFF90E0EF).withOpacity(0.1),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFF00B4D8).withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Icon(
                  widget.category.icon,
                  color: const Color(0xFF00B4D8),
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  widget.category.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Skills list
          Expanded(
            child: ListView.builder(
              itemCount: widget.category.skills.length,
              itemBuilder: (context, index) {
                final skill = widget.category.skills[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _SkillItem(
                    skill: skill,
                    animation: _progressAnimation,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _SkillItem extends StatelessWidget {
  final Skill skill;
  final Animation<double> animation;

  const _SkillItem({required this.skill, required this.animation});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              skill.name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            Text(
              '${(skill.proficiency * 100).toInt()}%',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white.withOpacity(0.7),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            return Container(
              height: 10,
              decoration: BoxDecoration(
                color: const Color(0xFF001B3D).withOpacity(0.3),
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: const Color(0xFF00B4D8).withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: skill.proficiency * animation.value,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        const Color(0xFF00B4D8),
                        const Color(0xFF48CAE4),
                        const Color(0xFF90E0EF),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF00B4D8).withOpacity(0.5),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
