import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:trenni/database/database.dart';

class DatabaseService {
  final _secureStorage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );
  final _localAuth = LocalAuthentication();
  
  static const String _dbKeyStorageName = 'trenni_db_encryption_key';

  bool get requiresPassword {
    if (kIsWeb) return false;
    return Platform.isWindows;
  }

  Future<bool> databaseFileExists() async {
    final dbFolder = await getApplicationSupportDirectory();
    final file = File(p.join(dbFolder.path, 'trenni.db'));
    return file.existsSync();
  }

  Future<bool> hasStoredKey() async {
    if (requiresPassword) return false;
    final key = await _secureStorage.read(key: _dbKeyStorageName);
    return key != null;
  }

  Future<bool> authenticateBiometrically() async {
    try {
      final isAvailable = await _localAuth.canCheckBiometrics;
      final isDeviceSupported = await _localAuth.isDeviceSupported();
      if (!isAvailable && !isDeviceSupported) {
        return false;
      }
      return await _localAuth.authenticate(
        localizedReason: 'Trenni requires biometric authentication to secure your local encrypted database.',
        options: const AuthenticationOptions(
          biometricOnly: false, // Standard OS fallback to PIN/passcode
          stickyAuth: true,
        ),
      );
    } catch (_) {
      return false;
    }
  }

  Future<String> getOrCreateKey() async {
    if (requiresPassword) {
      throw StateError('Password-based platforms must provide their key manually.');
    }
    
    var key = await _secureStorage.read(key: _dbKeyStorageName);
    if (key == null) {
      final random = Random.secure();
      final bytes = List<int>.generate(32, (_) => random.nextInt(256));
      key = base64Url.encode(bytes);
      await _secureStorage.write(key: _dbKeyStorageName, value: key);
    }
    return key;
  }

  Future<bool> verifyDatabaseKey(String passphrase) async {
    try {
      if (!await databaseFileExists()) {
        return true; // No file, setup key for the first time
      }
      final db = AppDatabase(openConnection(passphrase));
      // Force execution of a simple query to verify the encryption key is correct
      final result = await db.customSelect("SELECT 1 AS val;").getSingle();
      await db.close();
      return result.read<int>('val') == 1;
    } catch (_) {
      return false;
    }
  }

  AppDatabase initDatabase(String passphrase) {
    return AppDatabase(openConnection(passphrase));
  }
}
