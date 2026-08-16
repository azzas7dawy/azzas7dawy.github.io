import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

void main() {
  runApp(const AzzaPortfolioApp());
}

class AzzaPortfolioApp extends StatelessWidget {
  const AzzaPortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Azza Sadawy | Mobile App Flutter Developer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0B0F19), // Deeper Dark Navy
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF00E676), // Emerald Green
          secondary: Color(0xFF00D2FF), // Neon Cyan
          surface: Color(0xFF151C2C),
        ),
        textTheme: GoogleFonts.outfitTextTheme(ThemeData.dark().textTheme),
      ),
      home: const PortfolioHomePage(),
    );
  }
}

class PortfolioHomePage extends StatefulWidget {
  const PortfolioHomePage({super.key});

  @override
  State<PortfolioHomePage> createState() => _PortfolioHomePageState();
}

class _PortfolioHomePageState extends State<PortfolioHomePage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _experienceKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 1000),
        curve: Curves.fastOutSlowIn,
      );
    }
  }

  Future<void> _launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      debugPrint('Could not launch $urlString');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 900;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B0F19).withOpacity(0.85),
        elevation: 0,
        centerTitle: isMobile,
        title: Text(
          '<Azza.dev />',
          style: GoogleFonts.firaCode(
            color: const Color(0xFF00D2FF),
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ).animate().fadeIn(duration: 800.ms).slideX(begin: -0.2, end: 0),
        actions: isMobile
            ? null
            : [
                _navButton('Home', () => _scrollToSection(_homeKey)),
                _navButton('About & Edu', () => _scrollToSection(_aboutKey)),
                _navButton(
                  'Experience',
                  () => _scrollToSection(_experienceKey),
                ),
                _navButton('Skills', () => _scrollToSection(_skillsKey)),
                _navButton('Projects', () => _scrollToSection(_projectsKey)),
                _navButton('Contact', () => _scrollToSection(_contactKey)),
                const SizedBox(width: 30),
              ].animate(interval: 100.ms).fadeIn().slideY(begin: -0.5, end: 0),
      ),
      drawer: isMobile
          ? Drawer(
              backgroundColor: const Color(0xFF151C2C),
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  vertical: 60,
                  horizontal: 20,
                ),
                children: [
                  Text(
                    '<Azza.dev />',
                    style: GoogleFonts.firaCode(
                      color: const Color(0xFF00D2FF),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),
                  _drawerItem('Home', Icons.home_outlined, _homeKey),
                  _drawerItem('About & Edu', Icons.person_outline, _aboutKey),
                  _drawerItem('Experience', Icons.work_outline, _experienceKey),
                  _drawerItem('Skills', Icons.code, _skillsKey),
                  _drawerItem(
                    'Projects',
                    Icons.dashboard_outlined,
                    _projectsKey,
                  ),
                  _drawerItem('Contact', Icons.mail_outline, _contactKey),
                ],
              ),
            )
          : null,
      body: Stack(
        children: [
          // Background subtle animated gradient blobs (simulated via decoration)
          Positioned(
            top: -150,
            right: -100,
            child:
                Container(
                      width: 400,
                      height: 400,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFF00D2FF).withOpacity(0.05),
                      ),
                    )
                    .animate(
                      onPlay: (controller) => controller.repeat(reverse: true),
                    )
                    .scale(
                      begin: const Offset(1, 1),
                      end: const Offset(1.2, 1.2),
                      duration: 4.seconds,
                    ),
          ),
          Positioned(
            bottom: -200,
            left: -100,
            child:
                Container(
                      width: 500,
                      height: 500,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFF00E676).withOpacity(0.05),
                      ),
                    )
                    .animate(
                      onPlay: (controller) => controller.repeat(reverse: true),
                    )
                    .scale(
                      begin: const Offset(1, 1),
                      end: const Offset(1.1, 1.1),
                      duration: 5.seconds,
                    ),
          ),

          SingleChildScrollView(
            controller: _scrollController,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 24 : 100,
                vertical: 40,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 80), // AppBar spacing
                  Container(key: _homeKey, child: _buildHeroSection(isMobile)),
                  const SizedBox(height: 120),
                  Container(
                    key: _aboutKey,
                    child: _buildAboutSection(isMobile),
                  ),
                  const SizedBox(height: 120),
                  Container(
                    key: _experienceKey,
                    child: _buildExperienceSection(),
                  ),
                  const SizedBox(height: 120),
                  Container(
                    key: _skillsKey,
                    child: _buildSkillsSection(isMobile),
                  ),
                  const SizedBox(height: 120),
                  Container(
                    key: _projectsKey,
                    child: _buildProjectsSection(isMobile),
                  ),
                  const SizedBox(height: 120),
                  Container(
                    key: _contactKey,
                    child: _buildContactSection(isMobile),
                  ),
                  const SizedBox(height: 80),

                  // Footer
                  Center(
                    child: Column(
                      children: [
                        const Divider(color: Colors.white12),
                        const SizedBox(height: 20),
                        Text(
                          'Designed & Built with Flutter by Azza Sadawy © 2024',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _navButton(String title, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          foregroundColor: Colors.white70,
          textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
        child: Text(title)
            .animate(onPlay: (controller) => controller.repeat(reverse: true))
            .tint(color: const Color(0xFF00D2FF), duration: 200.ms),
      ),
    );
  }

  Widget _drawerItem(String title, IconData icon, GlobalKey key) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF00D2FF)),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16, color: Colors.white),
      ),
      onTap: () {
        Navigator.pop(context);
        _scrollToSection(key);
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      hoverColor: const Color(0xFF00D2FF).withOpacity(0.1),
    );
  }

  // --- 1. HERO SECTION ---
  Widget _buildHeroSection(bool isMobile) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF00E676).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: const Color(0xFF00E676).withOpacity(0.5),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: Color(0xFF00E676),
                                shape: BoxShape.circle,
                              ),
                            )
                            .animate(
                              onPlay: (controller) =>
                                  controller.repeat(reverse: true),
                            )
                            .fadeOut(duration: 600.ms),
                        const SizedBox(width: 10),
                        const Text(
                          'Available for New Opportunities',
                          style: TextStyle(
                            color: Color(0xFF00E676),
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ).animate().fade(duration: 600.ms).slideY(begin: 0.3),

                  const SizedBox(height: 25),
                  Text(
                    'Hello, I\'m',
                    style: TextStyle(
                      fontSize: isMobile ? 20 : 28,
                      color: Colors.white70,
                    ),
                  ).animate().fade(delay: 200.ms),

                  ShaderMask(
                        shaderCallback: (bounds) => const LinearGradient(
                          colors: [Color(0xFF00D2FF), Color(0xFF00E676)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ).createShader(bounds),
                        child: Text(
                          'Azza Sadawy',
                          style: GoogleFonts.outfit(
                            fontSize: isMobile ? 48 : 80,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            height: 1.1,
                          ),
                        ),
                      )
                      .animate()
                      .fade(delay: 400.ms, duration: 800.ms)
                      .shimmer(delay: 1.seconds, duration: 2.seconds),

                  Text(
                    'Mobile App Flutter Developer',
                    style: GoogleFonts.outfit(
                      fontSize: isMobile ? 24 : 40,
                      fontWeight: FontWeight.w600,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ).animate().fade(delay: 600.ms).slideX(begin: -0.1),

                  const SizedBox(height: 30),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 700),
                    child: Text(
                      'I build scalable, high-performance, and beautifully designed cross-platform applications for Android and iOS. Expert in Clean Architecture, state management, and delivering pixel-perfect UI/UX.',
                      style: TextStyle(
                        fontSize: isMobile ? 16 : 20,
                        color: Colors.white60,
                        height: 1.6,
                      ),
                    ),
                  ).animate().fade(delay: 800.ms),

                  const SizedBox(height: 40),
                  Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    children: [
                      ElevatedButton(
                        onPressed: () => _scrollToSection(_projectsKey),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00D2FF),
                          foregroundColor: const Color(0xFF0B0F19),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 20,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 10,
                          shadowColor: const Color(0xFF00D2FF).withOpacity(0.5),
                        ),
                        child: const Text(
                          'View Projects',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ).animate().fade(delay: 1000.ms).scale(),

                      OutlinedButton.icon(
                        onPressed: () =>
                            _launchURL('https://github.com/azzas7dawy'),
                        icon: const Icon(Icons.code),
                        label: const Text(
                          'GitHub',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          side: const BorderSide(
                            color: Colors.white30,
                            width: 2,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 20,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ).animate().fade(delay: 1100.ms).scale(),
                    ],
                  ),
                ],
              ),
            ),
            if (!isMobile) ...[
              Expanded(
                flex: 2,
                child: Center(
                  child: Container(
                    width: 350,
                    height: 350,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFF00D2FF).withOpacity(0.2),
                          const Color(0xFF00E676).withOpacity(0.2),
                        ],
                      ),
                      border: Border.all(
                        color: const Color(0xFF00D2FF).withOpacity(0.5),
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF00D2FF).withOpacity(0.15),
                          blurRadius: 50,
                          spreadRadius: 20,
                        ),
                      ],
                    ),
                    child: Center(
                      child:
                          const Icon(
                                Icons.developer_mode,
                                size: 120,
                                color: Colors.white70,
                              )
                              .animate(
                                onPlay: (controller) =>
                                    controller.repeat(reverse: true),
                              )
                              .scale(
                                begin: const Offset(1, 1),
                                end: const Offset(1.1, 1.1),
                                duration: 2.seconds,
                              ),
                    ),
                  ).animate().fade(delay: 500.ms, duration: 1.seconds).scale(),
                ),
              ),
            ],
          ],
        );
      },
    );
  }

  // --- 2. ABOUT & EDUCATION ---
  Widget _buildAboutSection(bool isMobile) {
    final aboutCard = Container(
      padding: const EdgeInsets.all(30),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.person_outline,
            size: 40,
            color: Color(0xFF00D2FF),
          ),
          const SizedBox(height: 20),
          const Text(
            'About Me',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 15),
          const Text(
            'I am a passionate Mobile App Developer dedicated to crafting exceptional mobile experiences. I specialize in Flutter and Dart, focusing on writing clean, scalable, and maintainable code using advanced design patterns.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white70,
              height: 1.6,
            ),
          ),
        ],
      ),
    ).animate().slideX(begin: -0.2).fade(duration: 600.ms);

    final eduCard = Container(
      padding: const EdgeInsets.all(30),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.school_outlined,
            size: 40,
            color: Color(0xFF00E676),
          ),
          const SizedBox(height: 20),
          const Text(
            'Education & Training',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 25),
          _timelineItem(
            title: 'Intensive Code Camps - Mobile Development',
            subtitle: 'Information Technology Institute (ITI), Minia Branch',
            date: '11/2024 – 03/2025',
            description:
                'Completed intensive training program focused on modern mobile and web development practices, cross-platform technologies, and industry best practices.',
          ),
          const SizedBox(height: 25),
          _timelineItem(
            title: 'Bachelor\'s Degree in Computer Science',
            subtitle: 'Minia University, Egypt',
            date: '10/2020 – 10/2024',
            description:
                'Foundational knowledge in algorithms, data structures, software engineering, and systems design.',
          ),
        ],
      ),
    ).animate().slideX(begin: 0.2).fade(duration: 600.ms);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader('01.', 'About & Education'),
        const SizedBox(height: 40),
        if (isMobile)
          Column(
            children: [
              aboutCard,
              const SizedBox(height: 30),
              eduCard,
            ],
          )
        else
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(child: aboutCard),
                const SizedBox(width: 30),
                Expanded(child: eduCard),
              ],
            ),
          ),
      ],
    );
  }

  // --- 3. EXPERIENCE ---
  Widget _buildExperienceSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader('02.', 'Professional Experience'),
        const SizedBox(height: 40),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(35),
          decoration: _cardDecoration(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Freelance Flutter Developer',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF00D2FF).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'September 2024',
                      style: TextStyle(
                        color: Color(0xFF00D2FF),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                'Sabooba App Team',
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF00E676),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              _bulletPoint(
                'Developed user interface for Sabooba App as part of a development team.',
              ),
              _bulletPoint(
                'Collaborated with team members to deliver a high-quality mobile application for classified ads management.',
              ),
              _bulletPoint(
                'Implemented responsive and user-friendly UI components using Flutter.',
              ),
              _bulletPoint(
                'Contributed to multi-language support and theme customization features.',
              ),
            ],
          ),
        ).animate().scale(begin: const Offset(0.95, 0.95)).fade(duration: 600.ms),
      ],
    );
  }

  // --- 4. SKILLS SECTION ---
  Widget _buildSkillsSection(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader('03.', 'Technical Expertise'),
        const SizedBox(height: 40),

        Wrap(
          spacing: 20,
          runSpacing: 20,
          children: [
            _skillCategoryCard('Mobile Development', Icons.smartphone, [
              'Flutter',
              'Dart',
              'Responsive Design',
              'Mobile UI/UX',
              'Platform Channels',
              'Flavors',
              'Dynamic Links',
            ]),
            _skillCategoryCard('Architecture & State', Icons.architecture, [
              'Clean Architecture',
              'SOLID Principles',
              'OOP',
              'Design Patterns',
              'Bloc (Cubit)',
              'Provider',
            ]),
            _skillCategoryCard(
              'Backend & Firebase',
              Icons.cloud_done_outlined,
              [
                'RESTful APIs',
                'HTTP / Dio',
                'Firebase Auth',
                'Firestore',
                'Storage',
                'FCM',
                'App Distribution',
              ],
            ),
            _skillCategoryCard('Tools & Testing', Icons.build_circle_outlined, [
              'Git / GitHub',
              'Android Studio / VS Code',
              'Unit Testing',
              'Widget Testing',
              'Postman',
            ]),
            _skillCategoryCard('Web & Others', Icons.web, [
              'HTML / CSS',
              'JavaScript',
              'React',
              'Java',
              'C#',
              'Material UI',
            ]),
            _skillCategoryCard('Integrations', Icons.api, [
              'Google Maps',
              'Live Location',
              'Paymob',
              'PayPal',
              'i18n (Multi-language)',
            ]),
          ],
        ),
      ],
    );
  }

  Widget _skillCategoryCard(String title, IconData icon, List<String> skills) {
    return Container(
      width: 350,
      padding: const EdgeInsets.all(25),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: const Color(0xFF00D2FF), size: 28),
              const SizedBox(width: 15),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: skills
                .map(
                  (skill) => Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0B0F19),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.white10),
                    ),
                    child: Text(
                      skill,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.1);
  }

  // --- 5. PROJECTS SECTION ---
  Widget _buildProjectsSection(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader('04.', 'Featured Projects'),
        const SizedBox(height: 40),
        ProjectShowcaseCard(
          title: 'Rehala (رحلة) - Live App',
          date: '2024',
          description:
              'A live ride-hailing and service app available on Google Play Store. Built for seamless real-time interaction and modern mobile UX.',
          techStack: ['Flutter', 'Google Maps', 'Live Location', 'APIs'],
          videoAsset: 'assets/video/rehala.mp4',
          isReversed: false,
          isMobile: isMobile,
        ),
        const SizedBox(height: 80),

        ProjectShowcaseCard(
          title: 'Fintech App - Cryptocurrency Portfolio Manager',
          date: 'Oct 2025 – Dec 2025',
          description:
              'Advanced fintech application enabling users to track cryptocurrency markets, manage investment portfolios, and simulate trading operations using real-time market data.',
          techStack: [
            'Clean Architecture',
            'SOLID',
            'Bloc (Cubit)',
            'CoinGecko API',
            'Biometric Auth',
            'Dio / Retrofit',
          ],
          videoAsset: 'assets/video/finitch.mp4',
          isReversed: true,
          isMobile: isMobile,
        ),
        const SizedBox(height: 80),

        ProjectShowcaseCard(
          title: 'Restaurant App (ITI Graduation Project)',
          date: 'Feb 2025 – Mar 2025',
          description:
              'Comprehensive restaurant management application enhancing the dining experience with seamless ordering, table reservation, and payment capabilities (Cash on Delivery and Paymob).',
          techStack: [
            'Flutter',
            'Bloc (Cubit)',
            'Firebase',
            'Paymob',
            'Interactive UI',
          ],
          videoAsset: 'assets/video/resturant.mp4',
          isReversed: false,
          isMobile: isMobile,
        ),
        const SizedBox(height: 80),

        ProjectShowcaseCard(
          title: 'E-Commerce App (Clothing Store)',
          date: '04/2024 – 06/2024',
          description:
              'Comprehensive e-commerce mobile application featuring admin panel and user interface for clothing retail business. Includes package management, wallet transactions, and real-time status.',
          techStack: [
            'Flutter',
            'Firebase Auth',
            'Firestore',
            'Cloud Storage',
            'Bloc (Cubit)',
          ],
          githubLink: 'https://github.com/azzas7dawy/E-Commerce-App-2',
          isReversed: true,
          isMobile: isMobile,
        ),
        const SizedBox(height: 80),

        ProjectShowcaseCard(
          title: 'Pet App',
          date: '2024',
          description:
              'A comprehensive mobile application dedicated to pet care, adoption, and management with a smooth and interactive user interface.',
          techStack: ['Flutter', 'Custom UI', 'Animations'],
          videoAsset: 'assets/video/pet_app.mp4',
          isReversed: false,
          isMobile: isMobile,
        ),
        const SizedBox(height: 80),

        // Grid for other projects
        LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth > 800;
            return GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: isWide ? 2 : 1,
              mainAxisSpacing: 25,
              crossAxisSpacing: 25,
              childAspectRatio: isWide ? 1.6 : 1.2,
              children: [
                _minorProjectCard(
                  title: 'DocLink - Healthcare System',
                  grade: 'Grade: A+',
                  date: '04/2023 – 01/2024',
                  desc:
                      'Advanced healthcare platform connecting doctors and patients with streamlined appointment booking, real-time chat, and hospital referral system.',
                  tech: ['RESTful APIs', 'Firebase Auth', 'Bloc (Cubit)'],
                ),
                _minorProjectCard(
                  title: 'ChatApp',
                  grade: 'Grade: A+',
                  date: '08/2024 – 10/2024',
                  desc:
                      'Real-time messaging application built from scratch utilizing Firebase for secure data storage and Provider for efficient state management.',
                  tech: ['Firestore', 'Provider', 'Custom UI'],
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  // _projectShowcase replaced by ProjectShowcaseCard class at the bottom

  Widget _minorProjectCard({
    required String title,
    required String grade,
    required String date,
    required String desc,
    required List<String> tech,
  }) {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(
                Icons.folder_outlined,
                size: 36,
                color: Color(0xFF00D2FF),
              ),
              if (grade.isNotEmpty)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF00E676).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    grade,
                    style: const TextStyle(
                      color: Color(0xFF00E676),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            date,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white.withOpacity(0.5),
            ),
          ),
          const SizedBox(height: 15),
          Expanded(
            child: Text(
              desc,
              style: TextStyle(
                fontSize: 14,
                color: Colors.white.withOpacity(0.7),
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 15),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: tech
                .map(
                  (t) => Text(
                    t,
                    style: const TextStyle(
                      color: Colors.white54,
                      fontSize: 12,
                      fontFamily: 'FiraCode',
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    ).animate().scale(begin: const Offset(0.9, 0.9)).fadeIn(duration: 600.ms);
  }

  // --- 6. CONTACT SECTION ---
  Widget _buildContactSection(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader('05.', 'Get In Touch'),
        const SizedBox(height: 40),
        Center(
          child: Container(
            width: isMobile ? double.infinity : 700,
            padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [const Color(0xFF151C2C), const Color(0xFF0B0F19)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: const Color(0xFF00D2FF).withOpacity(0.2),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF00D2FF).withOpacity(0.05),
                  blurRadius: 40,
                  spreadRadius: 10,
                ),
              ],
            ),
            child: Column(
              children: [
                const Text(
                  'Let\'s Build Something Great Together!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'I am currently open for full-time Flutter developer positions and freelance projects. Whether you have a question or just want to say hi, I\'ll try my best to get back to you!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 18,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 40),
                Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  alignment: WrapAlignment.center,
                  children: [
                    ElevatedButton.icon(
                          onPressed: () =>
                              _launchURL('mailto:azzasadawy8@gmail.com'),
                          icon: const Icon(Icons.email_outlined),
                          label: const Text(
                            'Email Me',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF00D2FF),
                            foregroundColor: const Color(0xFF0B0F19),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 30,
                              vertical: 20,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        )
                        .animate(onPlay: (c) => c.repeat(reverse: true))
                        .shimmer(duration: 2.seconds, delay: 1.seconds),

                    OutlinedButton.icon(
                      onPressed: () => _launchURL('https://wa.me/201119565242'),
                      icon: const Icon(Icons.phone_outlined),
                      label: const Text(
                        'WhatsApp',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF00E676),
                        side: const BorderSide(
                          color: Color(0xFF00E676),
                          width: 2,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 20,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ).animate().slideY(begin: 0.1).fadeIn(duration: 800.ms),
        ),
      ],
    );
  }

  // --- HELPERS ---
  Widget _sectionHeader(String number, String title) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          number,
          style: GoogleFonts.firaCode(
            fontSize: 24,
            color: const Color(0xFF00D2FF),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 15),
        Text(
          title,
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(width: 20),
        Expanded(child: Container(height: 1, color: Colors.white24)),
      ],
    ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.1);
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: const Color(0xFF151C2C),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: Colors.white.withOpacity(0.05)),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          blurRadius: 15,
          offset: const Offset(0, 5),
        ),
      ],
    );
  }

  Widget _timelineItem({
    required String title,
    required String subtitle,
    required String date,
    required String description,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: const BoxDecoration(
                color: Color(0xFF00D2FF),
                shape: BoxShape.circle,
              ),
            ),
            Container(
              width: 2,
              height: 80,
              color: const Color(0xFF00D2FF).withOpacity(0.3),
            ),
          ],
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 15,
                  color: Color(0xFF00E676),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                date,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                description,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.7),
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _bulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 6),
            child: Icon(Icons.arrow_right, color: Color(0xFF00D2FF), size: 20),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white.withOpacity(0.8),
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomVideoPlayer extends StatefulWidget {
  const _CustomVideoPlayer({required this.assetPath});
  final String assetPath;

  @override
  State<_CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<_CustomVideoPlayer> {
  late VideoPlayerController _controller;
  bool _isHovering = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.assetPath)
      ..setLooping(true)
      ..setVolume(0)
      ..initialize().then((_) {
        if (mounted) setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized) {
      return Container(
        color: const Color(0xFF0B0F19),
        child: const Center(
          child: CircularProgressIndicator(color: Color(0xFF00D2FF)),
        ),
      );
    }

    return MouseRegion(
      onEnter: (_) {
        setState(() => _isHovering = true);
        _controller.play();
      },
      onExit: (_) {
        setState(() => _isHovering = false);
        _controller.pause();
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          FittedBox(
            fit: BoxFit.cover,
            child: SizedBox(
              width: _controller.value.size.width,
              height: _controller.value.size.height,
              child: VideoPlayer(_controller),
            ),
          ),
          // Overlay to show when not playing
          AnimatedOpacity(
            opacity: _isHovering || _controller.value.isPlaying ? 0.0 : 0.6,
            duration: const Duration(milliseconds: 300),
            child: Container(color: Colors.black),
          ),
          if (!_isHovering && !_controller.value.isPlaying)
            const Center(
              child: Icon(
                Icons.play_circle_fill,
                size: 64,
                color: Colors.white70,
              ),
            ),
        ],
      ),
    );
  }
}

class ProjectShowcaseCard extends StatefulWidget {
  final String title;
  final String date;
  final String description;
  final List<String> techStack;
  final String? videoAsset;
  final String? githubLink;
  final bool isReversed;
  final bool isMobile;

  const ProjectShowcaseCard({
    super.key,
    required this.title,
    required this.date,
    required this.description,
    required this.techStack,
    this.videoAsset,
    this.githubLink,
    required this.isReversed,
    required this.isMobile,
  });

  @override
  State<ProjectShowcaseCard> createState() => _ProjectShowcaseCardState();
}

class _ProjectShowcaseCardState extends State<ProjectShowcaseCard> {
  bool _isVisible = false;

  void _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          widget.date,
          style: const TextStyle(
            color: Color(0xFF00E676),
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          widget.title,
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF151C2C),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
            border: Border.all(color: Colors.white.withOpacity(0.05)),
          ),
          child: Text(
            widget.description,
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 16,
              height: 1.6,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: widget.techStack
              .map(
                (t) => Text(
                  t,
                  style: const TextStyle(
                    color: Color(0xFF00D2FF),
                    fontSize: 14,
                    fontFamily: 'FiraCode',
                  ),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 25),
        if (widget.githubLink != null)
          OutlinedButton.icon(
            onPressed: () => _launchURL(widget.githubLink!),
            icon: const Icon(Icons.code),
            label: const Text('View Source'),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              side: const BorderSide(color: Color(0xFF00D2FF)),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            ),
          ),
      ],
    );

    final media = Container(
      height: 350,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF00D2FF).withOpacity(0.3),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF00D2FF).withOpacity(0.1),
            blurRadius: 30,
            spreadRadius: -5,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: widget.videoAsset != null
            ? _CustomVideoPlayer(assetPath: widget.videoAsset!)
            : Container(
                color: const Color(0xFF0B0F19),
                child: const Center(
                  child: Icon(
                    Icons.image_outlined,
                    size: 80,
                    color: Colors.white24,
                  ),
                ),
              ),
      ),
    );

    Widget layout;
    if (widget.isMobile) {
      layout = Column(
        children: [
          media
              .animate(target: _isVisible ? 1 : 0)
              .slideY(begin: 0.5, duration: 1000.ms, curve: Curves.easeOutCubic)
              .fade(duration: 1000.ms),
          const SizedBox(height: 30),
          content
              .animate(target: _isVisible ? 1 : 0)
              .slideY(begin: 0.5, duration: 1000.ms, curve: Curves.easeOutCubic)
              .fade(duration: 1000.ms, delay: 200.ms),
        ],
      );
    } else {
      layout = Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: widget.isReversed
            ? [
                Expanded(
                  flex: 5,
                  child: media
                      .animate(target: _isVisible ? 1 : 0)
                      .slideX(
                        begin: -1.0,
                        duration: 1000.ms,
                        curve: Curves.easeOutCubic,
                      )
                      .fade(duration: 1000.ms),
                ),
                const SizedBox(width: 50),
                Expanded(
                  flex: 4,
                  child: content
                      .animate(target: _isVisible ? 1 : 0)
                      .slideX(
                        begin: 1.0,
                        duration: 1000.ms,
                        curve: Curves.easeOutCubic,
                      )
                      .fade(duration: 1000.ms),
                ),
              ]
            : [
                Expanded(
                  flex: 4,
                  child: content
                      .animate(target: _isVisible ? 1 : 0)
                      .slideX(
                        begin: -1.0,
                        duration: 1000.ms,
                        curve: Curves.easeOutCubic,
                      )
                      .fade(duration: 1000.ms),
                ),
                const SizedBox(width: 50),
                Expanded(
                  flex: 5,
                  child: media
                      .animate(target: _isVisible ? 1 : 0)
                      .slideX(
                        begin: 1.0,
                        duration: 1000.ms,
                        curve: Curves.easeOutCubic,
                      )
                      .fade(duration: 1000.ms),
                ),
              ],
      );
    }

    return VisibilityDetector(
      key: Key(widget.title),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.1 && !_isVisible) {
          setState(() {
            _isVisible = true;
          });
        }
      },
      child: layout,
    );
  }
}
