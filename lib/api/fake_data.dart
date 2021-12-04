import 'package:minbar_fl/model/cast.dart';
import 'package:minbar_fl/model/comment_data.dart';
import 'package:minbar_fl/model/publication.dart';
import 'package:minbar_fl/model/user.dart';

class FakeData {
  static List<UserData> users = [
    UserData(
        userId: "-1",
        firstName: "مسيلمة",
        lastName: "الكذاب",
        birthDate: DateTime(1998, 12, 2)),
    UserData(
        userId: "-2",
        firstName: "علي",
        lastName: "راشد",
        avatarUrl:
            "https://trello-members.s3.amazonaws.com/5eacf9a70febde6276206c08/514965ddb48dd00a19fe8f71b8201874/original.png",
        birthDate: DateTime(1998, 12, 2))
  ];
  static UserData currentUser = users[1];
  static List<Publication> pub = [
    Publication(
        id: "1",
        content:
            "نظل سنوات ندعو على الظالمين والمتكبرين  ومجرد أن نرى في أحدهم شيئا لا نستطيع الشماتة او التشفي ونوصي بعضنا بعضا قائلين - ارحموا عزيز قوم ذل لا عجب إذن أننا أُمة مرحومة. قلوبها كأفئدة الطير بحق",
        date: DateTime(2021, 9, 24, 23, 40),
        heartCount: 12214,
        pinCount: 5,
        author: users[0]),
    Publication(
        id: "2",
        content:
            "نظل سنوات ندعو على الظالمين والمتكبرين  ومجرد أن نرى في أحدهم شيئا لا نستطيع الشماتة او التشفي ونوصي بعضنا بعضا قائلين - ارحموا عزيز قوم ذل لا عجب إذن أننا أُمة مرحومة. قلوبها كأفئدة الطير بحق",
        date: DateTime(2021, 9, 24, 23, 40),
        heartCount: 24,
        pinCount: 5,
        author: users[1]),
    Publication(
        id: "3",
        content:
            "نظل سنوات ندعو على الظالمين والمتكبرين  ومجرد أن نرى في أحدهم شيئا لا نستطيع الشماتة او التشفي ونوصي بعضنا بعضا قائلين - ارحموا عزيز قوم ذل لا عجب إذن أننا أُمة مرحومة. قلوبها كأفئدة الطير بحق",
        date: DateTime(2021, 9, 24, 23, 40),
        heartCount: 24,
        pinCount: 5,
        author: users[0]),
    Publication(
        id: "4",
        content:
            "نظل سنوات ندعو على الظالمين والمتكبرين  ومجرد أن نرى في أحدهم شيئا لا نستطيع الشماتة او التشفي ونوصي بعضنا بعضا قائلين - ارحموا عزيز قوم ذل لا عجب إذن أننا أُمة مرحومة. قلوبها كأفئدة الطير بحق",
        date: DateTime(2021, 9, 24, 23, 40),
        heartCount: 24,
        pinCount: 5,
        author: users[0]),
    Publication(
        id: "5",
        content:
            "نظل سنوات ندعو على الظالمين والمتكبرين  ومجرد أن نرى في أحدهم شيئا لا نستطيع الشماتة او التشفي ونوصي بعضنا بعضا قائلين - ارحموا عزيز قوم ذل لا عجب إذن أننا أُمة مرحومة. قلوبها كأفئدة الطير بحق",
        date: DateTime(2021, 9, 24, 23, 40),
        heartCount: 24,
        pinCount: 5,
        author: users[0]),
    Publication(
        id: "6",
        content:
            "نظل سنوات ندعو على الظالمين والمتكبرين  ومجرد أن نرى في أحدهم شيئا لا نستطيع الشماتة او التشفي ونوصي بعضنا بعضا قائلين - ارحموا عزيز قوم ذل لا عجب إذن أننا أُمة مرحومة. قلوبها كأفئدة الطير بحق",
        date: DateTime(2021, 9, 24, 23, 40),
        heartCount: 24,
        pinCount: 5,
        author: users[0]),
    Publication(
        id: "7",
        content:
            "نظل سنوات ندعو على الظالمين والمتكبرين  ومجرد أن نرى في أحدهم شيئا لا نستطيع الشماتة او التشفي ونوصي بعضنا بعضا قائلين - ارحموا عزيز قوم ذل لا عجب إذن أننا أُمة مرحومة. قلوبها كأفئدة الطير بحق",
        date: DateTime(2021, 9, 24, 23, 40),
        heartCount: 24,
        pinCount: 5,
        author: users[0]),
    Publication(
        id: "8",
        content:
            "نظل سنوات ندعو على الظالمين والمتكبرين  ومجرد أن نرى في أحدهم شيئا لا نستطيع الشماتة او التشفي ونوصي بعضنا بعضا قائلين - ارحموا عزيز قوم ذل لا عجب إذن أننا أُمة مرحومة. قلوبها كأفئدة الطير بحق",
        date: DateTime(2021, 9, 24, 23, 40),
        heartCount: 24,
        pinCount: 5,
        author: users[0]),
    Publication(
        id: "9",
        content:
            "نظل سنوات ندعو على الظالمين والمتكبرين  ومجرد أن نرى في أحدهم شيئا لا نستطيع الشماتة او التشفي ونوصي بعضنا بعضا قائلين - ارحموا عزيز قوم ذل لا عجب إذن أننا أُمة مرحومة. قلوبها كأفئدة الطير بحق",
        date: DateTime(2021, 9, 24, 23, 40),
        heartCount: 24,
        pinCount: 5,
        author: users[0]),
    Publication(
        id: "10",
        content:
            "نظل سنوات ندعو على الظالمين والمتكبرين  ومجرد أن نرى في أحدهم شيئا لا نستطيع الشماتة او التشفي ونوصي بعضنا بعضا قائلين - ارحموا عزيز قوم ذل لا عجب إذن أننا أُمة مرحومة. قلوبها كأفئدة الطير بحق",
        date: DateTime(2021, 9, 24, 23, 40),
        heartCount: 24,
        pinCount: 5,
        author: users[0]),
    Publication(
        id: "11",
        content:
            "نظل سنوات ندعو على الظالمين والمتكبرين  ومجرد أن نرى في أحدهم شيئا لا نستطيع الشماتة او التشفي ونوصي بعضنا بعضا قائلين - ارحموا عزيز قوم ذل لا عجب إذن أننا أُمة مرحومة. قلوبها كأفئدة الطير بحق",
        date: DateTime(2021, 9, 24, 23, 40),
        heartCount: 24,
        pinCount: 5,
        author: users[0]),
    Publication(
        id: "12",
        content:
            "نظل سنوات ندعو على الظالمين والمتكبرين  ومجرد أن نرى في أحدهم شيئا لا نستطيع الشماتة او التشفي ونوصي بعضنا بعضا قائلين - ارحموا عزيز قوم ذل لا عجب إذن أننا أُمة مرحومة. قلوبها كأفئدة الطير بحق",
        date: DateTime(2021, 9, 24, 23, 40),
        heartCount: 24,
        pinCount: 5,
        author: users[0]),
    Publication(
        id: "13",
        content: "سوء الضن",
        date: DateTime(2021, 9, 24, 23, 40),
        heartCount: 24,
        pinCount: 5,
        cast: casts[1],
        author: users[0]),
    Publication(
        id: "14",
        content:
            "نظل سنوات ندعو على الظالمين والمتكبرين  ومجرد أن نرى في أحدهم شيئا لا نستطيع الشماتة او التشفي ونوصي بعضنا بعضا قائلين - ارحموا عزيز قوم ذل لا عجب إذن أننا أُمة مرحومة. قلوبها كأفئدة الطير بحق",
        date: DateTime(2021, 9, 24, 23, 40),
        heartCount: 24,
        pinCount: 5,
        author: users[0]),
  ];
  static List<Cast> casts = [
    Cast(
        host: users[0],
        field: "حوار",
        subject: "قرأن",
        castId:
            "https://usa11.fastcast4u.com/proxy/alserajr?mp=/1&DIST=TuneIn&TGT=TuneIn&maxServers=2&gdpr=0&us_privacy=1YNY&partnertok=eyJhbGciOiJIUzI1NiIsImtpZCI6InR1bmVpbiIsInR5cCI6IkpXVCJ9.eyJ0cnVzdGVkX3BhcnRuZXIiOnRydWUsImlhdCI6MTYzNzExNjI1OCwiaXNzIjoidGlzcnYifQ.8av-wHYv_5JVOtkPtJ4CgCa-UPnsRcoQMJjSidngEfg"),
    Cast(host: users[0], field: "حوار", subject: "الثقة", listeners: 2),
    Cast(host: users[0], field: "حوار", subject: "الكون"),
    Cast(host: users[0], field: "حوار", subject: "العلم"),
    Cast(host: users[0], field: "حوار", subject: "الثقة والمعرفة"),
    Cast(host: users[0], field: "حوار", subject: "حسنا"),
    Cast(
        host: users[0],
        field: "حوار",
        subject: "الاثم",
        castId:
            "https://alchemyfor.life/podcasts/fantasy.mp3?DIST=TuneIn&TGT=TuneIn&maxServers=2"),
    Cast(
        host: users[0],
        field: "حوار",
        subject: "mindfulness",
        castId:
            "https://content.production.cdn.art19.com/validation=1637202989,3288c423-3a6e-5033-bde6-622ec1a05f62,AbKEr8-SJY05bAOAmF6Ga7HQ7BI/episodes/fadc4e33-4472-4cdd-8b3a-bcb608854efb/90d7c4a5a65c585b2b8dbe7808c25751955d50e035ddc7c5ca9f1ea174ae6f0c43bc7f5ca7f437c5be87879c59927cf7efa831ba6bd8458602f2e013278a008d/%23565%20Anne%20Moss%20Rogers.mp3"),
    Cast(
        host: users[0],
        field: "حوار",
        subject: "health radio",
        castId:
            "https://streaming.radio.co/s8e535ff20/listen?DIST=TuneIn&TGT=TuneIn&maxServers=2&gdpr=0&us_privacy=1YNY&partnertok=eyJhbGciOiJIUzI1NiIsImtpZCI6InR1bmVpbiIsInR5cCI6IkpXVCJ9.eyJ0cnVzdGVkX3BhcnRuZXIiOnRydWUsImlhdCI6MTYzNzExNTQ4NywiaXNzIjoidGlzcnYifQ.-brXkcPpoO2n2fJ79nRpMGEQ-ZlwR-zkG0V0doTfCXo"),
    Cast(
        host: users[0],
        field: "lofi",
        subject: "Lo_Fi Music",
        castId:
            "https://usa9.fastcast4u.com/proxy/jamz?mp=/1&DIST=TuneIn&TGT=TuneIn&maxServers=2&gdpr=0&us_privacy=1YNY&partnertok=eyJhbGciOiJIUzI1NiIsImtpZCI6InR1bmVpbiIsInR5cCI6IkpXVCJ9.eyJ0cnVzdGVkX3BhcnRuZXIiOnRydWUsImlhdCI6MTYzNzExNjg4NiwiaXNzIjoidGlzcnYifQ._zUJw0MSlmuwzJ2NaHHBfwdqSr2FWfPrHea_1RWAeKk"),
  ];
  static const List<String> fields = ["الكل", "درس", "خطبة", "حوار"];
  static List<CommentData> commentList = [
    CommentData("شكرا", users[0]),
    CommentData("الحمد لله", users[0]),
    CommentData("اهلا", users[0]),
    CommentData("شكرا", users[0]),
    CommentData("اهلا", users[0]),
    CommentData("اهلا", users[0]),
    CommentData("منافق", users[0]),
    CommentData(" لا", users[0]),
    CommentData("اكتب سبحان الله", users[0]),
    CommentData("كذاب", users[0]),
    CommentData("اهلا", users[0]),
  ];


}
