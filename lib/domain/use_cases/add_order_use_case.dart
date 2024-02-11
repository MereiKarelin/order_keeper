import 'package:injectable/injectable.dart';
import 'package:order_keeper/data/models/response/orders_response_model.dart';

import 'package:order_keeper/domain/repository/waiter_repo.dart';
import 'package:order_keeper/domain/use_cases/base_use_case.dart';

@lazySingleton
class AddOrderUseCase implements UseCase<void, OrderResponseModel> {
  final WaiterRepo repository;

  const AddOrderUseCase({
    required this.repository,
  });

  @override
  Future<void> call(OrderResponseModel params) async {
    return await repository.addOrder(params);
  }
}
