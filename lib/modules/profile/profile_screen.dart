import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:exam_prep_app/core/theme/app_colors.dart';
import 'package:exam_prep_app/core/utils/app_constants.dart';
import 'package:exam_prep_app/widgets/app_button.dart';
import 'package:exam_prep_app/core/controllers/theme_controller.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'profile_controller.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      body: Stack(
        children: [
          // Background
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: isDarkMode 
                    ? [Color(0xFF192A51), Color(0xFF0F172A)]
                    : [Colors.white, Color(0xFFF9FAFC)],
              ),
            ),
          ),
          
          // Background decoration
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isDarkMode 
                    ? AppColors.primary.withOpacity(0.05)
                    : AppColors.primary.withOpacity(0.05),
              ),
            ),
          ),
          
          Positioned(
            bottom: -80,
            left: -50,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isDarkMode 
                    ? AppColors.accent.withOpacity(0.07)
                    : AppColors.accent.withOpacity(0.07),
              ),
            ),
          ),
          
          // Content
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Top bar
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Title
                            Text(
                              'Complete Your Profile',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: isDarkMode ? Colors.white : AppColors.textDark,
                              ),
                            ),
                            
                            // Theme toggle
                            GestureDetector(
                              onTap: themeController.toggleTheme,
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: isDarkMode 
                                      ? Colors.white.withOpacity(0.05)
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: isDarkMode
                                      ? []
                                      : [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.05),
                                            blurRadius: 10,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                ),
                                child: Icon(
                                  isDarkMode ? Icons.light_mode : Icons.dark_mode,
                                  size: 20,
                                  color: isDarkMode 
                                      ? AppColors.primaryLight
                                      : AppColors.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                      .animate()
                      .fadeIn(duration: 600.ms)
                      .moveY(begin: -10, end: 0),
                      
                      const SizedBox(height: 40),
                      
                      // Profile picture section
                      Center(
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            // Profile image container
                            Container(
                              width: 140,
                              height: 140,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  colors: [
                                    AppColors.primary.withOpacity(0.7),
                                    AppColors.accent.withOpacity(0.7),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.primary.withOpacity(0.3),
                                    blurRadius: 20,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: Obx(() => controller.imageFile.value != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(70),
                                      child: Image.file(
                                        controller.imageFile.value!,
                                        width: 140,
                                        height: 140,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : Icon(
                                      Icons.person,
                                      size: 70,
                                      color: Colors.white,
                                    ),
                              ),
                            ),
                            
                            // Camera button
                            GestureDetector(
                              onTap: controller.pickImage,
                              child: Container(
                                width: 44,
                                height: 44,
                                decoration: BoxDecoration(
                                  color: isDarkMode 
                                      ? AppColors.primaryLight
                                      : AppColors.primary,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: isDarkMode 
                                        ? AppColors.darkBackground
                                        : Colors.white,
                                    width: 3,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.primary.withOpacity(0.3),
                                      blurRadius: 8,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.camera_alt,
                                    size: 22,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                      .animate()
                      .fadeIn(duration: 600.ms, delay: 200.ms)
                      .scale(
                        begin: const Offset(0.8, 0.8),
                        duration: 600.ms,
                        curve: Curves.easeOutQuad,
                      ),
                      
                      const SizedBox(height: 50),
                      
                      // Form fields with card design
                      Container(
                        decoration: BoxDecoration(
                          color: isDarkMode 
                              ? AppColors.darkSurface
                              : Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: isDarkMode
                              ? [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 15,
                                    offset: const Offset(0, 5),
                                  ),
                                ]
                              : [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 15,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                        ),
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Form title
                            Text(
                              'Personal Information',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: isDarkMode ? Colors.white : AppColors.textDark,
                              ),
                            ),
                            
                            const SizedBox(height: 24),
                            
                            // Name field
                            _buildFormField(
                              context: context,
                              icon: Icons.person_outline,
                              label: 'Full Name',
                              hintText: 'Enter your full name',
                              controller: controller.nameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your name';
                                }
                                return null;
                              },
                              isDarkMode: isDarkMode,
                              animationDelay: 300,
                            ),
                            
                            const SizedBox(height: 16),
                            
                            // Exam field
                            _buildDropdownField(
                              context: context,
                              icon: Icons.school_outlined,
                              label: 'Exam Preparing For',
                              hintText: 'Select exam',
                              value: controller.selectedExam.value.isEmpty 
                                  ? null
                                  : controller.selectedExam.value,
                              items: AppConstants.examTypes,
                              onChange: (value) {
                                if (value != null) {
                                  controller.selectedExam.value = value;
                                }
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select an exam';
                                }
                                return null;
                              },
                              isDarkMode: isDarkMode,
                              animationDelay: 400,
                            ),
                            
                            const SizedBox(height: 16),
                            
                            // Address field
                            _buildFormField(
                              context: context,
                              icon: Icons.location_on_outlined,
                              label: 'Address',
                              hintText: 'Enter your address',
                              controller: controller.addressController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your address';
                                }
                                return null;
                              },
                              maxLines: 2,
                              isDarkMode: isDarkMode,
                              animationDelay: 500,
                            ),
                            
                            const SizedBox(height: 16),
                            
                            // PAN card upload
                            _buildUploadField(
                              context: context,
                              icon: Icons.file_upload_outlined,
                              label: 'PAN Card (Optional)',
                              hintText: 'Upload PAN Card',
                              isUploaded: controller.panCardFile.value != null,
                              onTap: controller.pickPanCard,
                              isDarkMode: isDarkMode,
                              animationDelay: 600,
                            ),
                          ],
                        ),
                      )
                      .animate()
                      .fadeIn(duration: 600.ms, delay: 200.ms)
                      .moveY(begin: 30, end: 0),
                      
                      const SizedBox(height: 30),
                      
                      // Error message
                      Obx(() => controller.errorMessage.isEmpty
                          ? const SizedBox.shrink()
                          : Container(
                              padding: const EdgeInsets.all(16),
                              margin: const EdgeInsets.only(bottom: 16),
                              decoration: BoxDecoration(
                                color: AppColors.error.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.error_outline,
                                    color: AppColors.error,
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      controller.errorMessage.value,
                                      style: TextStyle(
                                        color: AppColors.error,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                      ),
                      
                      // Submit button
                      Obx(() => AppButton(
                        text: 'Complete Profile',
                        isLoading: controller.isLoading.value,
                        onPressed: controller.submitProfile,
                        isGradient: true,
                      ))
                      .animate()
                      .fadeIn(duration: 600.ms, delay: 700.ms)
                      .moveY(begin: 20, end: 0),
                      
                      const SizedBox(height: 16),
                      
                      // Skip option
                      Center(
                        child: TextButton(
                          onPressed: controller.skipProfile,
                          child: Text(
                            'Skip for now',
                            style: TextStyle(
                              color: isDarkMode 
                                  ? Colors.white70
                                  : AppColors.textMuted,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 40),
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
  
  Widget _buildFormField({
    required BuildContext context,
    required IconData icon,
    required String label,
    required String hintText,
    required TextEditingController controller,
    required String? Function(String?) validator,
    bool obscureText = false,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
    required bool isDarkMode,
    required int animationDelay,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: isDarkMode ? Colors.white70 : AppColors.textDark,
            ),
          ),
        ),
        
        // Input field
        Container(
          decoration: BoxDecoration(
            color: isDarkMode 
                ? Colors.white.withOpacity(0.05)
                : AppColors.lightBackground,
            borderRadius: BorderRadius.circular(16),
          ),
          child: TextFormField(
            controller: controller,
            obscureText: obscureText,
            maxLines: maxLines,
            keyboardType: keyboardType,
            validator: validator,
            style: TextStyle(
              color: isDarkMode ? Colors.white : AppColors.textDark,
            ),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                color: isDarkMode 
                    ? Colors.white38
                    : AppColors.textHint,
              ),
              prefixIcon: Icon(
                icon,
                color: isDarkMode 
                    ? AppColors.primaryLight
                    : AppColors.primary,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 16,
              ),
            ),
          ),
        ),
      ],
    )
    .animate()
    .fadeIn(duration: 600.ms, delay: Duration(milliseconds: animationDelay))
    .moveX(begin: -20, end: 0);
  }
  
  Widget _buildDropdownField({
    required BuildContext context,
    required IconData icon,
    required String label,
    required String hintText,
    required String? value,
    required List<String> items,
    required Function(String?) onChange,
    required String? Function(String?) validator,
    required bool isDarkMode,
    required int animationDelay,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: isDarkMode ? Colors.white70 : AppColors.textDark,
            ),
          ),
        ),
        
        // Dropdown
        Container(
          decoration: BoxDecoration(
            color: isDarkMode 
                ? Colors.white.withOpacity(0.05)
                : AppColors.lightBackground,
            borderRadius: BorderRadius.circular(16),
          ),
          child: DropdownButtonFormField<String>(
            value: value,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                color: isDarkMode 
                    ? Colors.white38
                    : AppColors.textHint,
              ),
              prefixIcon: Icon(
                icon,
                color: isDarkMode 
                    ? AppColors.primaryLight
                    : AppColors.primary,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 16,
              ),
            ),
            style: TextStyle(
              color: isDarkMode ? Colors.white : AppColors.textDark,
            ),
            dropdownColor: isDarkMode 
                ? AppColors.darkSurface
                : Colors.white,
            icon: Icon(
              Icons.arrow_drop_down,
              color: isDarkMode 
                  ? Colors.white70
                  : AppColors.textMuted,
            ),
            items: items.map((String exam) {
              return DropdownMenuItem<String>(
                value: exam,
                child: Text(exam),
              );
            }).toList(),
            onChanged: onChange,
            validator: validator,
          ),
        ),
      ],
    )
    .animate()
    .fadeIn(duration: 600.ms, delay: Duration(milliseconds: animationDelay))
    .moveX(begin: -20, end: 0);
  }
  
  Widget _buildUploadField({
    required BuildContext context,
    required IconData icon,
    required String label,
    required String hintText,
    required bool isUploaded,
    required VoidCallback onTap,
    required bool isDarkMode,
    required int animationDelay,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: isDarkMode ? Colors.white70 : AppColors.textDark,
            ),
          ),
        ),
        
        // Upload button
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            decoration: BoxDecoration(
              color: isDarkMode 
                  ? Colors.white.withOpacity(0.05)
                  : AppColors.lightBackground,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isUploaded
                    ? AppColors.success.withOpacity(0.3)
                    : Colors.transparent,
                width: 1.5,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  isUploaded ? Icons.check_circle : icon,
                  color: isUploaded
                      ? AppColors.success
                      : (isDarkMode 
                          ? AppColors.primaryLight
                          : AppColors.primary),
                  size: 24,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    isUploaded ? 'File uploaded' : hintText,
                    style: TextStyle(
                      color: isUploaded
                          ? (isDarkMode ? Colors.white : AppColors.textDark)
                          : (isDarkMode 
                              ? Colors.white38
                              : AppColors.textHint),
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: isDarkMode 
                      ? Colors.white38
                      : AppColors.textMuted,
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ],
    )
    .animate()
    .fadeIn(duration: 600.ms, delay: Duration(milliseconds: animationDelay))
    .moveX(begin: -20, end: 0);
  }
}