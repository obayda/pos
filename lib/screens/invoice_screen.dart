import 'package:flutter/material.dart';
import 'invoice/quick_actions.dart';
import 'invoice/receipt.dart';
import 'invoice/payment_options.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InvoiceScreen extends StatefulWidget {
  const InvoiceScreen({super.key});

  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: AppLocalizations.of(context)!.back,
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Row(
        children: const [
          QuickActionsSection(),
          ReceiptSection(),
          PaymentOptionsSection(),
        ],
      ),
    );
  }
} 