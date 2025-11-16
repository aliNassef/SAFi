import 'package:flutter/material.dart';
 
class AppNavigation {
  static Future<T?> pushNamed<T extends Object?>(
    BuildContext context,
    String routeName, {
    Object? arguments,
    bool useAppRoute = false,
  }) {
    return Navigator.of(
      context,
      rootNavigator: useAppRoute,
    ).pushNamed(routeName, arguments: arguments);
  }

  static Future<T?> pushReplacementNamed<T extends Object?, TO extends Object?>(
    BuildContext context,
    String routeName, {
    Object? arguments,
    TO? result,
  }) {
    return Navigator.of(
      context,
    ).pushReplacementNamed(routeName, arguments: arguments, result: result);
  }

  static Future<T?> pushAndRemoveUntil<T extends Object?>(
    BuildContext context,
    String routeName,
    bool Function(Route<dynamic>) predicate, {
    Object? arguments,
    bool useAppRoute = false,
  }) {
    return Navigator.of(
      context,
      rootNavigator: useAppRoute,
    ).pushNamedAndRemoveUntil(routeName, predicate, arguments: arguments);
  }

  static void pop<T extends Object?>(
    BuildContext context, {
    bool? useAppRoute,
    T? result,
  }) {
    Navigator.of(context, rootNavigator: useAppRoute ?? false).pop(result);
  }
}
