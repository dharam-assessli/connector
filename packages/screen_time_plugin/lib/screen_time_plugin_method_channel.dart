import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'screen_time_plugin_platform_interface.dart';

/// An implementation of [ScreenTimePluginPlatform] that uses method channels.
class MethodChannelScreenTimePlugin extends ScreenTimePluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('screen_time_plugin');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>(
      'getPlatformVersion',
    );
    return version;
  }
}
