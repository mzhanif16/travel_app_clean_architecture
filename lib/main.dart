import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app_fix/common/app_route.dart';
import 'package:travel_app_fix/feature/destination/presentation/bloc/all_destination/all_destination_bloc.dart';
import 'package:travel_app_fix/feature/destination/presentation/bloc/search_destination/search_destination_bloc.dart';
import 'package:travel_app_fix/feature/destination/presentation/cubit/dashboard_cubit.dart';
import 'package:travel_app_fix/injection.dart';

import 'feature/destination/presentation/bloc/top_destination/top_destination_bloc.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await initLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override 
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => DashboardCubit()),
        BlocProvider(create: (_) => locator<AllDestinationBloc>()),
        BlocProvider(create: (_) => locator<TopDestinationBloc>()),
        BlocProvider(create: (_) => locator<SearchDestinationBloc>()),
      ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            textTheme: GoogleFonts.poppinsTextTheme(),
            scaffoldBackgroundColor: Colors.white
          ),
          initialRoute: AppRoute.dashboard,
          onGenerateRoute: AppRoute.onGenerateRoute,
        ));
  }
}
