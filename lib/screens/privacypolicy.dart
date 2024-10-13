import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    final heading = GoogleFonts.lato(
      fontWeight: FontWeight.w500,
      fontSize: 20,
    );
    final policy = GoogleFonts.lato(
      fontWeight: FontWeight.w400,
      fontSize: 15,
    );
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green.shade600,
        title: Text(
          'Privacy Policy',
          style: GoogleFonts.lato(
            fontSize: 28,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              '1. Introduction',
              style: heading,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                'Welcome to TRAVEL MATE! We are committed to protecting your privacy and ensuring that your personal information is handled responsibly. This Privacy Policy outlines how we collect, use, and protect your data when you use our travel planning app.',
                style: policy,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              '2. Information We Collect',
              style: heading,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                'We may collect the following types of information: ',
                style: policy,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                'Personal Information: This includes your name, email address, phone number, user profile information, and any travel preferences or itinerary details you provide.',
                style: policy,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                'Location Data: With your consent, we may collect your location to offer services like nearby attractions, hotels, or routes. ',
                style: policy,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                ' Device & Usage Data: Information about your device, IP address, browser type, pages visited, and interactions with the app.',
                style: policy,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              '3. How We Use Your Information',
              style: heading,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                'We use your information to: ',
                style: policy,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                'Provide and Manage Services: To help you create travel itineraries, manage bookings, and offer personalized recommendations.',
                style: policy,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                'Personalize Your Experience: To offer suggestions based on your travel history and preferences',
                style: policy,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                'Send Notifications: Including travel alerts, reminders, or updates related to your account. ',
                style: policy,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                'Improve the App: To analyze usage and improve features, security, and app performance. ',
                style: policy,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              '4. Sharing of Information',
              style: heading,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                'We do not sell or rent your data. We may share your information in the following cases: ',
                style: policy,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                'Service Providers: With third parties who help us operate the app, such as booking platforms, payment processors, and customer service providers. ',
                style: policy,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                'Legal Obligations: If required by law, to comply with legal obligations or governmental requests. ',
                style: policy,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                'With Your Consent: We will only share your information with third parties when we have your explicit consent. ',
                style: policy,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              '5. Data Security',
              style: heading,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                'We use appropriate security measures, including encryption and secure storage, to protect your information. However, no system is completely secure, and we cannot guarantee the absolute safety of your data.',
                style: policy,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              '6. Your Rights',
              style: heading,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                'You may have the right to: ',
                style: policy,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                'Access your data and request a copy of the personal information we hold.',
                style: policy,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                'Delete your data, where applicable.',
                style: policy,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                'Withdraw Consent for data processing at any time.',
                style: policy,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                'To exercise your rights, contact us at garage53.projects@gmail.com.',
                style: policy,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              '7. Cookies and Tracking',
              style: heading,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                'We use cookies and similar technologies to improve user experience and track usage patterns. You can manage your cookie preferences through your device settings.',
                style: policy,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              '8. Links to Third-Party Sites',
              style: heading,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                'TRAVEL MATE may contain links to third-party websites. We are not responsible for the privacy practices of these websites, and we recommend reviewing their privacy policies.',
                style: policy,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "9. Children's Privacy",
              style: heading,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                'TRAVEL MATE is not intended for children under the age of 13. We do not knowingly collect data from children. If we become aware that we have collected such data, we will take steps to delete it.',
                style: policy,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              '10. Changes to This Policy',
              style: heading,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                'We may update this Privacy Policy from time to time. Any changes will be posted in the app, and you will be notified of significant updates. Please check this policy regularly for updates.',
                style: policy,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              '11. Contact Us',
              style: heading,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                'If you have any questions or concerns about this Privacy Policy or your data, please contact us at:',
                style: policy,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                'Email: garage53.projects@gmail.com.',
                style: policy,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
