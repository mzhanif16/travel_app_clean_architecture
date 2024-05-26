import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_app_fix/core/platform/network_info.dart';
import 'package:travel_app_fix/feature/destination/data/datasource/destination_local_datasource.dart';
import 'package:travel_app_fix/feature/destination/data/datasource/destination_remote_datasource.dart';
import 'package:travel_app_fix/feature/destination/data/repository/destination_repositoryimpl.dart';
import 'package:travel_app_fix/feature/destination/domain/repository/destination_repository.dart';
import 'package:travel_app_fix/feature/destination/domain/usecases/get_all_destination_usecase.dart';
import 'package:travel_app_fix/feature/destination/domain/usecases/get_top_destination_usecase.dart';
import 'package:travel_app_fix/feature/destination/domain/usecases/search_destination_usecase.dart';
import 'package:travel_app_fix/feature/destination/presentation/bloc/all_destination/all_destination_bloc.dart';
import 'package:travel_app_fix/feature/destination/presentation/bloc/search_destination/search_destination_bloc.dart';
import 'package:travel_app_fix/feature/destination/presentation/bloc/top_destination/top_destination_bloc.dart';

import 'package:http/http.dart' as http;

final locator = GetIt.instance;

Future<void> initLocator() async {
  //bloc
  locator.registerFactory(() => AllDestinationBloc(locator()));
  locator.registerFactory(() => SearchDestinationBloc(locator()));
  locator.registerFactory(() => TopDestinationBloc(locator()));

  //usecase
  locator.registerLazySingleton(() => GetAllDestinationUseCase(locator()));
  locator.registerLazySingleton(() => GetTopDestinationUseCase(locator()));
  locator.registerLazySingleton(() => SearchDestinationUseCase(locator()));

  //repository
  locator.registerLazySingleton<DestinationRepository>(() =>
      DestinationRepositoryImpl(
          networkInfo: locator(),
          localDataSource: locator(),
          remoteDataSource: locator()));

  //datasource
  locator.registerLazySingleton<DestinationLocalDataSource>(
      () => DestinationLocalDataSourceImpl(locator()));
  locator.registerLazySingleton<DestinationRemoteDataSource>(
      () => DestinationRemoteDataSourceImpl(locator()));

  //platform
  locator.registerLazySingleton<NetworkInfo>(
          () => NetworkInfoImpl(locator()));

  //external
  final pref = await SharedPreferences.getInstance();
  locator.registerLazySingleton(() => pref);
  locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton(() => Connectivity());
}
