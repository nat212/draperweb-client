import 'package:draperweb/src/shared/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HandleLoginComplete extends StatefulWidget {
  const HandleLoginComplete({Key? key, required this.uri}) : super(key: key);

  final Uri uri;

  @override
  State<HandleLoginComplete> createState() => _HandleLoginCompleteState();
}

class _HandleLoginCompleteState extends State<HandleLoginComplete> {
  @override
  void initState() {
    super.initState();
    _completeSignIn();
  }

  Future<void> _completeSignIn() async {
    final params = widget.uri.queryParameters;
    await AuthProvider.instance.exchangeToken(code: params['code']!);
    _complete();
  }

  void _complete() {
    context.go('/');
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
