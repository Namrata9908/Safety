import 'package:battery_plus/battery_plus.dart';

class BatteryService {
  static Future<int> getBatteryLevel() async {
    final battery = Battery();

    int level = await battery.batteryLevel;
    print("CURRENT BATTERY LEVEL = $level");

    return level;
  }
}
