import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    final heading = GoogleFonts.lato(
      fontWeight: FontWeight.w700,
      fontSize: 20,
      color: Colors.black87,
    );
    final policy = GoogleFonts.lato(
      fontWeight: FontWeight.w400,
      fontSize: 16,
      color: Colors.black54,
    );

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'Privacy Policy',
          style: GoogleFonts.lato(
            fontSize: 26,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFf8f8f8), Color(0xFFe0f7fa)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 90.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildSection(
                title: '1. Introduction',
                content:
                    'Welcome to TRAVEL MATE! We are committed to protecting your privacy and ensuring that your personal information is handled responsibly. This Privacy Policy outlines how we collect, use, and protect your data when you use our travel planning app.',
                headingStyle: heading,
                policyStyle: policy,
              ),
              buildSection(
                title: '2. Information We Collect',
                content:
                    'We may collect the following types of information:\n\n'
                    '- Personal Information: Your name, email, phone number, profile information, and travel preferences.\n'
                    '- Location Data: With consent, we may collect your location for nearby services.\n'
                    '- Device & Usage Data: Device details, IP address, browser type, pages visited, and interactions.',
                headingStyle: heading,
                policyStyle: policy,
              ),
              buildSection(
                title: '3. How We Use Your Information',
                content: 'We use your information to:\n\n'
                    '- Provide and Manage Services: To help you create itineraries, manage bookings, and give recommendations.\n'
                    '- Personalize Your Experience: To offer suggestions based on your travel history.\n'
                    '- Send Notifications: For travel alerts, reminders, and updates.\n'
                    '- Improve the App: To analyze usage and enhance features, security, and performance.',
                headingStyle: heading,
                policyStyle: policy,
              ),
              buildSection(
                title: '4. Sharing of Information',
                content:
                    'We do not sell or rent your data. We may share your information with:\n\n'
                    '- Service Providers: Third parties like booking platforms and payment processors.\n'
                    '- Legal Obligations: To comply with laws or governmental requests.\n'
                    '- With Your Consent: Only with your explicit permission.',
                headingStyle: heading,
                policyStyle: policy,
              ),
              buildSection(
                title: '5. Data Security',
                content:
                    'We use security measures, including encryption, to protect your information. However, no system is completely secure, so we cannot guarantee absolute safety.',
                headingStyle: heading,
                policyStyle: policy,
              ),
              buildSection(
                title: '6. Your Rights',
                content: 'You may have the right to:\n\n'
                    '- Access and request a copy of your data.\n'
                    '- Delete your data, where applicable.\n'
                    '- Withdraw Consent for data processing.\n\n'
                    'To exercise your rights, contact us at garage53.projects@gmail.com.',
                headingStyle: heading,
                policyStyle: policy,
              ),
              buildSection(
                title: '7. Cookies and Tracking',
                content:
                    'We use cookies and similar technologies to improve your experience and track usage. You can manage cookie preferences in your device settings.',
                headingStyle: heading,
                policyStyle: policy,
              ),
              buildSection(
                title: '8. Links to Third-Party Sites',
                content:
                    'TRAVEL MATE may link to third-party sites. We are not responsible for their privacy practices, and we recommend reviewing their policies.',
                headingStyle: heading,
                policyStyle: policy,
              ),
              buildSection(
                title: "9. Children's Privacy",
                content:
                    'TRAVEL MATE is not for children under 13. We do not knowingly collect data from children. If we find such data, we will delete it.',
                headingStyle: heading,
                policyStyle: policy,
              ),
              buildSection(
                title: '10. Changes to This Policy',
                content:
                    'We may update this Privacy Policy periodically. Changes will be posted in the app, and significant updates will be notified. Please check regularly for updates.',
                headingStyle: heading,
                policyStyle: policy,
              ),
              buildSection(
                title: '11. Contact Us',
                content:
                    'If you have questions about this Privacy Policy or your data, please contact us at:\n\nEmail: garage53.projects@gmail.com.',
                headingStyle: heading,
                policyStyle: policy,
              ),
              const SizedBox(
                height: 40,
              ),
              Center(
                child: Text(
                  'Thank you for choosing TRAVEL MATE!',
                  style: GoogleFonts.lato(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.green.shade800,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSection({
    required String title,
    required String content,
    required TextStyle headingStyle,
    required TextStyle policyStyle,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: headingStyle),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.only(
              left: 8.0,
            ),
            child: Text(content, style: policyStyle),
          ),
        ],
      ),
    );
  }
}
