import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:inventory_app/presentation/authentication/secondary_user_approval/approve_secondary_user.dart';
import 'package:inventory_app/presentation/authentication/forgot_password/forgot_password.dart';
import 'package:inventory_app/presentation/authentication/login/login.dart';
import 'package:inventory_app/presentation/authentication/role_select.dart';
import 'package:inventory_app/presentation/authentication/secondary_wait.dart';
import 'package:inventory_app/presentation/authentication/signup/signup.dart';
import 'package:inventory_app/presentation/authentication/stopover.dart';
import 'package:inventory_app/presentation/authentication/stopover_add_user.dart';
import 'package:inventory_app/presentation/authentication/verify_email.dart';
import 'package:inventory_app/presentation/notification/notification.dart';
import 'package:inventory_app/presentation/splash/landing_page.dart';
import 'package:inventory_app/presentation/splash/splash_screen.dart';
import 'package:inventory_app/presentation/home/homepage/home_page.dart';
import 'package:inventory_app/presentation/splash/wrapper.dart';
part 'app_router.gr.dart';

@AdaptiveAutoRouter(            
  //replaceInRouteName: 'Page,Route',            
  routes: <AutoRoute>[            
    AutoRoute(page: SplashPage, initial: true),            
    AutoRoute(page: LandingPage),  
    AutoRoute(page: HomePage),
    AutoRoute(page: LoginPage),
    AutoRoute(page: SignupPage),
    AutoRoute(page: Wrapper),
    AutoRoute(page: VerifyEmailPage),
    AutoRoute(page: ForgotPasswordPage),
    AutoRoute(page: StopoverPage),
    AutoRoute(page: RoleSelectPage),
    AutoRoute(page: StopoverAddUserPage),
    AutoRoute(page: NotificationPage),
    AutoRoute(page: SecondaryWaitPage),
    AutoRoute(page: SecondaryUserApproval),
  ],            
)            
class AppRouter extends _$AppRouter{}