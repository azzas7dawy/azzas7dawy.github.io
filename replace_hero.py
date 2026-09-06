import re

file_path = r'd:\protifio\lib\main.dart'

with open(file_path, 'r', encoding='utf-8') as f:
    content = f.read()

# 1. Add dart:math import if not exists
if "import 'dart:math'" not in content:
    content = content.replace("import 'package:flutter/material.dart';", "import 'package:flutter/material.dart';\nimport 'dart:math' as math;")

# 2. Extract and replace _buildHeroSection
hero_start = content.find('  // --- 1. HERO SECTION ---')
about_start = content.find('  // --- 2. ABOUT & EDUCATION ---')

if hero_start != -1 and about_start != -1:
    new_hero = '''  // --- 1. HERO SECTION ---
  Widget _buildHeroSection(bool isMobile) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // The animated circular icons
              const SizedBox(height: 20),
              const AnimatedHeroCircle(),
              const SizedBox(height: 40),

              // Title
              Text(
                'Flutter Developer Creating\\nBeautiful Apps',
                textAlign: TextAlign.center,
                style: GoogleFonts.outfit(
                  fontSize: isMobile ? 32 : 54,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  height: 1.2,
                ),
              ).animate().fade(delay: 200.ms, duration: 800.ms).slideY(begin: 0.2),

              const SizedBox(height: 20),
              
              // Subtitle
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: Text(
                  'Passionate about building modern apps with clean UI, smooth animations, and seamless performance.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: isMobile ? 16 : 20,
                    color: Colors.white60,
                    height: 1.6,
                  ),
                ),
              ).animate().fade(delay: 400.ms).slideY(begin: 0.2),

              const SizedBox(height: 40),
              
              // Glowing Button
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF2196F3).withOpacity(0.4),
                      blurRadius: 20,
                      spreadRadius: 5,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: () => _scrollToSection(_projectsKey),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1976D2),
                    foregroundColor: Colors.white,
                    padding: isMobile
                        ? const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 18,
                          )
                        : const EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 22,
                          ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 0,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'View My Work',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Icon(Icons.arrow_forward_rounded, size: 22),
                    ],
                  ),
                ),
              ).animate().fade(delay: 600.ms).scale(),
              const SizedBox(height: 40),
            ],
          ),
        );
      },
    );
  }

'''
    content = content[:hero_start] + new_hero + content[about_start:]

# 3. Add AnimatedHeroCircle class at the end
animated_circle_class = '''
class AnimatedHeroCircle extends StatefulWidget {
  const AnimatedHeroCircle({super.key});

  @override
  State<AnimatedHeroCircle> createState() => _AnimatedHeroCircleState();
}

class _AnimatedHeroCircleState extends State<AnimatedHeroCircle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  final List<IconData> icons = [
    Icons.code,
    Icons.flutter_dash,
    Icons.cloud_done,
    Icons.data_object,
    Icons.devices,
    Icons.memory,
    Icons.storage,
    Icons.integration_instructions,
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double radius = MediaQuery.of(context).size.width < 900 ? 120 : 160;
    final double centerSize = MediaQuery.of(context).size.width < 900 ? 80 : 100;
    
    return SizedBox(
      width: radius * 2.5,
      height: radius * 2.5,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // The center profile
          Container(
            width: centerSize,
            height: centerSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF2196F3).withOpacity(0.5),
                  blurRadius: 30,
                  spreadRadius: 10,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF1976D2),
                ),
                child: const Icon(
                  Icons.person,
                  size: 40,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          
          // The revolving icons
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Stack(
                alignment: Alignment.center,
                children: List.generate(icons.length, (index) {
                  final double angle = (2 * math.pi / icons.length) * index;
                  final double currentAngle = angle + (_controller.value * 2 * math.pi);
                  
                  final double x = radius * math.cos(currentAngle);
                  final double y = radius * math.sin(currentAngle);

                  return Transform.translate(
                    offset: Offset(x, y),
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFF1E88E5),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF2196F3).withOpacity(0.4),
                            blurRadius: 15,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Icon(
                        icons[index],
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  );
                }),
              );
            },
          ),
        ],
      ),
    );
  }
}
'''
if "class AnimatedHeroCircle" not in content:
    content += animated_circle_class

with open(file_path, 'w', encoding='utf-8') as f:
    f.write(content)
print("Hero section updated successfully.")
