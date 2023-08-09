part of 'package_bloc.dart';

enum PackageStatus { initial, failure, success }

final class PackageState extends Equatable {
  final List<Package> packages;
  final PackageStatus status;

  const PackageState({
    this.packages = const <Package>[],
    this.status = PackageStatus.initial,
  });

  PackageState copyWith({List<Package>? packages, PackageStatus? status}) =>
      PackageState(
        status: status ?? this.status,
        packages: packages ?? this.packages,
      );

  @override
  List<Object> get props => [packages, status];
}
