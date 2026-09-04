import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF4F7FB),
        fontFamily: 'Roboto',
      ),
      home: const ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF4F7CAC);
    const darkColor = Color(0xFF263B53);
    const lightBlue = Color(0xFFEAF3FB);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top Header
            Container(
              height: 210,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF4F7CAC), Color(0xFF6D9BC5)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),

              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'My Profile',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 8),

                  Text(
                    'Welcome back!',
                    style: TextStyle(color: Colors.white70, fontSize: 15),
                  ),
                ],
              ),
            ),

            // Profile Card
            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(20, 70, 20, 20),
              padding: const EdgeInsets.fromLTRB(22, 65, 22, 22),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.10),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),

              child: Column(
                children: [
                  // Profile Icon
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      color: Color(0xFFEAF3FB),
                      shape: BoxShape.circle,
                    ),

                    child: const CircleAvatar(
                      radius: 55,
                      backgroundColor: Color(0xFFDCECF9),
                      child: Icon(
                        Icons.person,
                        size: 65,
                        color: Color(0xFF4F7CAC),
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  // Name
                  const Text(
                    'Vrutti Patil',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF263B53),
                    ),
                  ),

                  const SizedBox(height: 6),

                  // Profession
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEAF3FB),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Flutter Developer',
                      style: TextStyle(
                        color: Color(0xFF4F7CAC),
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Divider(color: Color(0xFFE8EDF3)),

                  const SizedBox(height: 15),

                  // Email
                  const Row(
                    children: [
                      Icon(
                        Icons.email_outlined,
                        color: Color(0xFF4F7CAC),
                        size: 23,
                      ),
                      SizedBox(width: 14),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Email',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),

                            SizedBox(height: 3),

                            Text(
                              'vruttipatil1396@gmail.com',
                              style: TextStyle(
                                color: Color(0xFF263B53),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 18),

                  // Location
                  const Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: Color(0xFF4F7CAC),
                        size: 23,
                      ),
                      SizedBox(width: 14),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Location',
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),

                          SizedBox(height: 3),

                          Text(
                            'Mumbai, India',
                            style: TextStyle(
                              color: Color(0xFF263B53),
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 18),

                  // Phone
                  const Row(
                    children: [
                      Icon(
                        Icons.phone_outlined,
                        color: Color(0xFF4F7CAC),
                        size: 23,
                      ),
                      SizedBox(width: 14),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Phone',
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),

                          SizedBox(height: 3),

                          Text(
                            '9321428539',
                            style: TextStyle(
                              color: Color(0xFF263B53),
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 22),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
