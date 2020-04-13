import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tempokit/model/column.dart';
import 'package:tempokit/model/comment.dart';
import 'package:tempokit/model/company.dart';
import 'package:tempokit/model/file.dart';
import 'package:tempokit/model/milestone.dart';
import 'package:tempokit/model/project.dart';
import 'package:tempokit/model/report.dart';
import 'package:tempokit/model/tag.dart';
import 'package:tempokit/model/task.dart';
import 'package:tempokit/model/user.dart';

class ApiClient {
  final http.Client client;

  ApiClient(this.client);

  final String baseUrl = 'someurl/';

  Future<dynamic> _getJson(Uri uri) async {
    try {
      final response = await client.get(uri);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        //...
      }
    } catch (err) {
      //...
    }
  }

  Future<List<Project>> getAllProjects({String uEmail, int compId}) async {
    final url = Uri.https(baseUrl, 'project', {});

    dynamic json = await _getJson(url);
    return json.map<Project>((item) => Project.fromJson(item)).toList();
  }
}
