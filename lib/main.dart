import 'package:flutter/material.dart';
import 'widgets/header_banner.dart';
import 'widgets/profile_card.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Quản lý trạng thái theme hiện tại (Sáng/Tối)
  ThemeMode _themeMode = ThemeMode.light;

  // Hàm callback để thay đổi theme
  void toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    const seedColor = Color(0xFF0468D7);

    return MaterialApp(
      title: 'F2_231A010603', 
      debugShowCheckedModeBanner: false,
      // Giao diện sáng
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: seedColor, 
          brightness: Brightness.light
        ),
        inputDecorationTheme: const InputDecorationTheme(border: OutlineInputBorder()),
      ),
      // Giao diện tối (NC1)
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: seedColor, 
          brightness: Brightness.dark
        ),
        inputDecorationTheme: const InputDecorationTheme(border: OutlineInputBorder()),
      ),
      themeMode: _themeMode,
      // Truyền hàm callback xuống LoginPage
      home: LoginPage(onToggleTheme: toggleTheme),
    );
  }
}

class LoginPage extends StatefulWidget {
  final VoidCallback onToggleTheme;
  const LoginPage({super.key, required this.onToggleTheme});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _ghiNho = false;
  bool _anMatKhau = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Sử dụng widget đã tách, truyền hàm callback (NC2)
              HeaderBanner(onToggleTheme: widget.onToggleTheme),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final manHinhRong = constraints.maxWidth >= 700;
                    if (!manHinhRong) {
                      return Column(
                        children: [
                          _buildForm(context),
                          const SizedBox(height: 24),
                          const ProfileCard(),
                        ],
                      );
                    }
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 3, child: _buildForm(context)),
                        const SizedBox(width: 24),
                        const Expanded(flex: 2, child: ProfileCard()),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Đăng nhập hệ thống', style: textTheme.headlineSmall, textAlign: TextAlign.center),
        const SizedBox(height: 4),
        Text(
          'Nhập MSSV và mật khẩu để tiếp tục',
          style: textTheme.bodyMedium?.copyWith(color: scheme.outline),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        const TextField(
          decoration: InputDecoration(
            labelText: 'Mã số sinh viên',
            prefixIcon: Icon(Icons.badge_outlined),
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          obscureText: _anMatKhau,
          decoration: InputDecoration(
            labelText: 'Mật khẩu',
            prefixIcon: const Icon(Icons.lock_outline),
            suffixIcon: IconButton(
              icon: Icon(_anMatKhau ? Icons.visibility_off : Icons.visibility),
              onPressed: () => setState(() => _anMatKhau = !_anMatKhau),
            ),
          ),
        ),
        Row(
          children: [
            Checkbox(
              value: _ghiNho,
              onChanged: (v) => setState(() => _ghiNho = v ?? false),
            ),
            const Text('Ghi nhớ đăng nhập'),
            const Spacer(),
            TextButton(onPressed: () {}, child: const Text('Quên mật khẩu?')),
          ],
        ),
        const SizedBox(height: 8),
        FilledButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Đăng nhập (mô phỏng) thành công')),
            );
          },
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Text('ĐĂNG NHẬP'),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            const Expanded(child: Divider()),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text('hoặc', style: TextStyle(color: scheme.outline)),
            ),
            const Expanded(child: Divider()),
          ],
        ),
        const SizedBox(height: 16),
        OutlinedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.school_outlined),
          label: const Text('Đăng nhập bằng tài khoản trường'),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Chưa có tài khoản?'),
            TextButton(onPressed: () {}, child: const Text('Đăng ký')),
          ],
        ),
      ],
    );
  }
}