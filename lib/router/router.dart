 import 'package:desktop_project/pages/document.dart';
import 'package:desktop_project/pages/home.dart';
import 'package:desktop_project/pages/new_home.dart';
import 'package:desktop_project/pages/user.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../pages/setting.dart';
 final GoRouter router = GoRouter(
   initialLocation: "/documentPage", //初始化路由
   routes: <RouteBase>[
     //每次切换都会触发
     ShellRoute(
       builder: (context,state,child){
         return  NewHomePage(child: child,);
       },
       routes: [
         GoRoute(
           path: '/documentPage',
           name: "document",

           // builder: (BuildContext context, GoRouterState state) {
           //   return const DocumentPage();
           // },
           pageBuilder: (context, state) {
             return CustomTransitionPage(
               key: state.pageKey,
               child: const DocumentPage(),
               transitionsBuilder: (context, animation, secondaryAnimation, child) {
                 // Change the opacity of the screen using a Curve based on the the animation's
                 // value
                 return FadeTransition(
                   opacity:
                   CurveTween(curve: Curves.easeInOutCirc).animate(animation),
                   child: child,
                 );
               },
             );
           },
         ),
         GoRoute(
           path: '/settingPage',
           name: "setting",
           pageBuilder: (context, state) {
             return CustomTransitionPage(
               key: state.pageKey,
               child: SettingPage(settingId: state.queryParameters["settingId"],),
               transitionsBuilder: (context, animation, secondaryAnimation, child) {
                 // Change the opacity of the screen using a Curve based on the the animation's
                 // value
                 return FadeTransition(
                   opacity:
                   CurveTween(curve: Curves.easeInOutCirc).animate(animation),
                   child: child,
                 );
               },
             );
           },
         ),
         GoRoute(
           path: '/userPage/:uid',
           name: "user",
           pageBuilder: (context, state) {
             return CustomTransitionPage(
               key: state.pageKey,
               child:  UserPage(uid: state.pathParameters['uid'],),
               transitionsBuilder: (context, animation, secondaryAnimation, child) {
                 // Change the opacity of the screen using a Curve based on the the animation's
                 // value
                 return FadeTransition(
                   opacity:
                   CurveTween(curve: Curves.easeInOutCirc).animate(animation),
                   child: child,
                 );
               },
             );
           },
         ),
       ]
     ),
     // GoRoute(
     //   path: '/',
     //   builder: (BuildContext context, GoRouterState state) {
     //     return const HomePage();
     //   },
     //   routes: <RouteBase>[
     //     GoRoute(
     //       path: 'details',
     //       builder: (BuildContext context, GoRouterState state) {
     //         return const DetailsScreen();
     //       },
     //     ),
     //   ],
     // ),
     // GoRoute(
     //   path: '/',
     //   name: "home",
     //   builder: (BuildContext context, GoRouterState state) {
     //     return const HomePage();
     //   },
     // ),

   ],
 );