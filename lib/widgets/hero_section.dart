import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:my_website/services/portfolio_data.dart';
import 'package:url_launcher/url_launcher.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _slideController, curve: Curves.easeOut));

    _fadeController.forward();
    Future.delayed(const Duration(milliseconds: 300), () {
      _slideController.forward();
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  Future<void> _launchUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF001B3D), // Deep dark blue
            const Color(0xFF0A1929), // Dark blue surface
            const Color(0xFF001B3D), // Deep dark blue
          ],
          stops: const [0.0, 0.5, 1.0],
        ),
      ),
      child: Stack(
        children: [
          // Animated background elements
          _AnimatedBackgroundElements(),

          // Main content
          FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Animated greeting with enhanced styling
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              const Color(0xFF00B4D8).withOpacity(0.1),
                              const Color(0xFF90E0EF).withOpacity(0.05),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: const Color(0xFF00B4D8).withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: AnimatedTextKit(
                          animatedTexts: [
                            TypewriterAnimatedText(
                              'Hi, I\'m ${PortfolioData.name}',
                              textStyle: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width > 768
                                        ? 48
                                        : 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                shadows: [
                                  Shadow(
                                    color: const Color(
                                      0xFF00B4D8,
                                    ).withOpacity(0.5),
                                    blurRadius: 10,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              speed: const Duration(milliseconds: 100),
                            ),
                          ],
                          totalRepeatCount: 1,
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Title
                      Text(
                        PortfolioData.title,
                        style: TextStyle(
                          fontSize:
                              MediaQuery.of(context).size.width > 768 ? 24 : 18,
                          color: const Color(0xFF00B4D8),
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Subtitle
                      Text(
                        PortfolioData.subtitle,
                        style: TextStyle(
                          fontSize:
                              MediaQuery.of(context).size.width > 768 ? 18 : 16,
                          color: Colors.white.withOpacity(0.8),
                        ),
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 40),

                      // Action buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _ActionButton(
                            text: 'View Projects',
                            onPressed: () {
                              // Scroll to projects section
                              // This will be handled by the parent widget
                            },
                            isPrimary: true,
                          ),
                          const SizedBox(width: 20),
                          _ActionButton(
                            text: 'Contact Me',
                            onPressed: () {
                              // Scroll to contact section
                              // This will be handled by the parent widget
                            },
                            isPrimary: false,
                          ),
                        ],
                      ),

                      const SizedBox(height: 40),

                      // Social links
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _SocialButton(
                            icon: Icons.code,
                            onPressed:
                                () => _launchUrl(PortfolioData.githubUrl),
                            tooltip: 'GitHub',
                          ),
                          const SizedBox(width: 20),
                          _SocialButton(
                            icon: Icons.work,
                            onPressed:
                                () => _launchUrl(PortfolioData.linkedinUrl),
                            tooltip: 'LinkedIn',
                          ),
                          const SizedBox(width: 20),
                          _SocialButton(
                            icon: Icons.email,
                            onPressed:
                                () =>
                                    _launchUrl('mailto:${PortfolioData.email}'),
                            tooltip: 'Email',
                          ),
                          const SizedBox(width: 20),
                          _SocialButton(
                            icon: Icons.camera_alt,
                            onPressed:
                                () => _launchUrl(PortfolioData.instagramUrl),
                            tooltip: 'Instagram',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isPrimary;

  const _ActionButton({
    required this.text,
    required this.onPressed,
    required this.isPrimary,
  });

  @override
  State<_ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<_ActionButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) => _controller.reverse(),
      onTapCancel: () => _controller.reverse(),
      onTap: widget.onPressed,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              decoration: BoxDecoration(
                gradient:
                    widget.isPrimary
                        ? LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            const Color(0xFF00B4D8),
                            const Color(0xFF48CAE4),
                          ],
                        )
                        : null,
                color: widget.isPrimary ? null : Colors.transparent,
                borderRadius: BorderRadius.circular(30),
                border:
                    widget.isPrimary
                        ? null
                        : Border.all(color: const Color(0xFF00B4D8), width: 2),
                boxShadow:
                    widget.isPrimary
                        ? [
                          BoxShadow(
                            color: const Color(0xFF00B4D8).withOpacity(0.4),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ]
                        : null,
              ),
              child: Text(
                widget.text,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color:
                      widget.isPrimary ? Colors.white : const Color(0xFF00B4D8),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _SocialButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final String tooltip;

  const _SocialButton({
    required this.icon,
    required this.onPressed,
    required this.tooltip,
  });

  @override
  State<_SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<_SocialButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.8,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.tooltip,
      child: GestureDetector(
        onTapDown: (_) => _controller.forward(),
        onTapUp: (_) => _controller.reverse(),
        onTapCancel: () => _controller.reverse(),
        onTap: widget.onPressed,
        child: AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: Container(
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
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: const Color(0xFF00B4D8).withOpacity(0.3),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF00B4D8).withOpacity(0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Icon(
                  widget.icon,
                  color: const Color(0xFF00B4D8),
                  size: 24,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _AnimatedBackgroundElements extends StatefulWidget {
  const _AnimatedBackgroundElements();

  @override
  State<_AnimatedBackgroundElements> createState() =>
      _AnimatedBackgroundElementsState();
}

class _AnimatedBackgroundElementsState
    extends State<_AnimatedBackgroundElements>
    with TickerProviderStateMixin {
  late AnimationController _floatingController;
  late AnimationController _pulseController;
  late AnimationController _rotateController;

  late Animation<double> _floatingAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<double> _rotateAnimation;

  @override
  void initState() {
    super.initState();

    _floatingController = AnimationController(
      duration: const Duration(seconds: 6),
      vsync: this,
    )..repeat(reverse: true);

    _pulseController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _rotateController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();

    _floatingAnimation = Tween<double>(begin: -20.0, end: 20.0).animate(
      CurvedAnimation(parent: _floatingController, curve: Curves.easeInOut),
    );

    _pulseAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _rotateAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _rotateController, curve: Curves.linear));
  }

  @override
  void dispose() {
    _floatingController.dispose();
    _pulseController.dispose();
    _rotateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Floating geometric shapes
        Positioned(
          top: 100,
          left: 50,
          child: AnimatedBuilder(
            animation: _floatingAnimation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, _floatingAnimation.value),
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFF00B4D8).withOpacity(0.3),
                        const Color(0xFF90E0EF).withOpacity(0.1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: const Color(0xFF00B4D8).withOpacity(0.5),
                      width: 2,
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        Positioned(
          top: 200,
          right: 80,
          child: AnimatedBuilder(
            animation: _pulseAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _pulseAnimation.value,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFF48CAE4).withOpacity(0.4),
                        const Color(0xFF00B4D8).withOpacity(0.2),
                      ],
                    ),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFF48CAE4).withOpacity(0.6),
                      width: 1,
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        Positioned(
          bottom: 150,
          left: 100,
          child: AnimatedBuilder(
            animation: _rotateAnimation,
            builder: (context, child) {
              return Transform.rotate(
                angle: _rotateAnimation.value * 2 * 3.14159,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFF90E0EF).withOpacity(0.2),
                        const Color(0xFF48CAE4).withOpacity(0.1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: const Color(0xFF90E0EF).withOpacity(0.4),
                      width: 1,
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        Positioned(
          bottom: 250,
          right: 120,
          child: AnimatedBuilder(
            animation: _floatingAnimation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(_floatingAnimation.value * 0.5, 0),
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFF00B4D8).withOpacity(0.3),
                        const Color(0xFF90E0EF).withOpacity(0.1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: const Color(0xFF00B4D8).withOpacity(0.4),
                      width: 1,
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        // Animated lines connecting elements
        CustomPaint(
          painter: _AnimatedLinesPainter(
            floatingAnimation: _floatingAnimation,
            pulseAnimation: _pulseAnimation,
          ),
          size: Size.infinite,
        ),
      ],
    );
  }
}

class _AnimatedLinesPainter extends CustomPainter {
  final Animation<double> floatingAnimation;
  final Animation<double> pulseAnimation;

  _AnimatedLinesPainter({
    required this.floatingAnimation,
    required this.pulseAnimation,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.0;

    // Draw animated connecting lines
    final points = [
      Offset(110, 130 + floatingAnimation.value),
      Offset(size.width - 120, 240),
      Offset(180, size.height - 190),
      Offset(
        size.width - 170,
        size.height - 275 + floatingAnimation.value * 0.5,
      ),
    ];

    for (int i = 0; i < points.length; i++) {
      for (int j = i + 1; j < points.length; j++) {
        final distance = (points[i] - points[j]).distance;
        if (distance < 300) {
          final opacity = (300 - distance) / 300 * 0.2 * pulseAnimation.value;
          final gradient = LinearGradient(
            colors: [
              const Color(0xFF00B4D8).withOpacity(opacity),
              const Color(0xFF90E0EF).withOpacity(opacity * 0.7),
            ],
          );

          paint.shader = gradient.createShader(
            Rect.fromPoints(points[i], points[j]),
          );

          canvas.drawLine(points[i], points[j], paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
