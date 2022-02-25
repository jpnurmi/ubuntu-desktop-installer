import 'dart:async';

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

// The spacing between the form field and the success icon.
const _kIconSpacing = 10.0;

typedef StatusWidgetBuilder = Widget? Function(
    BuildContext context, bool success);

/// A [TextFormField] rewarding a validated input with a specific widget.
///
/// See also:
///  * [SuccessIcon]
///  * [EqualValidator]
class ValidatedFormField extends StatefulWidget {
  /// The controller used to get the [TextField] values. If [controller] is
  /// null, a controller is created internally and its text is set to
  /// [initialValue].
  final TextEditingController? controller;

  /// An optional value to initialize the form field with when not using a
  /// [controller].
  final String? initialValue;

  /// Called when the user changes the text in the field.
  final ValueChanged<String>? onChanged;

  /// The validator used to validate the [TextField] value.
  final FieldValidator<String?> validator;

  /// Whether this input field should focus itself automatically.
  final bool autofocus;

  /// Defines the keyboard focus for the [TextField].
  final FocusNode? focusNode;

  /// The label above the [TextField]
  final String? labelText;

  /// The label below the [TextField]
  final String? helperText;

  /// This boolean is forwarded to the [TextField] to decide
  /// if the digits should be obscured.
  final bool obscureText;

  /// Builds the widget shown right to the [TextField] indicating
  /// the status of the input.
  final StatusWidgetBuilder? statusWidgetBuilder;

  /// Sets the optional field width for layout reasons.
  final double? fieldWidth;

  /// Sets the optional space between the [TextField] and the status widget
  final double? spacing;

  /// See [FormField.autovalidateMode].
  final AutovalidateMode autovalidateMode;

  /// Enables or disables TextField (defaults to true)
  final bool enabled;

  /// An optional Widget placed inside the text input.
  final Widget? suffixIcon;

  /// Creates a [TextFormField] and a check mark.
  ///
  /// The `validator' helps to decide when to show the check mark.
  ValidatedFormField({
    Key? key,
    this.controller,
    this.initialValue,
    this.onChanged,
    FieldValidator<String?>? validator,
    this.autofocus = false,
    this.focusNode,
    this.labelText,
    this.helperText,
    this.obscureText = false,
    this.statusWidgetBuilder,
    double? spacing,
    this.fieldWidth,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.enabled = true,
    this.suffixIcon,
  })  : validator = validator ?? _NoValidator(),
        spacing =
            spacing ?? (statusWidgetBuilder != null ? _kIconSpacing : null),
        super(key: key);

  @override
  State<ValidatedFormField> createState() => _ValidatedFormFieldState();
}

class _ValidatedFormFieldState extends State<ValidatedFormField> {
  late final TextEditingController _controller;
  FocusNode? _focusNode;

  FocusNode get focusNode => widget.focusNode ?? _focusNode!;

  @override
  void initState() {
    super.initState();
    _controller =
        widget.controller ?? TextEditingController(text: widget.initialValue);
    if (widget.focusNode == null) {
      _focusNode ??= FocusNode();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode?.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(ValidatedFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!focusNode.hasFocus &&
        widget.initialValue != null &&
        oldWidget.initialValue != widget.initialValue) {
      scheduleMicrotask(() {
        _controller.text = widget.initialValue!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final formField = TextFormField(
      autofocus: widget.autofocus,
      autovalidateMode: widget.autovalidateMode,
      controller: _controller,
      focusNode: focusNode,
      onChanged: widget.onChanged,
      validator: widget.validator,
      obscureText: widget.obscureText,
      enabled: widget.enabled,
      decoration: InputDecoration(
        labelText: widget.labelText,
        helperText: widget.helperText,
        suffixIcon: widget.suffixIcon,
      ),
    );

    return Row(
      children: [
        widget.fieldWidth == null
            ? Expanded(child: formField)
            : SizedBox(width: widget.fieldWidth, child: formField),
        ValueListenableBuilder<TextEditingValue>(
          valueListenable: _controller,
          builder: (context, value, child) {
            return Padding(
              padding: EdgeInsets.only(left: widget.spacing ?? 0.0),
              child: _alignBaseline(widget.statusWidgetBuilder
                  ?.call(context, widget.validator.isValid(value.text))),
            );
          },
        ),
      ],
    );
  }

  Widget? _alignBaseline(Widget? child) {
    if (child == null || widget.helperText?.isNotEmpty != true) {
      return child;
    }

    final border = Theme.of(context).inputDecorationTheme.border;
    return Baseline(
      baseline: border?.borderSide.width ?? 0,
      baselineType: TextBaseline.alphabetic,
      child: child,
    );
  }
}

class _NoValidator extends FieldValidator<String?> {
  _NoValidator() : super('');

  @override
  bool isValid(String? value) => true;
}

/// Validates that a form field input is valid according to the given callback.
///
/// See also:
///  * [ValidatedFormField]
class CallbackValidator extends FieldValidator<String?> {
  /// The callback used to validate the input.
  CallbackValidator(this._callback, {required String errorText})
      : super(errorText);

  final bool Function(String?) _callback;

  @override
  bool isValid(String? value) => _callback(value);
}

/// Validates that a form field input is equal to the given value.
///
/// See also:
///  * [ValidatedFormField]
class EqualValidator extends FieldValidator<String?> {
  /// Creates an equality validator for the given value and error.
  EqualValidator(this._value, {required String errorText}) : super(errorText);

  final String _value;

  @override
  bool isValid(String? value) => value == _value;
}
