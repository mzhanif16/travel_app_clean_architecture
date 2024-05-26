import 'package:flutter/material.dart';
import 'package:travel_app_fix/feature/destination/domain/entities/destination_entity.dart';
import 'package:travel_app_fix/feature/destination/presentation/pages/dashboard_page.dart';
import 'package:travel_app_fix/feature/destination/presentation/pages/detail_destination_page.dart';
import 'package:travel_app_fix/feature/destination/presentation/pages/search_destination_page.dart';

class AppRoute {
  static const dashboard = '/';
  static const detailDestination = '/destination/detail';
  static const searchDestination = '/destination/search';

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case dashboard:
        return MaterialPageRoute(builder: (context) => const DashboardPage());
      case detailDestination:
        final destination = settings.arguments;
        if(destination==null)return _invalidArgumentPage;
        if(destination is! DestinationEntity)return _invalidArgumentPage;
        return MaterialPageRoute(builder: (context)=>DetailDestinationPage(destinationEntity: destination));
      case searchDestination:
        return MaterialPageRoute(builder: (context)=>const SearchDestinationPage());
      default:
        return _notFoundPage;
    }
  }

  static MaterialPageRoute get _notFoundPage => MaterialPageRoute(
      builder: (context) => const Scaffold(
            body: Center(
              child: Text('Page Not Found'),
            ),
          ));

  static MaterialPageRoute get _invalidArgumentPage => MaterialPageRoute(
      builder: (context) => const Scaffold(
        body: Center(
          child: Text('Invalid Argument'),
        ),
      ));
}
