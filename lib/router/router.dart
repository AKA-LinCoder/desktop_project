 import 'package:desktop_project/pages/document.dart';
import 'package:desktop_project/pages/home.dart';
import 'package:desktop_project/pages/user.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../pages/setting.dart';
 final GoRouter router = GoRouter(
   initialLocation: "/", //初始化路由
   routes: <RouteBase>[
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
     GoRoute(
       path: '/',
       name: "home",
       builder: (BuildContext context, GoRouterState state) {
         return const HomePage();
       },
     ),
     GoRoute(
       path: '/documentPage',
       name: "document",
       builder: (BuildContext context, GoRouterState state) {
         return const DocumentPage();
       },
     ),
     GoRoute(
       path: '/settingPage',
       name: "setting",
       builder: (BuildContext context, GoRouterState state) {
         return  SettingPage(settingId: state.queryParameters["settingId"],);
       },
     ),
     GoRoute(
       path: '/userPage/:uid',
       name: "user",
       builder: (BuildContext context, GoRouterState state) {
         return  UserPage(uid: state.pathParameters['uid'],);
       },
     ),
   ],
 );