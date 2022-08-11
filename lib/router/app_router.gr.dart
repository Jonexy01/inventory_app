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
    },
    WrapperRoute.name: (routeData) {
      return AdaptivePage<dynamic>(
          routeData: routeData, child: const Wrapper());
    },
    VerifyEmailPageRoute.name: (routeData) {
      return AdaptivePage<dynamic>(
          routeData: routeData, child: const VerifyEmailPage());
    },
    ForgotPasswordPageRoute.name: (routeData) {
      return AdaptivePage<dynamic>(
          routeData: routeData, child: const ForgotPasswordPage());
    },
    StopoverPageRoute.name: (routeData) {
      return AdaptivePage<dynamic>(
          routeData: routeData, child: const StopoverPage());
    },
    RoleSelectPageRoute.name: (routeData) {
      return AdaptivePage<dynamic>(
          routeData: routeData, child: const RoleSelectPage());
    },
    StopoverAddUserPageRoute.name: (routeData) {
      return AdaptivePage<dynamic>(
          routeData: routeData, child: const StopoverAddUserPage());
    },
    NotificationPageRoute.name: (routeData) {
      return AdaptivePage<dynamic>(
          routeData: routeData, child: const NotificationPage());
    },
    SecondaryWaitPageRoute.name: (routeData) {
      return AdaptivePage<dynamic>(
          routeData: routeData, child: const SecondaryWaitPage());
    }
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(SplashPageRoute.name, path: '/'),
        RouteConfig(LandingPageRoute.name, path: '/landing-page'),
        RouteConfig(HomePageRoute.name, path: '/home-page'),
        RouteConfig(LoginPageRoute.name, path: '/login-page'),
        RouteConfig(SignupPageRoute.name, path: '/signup-page'),
        RouteConfig(WrapperRoute.name, path: '/Wrapper'),
        RouteConfig(VerifyEmailPageRoute.name, path: '/verify-email-page'),
        RouteConfig(ForgotPasswordPageRoute.name,
            path: '/forgot-password-page'),
        RouteConfig(StopoverPageRoute.name, path: '/stopover-page'),
        RouteConfig(RoleSelectPageRoute.name, path: '/role-select-page'),
        RouteConfig(StopoverAddUserPageRoute.name,
            path: '/stopover-add-user-page'),
        RouteConfig(NotificationPageRoute.name, path: '/notification-page'),
        RouteConfig(SecondaryWaitPageRoute.name, path: '/secondary-wait-page')
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

/// generated route for
/// [Wrapper]
class WrapperRoute extends PageRouteInfo<void> {
  const WrapperRoute() : super(WrapperRoute.name, path: '/Wrapper');

  static const String name = 'WrapperRoute';
}

/// generated route for
/// [VerifyEmailPage]
class VerifyEmailPageRoute extends PageRouteInfo<void> {
  const VerifyEmailPageRoute()
      : super(VerifyEmailPageRoute.name, path: '/verify-email-page');

  static const String name = 'VerifyEmailPageRoute';
}

/// generated route for
/// [ForgotPasswordPage]
class ForgotPasswordPageRoute extends PageRouteInfo<void> {
  const ForgotPasswordPageRoute()
      : super(ForgotPasswordPageRoute.name, path: '/forgot-password-page');

  static const String name = 'ForgotPasswordPageRoute';
}

/// generated route for
/// [StopoverPage]
class StopoverPageRoute extends PageRouteInfo<void> {
  const StopoverPageRoute()
      : super(StopoverPageRoute.name, path: '/stopover-page');

  static const String name = 'StopoverPageRoute';
}

/// generated route for
/// [RoleSelectPage]
class RoleSelectPageRoute extends PageRouteInfo<void> {
  const RoleSelectPageRoute()
      : super(RoleSelectPageRoute.name, path: '/role-select-page');

  static const String name = 'RoleSelectPageRoute';
}

/// generated route for
/// [StopoverAddUserPage]
class StopoverAddUserPageRoute extends PageRouteInfo<void> {
  const StopoverAddUserPageRoute()
      : super(StopoverAddUserPageRoute.name, path: '/stopover-add-user-page');

  static const String name = 'StopoverAddUserPageRoute';
}

/// generated route for
/// [NotificationPage]
class NotificationPageRoute extends PageRouteInfo<void> {
  const NotificationPageRoute()
      : super(NotificationPageRoute.name, path: '/notification-page');

  static const String name = 'NotificationPageRoute';
}

/// generated route for
/// [SecondaryWaitPage]
class SecondaryWaitPageRoute extends PageRouteInfo<void> {
  const SecondaryWaitPageRoute()
      : super(SecondaryWaitPageRoute.name, path: '/secondary-wait-page');

  static const String name = 'SecondaryWaitPageRoute';
}
