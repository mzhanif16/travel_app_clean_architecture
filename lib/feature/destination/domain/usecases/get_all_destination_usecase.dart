import 'package:dartz/dartz.dart';
import 'package:travel_app_fix/feature/destination/domain/repository/destination_repository.dart';

import '../../../../core/error/failures.dart';
import '../entities/destination_entity.dart';

class GetAllDestinationUseCase {
  final DestinationRepository _repository;

  GetAllDestinationUseCase(this._repository);

  Future<Either<Failure, List<DestinationEntity>>> call() {
    return _repository.all();
  }
}
