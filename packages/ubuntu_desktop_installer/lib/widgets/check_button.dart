import 'package:flutter/material.dart';

/// A classic style backgroundless checkbox with a leading check indicator.
class CheckButton extends StatelessWidget {
  /// Creates a check button with the given attributes.
  const CheckButton({
    Key? key,
    this.title,
    this.subtitle,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  /// The title of the checkbox (shown above subtitle).
  final Widget? title;

  /// The subtitle of the checkbox (shown below title).
  final Widget? subtitle;

  /// The current state of the checkbox.
  final bool value;

  /// Called when the checkbox state is changed.
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
      ),
      child: ListTileTheme(
        horizontalTitleGap: 4,
        minVerticalPadding: 8,
        child: IntrinsicWidth(
          child: CheckboxListTile(
            title: title,
            subtitle: subtitle,
            tileColor: Colors.transparent,
            controlAffinity: ListTileControlAffinity.leading,
            value: value,
            onChanged: (value) => onChanged(value == true),
          ),
        ),
      ),
    );
  }
}
