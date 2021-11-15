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
      backgroundColor: minbarTheme.background,
      hasBottomNavigationBar: false,
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            elevation: 0,
            backgroundColor: minbarTheme.secondary,
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
            backgroundColor: minbarTheme.secondary,
            shrinkedColor: minbarTheme.secondaryVariant,
            shrinkTextStyle: DTextStyle.w15b,
            textStyle: DTextStyle.b15b,
            title: group.title!,
            maxHeight: 60,
          ),
        ...group.params
            .map<List<Widget>>((paramOptions) => [
                  if (paramOptions.description != null)
                    SliverToBoxAdapter(
                      child: groupTitle(paramOptions.description!),
                    ),
                  buildParamOptions(paramOptions),
                  SliverToBoxAdapter(child: Divider())
                ])
            .expand((i) => i)
      ];

  Widget buildParamOptions(Options group) {
    switch (group.type) {
      case OptionType.datePicker:
        return createRadioOption(group as RadioOptionGroup);
      case OptionType.textField:
        return createInputBox(group as InputOption);
      case OptionType.toggle:
        return createRadioOption(group as RadioOptionGroup);
      case OptionType.checkbox:
        return createCheckBoxOption(group as CheckboxOptionGroup);
      case OptionType.radio:
        return createRadioOption(group as RadioOptionGroup);
    }
  }

  Widget createCheckBoxOption(CheckboxOptionGroup group) {
    return SliverList(
        delegate: SliverChildBuilderDelegate(
            (_, index) => SwitchListTile(
                title: textOrNull(group.options[index].description,
                    style: DTextStyle.bg12s),
                subtitle: textOrNull(group.options[index].detail,
                    style: DTextStyle.b10),
                value: group.options[index].userValue,
                onChanged: (value) => {
                      setState(() {
                        group.options[index].userValue =
                            !group.options[index].userValue;
                      })
                    }),
            childCount: group.options.length));
  }

  Widget createRadioOption(RadioOptionGroup group) {
    return SliverList(
        delegate: SliverChildBuilderDelegate(
            (_, index) => RadioListTile(
                title: textOrNull(group.options[index].description,
                    style: DTextStyle.bg12s),
                subtitle: textOrNull(group.options[index].detail,
                    style: DTextStyle.b10),
                groupValue: group.options[index].isSelected ? index : -1,
                value: index,
                onChanged: (int? v) => setState(() {
                      group.setCurrentSelectedItem(v ?? 0);
                    })),
            childCount: group.options.length));
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
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
      child: Text(
        title,
        style: DTextStyle.b12b,
      ),
    );
  }

  Widget createInputBox(InputOption field) {
    TextEditingController _controller =
        TextEditingController(text: field.userValue);

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: TextField(
          style: DTextStyle.b12,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(width: 1),
                borderRadius: const BorderRadius.all(
                  Radius.circular(15.0),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(width: 1, color: minbarTheme.surfaceBorder),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(15.0),
                  )),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(15.0),
                  )),
              filled: true,
              fillColor: Colors.white),
          onSubmitted: (value) => {field.userValue = value},
          controller: _controller,
          maxLines: 1,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.name,
        ),
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