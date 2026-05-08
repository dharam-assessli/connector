import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'screen_time_plugin_method_channel.dart';

abstract class ScreenTimePluginPlatform extends PlatformInterface {
  /// Constructs a ScreenTimePluginPlatform.
  ScreenTimePluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static ScreenTimePluginPlatform _instance = MethodChannelScreenTimePlugin();

  /// The default instance of [ScreenTimePluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelScreenTimePlugin].
  static ScreenTimePluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [ScreenTimePluginPlatform] when
  /// they register themselves.
  static set instance(ScreenTimePluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
