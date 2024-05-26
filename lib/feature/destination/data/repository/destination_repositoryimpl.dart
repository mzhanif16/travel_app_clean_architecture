import 'dart:async';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:travel_app_fix/core/error/exceptions.dart';
import 'package:travel_app_fix/core/error/failures.dart';
import 'package:travel_app_fix/core/platform/network_info.dart';
import 'package:travel_app_fix/feature/destination/data/datasource/destination_local_datasource.dart';
import 'package:travel_app_fix/feature/destination/data/datasource/destination_remote_datasource.dart';
import 'package:travel_app_fix/feature/destination/domain/entities/destination_entity.dart';
import 'package:travel_app_fix/feature/destination/domain/repository/destination_repository.dart';

class DestinationRepositoryImpl implements DestinationRepository {
  final NetworkInfo networkInfo;
  final DestinationLocalDataSource localDataSource;
  final DestinationRemoteDataSource remoteDataSource;

  DestinationRepositoryImpl(
      {required this.networkInfo,
      required this.localDataSource,
      required this.remoteDataSource});

  @override
  Future<Either<Failure, List<DestinationEntity>>> all() async {
    bool online = await networkInfo.isConnected();
    // if (online) {
      try {
        final result = await remoteDataSource.all();
        await localDataSource.cacheAll(result);
        return Right(result.map((e) => e.toEntity).toList());
      } on NotFoundException {
        return const Left(NotFoundFailure('Data Not Found'));
      } on ServerException {
        return const Left(ServerFailure('Server Error'));
      } on TimeoutException {
        return const Left(TimeoutFailure('Time Out. No Response'));
      }
    // } else {
    //   try {
    //     final result = await localDataSource.getAll();
    //     return Right(result.map((e) => e.toEntity).toList());
    //   } on CacheException {
    //     return const Left(CachedFailure('Data is not Present'));
    //   }
    // }
  }

  @override
  Future<Either<Failure, List<DestinationEntity>>> search(String query) async {
    try {
      final result = await remoteDataSource.search(query);
      return Right(result.map((e) => e.toEntity).toList());
    } on NotFoundException {
      return const Left(NotFoundFailure('Data Not Found'));
    } on ServerException {
      return const Left(ServerFailure('Server Error'));
    } on TimeoutException {
      return const Left(TimeoutFailure('Timeout. No Response'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed connect to the Network'));
    }
  }

  @override
  Future<Either<Failure, List<DestinationEntity>>> top() async {
    try {
      final result = await remoteDataSource.top();
      return Right(result.map((e) => e.toEntity).toList());
    } on NotFoundException {
      return const Left(NotFoundFailure('Data Not Found'));
    } on ServerException {
      return const Left(ServerFailure('Server Error'));
    } on TimeoutException {
      return const Left(TimeoutFailure('Timeout. No Response'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed connect to the Network'));
    }
  }
}
