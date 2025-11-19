import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../datasource/subscribtion_remote_datasource.dart';
import '../models/subscribtion_model.dart';
import 'subscribtion_repo.dart';

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
