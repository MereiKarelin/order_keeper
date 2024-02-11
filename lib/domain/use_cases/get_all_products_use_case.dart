import 'package:injectable/injectable.dart';
import 'package:order_keeper/data/models/response/products_respinse_model.dart';

import 'package:order_keeper/domain/repository/waiter_repo.dart';
import 'package:order_keeper/domain/use_cases/base_use_case.dart';

@lazySingleton
class GetAllProductsUseCase
    implements UseCase<ProductsResponseModel, NoParams> {
  final WaiterRepo repository;

  const GetAllProductsUseCase({
    required this.repository,
  });

  @override
  Future<ProductsResponseModel> call(NoParams params) async {
    return await repository.getAllProducts();
  }
}
