import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trenni/database/providers.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;
  bool _isNewDatabase = false;
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkDatabaseStateAndAttemptAuth();
    });
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _checkDatabaseStateAndAttemptAuth() async {
    final dbService = ref.read(databaseServiceProvider);
    
    // Check if the database file already exists.
    final exists = await dbService.databaseFileExists();
    setState(() {
      _isNewDatabase = !exists;
    });

    if (!dbService.requiresPassword) {
      // Mobile/macOS Workflow
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      final hasKey = await dbService.hasStoredKey();
      if (!hasKey) {
        // First install: generate the secure random 256-bit key and decrypt instantly
        try {
          final key = await dbService.getOrCreateKey();
          final db = dbService.initDatabase(key);
          ref.read(databaseProvider.notifier).state = db;
        } catch (e) {
          setState(() {
            _isLoading = false;
            _errorMessage = 'Failed to generate encryption key: $e';
          });
        }
        return;
      }

      // If key exists, trigger biometrics
      _triggerBiometrics();
    }
  }

  Future<void> _triggerBiometrics() async {
    final dbService = ref.read(databaseServiceProvider);
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final success = await dbService.authenticateBiometrically();
    if (success) {
      try {
        final key = await dbService.getOrCreateKey();
        final db = dbService.initDatabase(key);
        ref.read(databaseProvider.notifier).state = db;
      } catch (e) {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Failed to open secure database: $e';
        });
      }
    } else {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Biometric authentication cancelled or failed. Please authenticate.';
      });
    }
  }

  Future<void> _unlockWithPassword() async {
    final password = _passwordController.text;
    if (password.isEmpty) {
      setState(() {
        _errorMessage = 'Password cannot be empty';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    // Let the event loop refresh the UI before blocking FFI operations
    await Future.delayed(const Duration(milliseconds: 100));

    final dbService = ref.read(databaseServiceProvider);
    final isValid = await dbService.verifyDatabaseKey(password);

    if (isValid) {
      try {
        final db = dbService.initDatabase(password);
        ref.read(databaseProvider.notifier).state = db;
      } catch (e) {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Failed to open database: $e';
        });
      }
    } else {
      setState(() {
        _isLoading = false;
        _errorMessage = _isNewDatabase 
            ? 'Failed to initialize database with password.' 
            : 'Incorrect Master Password. Please try again.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final dbService = ref.watch(databaseServiceProvider);
    final isPasswordRequired = dbService.requiresPassword;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              colorScheme.primary.withValues(alpha: 0.05),
              colorScheme.surface,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Card(
                elevation: 8,
                shadowColor: colorScheme.shadow.withValues(alpha: 0.15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Header Icon & Lock Aura
                      Container(
                        width: 72,
                        height: 72,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              colorScheme.primary,
                              colorScheme.secondary,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: colorScheme.primary.withValues(alpha: 0.3),
                              blurRadius: 16,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.lock_outline,
                          color: Colors.white,
                          size: 36,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Trenni',
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _isNewDatabase
                            ? 'Create a Master Password to encrypt your data locally.'
                            : 'Enter your Master Password to unlock Trenni.',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 32),

                      if (_errorMessage != null) ...[
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: colorScheme.errorContainer.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: colorScheme.error.withValues(alpha: 0.3),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.error_outline, color: colorScheme.error, size: 20),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  _errorMessage!,
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: colorScheme.onErrorContainer,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],

                      if (_isLoading)
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 24),
                          child: CircularProgressIndicator(),
                        )
                      else ...[
                        if (isPasswordRequired) ...[
                          TextField(
                            controller: _passwordController,
                            obscureText: _obscurePassword,
                            keyboardType: TextInputType.visiblePassword,
                            autofocus: true,
                            decoration: InputDecoration(
                              labelText: _isNewDatabase ? 'Create Master Password' : 'Master Password',
                              prefixIcon: const Icon(Icons.password_outlined),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: BorderSide(
                                  color: colorScheme.outlineVariant,
                                ),
                              ),
                            ),
                            onSubmitted: (_) => _unlockWithPassword(),
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton(
                            onPressed: _unlockWithPassword,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: colorScheme.primary,
                              foregroundColor: colorScheme.onPrimary,
                              minimumSize: const Size.fromHeight(56),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              elevation: 2,
                            ),
                            child: Text(
                              _isNewDatabase ? 'Create & Decrypt' : 'Unlock Database',
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                        ] else ...[
                          // Mobile/macOS Trigger
                          ElevatedButton.icon(
                            onPressed: _triggerBiometrics,
                            icon: Icon(
                              Platform.isMacOS || Platform.isIOS
                                  ? Icons.face_retouching_natural_outlined
                                  : Icons.fingerprint_outlined,
                            ),
                            label: const Text('Unlock with Biometrics'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: colorScheme.primary,
                              foregroundColor: colorScheme.onPrimary,
                              minimumSize: const Size.fromHeight(56),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              elevation: 2,
                            ),
                          ),
                        ]
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
