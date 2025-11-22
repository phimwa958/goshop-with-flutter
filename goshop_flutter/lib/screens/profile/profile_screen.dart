import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/accessible_button.dart';
import '../../widgets/loading_indicator.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Future<void> _logout(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Logout'),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      await context.read<AuthProvider>().logout();
      if (context.mounted) {
        context.go('/login');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        leading: Semantics(
          button: true,
          label: 'Back button',
          hint: 'Navigate to previous screen',
          child: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              if (Navigator.of(context).canPop()) {
                Navigator.of(context).pop();
              } else {
                context.go('/products');
              }
            },
          ),
        ),
      ),
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          if (authProvider.isLoading) {
            return const LoadingIndicator(message: 'Loading profile...');
          }

          final user = authProvider.currentUser;
          if (user == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Please login to view your profile'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => context.go('/login'),
                    child: const Text('Login'),
                  ),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Semantics(
                  image: true,
                  label: 'Profile picture',
                  child: const Center(
                    child: CircleAvatar(
                      radius: 60,
                      child: Icon(Icons.person, size: 60),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Semantics(
                  header: true,
                  child: Text(
                    user.email,
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 32),
                Card(
                  child: Column(
                    children: [
                      Semantics(
                        button: true,
                        label: 'View my orders',
                        hint: 'Navigate to order history',
                        child: ListTile(
                          leading: const Icon(Icons.receipt_long),
                          title: const Text('My Orders'),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () => context.go('/orders'),
                        ),
                      ),
                      const Divider(height: 1),
                      Semantics(
                        button: true,
                        label: 'Change password',
                        hint: 'Navigate to change password screen',
                        child: ListTile(
                          leading: const Icon(Icons.lock),
                          title: const Text('Change Password'),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () => context.go('/change-password'),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                AccessibleButton(
                  label: 'Logout',
                  semanticHint: 'Logout from your account',
                  onPressed: () => _logout(context),
                  icon: Icons.logout,
                  backgroundColor: Colors.red,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
