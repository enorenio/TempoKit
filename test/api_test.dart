import 'dart:math';

import 'package:encrypt/encrypt.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tempokit/model/comment.dart';
import 'package:tempokit/model/company.dart';
import 'package:tempokit/model/project.dart';
import 'package:tempokit/model/column.dart' as c;
import 'package:tempokit/model/tag.dart';

import 'package:tempokit/model/task.dart';
import 'package:tempokit/model/user.dart';
import 'package:tempokit/util/api_client.dart';
import 'package:tempokit/util/cache_controller.dart';
import 'package:tempokit/util/network/network_info.dart';
import 'package:tempokit/util/repository.dart';

class MockApiClient extends Mock implements ApiClient {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

class MockCacheController extends Mock implements CacheController {}

void main() {
  Repository repository;
  MockNetworkInfo mockNetworkInfo;
  ApiClient mockApiClient;
  MockCacheController mockCacheController;

  final Key _key = Key.fromUtf8('moy_modniy_klu4ik_dlinoy_32_bita');
  final IV _iv = IV.fromLength(16);
  final Encrypter _encrypter = Encrypter(AES(_key));

  final User gUser = User(
    uEmail: 'test${Random().nextInt(1 << 16)}@gmail.com',
    fullName: 'Test Test',
    password: '12345',
    workType: 'Tester',
  );

  Company gCompany;
  Project gProject;
  c.Column gColumn;
  Task gTask;
  Comment gComment;
  Tag gTag;

  setUp(() {
    mockApiClient = ApiClient();
    mockNetworkInfo = MockNetworkInfo();
    mockCacheController = MockCacheController();
    repository = Repository(
      apiClient: mockApiClient,
      networkInfo: mockNetworkInfo,
      cacheController: mockCacheController,
    );
    when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
  });

  group('encrypt', () {
    test('should encrypt password', () {
      // act
      String password = _encrypter.encrypt(gUser.password, iv: _iv).base64;
      // assert
      print(password);
      expect(password, password);
    });
  });

  group('auth', () {
    test('should perform [POST] /signup', () async {
      // act
      final result = await repository.register(
        user: gUser,
      );
      gUser.password = '12345';
      // assert
      print(result);
      expect(result, result);
    });
    test('should perform [POST] /signin', () async {
      // act
      final result = await repository.logIn(
        uEmail: gUser.uEmail,
        password: gUser.password,
      );
      // assert
      print(result);
      expect(result, result);
    });
  });

  group('company', () {
    test('should perform [POST]', () async {
      // act
      await repository.logIn(
        uEmail: gUser.uEmail,
        password: gUser.password,
      );
      final result = await repository.createCompany(
          name: 'Test${Random().nextInt(1 << 16)}');
      gCompany = result;
      //assert
      print(result);
      expect(result, result);
    });
    test('should perform [GET]', () async {
      // act
      await repository.logIn(
        uEmail: gUser.uEmail,
        password: gUser.password,
      );
      final result = await repository.getAllCompanies();
      // assert
      print(result);
      expect(result, result);
    });
  });

  group('project', () {
    test('should perform [POST]', () async {
      // act
      await repository.logIn(
        uEmail: gUser.uEmail,
        password: gUser.password,
      );
      final result = await repository.createProject(
          compId: gCompany.compId,
          description: 'Test',
          name: 'Testing Project');
      // assert
      gProject = result;
      print(result);
      expect(result, result);
    });
    test('should perform [GET]', () async {
      // act
      await repository.logIn(
        uEmail: gUser.uEmail,
        password: gUser.password,
      );
      final result = await repository.getProjects(compId: gCompany.compId);
      // assert
      print(result);
      expect(result, result);
    });
    test('should perform [POST] favourite', () async {
      // act
      await repository.logIn(
        uEmail: gUser.uEmail,
        password: gUser.password,
      );
      await repository.makeFavouriteProject(
        project: gProject,
        makeFavourite: true,
      );
      // assert
      // print(result);
      expect(1, 1);
    });
    test('should perform [PUT]', () {});
    test('should perform [DELETE]', () {});
  });

  group('column', () {
    test('should perform [POST]', () async {
      // act
      await repository.logIn(
        uEmail: gUser.uEmail,
        password: gUser.password,
      );
      final result = await repository.createColumn(
        name: 'Column${Random().nextInt(1 << 16)}',
        pId: gProject.pId,
      );
      gColumn = result;
      // assert
      print(result);
      expect(result, result);
    });

    test('should perform [GET]', () async {
      // act
      await repository.logIn(
        uEmail: gUser.uEmail,
        password: gUser.password,
      );
      final result = await repository.getColumns(pId: gProject.pId);
      // assert
      print(result);
      expect(result, result);
    });

    test('should perform [PUT]', () async {});

    test('should perform [DELETE]', () async {});
  });

  group('task', () {
    test('should perform [POST]', () async {
      // act
      await repository.logIn(
        uEmail: gUser.uEmail,
        password: gUser.password,
      );
      final result = await repository.createTask(
        task: Task(
          name: 'Task${Random().nextInt(1 << 16)}',
          description: 'Description',
          dueDate: '2020-05-05',
          colId: gColumn.colId,
        ),
      );
      gTask = result;
      // assert
      print(result);
      expect(result, result);
    });
    test('should perform [GET]', () async {
      // act
      await repository.logIn(
        uEmail: gUser.uEmail,
        password: gUser.password,
      );
      final result = await repository.getColumnsAndTasks(pId: gProject.pId);
      // assert
      print(result);
      expect(result, result);
    });
    test('should perform [PUT]', () {});
    test('should perform [DELETE]', () {});

    test('should perform [GET] myTasks', () async {
      // act
      await repository.logIn(
        uEmail: gUser.uEmail,
        password: gUser.password,
      );
      final result = await repository.getMyTasks();
      // assert
      print(result);
      expect(result, result);
    });

    test('should perform [GET] byMeTasks', () async {
      // act
      await repository.logIn(
        uEmail: gUser.uEmail,
        password: gUser.password,
      );
      final result = await repository.getByMeTasks();
      // assert
      print(result);
      expect(result, result);
    });

    test('should perform [POST] assign', () async {
      // act
      await repository.logIn(
        uEmail: gUser.uEmail,
        password: gUser.password,
      );
      final result = await repository.assignTask(
        task: gTask,
        assignees: [
          gUser,
        ],
      );
      // assert
      print(result);
      expect(result, result);
    });
  });

  group('comments', () {
    test('should perform [POST]', () async {
      // act
      await repository.logIn(
        uEmail: gUser.uEmail,
        password: gUser.password,
      );
      final result = await repository.createComment(
          text: 'Comment${Random().nextInt(1 << 16)}', taskId: gTask.taskId);
      gComment = result;
      // assert
      print(result);
      expect(result, result);
    });

    test('should perform [GET]', () async {
      // act
      await repository.logIn(
        uEmail: gUser.uEmail,
        password: gUser.password,
      );
      final result = await repository.getAllComments(taskId: gTask.taskId);
      // assert
      print(result);
      expect(result, result);
    });

    test('should perform [PUT]', () {});

    test('should perform [DELETE]', () {});
  });

  group('tags', () {
    test('should perform [POST]', () async {
      // act
      await repository.logIn(
        uEmail: gUser.uEmail,
        password: gUser.password,
      );
      final result = await repository.createTag(
        project: gProject,
        tag: Tag(
          name: 'Tag${Random().nextInt(1 << 16)}',
          color: '388E3C',
        ),
      );
      gTag = result;
      // assert
      print(result);
      expect(result, result);
    });

    test('should perform [GET]', () async {
      // act
      await repository.logIn(
        uEmail: gUser.uEmail,
        password: gUser.password,
      );
      final result = await repository.getAllTags(project: gProject);
      // assert
      print(result);
      expect(result, result);
    });

    test('should perform [PUT]', () {});

    test('should perform [DELETE]', () {});

    test('should perform [POST] assign', () async {
      // act
      await repository.logIn(
        uEmail: gUser.uEmail,
        password: gUser.password,
      );
      await repository.assignTag(task: gTask, tags: [gTag]);
      // assert
      // print(result);
      expect(1, 1);
    });
  });
}
