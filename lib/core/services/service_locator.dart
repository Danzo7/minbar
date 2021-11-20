import 'package:get_it/get_it.dart';
import 'package:minbar_fl/components/theme/minbar_theme.dart';
import 'package:minbar_fl/core/services/AudioService.dart';
import 'package:minbar_fl/misc/navigation.dart';

/// [GetIt] is a simple service locator for accessing services from anywhere
/// in the app.
final GetIt app = GetIt.instance;

/// Adds the services to the [app] service locator.
void setupServices() {
  app
    ..registerLazySingleton(() => MinbarNavigator())
    ..registerLazySingleton(() => AudioService())
    ..registerLazySingleton(() => MinbarTheme());
}
