import 'package:dalily/features/settings/logic/profile_cubit.dart';
import 'package:dalily/features/settings/logic/update_user_profile_cubit/update_user_profile_cubit.dart';
import 'package:dalily/haha.dart';
import 'package:dalily/sasa.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dada.dart';
import 'firebase_options.dart';
import 'config/local/cache_helper.dart';
import 'config/routes/app_routes.dart';
import 'config/themes/app_theme.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Supabase.initialize(
      url: 'https://vgzhhoynlhayyhxnwaix.supabase.co',
      anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZnemhob3lubGhheXloeG53YWl4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDcxNDYzMDUsImV4cCI6MjA2MjcyMjMwNX0.p3JYU9RpI9RfFqQFPxr1rGbUALKJGTEc75HUhNWlcNE');
  await CacheHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  void initState() {
    // TODO: implement initState
    //ProfileCubit.get(context).getUser();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return  MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => ProfileCubit()..getUser(),),
            BlocProvider(create: (context) => UpdateUserProfileCubit(),)
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            locale: Locale('ar'), //
            supportedLocales: [
             // Locale('en'),
              Locale('ar'),
            ],
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            // theme: ThemeData(
            //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            // ),
            theme: appTheme(),
            //home: ModernLandingPage(),
            onGenerateRoute: AppRoutes.generateRoute,
          ),
        );
      },

    );
  }
}
