import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../routes/app_routes.dart';
import '../theme/app_theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.scaffoldBgColor,
      appBar: AppBar(
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.layers_rounded, color: AppTheme.primaryColor, size: 24),
            SizedBox(width: 8),
            Text('MultiScreen App'),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'App Info',
            icon: const Icon(Icons.info_outline_rounded, color: AppTheme.textSecondary),
            onPressed: () => _showAppInfoDialog(context),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hero Banner Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppTheme.primaryColor, Color(0xFF6366F1), Color(0xFF818CF8)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.primaryColor.withValues(alpha: 0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.star_rounded, color: Colors.amber, size: 16),
                          SizedBox(width: 6),
                          Text(
                            '3-Screen Architecture',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Welcome to the\nRegistration Portal',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        height: 1.2,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Seamless navigation powered by Flutter named routes with interactive form validation.',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.9),
                        fontSize: 14,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // Section Title
              const Text(
                'Application Workflow',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.textPrimary,
                  letterSpacing: -0.3,
                ),
              ),
              const SizedBox(height: 14),

              // Step 1 Card: Home Screen
              _buildWorkflowTile(
                step: '1',
                title: 'Home Screen',
                subtitle: 'Named route: "/" • Welcome hub & overview',
                icon: Icons.home_rounded,
                color: const Color(0xFF6366F1),
                isActive: true,
              ),
              const SizedBox(height: 12),

              // Step 2 Card: Form Screen
              _buildWorkflowTile(
                step: '2',
                title: 'Registration Form',
                subtitle: 'Named route: "/form" • Validation rules & input controls',
                icon: Icons.assignment_turned_in_rounded,
                color: const Color(0xFF0EA5E9),
                isActive: false,
              ),
              const SizedBox(height: 12),

              // Step 3 Card: Detail Screen
              _buildWorkflowTile(
                step: '3',
                title: 'User Profile Detail',
                subtitle: 'Named route: "/detail" • Receives dynamic user arguments',
                icon: Icons.badge_rounded,
                color: const Color(0xFF10B981),
                isActive: false,
              ),

              const SizedBox(height: 32),

              // Call to action button
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.form);
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Proceed to Registration'),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward_rounded, size: 20),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Quick Preview Sample Detail Screen Button
              OutlinedButton.icon(
                onPressed: () {
                  final sampleUser = UserModel(
                    name: 'Vrutti Patil',
                    email: 'vrutti.patil@example.com',
                    phone: '9876543210',
                    registrationDate: DateTime.now(),
                  );
                  Navigator.pushNamed(
                    context,
                    AppRoutes.detail,
                    arguments: sampleUser,
                  );
                },
                icon: const Icon(Icons.remove_red_eye_outlined, size: 18),
                label: const Text('Quick Preview Demo Profile'),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWorkflowTile({
    required String step,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required bool isActive,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isActive ? AppTheme.primaryLight : AppTheme.cardBorderColor,
          width: isActive ? 1.5 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    if (isActive) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          'Current',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          CircleAvatar(
            radius: 12,
            backgroundColor: color.withValues(alpha: 0.15),
            child: Text(
              step,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAppInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Row(
          children: [
            Icon(Icons.info_rounded, color: AppTheme.primaryColor),
            SizedBox(width: 8),
            Text('About MultiScreen'),
          ],
        ),
        content: const Text(
          'This app demonstrates a complete 3-screen navigation flow using Flutter named routes ("/", "/form", "/detail").\n\n'
          'It includes comprehensive registration form validation (Name, Email regex, Phone length, Password length & confirmation, Terms agreement) and passes data seamlessly to the Detail screen.',
          style: TextStyle(color: AppTheme.textSecondary, height: 1.4),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Got it', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
