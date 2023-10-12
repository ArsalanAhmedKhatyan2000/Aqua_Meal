import 'package:flutter/material.dart';

class BuildCustomExpensionListTile extends StatelessWidget {
  final String? _title;
  final IconData? _leadingIcon;
  final List<Widget> _children;
  const BuildCustomExpensionListTile({
    Key? key,
    required String? title,
    required IconData? leadingIcon,
    required List<Widget> children,
  })  : _title = title,
        _leadingIcon = leadingIcon,
        _children = children,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        _title!,
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.w700,
        ),
      ),
      leading: Icon(
        _leadingIcon,
        color: Theme.of(context).primaryColor,
      ),
      expandedAlignment: Alignment.topCenter,
      children: _children,
    );
  }
}
