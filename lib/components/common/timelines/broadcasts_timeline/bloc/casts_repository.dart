import 'dart:math';

import 'package:minbar_fl/api/fake_data.dart';
import 'package:minbar_fl/model/cast.dart';

class CastsRepository {
  final List<Cast> data = [];
  Future<List<Cast>> fetchItems() {
    return Future<List<Cast>>.delayed(Duration(seconds: Random().nextInt(3)),
        () {
      // if (Random().nextBool()) throw Exception('cannot communicate');
      data.addAll(FakeData.casts);
      return data;
    });
  }
}
