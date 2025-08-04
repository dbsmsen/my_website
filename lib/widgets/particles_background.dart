import 'dart:math';
import 'package:flutter/material.dart';

class ParticlesBackground extends StatefulWidget {
  const ParticlesBackground({super.key});

  @override
  State<ParticlesBackground> createState() => _ParticlesBackgroundState();
}

class _ParticlesBackgroundState extends State<ParticlesBackground>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late List<Particle> _particles;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 30),
      vsync: this,
    )..repeat();

    _particles = List.generate(80, (index) => _createParticle());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Particle _createParticle() {
    return Particle(
      x: _random.nextDouble() * 1200,
      y: _random.nextDouble() * 1200,
      size: _random.nextDouble() * 4 + 1,
      speed: _random.nextDouble() * 0.8 + 0.2,
      opacity: _random.nextDouble() * 0.7 + 0.2,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: ParticlesPainter(
            particles: _particles,
            animation: _controller.value,
          ),
          size: Size.infinite,
        );
      },
    );
  }
}

class Particle {
  double x;
  double y;
  final double size;
  final double speed;
  final double opacity;

  Particle({
    required this.x,
    required this.y,
    required this.size,
    required this.speed,
    required this.opacity,
  });
}

class ParticlesPainter extends CustomPainter {
  final List<Particle> particles;
  final double animation;

  ParticlesPainter({required this.particles, required this.animation});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    for (final particle in particles) {
      // Update particle position
      particle.y -= particle.speed;
      if (particle.y < -10) {
        particle.y = size.height + 10;
        particle.x = Random().nextDouble() * size.width;
      }

      // Draw particle with blue gradient
      final gradient = RadialGradient(
        colors: [
          const Color(0xFF00B4D8).withOpacity(particle.opacity),
          const Color(0xFF90E0EF).withOpacity(particle.opacity * 0.7),
          const Color(0xFF48CAE4).withOpacity(particle.opacity * 0.3),
        ],
      );

      paint.shader = gradient.createShader(
        Rect.fromCircle(
          center: Offset(particle.x, particle.y),
          radius: particle.size,
        ),
      );

      canvas.drawCircle(Offset(particle.x, particle.y), particle.size, paint);
    }

    // Draw connecting lines between nearby particles
    _drawConnections(canvas, size);
  }

  void _drawConnections(Canvas canvas, Size size) {
    final linePaint =
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.0;

    for (int i = 0; i < particles.length; i++) {
      for (int j = i + 1; j < particles.length; j++) {
        final particle1 = particles[i];
        final particle2 = particles[j];

        final distance = _calculateDistance(particle1, particle2);
        if (distance < 120) {
          final opacity = (120 - distance) / 120 * 0.15;
          final gradient = LinearGradient(
            colors: [
              const Color(0xFF00B4D8).withOpacity(opacity),
              const Color(0xFF90E0EF).withOpacity(opacity * 0.7),
            ],
          );

          linePaint.shader = gradient.createShader(
            Rect.fromPoints(
              Offset(particle1.x, particle1.y),
              Offset(particle2.x, particle2.y),
            ),
          );

          canvas.drawLine(
            Offset(particle1.x, particle1.y),
            Offset(particle2.x, particle2.y),
            linePaint,
          );
        }
      }
    }
  }

  double _calculateDistance(Particle p1, Particle p2) {
    final dx = p1.x - p2.x;
    final dy = p1.y - p2.y;
    return sqrt(dx * dx + dy * dy);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
