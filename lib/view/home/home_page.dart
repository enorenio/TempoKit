import 'package:flutter/material.dart';
import 'package:tempokit/util/cache_controller.dart';
import 'package:tempokit/util/consts.dart';

import '../../injection_container.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$this',
              style: Theme.of(context).textTheme.title,
            ),
            RaisedButton(
              child: Text('Dispatch 1'),
              onPressed: () async {
                CacheController cacheController = sl();
                String authKey = await cacheController.readKey(AUTH_CACHE_KEY);
                String userKey = await cacheController.readKey(USER_CACHE_KEY);
                print(authKey);
                print(userKey);
              },
            ),
          ],
        ),
      ),
    );
  }
}
