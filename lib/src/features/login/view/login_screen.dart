import 'package:draperweb/Constants.dart';
import 'package:draperweb/src/shared/views/adaptive_padding.dart';
import 'package:draperweb/src/shared/views/spaced_column.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AdaptivePadding(
          maxWidth: 400,
          child: Center(
            child: _buildForm(),
          )),
    );
  }

  Widget _buildForm() {
    return SpacedColumn(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).colorScheme.tertiary,
          ),
          child: Image.asset('assets/image/bushy-transparent.png'),
        ),
        ElevatedButton(
            onPressed: () {
              launchUrl(Uri.parse('${Constants.apiUrl}/social/login/nextcloud'),
                  mode: LaunchMode.externalApplication);
            },
            child: const Text('Login')),
      ],
    );
  }
}
