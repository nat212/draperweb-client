import 'package:draperweb/src/shared/extensions.dart';
import 'package:flutter/material.dart';

class AdaptiveNavigation extends StatelessWidget {
  const AdaptiveNavigation({
    super.key,
    required this.destinations,
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.child,
  });

  final List<NavigationDestination> destinations;
  final int selectedIndex;
  final void Function(int index) onDestinationSelected;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, dimens) {
      if (dimens.isTablet) {
        return Scaffold(
            body:
                Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          SafeArea(
            child: NavigationRail(
              extended: dimens.maxWidth >= 800,
              minExtendedWidth: 180,
              destinations: destinations
                  .map((e) => NavigationRailDestination(
                        icon: e.icon,
                        label: Text(e.label),
                      ))
                  .toList(),
              selectedIndex: selectedIndex,
              onDestinationSelected: onDestinationSelected,
            ),
          ),
          const VerticalDivider(width: 2),
          Expanded(child: child),
        ]));
      }
      return Scaffold(
        body: Container(
          constraints: BoxConstraints(
            maxHeight: dimens.maxHeight,
          ),
          child: child,
        ),
        bottomNavigationBar: NavigationBar(
          destinations: destinations,
          selectedIndex: selectedIndex,
          onDestinationSelected: onDestinationSelected,
        ),
      );
    });
  }
}
