// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UserLocation)
final userLocationProvider = UserLocationProvider._();

final class UserLocationProvider
    extends $StreamNotifierProvider<UserLocation, LocationData> {
  UserLocationProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userLocationProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userLocationHash();

  @$internal
  @override
  UserLocation create() => UserLocation();
}

String _$userLocationHash() => r'50f18613a6f13deeb17faa71adba1f8e4dc2b498';

abstract class _$UserLocation extends $StreamNotifier<LocationData> {
  Stream<LocationData> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<LocationData>, LocationData>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<LocationData>, LocationData>,
              AsyncValue<LocationData>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
