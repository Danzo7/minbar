import 'package:flutter/material.dart';
import 'package:minbar_fl/components/static/colors.dart';
import 'package:minbar_fl/components/widgets/NavgationBar/NavigationBar.dart';
import 'package:minbar_fl/components/widgets/ScrollView.dart';
import 'package:minbar_fl/components/widgets/post/post.dart';
import 'package:minbar_fl/model/publication.dart';

List<Publication> pub = [
  Publication(
      id: "12334",
      content:
          "نظل سنوات ندعو على الظالمين والمتكبرين  ومجرد أن نرى في أحدهم شيئا لا نستطيع الشماتة او التشفي ونوصي بعضنا بعضا قائلين - ارحموا عزيز قوم ذل لا عجب إذن أننا أُمة مرحومة. قلوبها كأفئدة الطير بحق",
      type: "حوار",
      date: DateTime(2021, 9, 24, 23, 40),
      likeCount: 24,
      pinCount: 5,
      hasPodcast: false,
      authorAvatar: "assets/images/profilePicture.png",
      authorName: "مسيلمة الكذاب"),
  Publication(
      id: "12334",
      content:
          "نظل سنوات ندعو على الظالمين والمتكبرين  ومجرد أن نرى في أحدهم شيئا لا نستطيع الشماتة او التشفي ونوصي بعضنا بعضا قائلين - ارحموا عزيز قوم ذل لا عجب إذن أننا أُمة مرحومة. قلوبها كأفئدة الطير بحق",
      type: "حوار",
      date: DateTime(2021, 9, 24, 23, 40),
      likeCount: 24,
      pinCount: 5,
      hasPodcast: false,
      authorAvatar: "assets/images/profilePicture.png",
      authorName: "مسيلمة الكذاب"),
  Publication(
      id: "12334",
      content:
          "نظل سنوات ندعو على الظالمين والمتكبرين  ومجرد أن نرى في أحدهم شيئا لا نستطيع الشماتة او التشفي ونوصي بعضنا بعضا قائلين - ارحموا عزيز قوم ذل لا عجب إذن أننا أُمة مرحومة. قلوبها كأفئدة الطير بحق",
      type: "حوار",
      date: DateTime(2021, 9, 24, 23, 40),
      likeCount: 24,
      pinCount: 5,
      hasPodcast: false,
      authorAvatar: "assets/images/profilePicture.png",
      authorName: "مسيلمة الكذاب"),
  Publication(
      id: "12334",
      content:
          "نظل سنوات ندعو على الظالمين والمتكبرين  ومجرد أن نرى في أحدهم شيئا لا نستطيع الشماتة او التشفي ونوصي بعضنا بعضا قائلين - ارحموا عزيز قوم ذل لا عجب إذن أننا أُمة مرحومة. قلوبها كأفئدة الطير بحق",
      type: "حوار",
      date: DateTime(2021, 9, 24, 23, 40),
      likeCount: 24,
      pinCount: 5,
      hasPodcast: false,
      authorAvatar: "assets/images/profilePicture.png",
      authorName: "مسيلمة الكذاب"),
  Publication(
      id: "12334",
      content:
          "نظل سنوات ندعو على الظالمين والمتكبرين  ومجرد أن نرى في أحدهم شيئا لا نستطيع الشماتة او التشفي ونوصي بعضنا بعضا قائلين - ارحموا عزيز قوم ذل لا عجب إذن أننا أُمة مرحومة. قلوبها كأفئدة الطير بحق",
      type: "حوار",
      date: DateTime(2021, 9, 24, 23, 40),
      likeCount: 24,
      pinCount: 5,
      hasPodcast: false,
      authorAvatar: "assets/images/profilePicture.png",
      authorName: "مسيلمة الكذاب"),
  Publication(
      id: "12334",
      content:
          "نظل سنوات ندعو على الظالمين والمتكبرين  ومجرد أن نرى في أحدهم شيئا لا نستطيع الشماتة او التشفي ونوصي بعضنا بعضا قائلين - ارحموا عزيز قوم ذل لا عجب إذن أننا أُمة مرحومة. قلوبها كأفئدة الطير بحق",
      type: "حوار",
      date: DateTime(2021, 9, 24, 23, 40),
      likeCount: 24,
      pinCount: 5,
      hasPodcast: false,
      authorAvatar: "assets/images/profilePicture.png",
      authorName: "مسيلمة الكذاب"),
  Publication(
      id: "12334",
      content:
          "نظل سنوات ندعو على الظالمين والمتكبرين  ومجرد أن نرى في أحدهم شيئا لا نستطيع الشماتة او التشفي ونوصي بعضنا بعضا قائلين - ارحموا عزيز قوم ذل لا عجب إذن أننا أُمة مرحومة. قلوبها كأفئدة الطير بحق",
      type: "حوار",
      date: DateTime(2021, 9, 24, 23, 40),
      likeCount: 24,
      pinCount: 5,
      hasPodcast: false,
      authorAvatar: "assets/images/profilePicture.png",
      authorName: "مسيلمة الكذاب"),
  Publication(
      id: "12334",
      content:
          "نظل سنوات ندعو على الظالمين والمتكبرين  ومجرد أن نرى في أحدهم شيئا لا نستطيع الشماتة او التشفي ونوصي بعضنا بعضا قائلين - ارحموا عزيز قوم ذل لا عجب إذن أننا أُمة مرحومة. قلوبها كأفئدة الطير بحق",
      type: "حوار",
      date: DateTime(2021, 9, 24, 23, 40),
      likeCount: 24,
      pinCount: 5,
      hasPodcast: false,
      authorAvatar: "assets/images/profilePicture.png",
      authorName: "مسيلمة الكذاب"),
  Publication(
      id: "12334",
      content:
          "نظل سنوات ندعو على الظالمين والمتكبرين  ومجرد أن نرى في أحدهم شيئا لا نستطيع الشماتة او التشفي ونوصي بعضنا بعضا قائلين - ارحموا عزيز قوم ذل لا عجب إذن أننا أُمة مرحومة. قلوبها كأفئدة الطير بحق",
      type: "حوار",
      date: DateTime(2021, 9, 24, 23, 40),
      likeCount: 24,
      pinCount: 5,
      hasPodcast: false,
      authorAvatar: "assets/images/profilePicture.png",
      authorName: "مسيلمة الكذاب"),
  Publication(
      id: "12334",
      content:
          "نظل سنوات ندعو على الظالمين والمتكبرين  ومجرد أن نرى في أحدهم شيئا لا نستطيع الشماتة او التشفي ونوصي بعضنا بعضا قائلين - ارحموا عزيز قوم ذل لا عجب إذن أننا أُمة مرحومة. قلوبها كأفئدة الطير بحق",
      type: "حوار",
      date: DateTime(2021, 9, 24, 23, 40),
      likeCount: 24,
      pinCount: 5,
      hasPodcast: false,
      authorAvatar: "assets/images/profilePicture.png",
      authorName: "مسيلمة الكذاب"),
  Publication(
      id: "12334",
      content:
          "نظل سنوات ندعو على الظالمين والمتكبرين  ومجرد أن نرى في أحدهم شيئا لا نستطيع الشماتة او التشفي ونوصي بعضنا بعضا قائلين - ارحموا عزيز قوم ذل لا عجب إذن أننا أُمة مرحومة. قلوبها كأفئدة الطير بحق",
      type: "حوار",
      date: DateTime(2021, 9, 24, 23, 40),
      likeCount: 24,
      pinCount: 5,
      hasPodcast: false,
      authorAvatar: "assets/images/profilePicture.png",
      authorName: "مسيلمة الكذاب"),
  Publication(
      id: "12334",
      content:
          "نظل سنوات ندعو على الظالمين والمتكبرين  ومجرد أن نرى في أحدهم شيئا لا نستطيع الشماتة او التشفي ونوصي بعضنا بعضا قائلين - ارحموا عزيز قوم ذل لا عجب إذن أننا أُمة مرحومة. قلوبها كأفئدة الطير بحق",
      type: "حوار",
      date: DateTime(2021, 9, 24, 23, 40),
      likeCount: 24,
      pinCount: 5,
      hasPodcast: false,
      authorAvatar: "assets/images/profilePicture.png",
      authorName: "مسيلمة الكذاب"),
  Publication(
      id: "12334",
      content: "سوء الضن",
      type: "درس",
      date: DateTime(2021, 9, 24, 23, 40),
      likeCount: 24,
      pinCount: 5,
      hasPodcast: true,
      authorAvatar: "assets/images/profilePicture.png",
      authorName: "مسيلمة الكذاب"),
  Publication(
      id: "12334",
      content:
          "نظل سنوات ندعو على الظالمين والمتكبرين  ومجرد أن نرى في أحدهم شيئا لا نستطيع الشماتة او التشفي ونوصي بعضنا بعضا قائلين - ارحموا عزيز قوم ذل لا عجب إذن أننا أُمة مرحومة. قلوبها كأفئدة الطير بحق",
      type: "حوار",
      date: DateTime(2021, 9, 24, 23, 40),
      likeCount: 24,
      pinCount: 5,
      hasPodcast: false,
      authorAvatar: "assets/images/profilePicture.png",
      authorName: "مسيلمة الكذاب"),
];

class ShowCaseScreen extends StatelessWidget {
  final component;
  const ShowCaseScreen({Key? key, this.component}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: DColors.white,
        extendBody: true,
        body: Container(
          padding: EdgeInsets.all(10),
          child: SpacedScrollView(
            spacing: 10,
            children: [...pub.map((e) => Post(e)).toList()],
          ),
          alignment: Alignment.center,
        ),
        bottomNavigationBar: const NavigationBar(selectedIndex: 1));
  }
}
