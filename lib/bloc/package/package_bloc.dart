import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:frond_end_rental/models/package.dart';
import 'package:frond_end_rental/repositories/package_repository.dart';

part 'package_event.dart';
part 'package_state.dart';

class PackageBloc extends Bloc<PackageEvent, PackageState> {
  PackageBloc() : super(const PackageState()) {
    on<PackageFetched>(_onPackageFetched);
  }

  _onPackageFetched(PackageFetched event, Emitter<PackageState> emit) async {
    try {
      final response = await PackageRepository.getPackages();
      emit(state.copyWith(
        status: PackageStatus.success,
        packages: List.of(state.packages)..addAll(response),
      ));
    } on DioException catch (_) {
      emit(state.copyWith(status: PackageStatus.failure));
    }
  }
}
