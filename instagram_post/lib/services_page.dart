import 'package:flutter/material.dart';

// ===========================================================
// SERVICES PAGE
// ===========================================================

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),

      // =====================================================
      // APP BAR
      // =====================================================
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        centerTitle: false,

        title: const Row(
          children: [
            Icon(
              Icons.camera_alt_outlined,
              color: Colors.black,
              size: 28,
            ),
            SizedBox(width: 10),
            Text(
              'Instagram Services',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                letterSpacing: -0.5,
              ),
            ),
          ],
        ),

        actions: [
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Search services tapped'),
                  duration: Duration(seconds: 1),
                ),
              );
            },
            icon: const Icon(
              Icons.search,
              color: Colors.black,
            ),
          ),
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('More options tapped'),
                  duration: Duration(seconds: 1),
                ),
              );
            },
            icon: const Icon(
              Icons.more_vert,
              color: Colors.black,
            ),
          ),
        ],
      ),

      // =====================================================
      // BODY / SERVICES LIST
      // =====================================================
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // =================================================
            // HEADER BANNER
            // =================================================
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF833AB4),
                    Color(0xFFF77737),
                    Color(0xFFFFDC80),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.purple.withValues(alpha: 0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.25),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.auto_awesome,
                          color: Colors.white,
                          size: 26,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          'Creator & Business Suite',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Explore premium services to boost your profile, enhance reach, and monetize your content.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Get Started clicked!'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF833AB4),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                    ),
                    child: const Text(
                      'Get Started',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // =================================================
            // SECTION TITLE
            // =================================================
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Text(
                    'Available Services',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  Spacer(),
                  Text(
                    '8 Services',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            // =================================================
            // SERVICE 1: CONTENT CREATION & REELS
            // =================================================
            const ServiceCard(
              icon: Icons.movie_creation_outlined,
              serviceName: 'Content Creation & Reels',
              description:
                  'Professional video editing, trending transitions, and viral templates for high engagement.',
              buttonText: 'Create Reel',
              badgeText: 'Popular',
              iconGradient: [Color(0xFF833AB4), Color(0xFFFD1D1D)],
            ),

            const Divider(
              indent: 16,
              endIndent: 16,
              height: 1,
              thickness: 0.5,
            ),

            // =================================================
            // SERVICE 2: GROWTH & ANALYTICS
            // =================================================
            const ServiceCard(
              icon: Icons.insights_outlined,
              serviceName: 'Growth & Social Analytics',
              description:
                  'In-depth audience insights, post reach analysis, follower growth tracking, and peak hours.',
              buttonText: 'View Insights',
              badgeText: 'Trending',
              iconGradient: [Color(0xFF405DE6), Color(0xFF5851DB)],
            ),

            const Divider(
              indent: 16,
              endIndent: 16,
              height: 1,
              thickness: 0.5,
            ),

            // =================================================
            // SERVICE 3: BRAND SPONSORSHIPS
            // =================================================
            const ServiceCard(
              icon: Icons.monetization_on_outlined,
              serviceName: 'Brand Sponsorships & Collabs',
              description:
                  'Connect with top verified brands, manage paid campaigns, and generate creator media kits.',
              buttonText: 'Find Collabs',
              badgeText: 'Monetize',
              iconGradient: [Color(0xFF00B09B), Color(0xFF96C93D)],
            ),

            const Divider(
              indent: 16,
              endIndent: 16,
              height: 1,
              thickness: 0.5,
            ),

            // =================================================
            // SERVICE 4: VERIFICATION & SECURITY
            // =================================================
            const ServiceCard(
              icon: Icons.verified_outlined,
              serviceName: 'Account Verification & Badge',
              description:
                  'Request Meta verified blue badge, enhance two-factor protection, and secure account assets.',
              buttonText: 'Get Verified',
              badgeText: 'Official',
              iconGradient: [Color(0xFF00C6FF), Color(0xFF0072FF)],
            ),

            const Divider(
              indent: 16,
              endIndent: 16,
              height: 1,
              thickness: 0.5,
            ),

            // =================================================
            // SERVICE 5: INSTAGRAM SHOP
            // =================================================
            const ServiceCard(
              icon: Icons.storefront_outlined,
              serviceName: 'Instagram Shop Setup',
              description:
                  'Create an interactive product showcase, tag products in posts & stories, and enable in-app checkout.',
              buttonText: 'Open Shop',
              badgeText: 'Business',
              iconGradient: [Color(0xFFFF512F), Color(0xFFDD2476)],
            ),

            const Divider(
              indent: 16,
              endIndent: 16,
              height: 1,
              thickness: 0.5,
            ),

            // =================================================
            // SERVICE 6: AUTOMATED MESSAGING (DM)
            // =================================================
            const ServiceCard(
              icon: Icons.chat_bubble_outline_rounded,
              serviceName: 'Automated DM & Support',
              description:
                  'Configure instant keyword responses, FAQ chatbots, and unified customer inquiries management.',
              buttonText: 'Set Up DM',
              badgeText: 'Automation',
              iconGradient: [Color(0xFF654EA3), Color(0xFFEAAFC8)],
            ),

            const Divider(
              indent: 16,
              endIndent: 16,
              height: 1,
              thickness: 0.5,
            ),

            // =================================================
            // SERVICE 7: HASHTAG & SEO OPTIMIZER
            // =================================================
            const ServiceCard(
              icon: Icons.tag_rounded,
              serviceName: 'Hashtag & SEO Optimizer',
              description:
                  'Discover high-converting hashtags and keywords to maximize visibility on the Explore feed.',
              buttonText: 'Optimize',
              badgeText: 'SEO',
              iconGradient: [Color(0xFFFF8008), Color(0xFFFFC837)],
            ),

            const Divider(
              indent: 16,
              endIndent: 16,
              height: 1,
              thickness: 0.5,
            ),

            // =================================================
            // SERVICE 8: AR FILTERS & EFFECTS
            // =================================================
            const ServiceCard(
              icon: Icons.auto_awesome_outlined,
              serviceName: 'Custom AR Filters & Effects',
              description:
                  'Design and publish personalized augmented reality face filters and story camera effects.',
              buttonText: 'Try Effects',
              badgeText: 'Design',
              iconGradient: [Color(0xFF8E2DE2), Color(0xFF4A00E0)],
            ),

            const SizedBox(height: 16),

            // =================================================
            // FOOTER HELP CARD
            // =================================================
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.grey.shade300,
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.help_outline_rounded,
                    color: Colors.black54,
                    size: 32,
                  ),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Need assistance?',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Our creator support team is here 24/7.',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Contact support tapped!'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    },
                    child: const Text('Contact'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

// ===========================================================
// REUSABLE SERVICE CARD WIDGET
// ===========================================================

class ServiceCard extends StatelessWidget {
  final IconData icon;
  final String serviceName;
  final String description;
  final String buttonText;
  final String badgeText;
  final List<Color> iconGradient;

  const ServiceCard({
    super.key,
    required this.icon,
    required this.serviceName,
    required this.description,
    required this.buttonText,
    required this.badgeText,
    required this.iconGradient,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: Colors.grey.shade200,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TOP ROW: ICON + TITLE + BADGE
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SERVICE ICON WITH GRADIENT BACKGROUND
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: iconGradient,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: iconGradient.first.withValues(alpha: 0.3),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 26,
                  ),
                ),

                const SizedBox(width: 14),

                // SERVICE NAME & BADGE
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              serviceName,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Colors.grey.shade300,
                                width: 0.8,
                              ),
                            ),
                            child: Text(
                              badgeText,
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey.shade800,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 6),

                      // SHORT DESCRIPTION
                      Text(
                        description,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade600,
                          height: 1.35,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            // BOTTOM ROW: ACTION BUTTON & ARROW
            Row(
              children: [
                // SERVICE ACTION BUTTON
                ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('$serviceName selected!'),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    buttonText,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                const SizedBox(width: 8),

                // LEARN MORE OUTLINED BUTTON
                OutlinedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Details for $serviceName'),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.black87,
                    side: BorderSide(
                      color: Colors.grey.shade300,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Learn More',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),

                const Spacer(),

                // ARROW ICON BUTTON
                IconButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Navigating to $serviceName...'),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
