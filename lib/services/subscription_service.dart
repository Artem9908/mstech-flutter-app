import 'package:shared_preferences/shared_preferences.dart';

class SubscriptionService {
  static const String _subscriptionKey = 'is_subscribed';
  static const String _subscriptionTypeKey = 'subscription_type';
  static const String _purchaseDateKey = 'purchase_date';

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
    await prefs.setString(_purchaseDateKey, DateTime.now().toIso8601String());
  }

  /// Возвращает тип подписки
  static Future<String?> getSubscriptionType() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_subscriptionTypeKey);
  }

  /// Возвращает дату покупки
  static Future<DateTime?> getPurchaseDate() async {
    final prefs = await SharedPreferences.getInstance();
    final dateStr = prefs.getString(_purchaseDateKey);
    if (dateStr == null) return null;
    return DateTime.tryParse(dateStr);
  }

  /// Сбрасывает подписку (для тестирования)
  static Future<void> resetSubscription() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_subscriptionKey);
    await prefs.remove(_subscriptionTypeKey);
    await prefs.remove(_purchaseDateKey);
  }
}
