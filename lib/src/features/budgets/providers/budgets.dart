import 'package:draperweb/src/shared/providers/api_service.dart';
import 'package:draperweb/src/shared/providers/auth.dart';

class BudgetsProvider extends ApiService {
  static final BudgetsProvider _instance = BudgetsProvider._internal();

  BudgetsProvider._internal([AuthProvider? providerOverride])
      : super(providerOverride ?? AuthProvider.instance);

  factory BudgetsProvider() {
    return _instance;
  }

  static BudgetsProvider get instance => _instance;
}
