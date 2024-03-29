import 'package:flutter/material.dart';
import 'package:mobtestpackage/widgets/loading_widget.dart';

class CompanyInfoDialog extends StatelessWidget {
  const CompanyInfoDialog({super.key, required this.companyID});

  final String companyID;

  static show({required BuildContext context, required String companyID}) {
    return showDialog(
        context: context,
        builder: (context) => CompanyInfoDialog(companyID: companyID));
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      content: Center(
        heightFactor: 1,
        child: FutureBuilder(
            // TODO: update
            future: Future.wait([Future.delayed(const Duration(seconds: 1))]),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(companyID,
                        style: const TextStyle(fontWeight: FontWeight.w600)),
                    const Text(
                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. ")
                  ],
                );
              } else {
                return const LoadingWidget();
              }
            }),
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context), child: const Text("OK"))
      ],
    );
  }
}
