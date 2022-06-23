import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:inventory_app/presentation/authentication/login/login.dart';
import 'package:inventory_app/presentation/authentication/signup/signup.dart';
import 'package:inventory_app/presentation/splash/landing_page.dart';
import 'package:inventory_app/presentation/splash/splash_screen.dart';
import 'package:inventory_app/presentation/home/homepage/home_page.dart';
part 'app_router.gr.dart';

@AdaptiveAutoRouter(            
  //replaceInRouteName: 'Page,Route',            
  routes: <AutoRoute>[            
    AutoRoute(page: SplashPage, initial: true),            
    AutoRoute(page: LandingPage),  
    AutoRoute(page: HomePage),
    AutoRoute(page: LoginPage),
    AutoRoute(page: SignupPage),
  ],            
)            
class AppRouter extends _$AppRouter{}