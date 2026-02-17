import 'package:flutter/material.dart';
import '../services/subscription_service.dart';
import 'onboarding_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> _resetSubscription(BuildContext context) async {
    await SubscriptionService.resetSubscription();
    if (!context.mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const OnboardingScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF16213E),
        title: const Text(
          'Главная',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_rounded, color: Colors.white54),
            tooltip: 'Сбросить подписку',
            onPressed: () => _resetSubscription(context),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Баннер подписки
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFE94560), Color(0xFF0F3460)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Premium активен',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Полный доступ ко всем функциям',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withValues(alpha: 0.8),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.verified_rounded,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Категории (горизонтальный скролл)
          const Text(
            'Категории',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 100,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: const [
                _CategoryChip(
                    icon: Icons.fitness_center_rounded,
                    label: 'Фитнес',
                    color: Color(0xFFE94560)),
                _CategoryChip(
                    icon: Icons.restaurant_rounded,
                    label: 'Питание',
                    color: Color(0xFF4CAF50)),
                _CategoryChip(
                    icon: Icons.self_improvement_rounded,
                    label: 'Медитация',
                    color: Color(0xFF2196F3)),
                _CategoryChip(
                    icon: Icons.menu_book_rounded,
                    label: 'Обучение',
                    color: Color(0xFFFF9800)),
                _CategoryChip(
                    icon: Icons.nightlight_rounded,
                    label: 'Сон',
                    color: Color(0xFF9C27B0)),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Рекомендации
          const Text(
            'Рекомендации',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          const _ContentCard(
            title: 'Утренняя тренировка',
            subtitle: '15 минут · Для начинающих',
            icon: Icons.bolt_rounded,
            color: Color(0xFFE94560),
          ),
          const _ContentCard(
            title: 'Здоровый завтрак',
            subtitle: '5 рецептов · 10 мин на готовку',
            icon: Icons.restaurant_rounded,
            color: Color(0xFF4CAF50),
          ),
          const _ContentCard(
            title: 'Вечерняя медитация',
            subtitle: '10 минут · Снятие стресса',
            icon: Icons.self_improvement_rounded,
            color: Color(0xFF2196F3),
          ),
          const _ContentCard(
            title: 'Продуктивность',
            subtitle: 'Техника Pomodoro · 7 советов',
            icon: Icons.timer_rounded,
            color: Color(0xFFFF9800),
          ),
          const _ContentCard(
            title: 'Глубокий сон',
            subtitle: '30 минут · Звуки природы',
            icon: Icons.nightlight_rounded,
            color: Color(0xFF9C27B0),
          ),
        ],
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _CategoryChip({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 88,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF16213E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _ContentCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;

  const _ContentCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF16213E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white.withValues(alpha: 0.5),
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.play_circle_fill_rounded,
            color: color.withValues(alpha: 0.7),
            size: 32,
          ),
        ],
      ),
    );
  }
}
