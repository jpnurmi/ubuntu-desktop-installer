part of 'generate_recovery_key_page.dart';

class _RecoveryKeyLocationSelector extends StatelessWidget {
  const _RecoveryKeyLocationSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context);
    final model = Provider.of<GenerateRecoveryKeyModel>(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(lang.generateRecoveryKeyLocation),
        const SizedBox(width: kContentSpacing),
        _RecoveryKeyLocationEntry(model.recoveryKey),
        IconButton(
          icon: Icon(Icons.folder),
          splashRadius: 20,
          onPressed: () async {
            final path = await FileSelectorPlatform.instance.getSavePath(
              suggestedName: model.recoveryKey,
            );
            if (path != null) {
              model.recoveryKey = path;
            }
          },
        ),
      ],
    );
  }
}

class _RecoveryKeyLocationEntry extends StatefulWidget {
  const _RecoveryKeyLocationEntry(this.code, {Key? key}) : super(key: key);

  final String code;

  @override
  State<_RecoveryKeyLocationEntry> createState() =>
      _RecoveryKeyLocationEntryState();
}

class _RecoveryKeyLocationEntryState extends State<_RecoveryKeyLocationEntry> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.code;
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(_RecoveryKeyLocationEntry oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!_focusNode.hasFocus && oldWidget.code != widget.code) {
      scheduleMicrotask(() => _controller.text = widget.code);
    }
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<GenerateRecoveryKeyModel>(context, listen: false);
    final style = Theme.of(context).textTheme.bodyText1!.copyWith(
          fontFamily: 'Ubuntu Mono',
          backgroundColor: Theme.of(context).highlightColor,
        );
    return IntrinsicWidth(
      child: TextFormField(
        expands: false,
        focusNode: _focusNode,
        controller: _controller,
        style: style,
        decoration: InputDecoration(border: InputBorder.none),
        onChanged: (value) => model.recoveryKey = value,
      ),
    );
  }
}
