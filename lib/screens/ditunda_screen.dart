import 'package:flutter/material.dart';

import '../datasources/remote_datasources.dart';
import '../helpers/localization_helper.dart';
import '../models/request_model.dart';
import '../widgets/edit_permintaan_widget.dart';

class DitundaScreen extends StatelessWidget {
  const DitundaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ditunda"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: StreamBuilder<List<RequestModel>>(
          stream: RemoteDatasource().getRequests(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final data = snapshot.data!
                  .where((element) => element.statusPengerjaan == "Ditunda")
                  .toList();

              return data.isEmpty
                  ? const Center(
                      child: Text(
                        "Data Masih Kosong!",
                        style: TextStyle(fontSize: 20),
                      ),
                    )
                  : ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, i) {
                        return InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return EditPermintaanWidget(
                                  permintaan: data[i],
                                );
                              },
                            );
                          },
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Permintaan Perbaikan",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      const Expanded(
                                        flex: 1,
                                        child: Text("Tanggal"),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Text(
                                          ": ${LocalizationHelper.formatTgl(
                                            data[i].createdAt,
                                          )}",
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Expanded(
                                        flex: 1,
                                        child: Text("Kerusakan"),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Text(
                                          ": ${data[i].permintaanPerbaikan}",
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Expanded(
                                        flex: 1,
                                        child: Text("Catatan"),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Text(
                                          ": ${data[i].catatanPermintaan}",
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Text(
                                    "Pengerjaan",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      const Expanded(
                                        flex: 1,
                                        child: Text("Status"),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Text(
                                          ": ${data[i].statusPengerjaan}",
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Expanded(
                                        flex: 1,
                                        child: Text("Catatan"),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Text(
                                          ": ${data[i].catatanPengerjaan}",
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
