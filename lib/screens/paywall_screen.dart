import 'package:flutter/material.dart';
import '../services/subscription_service.dart';
import 'home_screen.dart';

class PaywallScreen extends StatefulWidget {
  const PaywallScreen({super.key});

  @override
  State<PaywallScreen> createState() => _PaywallScreenState();
}

class _PaywallScreenState extends State<PaywallScreen> {
  String _selectedPlan = 'yearly';
  bool _isLoading = false;

  Future<void> _purchase() async {
    setState(() => _isLoading = true);

    // Эмуляция задержки покупки
    await Future.delayed(const Duration(seconds: 1));

    await SubscriptionService.purchaseSubscription(_selectedPlan);

    if (!mounted) return;

    setState(() => _isLoading = false);

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const HomeScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 40),
              const Icon(
                Icons.workspace_premium_rounded,
                size: 64,
                color: Color(0xFFE94560),
              ),
              const SizedBox(height: 20),
              const Text(
                'Выберите план',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Получите полный доступ ко всем функциям',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white.withValues(alpha: 0.7),
                ),
              ),
              const SizedBox(height: 40),
              // Годовая подписка
              _PlanCard(
                title: 'Годовая',
                price: '2 990 ₽/год',
                pricePerMonth: '≈ 249 ₽/мес',
                discount: 'Скидка 58%',
                isSelected: _selectedPlan == 'yearly',
                onTap: () => setState(() => _selectedPlan = 'yearly'),
              ),
              const SizedBox(height: 12),
              // Месячная подписка
              _PlanCard(
                title: 'Месячная',
                price: '599 ₽/мес',
                pricePerMonth: null,
                discount: null,
                isSelected: _selectedPlan == 'monthly',
                onTap: () => setState(() => _selectedPlan = 'monthly'),
              ),
              const Spacer(),
              // Преимущества
              _buildFeatureRow(Icons.check_circle, 'Безлимитный доступ'),
              const SizedBox(height: 8),
              _buildFeatureRow(Icons.check_circle, 'Без рекламы'),
              const SizedBox(height: 8),
              _buildFeatureRow(Icons.check_circle, 'Приоритетная поддержка'),
              const SizedBox(height: 32),
              // Кнопка покупки
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _purchase,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE94560),
                    foregroundColor: Colors.white,
                    disabledBackgroundColor:
                        const Color(0xFFE94560).withValues(alpha: 0.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Text(
                          'Продолжить',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () {
                  // Пропуск пейволла (опционально)
                },
                child: Text(
                  'Восстановить покупки',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.5),
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF4CAF50), size: 20),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 15),
        ),
      ],
    );
  }
}

class _PlanCard extends StatelessWidget {
  final String title;
  final String price;
  final String? pricePerMonth;
  final String? discount;
  final bool isSelected;
  final VoidCallback onTap;

  const _PlanCard({
    required this.title,
    required this.price,
    this.pricePerMonth,
    this.discount,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF16213E)
              : const Color(0xFF16213E).withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? const Color(0xFFE94560)
                : Colors.white.withValues(alpha: 0.1),
            width: 2,
          ),
        ),
        child: Row(
          children: [
            // Радио-индикатор
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFFE94560)
                      : Colors.white24,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? const Center(
                      child: CircleAvatar(
                        radius: 6,
                        backgroundColor: Color(0xFFE94560),
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 16),
            // Информация о плане
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  if (pricePerMonth != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Text(
                        pricePerMonth!,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.white.withValues(alpha: 0.5),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            // Цена и скидка
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  price,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                if (discount != null)
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFF4CAF50),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      discount!,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
