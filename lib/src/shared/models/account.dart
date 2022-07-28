import 'package:hive_flutter/hive_flutter.dart';

import '../model_types.dart';

part 'account.g.dart';

@HiveType(typeId: accountTypeId)
class Account extends HiveObject {
  @HiveField(0)
  final String username;

  @HiveField(1)
  final String password;

  Account({required this.username, required this.password});

  @override
  String toString() => 'Account(username: $username, password: ${'*' * 8})';

  @override
  operator ==(
    Object other,
  ) =>
      identical(this, other) ||
      other.runtimeType == runtimeType &&
          other is Account &&
          username == other.username &&
          password == other.password;

  @override
  int get hashCode => username.hashCode ^ password.hashCode;
}
