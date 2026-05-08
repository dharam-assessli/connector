
import 'screen_time_plugin_platform_interface.dart';

class ScreenTimePlugin {
  Future<String?> getPlatformVersion() {
    return ScreenTimePluginPlatform.instance.getPlatformVersion();
  }
}
