import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/models/subscribtion_model.dart';
import '../../../data/repo/subscribtion_repo.dart';

part 'add_subscription_state.dart';

class AddSubscriptionCubit extends Cubit<AddSubscriptionState> {
  AddSubscriptionCubit(this._subscribtionRepo)
    : super(AddSubscriptionInitial());

  final SubscribtionRepo _subscribtionRepo;

  void addSubscripe({required userId, required SubscribtionModel model}) async {
    emit(AddSubscriptionLoading());
    final subscribeOrfailure = await _subscribtionRepo.addSubscripe(
      userId: userId,
      subscripe: model,
    );
    subscribeOrfailure.fold(
      (failure) => emit(AddSubscriptionFailure(errMessage: failure.errMessage)),
      (_) => emit(AddSubscriptionLoaded()), 
      
    );
  }
}
