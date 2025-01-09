import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/services.dart';

class ReceiptSection extends StatefulWidget {
  const ReceiptSection({super.key});

  @override
  State<ReceiptSection> createState() => _ReceiptSectionState();
}

class _ReceiptSectionState extends State<ReceiptSection> {
  final List<String> _scannedCodes = [];
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    RawKeyboard.instance.addListener(_handleKeyEvent);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override 
  void dispose() {
    RawKeyboard.instance.removeListener(_handleKeyEvent);
    _textController.dispose();
    super.dispose();
  }

  void _handleKeyEvent(RawKeyEvent event) {
    if (event is RawKeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.enter) {
        final scannedBarcode = _textController.text.trim();
        if (scannedBarcode.isNotEmpty) {
          setState(() {
            _scannedCodes.add(scannedBarcode);
          });
          _textController.clear();
          Future.delayed(const Duration(milliseconds: 100), () {
            _focusNode.requestFocus();
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.symmetric(
            vertical: BorderSide(
              color: Theme.of(context).colorScheme.outlineVariant,
            ),
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                AppLocalizations.of(context)!.receipt,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(0),
              child: TextField(
                controller: _textController,
                focusNode: _focusNode,
                autofocus: true,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
                style: const TextStyle(
                  color: Colors.transparent,
                  height: 0,
                ),
                cursorColor: Colors.transparent,
                cursorWidth: 0,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _scannedCodes.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(Icons.qr_code),
                    title: Text('Item ${index + 1}'),
                    subtitle: Text('Barcode: ${_scannedCodes[index]}'),
                    trailing: Text('\$${(index + 1) * 10}.00'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
} 