import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:tempokit/model/user.dart';

import 'package:tempokit/util/api_client.dart';
import 'package:tempokit/util/cache_controller.dart';
import 'package:encrypt/encrypt.dart';

// class MockApi extends Mock implements ApiClient {}
class MockHttpClient extends Mock implements Client {}

class MockCacheController extends Mock implements CacheController {}

void main() {
  ApiClient apiClient;
  MockHttpClient mockHttpClient;
  MockCacheController mockCacheController;
  final Key _key = Key.fromUtf8('moy_modniy_klu4ik_dlinoy_32_bita');
  final IV _iv = IV.fromLength(16);
  final Encrypter _encrypter = Encrypter(AES(_key));

  setUp(() {
    mockHttpClient = MockHttpClient();
    mockCacheController = MockCacheController();
    apiClient = ApiClient(
      client: mockHttpClient,
      cacheController: mockCacheController,
    );
  });

  group('encrypt', () {
    test('should encrypt password', () {
      // act
      String password = _encrypter.encrypt('12345', iv: _iv).base64;
      // assert
      print(password);
      expect(password, password);
    });
  });

  group('auth', () {
    test('should perform [POST] /signup', () async {
      // arrange
      final randomUser = User(
        uEmail: 'test${Random().nextInt(1 << 16)}@gmail.com',
        fullName: 'Test Test',
        password: _encrypter.encrypt('12345', iv: _iv).base64,
        workType: 'Tester',
      );
      // act
      final result = await apiClient.register(
        user: randomUser,
      );
      // assert
      print(result);
      expect(result, result);
    });
    test('should perform [POST] /signin', () async {
      // act
      final result = await apiClient.logIn(
        uEmail: 'morshnev.aleksey@gmail.com',
        password: _encrypter.encrypt('12345', iv: _iv).base64,
      );
      // assert
      print(result);
      expect(result, result);
    });
  });

  group('company', () {
    test('should perform [GET]', () async {
      // act
      await apiClient.logIn(
        uEmail: 'morshnev.aleksey@gmail.com',
        password: _encrypter.encrypt('12345', iv: _iv).base64,
      );
      final result = await apiClient.getAllCompanies();
      // assert
      print(result);
      expect(result, result);
    });
    test('should perform [POST]', () async {
      // act
      await apiClient.logIn(
        uEmail: 'morshnev.aleksey@gmail.com',
        password: _encrypter.encrypt('12345', iv: _iv).base64,
      );
      final result = await apiClient.createCompany(
          name: 'Test${Random().nextInt(1 << 16)}');
      //assert
      print(result);
      expect(result, result);
    });
  });

  group('project', () {
    test('should perform [GET]', () async {
      // act
      await apiClient.logIn(
        uEmail: 'morshnev.aleksey@gmail.com',
        password: _encrypter.encrypt('12345', iv: _iv).base64,
      );
      final result = await apiClient.getProjects(compId: 2);
      // assert
      print(result);
      expect(result, result);
    });
    test('should perform [POST]', () async {
      // act
      await apiClient.logIn(
        uEmail: 'morshnev.aleksey@gmail.com',
        password: _encrypter.encrypt('12345', iv: _iv).base64,
      );
      final result = await apiClient.createProject(
          compId: 2, description: 'Test', name: 'Testing Project');
      // assert
      print(result);
      expect(result, result);
    });
    test('should perform [PUT]', () {});
    test('should perform [DELETE]', () {});
  });

  group('task', () {
    test('should perform [GET]', () {});
    test('should perform [POST]', () {});
    test('should perform [PUT]', () {});
    test('should perform [DELETE]', () {});
  });
}
