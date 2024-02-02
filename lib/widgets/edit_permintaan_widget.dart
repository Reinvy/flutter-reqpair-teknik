import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:reqpair_teknik/models/progress_model.dart';
import 'package:reqpair_teknik/widgets/default_loading_dialog.dart';

import '../datasources/remote_datasources.dart';
import '../models/request_model.dart';

class EditPermintaanWidget extends StatefulWidget {
  const EditPermintaanWidget({super.key, required this.permintaan});

  final RequestModel permintaan;

  @override
  State<EditPermintaanWidget> createState() => _EditPermintaanWidgetState();
}

class _EditPermintaanWidgetState extends State<EditPermintaanWidget> {
  final formKey = GlobalKey<FormState>();
  final statusC = TextEditingController();
  final catatanC = TextEditingController();

  @override
  void initState() {
    statusC.text = widget.permintaan.statusPengerjaan;
    catatanC.text = widget.permintaan.catatanPengerjaan;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(child: Text("Ubah Status Permintaan")),
      content: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Status Perbaikan"),
            const SizedBox(
              height: 4,
            ),
            DropdownSearch<ProgressModel>(
              popupProps: const PopupProps.menu(fit: FlexFit.loose),
              items: listProgress,
              itemAsString: (item) => item.name,
              selectedItem: ProgressModel(name: statusC.text),
              onChanged: (value) {
                statusC.text = value!.name;
              },
              validator: (value) {
                if (value == null) {
                  return "Field tidak boleh kosong";
                }
                return null;
              },
            ),
            const SizedBox(
              height: 12,
            ),
            const Text("Catatan"),
            const SizedBox(
              height: 4,
            ),
            TextFormField(
              controller: catatanC,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12,
                ),
                hintText: "Catatan",
                border: OutlineInputBorder(),
              ),
              minLines: 1,
              maxLines: 4,
            ),
          ],
        ),
      ),
      actions: [
        FilledButton(
          style: FilledButton.styleFrom(backgroundColor: Colors.red),
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Batal"),
        ),
        FilledButton(
          onPressed: () async {
            if (formKey.currentState!.validate()) {
              defaultLoadingDialog(context);
              RemoteDatasource()
                  .editRequest(
                    RequestModel(
                      id: widget.permintaan.id,
                      permintaanPerbaikan:
                          widget.permintaan.permintaanPerbaikan,
                      catatanPermintaan: widget.permintaan.catatanPermintaan,
                      statusPengerjaan: statusC.text,
                      catatanPengerjaan: catatanC.text,
                      createdAt: widget.permintaan.createdAt,
                      updatedAt: DateTime.now(),
                    ),
                  )
                  .then(
                    (value) => RemoteDatasource().sendNotification(
                      "Perbaikan ${widget.permintaan.permintaanPerbaikan}",
                      "Status : ${statusC.text}",
                    ),
                  )
                  .then(
                (value) {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              );
            }
          },
          child: const Text("Edit"),
        ),
      ],
    );
  }
}
