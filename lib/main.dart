// lib/main.dart
// MedCure - Premium Medical Splash Screen with Login Options
import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';

void main() {
  runApp(const MedCureApp());
}

class MedCureApp extends StatelessWidget {
  const MedCureApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Removes the debug banner
      title: 'MedCure',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF0EA5A5)), // Professional teal
        fontFamily: 'Roboto',
      ),
      home: const SplashScreen(),
      // Define the routes for navigation
      routes: {
        '/welcome': (context) => const WelcomeScreen(),
        '/patientLogin': (context) => const PatientLoginScreen(),
        '/doctorLogin': (context) => const DoctorLoginScreen(),
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize animation controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    // Configure scale animation (icon grows into view)
    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );

    // Configure fade animation (text and elements fade in)
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInCubic),
    );

    // Start the animations
    _controller.forward();

    // Navigate to the welcome screen after 3 seconds
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const WelcomeScreen()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0EA5A5), // Professional Teal
              Color(0xFF2563EB), // Trustworthy Blue
            ],
          ),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background decorative elements for depth
            Positioned(
              top: -50,
              right: -30,
              child: Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.1),
                ),
              ),
            ),
            Positioned(
              bottom: -60,
              left: -20,
              child: Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.08),
                ),
              ),
            ),

            // Main Content Center
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Animated Logo Container
                  ScaleTransition(
                    scale: _scaleAnimation,
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.95),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              blurRadius: 25,
                              spreadRadius: 2,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Icon(
                            Icons.medical_services_rounded,
                            size: 60,
                            color: Colors.teal[700],
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 40), // Spacing

                  // App Name Text
                  const Text(
                    'MedCure',
                    style: TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: 1.0,
                    ),
                  ),

                  const SizedBox(height: 10), // Spacing

                  // Tagline Text
                  const Text(
                    'Precision Care, Connected',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 0.5,
                    ),
                  ),

                  const SizedBox(height: 50), // Spacing

                  // Modern Progress Indicator
                  SizedBox(
                    width: 220,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(3),
                      child: LinearProgressIndicator(
                        backgroundColor: Colors.white.withOpacity(0.3),
                        valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                        minHeight: 4,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Footer Text
            Positioned(
              bottom: 30,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Text(
                    'HIPAA Compliant • Secure • Trusted',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Version 1.0.0',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Welcome Screen with Two Buttons
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MedCure'),
        backgroundColor: const Color(0xFF0EA5A5),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App Icon and Welcome Message
            const Icon(
              Icons.health_and_safety,
              size: 70,
              color: Color(0xFF0EA5A5),
            ),
            const SizedBox(height: 20),
            const Text(
              'Welcome to the Future of Healthcare',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            const Text(
              'Please choose your access portal',
              style: TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),

            // Button 1: Patient Portal
            SizedBox(
              width: 250,
              child: ElevatedButton.icon(
                onPressed: () {
                  // Navigate to Patient Login Screen
                  Navigator.pushNamed(context, '/patientLogin');
                },
                icon: const Icon(Icons.person_outline),
                label: const Text('Patient Portal'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0EA5A5), // Teal color
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Button 2: Medical Professional
            SizedBox(
              width: 250,
              child: ElevatedButton.icon(
                onPressed: () {
                  // Navigate to Doctor Login Screen
                  Navigator.pushNamed(context, '/doctorLogin');
                },
                icon: const Icon(Icons.medical_services_outlined),
                label: const Text('Medical Professional'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2563EB), // Blue color
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Placeholder Screen for Patient Login
class PatientLoginScreen extends StatelessWidget {
  const PatientLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Portal'),
        backgroundColor: const Color(0xFF0EA5A5),
      ),
      body: const Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Secure Patient Login',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Here you will be able to:\n• View your health records\n• Message your doctor\n• Schedule appointments\n• Track your treatment plan',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            // In a real app, you would add a login form here
          ],
        ),
      ),
    );
  }
}

// Placeholder Screen for Doctor Login
class DoctorLoginScreen extends StatelessWidget {
  const DoctorLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medical Professional Portal'),
        backgroundColor: const Color(0xFF2563EB),
      ),
      body: const Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Healthcare Provider Login',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Here you will be able to:\n• Access patient medical charts\n• Manage your appointment schedule\n• Prescribe medication and treatments\n• Communicate with your patients',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            // In a real app, you would add a login form here
          ],
        ),
      ),
    );
  }
}