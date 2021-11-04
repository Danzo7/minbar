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
      backgroundColor: DColors.blueGray,
      hasBottomNavigationBar: false,
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            elevation: 0,
            backgroundColor: DColors.blueSaidGray,
            // Provide a standard title.
            title: Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "اعدادات الحساب",
                      style: DTextStyle.w18b,
                    ),
                  ]),
            ),

            floating: true, pinned: true,
            expandedHeight: 50,
          ),
          ...widget.arguments.parameters
              .map((arg) => buildParamGroups(arg))
              .expand((i) => i),
          ...widget.arguments.parameters
              .map((arg) => buildParamGroups(arg))
              .expand((i) => i),
          ...widget.arguments.parameters
              .map((arg) => buildParamGroups(arg))
              .expand((i) => i),
        ],
      ),
    );
  }

  List<Widget> fa() => [
        StickyTitles(
          backgroundColor: DColors.blueGray,
          shrink: false,
          shrinkedColor: DColors.blueSaidGray,
          title: ListTile(
            title: Text(
              "اعدادات",
              style: DTextStyle.w15s,
            ),
          ),
          maxHeight: 50,
        ),
        SliverList(
            delegate: SliverChildListDelegate([
          ListTile(
            title: Text(
              "الاختيار الاول",
              style: DTextStyle.w15s,
            ),
            subtitle: Text(
              "تفسير",
              style: DTextStyle.w12,
            ),
            trailing: Checkbox(value: false, onChanged: (value) => {}),
          )
        ])),
        SliverList(
            delegate: SliverChildListDelegate([
          ListTile(
            title: Text(
              "الاختيار الاول",
              style: DTextStyle.w15s,
            ),
            subtitle: Text(
              "تفسير",
              style: DTextStyle.w12,
            ),
            trailing: Checkbox(value: false, onChanged: (value) => {}),
          )
        ])),
        SliverList(
            delegate: SliverChildListDelegate([
          ListTile(
            title: Text(
              "الاختيار الاول",
              style: DTextStyle.w15s,
            ),
            subtitle: Text(
              "تفسير",
              style: DTextStyle.w12,
            ),
            trailing: Checkbox(value: false, onChanged: (value) => {}),
          )
        ])),
        SliverList(
            delegate: SliverChildListDelegate([
          ListTile(
            title: Text(
              "الاختيار الاول",
              style: DTextStyle.w15s,
            ),
            subtitle: Text(
              "تفسير",
              style: DTextStyle.w12,
            ),
            trailing: Checkbox(value: false, onChanged: (value) => {}),
          )
        ]))
      ];

  List<Widget> buildParamGroups(ParamGroups group) => [
        if (group.title != null)
          StickyTitles(
            backgroundColor: DColors.blueGray,
            shrink: false,
            shrinkedColor: DColors.blueSaidGray,
            title: SizedBox(
              height: 60,
              child: ListTile(
                title: Text(
                  group.title!,
                  style: DTextStyle.w18,
                ),
              ),
            ),
            maxHeight: 60,
          ),
        ...group.params
            .map<List<Widget>>((paramOptions) => paramOptions.isRadioGroup
                ? buildRadioGroups(paramOptions as RadioGroupOptions)
                : buildParamOptions(paramOptions as ParamOptions))
            .expand((i) => i)
      ];

  List<Widget> buildParamOptions(ParamOptions param) => [
        SliverToBoxAdapter(
          child: ListTile(
            title: Text(
              param.description ?? "اعدادات",
              style: DTextStyle.w12b,
            ),
          ),
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate((_, index) {
          switch (param.options[index].type) {
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
        }, childCount: param.options.length))
      ];

  List<Widget> buildRadioGroups(RadioGroupOptions param) => [
        SliverToBoxAdapter(
          child: ListTile(
            title: Text(
              param.description ?? "اعدادات",
              style: DTextStyle.w12b,
            ),
          ),
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate((_, index) {
          return createRadioOption(
              param.options[index], index, param.setCurrentSelectedItem);
        }, childCount: param.options.length))
      ];

  Widget createCheckBoxOption<T>(CheckBoxParam option) {
    return CheckboxListTile(
        title: Text(
          option.description ?? "",
          style: DTextStyle.w15s,
        ),
        subtitle: Text(
          option.detail ?? "",
          style: DTextStyle.w12,
        ),
        value: option.userValue,
        onChanged: (value) => {
              setState(() {
                option.userValue = !option.userValue;
              })
            });
  }

  Widget createRadioOption<T>(RadioParam option, int index,
      void Function(int index) setCurrentSelectedItem) {
    return Column(
      children: [
        RadioListTile(
            groupValue: option.isSelected ? index : -1,
            title: Text(
              option.description ?? "",
              style: DTextStyle.w15s,
            ),
            subtitle: Text(
              option.detail ?? "",
              style: DTextStyle.w12,
            ),
            value: index,
            onChanged: (int? v) => setState(() {
                  setCurrentSelectedItem(v ?? 0);
                })),
      ],
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