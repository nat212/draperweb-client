import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavigationWrapper extends StatefulWidget {
  const NavigationWrapper({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  State<NavigationWrapper> createState() => _NavigationWrapperState();
}

class _NavigationWrapperState extends State<NavigationWrapper> {
  late AppLinks _appLinks;
  StreamSubscription<Uri>? _linkSubscription;

  @override
  void initState() {
    super.initState();

    initLinks();
  }

  @override
  void dispose() {
    _linkSubscription?.cancel();
    super.dispose();
  }

  Future<void> _checkInitialLink() async {
    final appLink = await _appLinks.getInitialAppLink();
    if (appLink != null) {
      openAppLink(appLink);
    }
  }

  Future<void> initLinks() async {
    _appLinks = AppLinks();
    _linkSubscription = _appLinks.uriLinkStream.listen((uri) {
      openAppLink(uri);
    });
    _checkInitialLink();
  }

  static bool linkMatchesLoginHandler(Uri uri) {
    if (uri.scheme == 'http' || uri.scheme == 'https') {
      return uri.path.contains('/social/complete/nextcloud');
    } else if (uri.scheme == 'draperweb') {
      return uri.host == 'login';
    }
    return false;
  }

  void openAppLink(Uri uri) {
    if (linkMatchesLoginHandler(uri)) {
      GoRouter.of(context).go('/handle-login', extra: uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
