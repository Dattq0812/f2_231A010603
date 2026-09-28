import 'package:flutter/material.dart';

class HeaderBanner extends StatelessWidget {
  final VoidCallback onToggleTheme;
  
  const HeaderBanner({super.key, required this.onToggleTheme});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return SizedBox(
      height: 196,
      child: Stack(
        children: [
          Container(
            height: 150,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [scheme.primary, scheme.tertiary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
            ),
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'INT4211 – LẬP TRÌNH DI ĐỘNG',
                      style: TextStyle(color: scheme.onPrimary, fontSize: 12, letterSpacing: 1.5),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Cổng thực hành LTDD',
                      style: TextStyle(
                        color: scheme.onPrimary,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                // Nút chuyển đổi Dark/Light mode (NC1)
                IconButton(
                  icon: Icon(
                    Theme.of(context).brightness == Brightness.dark 
                        ? Icons.light_mode 
                        : Icons.dark_mode,
                    color: scheme.onPrimary,
                  ),
                  onPressed: onToggleTheme,
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Center(
              child: CircleAvatar(
                radius: 46,
                backgroundColor: scheme.surface,
                child: CircleAvatar(
                  radius: 42,
                  backgroundColor: scheme.primaryContainer,
                  child: Text(
                    'LT',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: scheme.onPrimaryContainer,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}