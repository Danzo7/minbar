import 'dart:math';

import 'package:minbar_fl/api/fake_data.dart';
import 'dart:async';

import 'package:minbar_fl/model/publication.dart';

class PostsRepository {
  final List<Publication> data = [];
  Future<List<Publication>> fetchItems() {
    return Future<List<Publication>>.delayed(
        Duration(seconds: Random().nextInt(3)), () {
      // if (Random().nextBool()) throw Exception('cannot communicate');
      data.addAll(FakeData.pub);
      return data;
    });
  }

  Future<bool> updatePublication(Publication current,
      {bool? liked, bool? pinned}) {
    return Future<bool>.delayed(Duration(seconds: 1), () {
      Publication res = doFakeUpdate(current.id, liked: liked, pinned: pinned);
      if (res == current) return false;
      data[data.indexOf(current)] = res;
      return true;
    });
  }

  Publication doFakeUpdate(String id, {bool? liked, bool? pinned}) {
    int selectedIndex = FakeData.pub
        .indexOf(FakeData.pub.firstWhere((element) => element.id == id));
    if (selectedIndex != -1) {
      Publication selected = FakeData.pub[selectedIndex];
      FakeData.pub[selectedIndex] = selected.copyWith(
          hasHeart: liked ?? FakeData.pub[selectedIndex].hasCast,
          hasPin: pinned ?? FakeData.pub[selectedIndex].hasPin,
          pinCount: selected.pinCount + (pinned != null && pinned ? 1 : 0),
          heartCount: selected.heartCount + (liked != null && liked ? 1 : 0));

      return FakeData.pub[selectedIndex];
    } else {
      return FakeData.pub[selectedIndex];
    }
  }
}
