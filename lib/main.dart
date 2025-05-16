import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:exam_prep_app/core/theme/app_theme.dart';
import 'package:exam_prep_app/core/controllers/theme_controller.dart';
import 'package:exam_prep_app/core/services/services.dart';
import 'package:exam_prep_app/modules/auth/login/login_screen.dart';
import 'package:exam_prep_app/modules/auth/otp/otp_screen.dart';
import 'package:exam_prep_app/modules/profile/profile_screen.dart';
import 'package:exam_prep_app/modules/dashboard/dashboard_screen.dart';
import 'package:exam_prep_app/modules/game_room/game_room_screen.dart';

// Import controllers and bindings
import 'package:exam_prep_app/modules/auth/login/login_binding.dart';
import 'package:exam_prep_app/modules/auth/otp/otp_binding.dart';
import 'package:exam_prep_app/modules/profile/profile_binding.dart';
import 'package:exam_prep_app/modules/dashboard/dashboard_binding.dart';
import 'package:exam_prep_app/modules/game_room/game_room_binding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Services
  await initServices();
  
  // Register theme controller
  final themeController = Get.put(ThemeController());
  
  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.black,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Exam Prep App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      defaultTransition: Transition.cupertino,
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/', 
          page: () => SplashScreen(),
          transition: Transition.fade,
        ),
        GetPage(
          name: '/login', 
          page: () => LoginScreen(),
          binding: LoginBinding(),
        ),
        GetPage(
          name: '/otp', 
          page: () => OtpScreen(),
          binding: OtpBinding(),
        ),
        GetPage(
          name: '/profile', 
          page: () => ProfileScreen(),
          binding: ProfileBinding(),
        ),
        GetPage(
          name: '/dashboard', 
          page: () => DashboardScreen(),
          binding: DashboardBinding(),
        ),
        GetPage(
          name: '/game-room', 
          page: () => GameRoomScreen(),
          binding: GameRoomBinding(),
        ),
      ],
      enableLog: true,
      logWriterCallback: (text, {isError = false}) {
        if (isError) {
          debugPrint('ERROR: $text');
        } else {
          debugPrint('LOG: $text');
        }
      },
    );
  }
}

// Simple SplashScreen directly in main.dart
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  
  @override
  void initState() {
    super.initState();
    
    // Setup animations
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );
    
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.2, 0.7, curve: Curves.easeOut),
      ),
    );
    
    // Start animation and navigate after it completes
    _animationController.forward();
    
    // Navigate to login screen after a delay
    Future.delayed(Duration(seconds: 3), () {
      print("Navigating to login screen...");
      Get.offAllNamed('/login');
    });
  }
  
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDarkMode 
                ? [Color(0xFF192A51), Color(0xFF0F172A)]
                : [Color(0xFF5E35B1), Color(0xFF3B1F74)],
          ),
        ),
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Opacity(
              opacity: _fadeAnimation.value,
              child: Transform.scale(
                scale: _scaleAnimation.value,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Logo
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 20,
                              offset: Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Icon(
                            Icons.school_rounded,
                            size: 70,
                            color: Color(0xFF5E35B1),
                          ),
                        ),
                      ),
                      
                      SizedBox(height: 40),
                      
                      // App name
                      Text(
                        'Exam Prep Pro',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1.2,
                        ),
                      ),
                      
                      SizedBox(height: 16),
                      
                      // Tagline
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          'Master Your Preparation',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      
                      SizedBox(height: 80),
                      
                      // Loading indicator
                      SizedBox(
                        width: 40,
                        height: 40,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          strokeWidth: 3,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}