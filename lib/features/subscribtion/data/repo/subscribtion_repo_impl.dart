import 'package:dartz/dartz.dart';
import 'package:safi/core/errors/failure.dart';
import 'package:safi/features/subscribtion/data/datasource/subscribtion_remote_datasource.dart';
import 'package:safi/features/subscribtion/data/models/subscribtion_model.dart';
import 'package:safi/features/subscribtion/data/repo/subscribtion_repo.dart';

class SubscribtionRepoImpl extends SubscribtionRepo {
  final SubscribtionRemoteDatasource _datasource;

  SubscribtionRepoImpl({required SubscribtionRemoteDatasource datasource})
    : _datasource = datasource;
  @override
  Future<Either<Failure, List<SubscribtionModel>>> getAllSubscribtions() async {
    try {
      final subscribtions = await _datasource.getAllSubscribtions();

      return right(subscribtions);
    } catch (e) {
      return left(Failure(errMessage: e.toString()));
    }
  }
}
