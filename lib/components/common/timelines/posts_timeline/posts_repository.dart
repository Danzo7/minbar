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
    return Future<bool>.delayed(Duration(seconds: 0), () {
      Publication res = doFakeUpdate(current, liked: liked, pinned: pinned);
      if (res == current) return false;
      //TODO:catch exceptions
      data[data.indexWhere((element) => element.id == current.id)] = res;
      return true;
    });
  }

  Publication doFakeUpdate(Publication currentPub,
      {bool? liked, bool? pinned}) {
    int selectedIndex =
        FakeData.pub.indexWhere((element) => element.id == currentPub.id);
    if (selectedIndex != -1) {
      int heartAddition = liked != null
          ? (((liked && currentPub.hasHeart) ||
                  (!liked && !currentPub.hasHeart))
              ? 0
              : (liked && !currentPub.hasHeart)
                  ? 1
                  : (!liked && currentPub.hasHeart)
                      ? -1
                      : 0)
          : 0;
      int pinAddition = pinned != null
          ? (((pinned && currentPub.hasPin) || (!pinned && !currentPub.hasPin))
              ? 0
              : (pinned && !currentPub.hasPin)
                  ? 1
                  : (!pinned && currentPub.hasPin)
                      ? -1
                      : 0)
          : 0;
      FakeData.pub[selectedIndex] = currentPub.copyWith(
          hasHeart: liked ?? currentPub.hasCast,
          hasPin: pinned ?? currentPub.hasPin,
          pinCount: currentPub.pinCount + pinAddition,
          heartCount: currentPub.heartCount + heartAddition);

      return FakeData.pub[selectedIndex];
    } else {
      throw Exception('wtf!');
    }
  }
}
