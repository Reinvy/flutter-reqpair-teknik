import 'package:flutter/material.dart';

import '../datasources/remote_datasources.dart';
import '../models/request_model.dart';
import 'edit_permintaan_widget.dart';

class ActionDialogWidget extends StatelessWidget {
  const ActionDialogWidget({
    super.key,
    required this.permintaan,
  });

  final RequestModel permintaan;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
              right: 0,
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.cancel_outlined))),
          const Center(
            child: Text("Pilih Aksi"),
          ),
        ],
      ),
      content: const Text("Silahkan pilih aksi yang ingin anda lakukan."),
      actionsAlignment: MainAxisAlignment.spaceAround,
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Hapus Permintaan"),
                  content: const Text(
                    "Apakah anda yakin untuk menghapus permintaan perbaikan ini?",
                  ),
                  actions: [
                    ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Batal",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        RemoteDatasource()
                            .deleteRequest(permintaan.id)
                            .then(
                              (value) => RemoteDatasource().sendNotification(
                                "Permintaan Perbaikan Dibatalkan",
                                permintaan.permintaanPerbaikan,
                              ),
                            )
                            .then(
                          (value) {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                        );
                      },
                      child: const Text("Ya"),
                    ),
                  ],
                );
              },
            );
          },
          child: const Text(
            "Hapus",
            style: TextStyle(color: Colors.white),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => EditPermintaanWidget(
                permintaan: permintaan,
              ),
            );
          },
          child: const Text("Edit"),
        ),
      ],
    );
  }
}
