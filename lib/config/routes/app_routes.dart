import 'package:dalily/features/calender/calender_page.dart';
import 'package:dalily/features/calender/logic/calender_cubit/calender_cubit.dart';
import 'package:dalily/features/calender/logic/calender_department_cubit/calender_department_cubit.dart';
import 'package:dalily/features/college_details/college_details.dart';
import 'package:dalily/features/home/home_page.dart';
import 'package:dalily/features/landing_page/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../core/animations/page_fade_transition.dart';
import '../../core/animations/page_slide_transition.dart';
import '../../features/authentication/presentation/cubits/login_cubit/login_cubit.dart';
import '../../features/authentication/presentation/cubits/register_cubit/register_cubit.dart';
import '../../features/authentication/presentation/views/login_view.dart';
import '../../features/authentication/presentation/views/register_view.dart';
import '../../features/calender/calender_department.dart';
import '../../features/onboarding/presentation/cubit/onboarding_cubit.dart';
import '../../features/onboarding/presentation/views/onboarding_view.dart';
import '../../features/splash/presentation/views/splash_view.dart';

class Routes {
  static const String slashView = '/';
  static const String onBoardingView = '/onBoarding_view';
  static const String registerView = '/register_view';
  static const String loginView = '/login_view';
  static const String homeView = '/home_view';
  static const String landingView = '/landing_view';
  static const String collegeDetails = '/college_details_view';
  static const String calender = '/calender_view';
  static const String calenderDepartment = '/calender_department_view';
  static const String layoutView = '/layout_view';
  static const String searchView = '/search_view';
  static const String chatView = '/chat_view';
  static const String jobsView = '/jobs_view';
  static const String jobDetailsView = '/job_details_view';
  static const String applyJob = '/apply_job_view';
}

class AppRoutes {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.slashView:
        return MaterialPageRoute(
          builder: (context) => const SplashView(),
        );
      case Routes.onBoardingView:
        return PageFadeTransition(
          page: BlocProvider(
            create: (context) => OnBoardingCubit(),
            child: const OnBoardingView(),
          ),
        );
      case Routes.loginView:
        return PageFadeTransition(
          page: BlocProvider(
            create: (context) => LoginCubit(),
            child: const LoginView(),
          ),
        );
      case Routes.registerView:
        return PageSlideTransition(
          direction: AxisDirection.left,
          page: BlocProvider(
            create: (context) => RegisterCubit(),
            child: const RegisterView(),
          ),
        );
      case Routes.homeView:
        return PageSlideTransition(
          direction: AxisDirection.left,
          page: const HomePage(),
        );
      case Routes.landingView:
        return PageSlideTransition(
          direction: AxisDirection.left,
          page: const LandingPage(),
        );
      case Routes.collegeDetails:
        return PageSlideTransition(
          direction: AxisDirection.left,
          page: const CollegeDetails(),
        );
      case Routes.calender:
        return PageSlideTransition(
          direction: AxisDirection.left,
          page: BlocProvider(
              create: (context) => CalenderCubit()..getCalenderData(),
              child: const CalenderPage()),
        );
      case Routes.calenderDepartment:
        settings.arguments;
        return PageSlideTransition(
          direction: AxisDirection.left,
          page: BlocProvider(
              create: (context) => CalenderDepartmentCubit()..getCalenderDepartment(classId: settings.arguments as String),
              child: CalenderDepartmentPage()),
        );

    }
    return undefinedRoute();
  }

  static Route undefinedRoute() {
    return MaterialPageRoute(
      builder: ((context) => const Scaffold(
            body: Center(
              child: Text('no route found'),
            ),
          )),
    );
  }
}
