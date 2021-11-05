import 'package:flutter/material.dart';
import 'package:minbar_fl/components/theme/default_text_styles.dart';
import 'package:minbar_fl/components/theme/default_theme.dart';
import 'package:minbar_fl/components/widgets/misc/minbar_scaffold.dart';
import 'package:minbar_fl/components/widgets/slivers/sticky-titles.dart';
import 'package:minbar_fl/model/setting_data_presentation.dart';

class SettingArgs {
  final List<ParamGroups> parameters;
  final String name;
  final dynamic arguments;
  SettingArgs(this.name, {required this.parameters, this.arguments});
}

class ParametersScreen extends StatefulWidget {
  static const String route = "params";

  final SettingArgs arguments;
  const ParametersScreen({Key? key, required this.arguments}) : super(key: key);

  @override
  State<ParametersScreen> createState() => _ParametersScreenState();
}

class _ParametersScreenState extends State<ParametersScreen> {
  @override
  Widget build(BuildContext context) {
    return MinbarScaffold(
      backgroundColor: DColors.white,
      hasBottomNavigationBar: false,
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            elevation: 0,
            backgroundColor: DColors.blueGray,
            // Provide a standard title.
            title: Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.arguments.name,
                      style: DTextStyle.w16s,
                    ),
                  ]),
            ),

            floating: true, pinned: true,
            expandedHeight: 50,
          ),
          ...widget.arguments.parameters
              .map((arg) => buildParamGroups(arg))
              .expand((i) => i),
        ],
      ),
    );
  }

  List<Widget> buildParamGroups(ParamGroups group) => [
        if (group.title != null)
          StickyTitles(
            backgroundColor: DColors.coldGray,
            shrinkedColor: DColors.blueSaidGray,
            shrinkTextStyle: DTextStyle.w15b,
            textStyle: DTextStyle.b15b,
            title: group.title!,
            maxHeight: 60,
          ),
        ...group.params
            .map<List<Widget>>(
                (paramOptions) => buildParamOptions(paramOptions))
            .expand((i) => i)
      ];

  List<Widget> buildParamOptions(ParamOptionNural param) => [
        if (param.description != null)
          SliverToBoxAdapter(
            child: groupTitle(param.description!),
          ),
        if (param.isRadioGroup)
          SliverList(
              delegate: SliverChildBuilderDelegate((_, index) {
            return createRadioOption(
                (param as RadioGroupOptions).options[index],
                index,
                param.setCurrentSelectedItem);
          }, childCount: (param as RadioGroupOptions).options.length))
        else
          SliverList(
              delegate: SliverChildBuilderDelegate((_, index) {
            switch ((param as ParamOptions).options[index].type) {
              case ParamType.datePicker:
                return createCheckBoxOption(
                    param.options[index] as CheckBoxParam);

              case ParamType.textField:
                return createCheckBoxOption(
                    param.options[index] as CheckBoxParam);
              case ParamType.toggle:
                return createCheckBoxOption(
                    param.options[index] as CheckBoxParam);
              case ParamType.checkbox:
                return createCheckBoxOption(
                    param.options[index] as CheckBoxParam);
              case ParamType.radio:
                break;
            }
          }, childCount: (param as ParamOptions).options.length))
      ];

  Widget createCheckBoxOption(CheckBoxParam option) {
    return SwitchListTile(
        title: textOrNull(option.description, style: DTextStyle.bg12s),
        subtitle: textOrNull(option.detail, style: DTextStyle.b10),
        value: option.userValue,
        onChanged: (value) => {
              setState(() {
                option.userValue = !option.userValue;
              })
            });
  }

  Widget createRadioOption(RadioParam option, int index,
      void Function(int index) setCurrentSelectedItem) {
    return RadioListTile(
        title: textOrNull(option.description, style: DTextStyle.bg12s),
        subtitle: textOrNull(option.detail, style: DTextStyle.b10),
        groupValue: option.isSelected ? index : -1,
        value: index,
        onChanged: (int? v) => setState(() {
              setCurrentSelectedItem(v ?? 0);
            }));
  }

  Widget? textOrNull(
    String? data, {
    Key? key,
    TextStyle? style,
    StrutStyle? strutStyle,
    TextAlign? textAlign,
    TextDirection? textDirection,
    Locale? locale,
    bool? softWrap,
    TextOverflow? overflow,
    double? textScaleFactor,
    int? maxLines,
    String? semanticsLabel,
    TextWidthBasis? textWidthBasis,
    TextHeightBehavior? textHeightBehavior,
  }) {
    return data != null
        ? Text(data,
            key: key,
            style: style,
            semanticsLabel: semanticsLabel,
            softWrap: softWrap,
            strutStyle: strutStyle,
            locale: locale,
            textAlign: textAlign,
            textDirection: textDirection,
            textHeightBehavior: textHeightBehavior,
            textScaleFactor: textScaleFactor,
            textWidthBasis: textWidthBasis,
            maxLines: maxLines,
            overflow: overflow)
        : null;
  }

  Widget groupTitle(String title) {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 10),
      child: Text(
        title,
        style: DTextStyle.bg12b,
      ),
    );
  }
}
/*
  ...arguments
              .map((e) => Wrap(children: [
                    Text(e.description ?? "non"),
                    ...e.options.map((Param param) {
                      Widget optionWidget;

                      switch (param.type) {
                        case ParamType.checkbox:
                          optionWidget = Row(children: [
                            Text(param.description ?? "non too"),
                            optionWidget = Checkbox(
                                value: (param as CheckBoxParam).userValue,
                                onChanged: (value) =>
                                    {(param).userValue = !(param).userValue})
                          ]);
                          break;
                        case ParamType.datePicker:
                          optionWidget = Row(children: [
                            Text(param.description ?? "non too"),
                            optionWidget =
                                Checkbox(value: false, onChanged: (value) => {})
                          ]);
                          break;
                        case ParamType.textField:
                          optionWidget = Row(children: [
                            Text(param.description ?? "non too"),
                            optionWidget =
                                Checkbox(value: false, onChanged: (value) => {})
                          ]);
                          break;
                        case ParamType.toggle:
                          optionWidget = Row(children: [
                            Text(param.description ?? "non too"),
                            optionWidget =
                                Checkbox(value: false, onChanged: (value) => {})
                          ]);
                          break;
                      }
                      return optionWidget;
                    }).toList()
                  ]))
              .toList(),
        

*/