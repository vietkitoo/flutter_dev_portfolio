import 'package:flutter/material.dart';

class AboutMeScreen extends StatefulWidget {
  const AboutMeScreen({super.key});

  @override
  State<AboutMeScreen> createState() => _AboutMeScreenState();
}

class _AboutMeScreenState extends State<AboutMeScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        padding: EdgeInsets.all(screenWidth * 0.05),
        child: Column(
          children: [
            SizedBox(height: screenHeight * 0.05),
            _buildAvatarSection(screenWidth),
            SizedBox(height: screenHeight * 0.04),
            _buildNameSection(screenWidth),
            SizedBox(height: screenHeight * 0.025),
            _buildBioSection(screenWidth),
            SizedBox(height: screenHeight * 0.04),
            _buildContactSection(screenWidth),
            SizedBox(height: screenHeight * 0.04),
            _buildExperienceSection(screenWidth),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatarSection(double screenWidth) {
    final avatarSize = screenWidth * 0.4; // 40% của screen width
    
    return Container(
      width: avatarSize,
      height: avatarSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.blueAccent,
          width: 4,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipOval(
        child: Container(
          color: Colors.blueAccent.withValues(alpha: 0.1),
          child: Icon(
            Icons.person,
            size: avatarSize * 0.5,
            color: Colors.blueAccent,
          ),
        ),
      ),
    );
  }

  Widget _buildNameSection(double screenWidth) {
    return Column(
      children: [
        Text(
          'Nguyễn Văn Quốc Việt',
          style: TextStyle(
            fontSize: screenWidth * 0.075,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: screenWidth * 0.02),
        Text(
          'Mobile Developer',
          style: TextStyle(
            fontSize: screenWidth * 0.048,
            color: Colors.blueAccent,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: screenWidth * 0.01),
      ],
    );
  }

  Widget _buildBioSection(double screenWidth) {
    return Container(
      padding: EdgeInsets.all(screenWidth * 0.053),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Giới thiệu',
            style: TextStyle(
              fontSize: screenWidth * 0.048,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: screenWidth * 0.032),
          Text(
            'Tôi là một lập trình viên mobile với 2+ năm kinh nghiệm phát triển ứng dụng với Flutter. Đam mê tạo ra những sản phẩm công nghệ có ích cho người dùng và luôn học hỏi những công nghệ mới.',
            style: TextStyle(
              fontSize: screenWidth * 0.037,
              color: Colors.grey[700],
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildContactSection(double screenWidth) {
    return Container(
      padding: EdgeInsets.all(screenWidth * 0.053),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Liên hệ',
            style: TextStyle(
              fontSize: screenWidth * 0.048,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: screenWidth * 0.04),
          _buildContactItem(Icons.email, 'vietkitoo@gmail.com', screenWidth),
          _buildContactItem(Icons.phone, '+84 395 724 247', screenWidth),
          _buildContactItem(Icons.location_on, 'Gò Vấp, Hồ Chí Minh, Việt Nam', screenWidth),
          _buildContactItem(Icons.link, 'www.linkedin.com/in/nguyenvanquocviet', screenWidth),
        ],
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String text, double screenWidth) {
    return Padding(
      padding: EdgeInsets.only(bottom: screenWidth * 0.032),
      child: Row(
        children: [
          Icon(
            icon,
            size: screenWidth * 0.053,
            color: Colors.blueAccent,
          ),
          SizedBox(width: screenWidth * 0.032),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: screenWidth * 0.037,
                color: Colors.grey[700],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExperienceSection(double screenWidth) {
    return Container(
      padding: EdgeInsets.all(screenWidth * 0.053),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Kinh nghiệm',
            style: TextStyle(
              fontSize: screenWidth * 0.048,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: screenWidth * 0.04),
          _buildExperienceItem(
            'Mobile Developer',
            'Công ty Tài chính TNHH Ngân hàng Việt Nam Thịnh Vượng SMBC',
            '1/2024 - Hiện tại',
            'Phát triển ứng dụng Financial với Flutter cho iOS và Android',
            screenWidth,
          ),
          _buildExperienceItem(
            'Mobile Developer',
            'Công ty CloudGo',
            '6/2023 - 11/2023',
            'Phát triển ứng dụng CRM',
            screenWidth,
          ),
        ],
      ),
    );
  }

  Widget _buildExperienceItem(String title, String company, String period, String description, double screenWidth) {
    return Padding(
      padding: EdgeInsets.only(bottom: screenWidth * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: screenWidth * 0.043,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          Text(
            company,
            style: TextStyle(
              fontSize: screenWidth * 0.037,
              color: Colors.blueAccent,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            period,
            style: TextStyle(
              fontSize: screenWidth * 0.032,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: screenWidth * 0.01),
          Text(
            description,
            style: TextStyle(
              fontSize: screenWidth * 0.035,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }
}