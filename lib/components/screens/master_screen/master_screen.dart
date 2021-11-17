import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:marquee/marquee.dart';
import 'package:minbar_fl/components/widgets/minbar_bottom_sheet.dart';
import 'package:minbar_fl/components/theme/default_colors.dart';
import 'package:minbar_fl/components/theme/default_theme.dart';
import 'package:minbar_fl/components/widgets/buttons/buttons.dart';
import 'package:minbar_fl/components/widgets/misc/minbar_scaffold.dart';
import 'package:minbar_fl/components/widgets/text_play.dart';
import 'package:minbar_fl/components/widgets/voice_visualisation.dart';
import 'package:minbar_fl/core/services/AudioService.dart';
import 'package:minbar_fl/core/services/cast_service.dart';
import 'package:minbar_fl/core/services/cubit/cast_cubit.dart';
import 'package:minbar_fl/core/services/service_locator.dart';
import 'package:minbar_fl/misc/page_navigation.dart';
import 'pages/pages.dart';
export 'pages/pages.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MasterScreen extends StatelessWidget {
  MasterScreen({Key? key}) : super(key: key);

  final NavgationController navgationController = NavgationController();
  Widget build(BuildContext context) {
    DateTime timeBackPressed = DateTime.now();
    return WillPopScope(
      onWillPop: () async {
        if (MinbarBottomSheetInstances.mayPop())
          return false;
        else if (navgationController.mayPop())
          return false;
        else {
          final differeance = DateTime.now().difference(timeBackPressed);
          timeBackPressed = DateTime.now();
          if (differeance >= Duration(seconds: 2)) {
            final String msg = 'اضغط مرة اخرى للخروج';
            Fluttertoast.showToast(
              msg: msg,
            );
            return false;
          } else {
            Fluttertoast.cancel();
            SystemNavigator.pop();
            return true;
          }
        }
      },
      child: BlocProvider(
        create: (context) => CastCubit(AudioService()),
        child: MinbarScaffold(
            floatingActionButton: ActionButton(),
            hasDrawer: true,
            body: PageNavigation(
                navgationController: navgationController,
                slidable: true,
                pages: {
                  BroadcastsPage.route: BroadcastsPage(),
                  HomePage.route: HomePage(),
                  ProfilePage.route: ProfilePage(),
                  SettingsScreen.route: SettingsScreen(),
                  // "crash": CrashPO()
                })),
      ),
    );
  }

  Widget startBroadcasting() {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: FlatIconButton(
          onTap: () => {},
          icon: Icon(SodaIcons.broadcast, size: 24, color: DColors.white),
          backgroundColor: minbarTheme.actionHot),
    );
  }
}

class ActionButton extends StatefulWidget {
  ActionButton({Key? key}) : super(key: key);

  @override
  _ActionButtonState createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {
  @override
  void initState() {
    super.initState();
    app<CastService>().addListener(() {
      setState(() {});
    });
  }

  void action() => showBroadcastBottomSheet(
        context,
      );
  @override
  Widget build(BuildContext context) {
    bool isSwipeUp = false;
    return app<CastService>().currentCast != null
        ? GestureDetector(
            onVerticalDragUpdate: (details) =>
                isSwipeUp = details.delta.dy < 0 ? true : false,
            onVerticalDragEnd: (c) => {if (isSwipeUp) action()},
            child: Container(
              alignment: Alignment.bottomCenter,
              height: 101,
              width: MediaQuery.of(context).size.width / 5,
              padding: const EdgeInsets.only(bottom: 30),
              child: Wrap(
                alignment: WrapAlignment.center,
                children: [
                  StreamBuilder<PlayerState>(
                      stream: app<AudioService>().playerStateStream,
                      builder: (BuildContext context,
                          AsyncSnapshot<PlayerState> snapshot) {
                        final playerState = snapshot.data;
                        final processingState = playerState?.processingState;
                        print(processingState);
                        if (processingState == ProcessingState.ready &&
                            app<AudioService>().playerState.playing)
                          return FlatIconButton(
                              backgroundColor: minbarTheme.secondary,
                              icon: VoiceVisualisation(),
                              onTap: () => showBroadcastBottomSheet(
                                    context,
                                  ));
                        else
                          return FlatIconButton(
                              backgroundColor: minbarTheme.secondary,
                              icon: Icon(Icons.pause),
                              onTap: () => showBroadcastBottomSheet(
                                    context,
                                  ));
                      }),
                  TextPlay(
                      textAlign: TextAlign.center,
                      minFontSize: 10,
                      marquee: Marquee(
                        showFadingOnlyWhenScrolling: true,
                        fadingEdgeEndFraction: 0.1,
                        text: app<CastService>().currentCast!.subject,
                        style: DTextStyle.w12,
                        blankSpace: 50,
                        velocity: 20.0,
                      ))
                ],
              ),
            ),
          )
        : SizedBox();
  }
}
