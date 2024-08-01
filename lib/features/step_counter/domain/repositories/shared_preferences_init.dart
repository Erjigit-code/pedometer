import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesInit {
  static const String STEP_COUNT_KEY = 'STEP_COUNT_KEY';
  static const String STEP_GOAL_KEY = 'STEP_GOAL_KEY';

  static Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(STEP_COUNT_KEY)) {
      await prefs.setInt(STEP_COUNT_KEY, 0);
    }
    if (!prefs.containsKey(STEP_GOAL_KEY)) {
      await prefs.setInt(STEP_GOAL_KEY, 10000);
    }
    print("SharedPreferences initialized with default values if needed");
  }
}