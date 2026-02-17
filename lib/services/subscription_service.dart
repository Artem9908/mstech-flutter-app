import 'package:shared_preferences/shared_preferences.dart';

class SubscriptionService {
  static const String _subscriptionKey = 'is_subscribed';
  static const String _subscriptionTypeKey = 'subscription_type';

  /// Проверяет, есть ли активная подписка
  static Future<bool> isSubscribed() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_subscriptionKey) ?? false;
  }

  /// Сохраняет подписку (эмуляция покупки)
  static Future<void> purchaseSubscription(String type) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_subscriptionKey, true);
    await prefs.setString(_subscriptionTypeKey, type);
  }

  /// Возвращает тип подписки
  static Future<String?> getSubscriptionType() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_subscriptionTypeKey);
  }
}
