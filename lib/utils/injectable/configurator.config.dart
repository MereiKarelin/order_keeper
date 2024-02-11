// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:order_keeper/data/datasource/waiters_local_datasourse.dart'
    as _i5;
import 'package:order_keeper/data/repository_impl/waiter_repo_impl.dart' as _i7;
import 'package:order_keeper/domain/repository/waiter_repo.dart' as _i6;
import 'package:order_keeper/domain/use_cases/add_order_use_case.dart' as _i8;
import 'package:order_keeper/domain/use_cases/get_all_products_use_case.dart'
    as _i9;
import 'package:order_keeper/domain/use_cases/get_all_tables_use_case.dart'
    as _i10;
import 'package:order_keeper/domain/use_cases/get_table_by_id_use_case.dart'
    as _i11;
import 'package:order_keeper/featers/add_order/bloc/add_order_bloc.dart'
    as _i13;
import 'package:order_keeper/featers/tables/bloc/tables_bloc.dart' as _i12;
import 'package:order_keeper/utils/sql/database_service.dart' as _i3;
import 'package:order_keeper/utils/sql/database_service_impl.dart' as _i4;

_i1.GetIt $initGetIt(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  gh.lazySingleton<_i3.DatabaseService>(() => _i4.DatabaseServiceImpl());
  gh.lazySingleton<_i5.WatersLocalDataSource>(
      () => _i5.WatersLocalDataSourceImpl(gh<_i3.DatabaseService>()));
  gh.lazySingleton<_i6.WaiterRepo>(() => _i7.WaiterRepoImpl(
      waiterLocalDataSource: gh<_i5.WatersLocalDataSource>()));
  gh.lazySingleton<_i8.AddOrderUseCase>(
      () => _i8.AddOrderUseCase(repository: gh<_i6.WaiterRepo>()));
  gh.lazySingleton<_i9.GetAllProductsUseCase>(
      () => _i9.GetAllProductsUseCase(repository: gh<_i6.WaiterRepo>()));
  gh.lazySingleton<_i10.GetAllTablesUseCase>(
      () => _i10.GetAllTablesUseCase(repository: gh<_i6.WaiterRepo>()));
  gh.lazySingleton<_i11.GetTableByIdUseCase>(
      () => _i11.GetTableByIdUseCase(repository: gh<_i6.WaiterRepo>()));
  gh.factory<_i12.TablesBloc>(() =>
      _i12.TablesBloc(getAllTablesUseCase: gh<_i10.GetAllTablesUseCase>()));
  gh.factory<_i13.AddOrderBloc>(() => _i13.AddOrderBloc(
        getAllProductsUseCase: gh<_i9.GetAllProductsUseCase>(),
        getTableByIdUseCase: gh<_i11.GetTableByIdUseCase>(),
        addOrderUseCase: gh<_i8.AddOrderUseCase>(),
      ));
  return get;
}
