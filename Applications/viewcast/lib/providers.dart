import 'package:flutter_riverpod/flutter_riverpod.dart';

final passwordProvider = StateProvider((ref) => "");

final visibilityProvider = StateProvider<bool>((ref) => true);

final standardProvider = StateProvider<bool>((ref) => true);

final errorUpdateProvider = StateProvider<int>((ref) => 0);

final localeProvider = StateProvider<String?>((ref) => "en");

final actualPage = StateProvider<String?>((ref) => "en");
