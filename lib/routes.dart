import 'package:flutter/material.dart';
import 'package:insaaju/ui/screen/compatibility/compatibility_screen.dart';
import 'package:insaaju/ui/screen/four_pillars_of_destiny/four_pillars_of_destiny_screen.dart';
import 'package:insaaju/ui/screen/home/home_screen.dart';
import 'package:insaaju/ui/screen/info/info_screen.dart';
import 'package:insaaju/ui/screen/list/list_screen.dart';
import 'package:insaaju/ui/screen/setting/setting_screen.dart';
import 'package:insaaju/ui/screen/widget/app_bottom_navigation_bar.dart';

class FadeRoute extends PageRouteBuilder {

  FadeRoute({required this.page})
      : super(
    pageBuilder: (_, __, ___) => page,
    transitionsBuilder: (_, animation, __, child) => FadeTransition(
      opacity: animation,
      child: Scaffold(
        body: child,
      ),
    ),
  );

  final Widget page;
}
enum Routes {
  home,
  info,
  list,
  four_pillars_of_destiny,
  compatibility,
  setting
}

extension RoutesExtention on Routes {
  String getValue() {
    return this.toString().split('.').last;
  }
}

class _Paths {
  static const String home = 'home';
  static const String info = 'info';
  static const String list = 'list';
  static const String four_pillars_of_destiny = 'four_pillars_of_destiny';
  static const String compatibility = 'compatibility';
  static const String setting = 'setting';

  static const Map<Routes, String> _pathMap = {
    Routes.home: _Paths.home,
    Routes.info: _Paths.info,
    Routes.list: _Paths.list,
    Routes.four_pillars_of_destiny: _Paths.four_pillars_of_destiny,
    Routes.compatibility: _Paths.compatibility,
    Routes.setting: _Paths.setting
  };

  static String of(Routes route) => _pathMap[route] ?? home;
}

class AppNavigator {
    static GlobalKey<NavigatorState> navigatorKey = GlobalKey();


    static Route onGenerateRoute(RouteSettings settings){
          AppNavigator.currentRoute = settings.name;
          switch(settings.name){
            case _Paths.home:
              return FadeRoute(page: const HomeScreen());
            case _Paths.info:
              return FadeRoute(page: const InfoScreen());
            case _Paths.list:
              return FadeRoute(page: const ListScreen());
            case _Paths.four_pillars_of_destiny:
              return FadeRoute(page: const FourPillarsOfDestinyScreen());
            case _Paths.compatibility:
              return FadeRoute(page: const CompatibilityScreen());
            case _Paths.setting:
              return FadeRoute(page: const SettingScreen());
            default:
              return FadeRoute(page: const HomeScreen());
          }
    }

    static Future? push<T>(Routes route, [T? arguments]) =>
        state?.pushNamed(_Paths.of(route), arguments: arguments);

    static Future? replaceWith<T>(Routes route, [T? arguments]) =>
        state?.pushReplacementNamed(_Paths.of(route), arguments: arguments);

    static void pop() => state?.pop();

    static NavigatorState? get state => navigatorKey.currentState;

    static String? currentRoute;
}
