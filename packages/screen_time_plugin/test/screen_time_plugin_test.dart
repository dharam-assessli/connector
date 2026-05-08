import 'package:flutter_test/flutter_test.dart';
import 'package:screen_time_plugin/screen_time_plugin.dart';
import 'package:screen_time_plugin/screen_time_plugin_platform_interface.dart';
import 'package:screen_time_plugin/screen_time_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockScreenTimePluginPlatform
    with MockPlatformInterfaceMixin
    implements ScreenTimePluginPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final ScreenTimePluginPlatform initialPlatform = ScreenTimePluginPlatform.instance;

  test('$MethodChannelScreenTimePlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelScreenTimePlugin>());
  });

  test('getPlatformVersion', () async {
    ScreenTimePlugin screenTimePlugin = ScreenTimePlugin();
    MockScreenTimePluginPlatform fakePlatform = MockScreenTimePluginPlatform();
    ScreenTimePluginPlatform.instance = fakePlatform;

    expect(await screenTimePlugin.getPlatformVersion(), '42');
  });
}
