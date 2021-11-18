import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import 'package:minbar_fl/core/services/service_locator.dart';
import 'package:minbar_fl/misc/page_navigation.dart';
import 'pages/pages.dart';
export 'pages/pages.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

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
      child: ChangeNotifierProvider(
        create: (context) => CastService(),
        child: MinbarScaffold(
            hasBottomNavigationBar: true,
            navgationController: navgationController,
            floatingActionButton: const ActionButton(),
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

  Widget startBroadcasting(context) {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: FlatIconButton(
          onTap: () {},
          icon: Icon(SodaIcons.broadcast, size: 24, color: DColors.white),
          backgroundColor: minbarTheme.actionHot),
    );
  }
}

class ActionButton extends StatefulWidget {
  const ActionButton({Key? key}) : super(key: key);

  @override
  _ActionButtonState createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {
  void action() => showBroadcastBottomSheet(
        context,
      );
  @override
  Widget build(BuildContext context) {
    bool isSwipeUp = false;
    return Consumer<CastService>(
      builder: (context, state, child) {
        if (state.currentCast != null) {
          growNavBubble(context);
        } else
          popNavBubble(context);
        return state.currentCast != null
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
                            final processingState =
                                playerState?.processingState;
                            if (processingState == ProcessingState.ready &&
                                app<AudioService>().playerState.playing)
                              return dragablebubble(
                                  onDragComplete: app<CastService>().stopCast,
                                  child: FlatIconButton(
                                      backgroundColor: minbarTheme.secondary,
                                      icon: VoiceVisualisation(
                                        key: widget.key,
                                      ),
                                      onTap: () => showBroadcastBottomSheet(
                                            context,
                                          )));
                            else
                              return dragablebubble(
                                onDragComplete: state.stopCast,
                                child: FlatIconButton(
                                    key: widget.key,
                                    backgroundColor: minbarTheme.secondary,
                                    icon: Icon(Icons.pause),
                                    onTap: () => showBroadcastBottomSheet(
                                          context,
                                        )),
                              );
                          }),
                      TextPlay(
                          textAlign: TextAlign.center,
                          minFontSize: 10,
                          marquee: Marquee(
                            showFadingOnlyWhenScrolling: true,
                            fadingEdgeEndFraction: 0.1,
                            text: state.currentCast!.subject,
                            style: DTextStyle.w12,
                            blankSpace: 50,
                            velocity: 20.0,
                          ))
                    ],
                  ),
                ),
              )
            : SizedBox();
      },
    );
  }

  Widget dragablebubble({required Widget child, Function? onDragComplete}) {
    return LongPressDraggable(
      maxSimultaneousDrags: 1,
      ignoringFeedbackSemantics: false,
      axis: Axis.vertical,
      child: child,
      feedback: child,
      onDragStarted: () => showOverlay(context),
      onDragEnd: (details) {
        if (MediaQuery.of(context).size.height - 170 > details.offset.dy) {
          if (onDragComplete != null) onDragComplete();
        }

        hideOverlay(context);
      },
      onDragUpdate: (details) {},
      childWhenDragging: SizedBox(),
    );
  }
}
