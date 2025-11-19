import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/models/subscribtion_model.dart';
import '../../../data/repo/subscribtion_repo.dart';

part 'subscribtion_state.dart';

class SubscribtionCubit extends Cubit<SubscribtionState> {
  SubscribtionCubit(this._subscribtionRepo) : super(SubscribtionInitial());
  final SubscribtionRepo _subscribtionRepo;
  void updateSubscribtionPage(
    int index,
  ) {
    emit(
      UpdateSubscribtionPage(
        index: index,
      ),
    );
  }

  void getSubscribtions() async {
    emit(SubscribtionLoading());
    final subscribtionsOrfailure = await _subscribtionRepo
        .getAllSubscribtions();

    subscribtionsOrfailure.fold(
      (failure) => emit(
        SubscribtionFailure(errMessage: failure.errMessage),
      ),
      (subscribtions) => emit(
        SubscribtionLoaded(subscribtions: subscribtions),
      ),
    );
  }
}
