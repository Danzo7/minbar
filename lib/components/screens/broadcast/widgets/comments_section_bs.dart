import 'dart:math';

import 'package:flutter/material.dart';
import 'package:minbar_fl/api/fake_data.dart';
import 'package:minbar_fl/components/common/broadcast/comments_timeline/widgets/comment_list.dart';
import 'package:minbar_fl/components/screens/broadcast/widgets/comment_field.dart';
import 'package:minbar_fl/components/theme/default_theme.dart';
import 'package:minbar_fl/components/widgets/icon_builder.dart';
import 'package:minbar_fl/components/widgets/minbar_bottom_sheet.dart';
import 'package:minbar_fl/components/widgets/misc/timeline.dart';
import 'package:minbar_fl/components/widgets/slivers/sliver_header_container.dart';
import 'package:minbar_fl/model/comment_data.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CommentSection extends StatefulWidget {
  CommentSection({Key? key, MinbarBottomSheetController? parentController})
      : super(key: key);

  @override
  State<CommentSection> createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  final TextEditingController _textEditingController = TextEditingController();
  final _refreshController = RefreshController();

  final MinbarBottomSheetController commentSheetController =
      MinbarBottomSheetController(isInstance: true);
  addToComments(comment) {
    if (mounted) {
      setState(() {
        FakeData.commentList = [
          CommentData(comment, FakeData.currentUser),
          ...FakeData.commentList
        ];
      });
    }
  }

  loadToComment(String comment) {
    if (mounted) {
      setState(() {
        FakeData.commentList.add(CommentData(comment, FakeData.currentUser));
      });
    }
  }

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 3000), () {
      addToComments("test");
    });
    _refreshController.refreshCompleted();
  }

  void _onload() async {
    await Future.delayed(Duration(milliseconds: 3000), () {
      for (var i = 0; i < 5; i++) {
        loadToComment("test $i");
      }
    });
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Container(
        child: MinbarBottomSheet(
      //isTranslucent: false,
      //elevation: 1,

      controller: commentSheetController,
      collapseHeight: 60,
      minHeight: height / 2,
      snapToExpand: false,
      child: Wrap(
        alignment: WrapAlignment.center,
        children: [
          _ShowCommentsButton(commentSheetController: commentSheetController),
          Container(
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Container(
                height: height * 4 / 6,
                width: double.infinity,
                alignment: Alignment.bottomCenter,
                padding: EdgeInsets.symmetric(horizontal: 17.5, vertical: 10),
                decoration: BoxDecoration(
                    color: minbarTheme.secondary,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(7),
                        topRight: Radius.circular(7))),
                child: Timeline(
                  bottomPadding: height / 2 - 80,
                  physics: BouncingScrollPhysics(),
                  onRefresh: _onRefresh,
                  onLoading: _onload,
                  refreshController: _refreshController,
                  header: SliverPersistentHeader(
                      floating: true,
                      delegate: SliverHeaderContainer(
                          child: CommentField(
                              controller: _textEditingController,
                              onSubmit: () {
                                if (_textEditingController.text.isNotEmpty) {
                                  addToComments(_textEditingController.text);
                                  _textEditingController.clear();
                                }
                              }),
                          maxHeight: 90)),
                  content: CommentList(FakeData.commentList),
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}

class _ShowCommentsButton extends StatefulWidget {
  const _ShowCommentsButton({
    Key? key,
    required this.commentSheetController,
  }) : super(key: key);

  final MinbarBottomSheetController commentSheetController;

  @override
  State<_ShowCommentsButton> createState() => _ShowCommentsButtonState();
}

class _ShowCommentsButtonState extends State<_ShowCommentsButton> {
  bool arrowDirUp = true;
  @override
  void didUpdateWidget(covariant _ShowCommentsButton oldWidget) {
    widget.commentSheetController.addListener(() => setState(() {
          arrowDirUp = widget.commentSheetController.isClosed;
        }));
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    widget.commentSheetController.addListener(() => setState(() {
          arrowDirUp = widget.commentSheetController.isClosed;
        }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: widget.commentSheetController.isClosed
            ? widget.commentSheetController.show
            : widget.commentSheetController.close,
        child: Container(
            decoration: BoxDecoration(
                color: minbarTheme.secondary,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(7), topRight: Radius.circular(7))),
            height: 40,
            width: 40,
            child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              IconBuilder(
                "comment",
                fit: BoxFit.scaleDown,
              ),
              TweenAnimationBuilder(
                duration: kLongAnimationDuration,
                tween: Tween<double>(begin: 0, end: arrowDirUp ? 180 : 0),
                builder: (BuildContext context, double value, Widget? child) {
                  return Transform.rotate(
                    angle: value * pi / 180,
                    child: Icon(
                      SodaIcons.arrowDown,
                      size: 10,
                      color: DColors.white,
                    ),
                  );
                },
              ),
            ])));
  }
}
