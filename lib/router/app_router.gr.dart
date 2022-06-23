// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

part of 'app_router.dart';

class _$AppRouter extends RootStackRouter {
  _$AppRouter([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    SplashPageRoute.name: (routeData) {
      return AdaptivePage<dynamic>(
          routeData: routeData, child: const SplashPage());
    },
    LandingPageRoute.name: (routeData) {
      return AdaptivePage<dynamic>(
          routeData: routeData, child: const LandingPage());
    },
    HomePageRoute.name: (routeData) {
      return AdaptivePage<dynamic>(
          routeData: routeData, child: const HomePage());
    },
    LoginPageRoute.name: (routeData) {
      return AdaptivePage<dynamic>(
          routeData: routeData, child: const LoginPage());
    },
    SignupPageRoute.name: (routeData) {
      return AdaptivePage<dynamic>(
          routeData: routeData, child: const SignupPage());
    }
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(SplashPageRoute.name, path: '/'),
        RouteConfig(LandingPageRoute.name, path: '/landing-page'),
        RouteConfig(HomePageRoute.name, path: '/home-page'),
        RouteConfig(LoginPageRoute.name, path: '/login-page'),
        RouteConfig(SignupPageRoute.name, path: '/signup-page')
      ];
}

/// generated route for
/// [SplashPage]
class SplashPageRoute extends PageRouteInfo<void> {
  const SplashPageRoute() : super(SplashPageRoute.name, path: '/');

  static const String name = 'SplashPageRoute';
}

/// generated route for
/// [LandingPage]
class LandingPageRoute extends PageRouteInfo<void> {
  const LandingPageRoute()
      : super(LandingPageRoute.name, path: '/landing-page');

  static const String name = 'LandingPageRoute';
}

/// generated route for
/// [HomePage]
class HomePageRoute extends PageRouteInfo<void> {
  const HomePageRoute() : super(HomePageRoute.name, path: '/home-page');

  static const String name = 'HomePageRoute';
}

/// generated route for
/// [LoginPage]
class LoginPageRoute extends PageRouteInfo<void> {
  const LoginPageRoute() : super(LoginPageRoute.name, path: '/login-page');

  static const String name = 'LoginPageRoute';
}

/// generated route for
/// [SignupPage]
class SignupPageRoute extends PageRouteInfo<void> {
  const SignupPageRoute() : super(SignupPageRoute.name, path: '/signup-page');

  static const String name = 'SignupPageRoute';
}
