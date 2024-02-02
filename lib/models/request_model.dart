class RequestModel {
  final String id;
  final String permintaanPerbaikan;
  final String catatanPermintaan;
  final String statusPengerjaan;
  final String catatanPengerjaan;
  final DateTime createdAt;
  final DateTime updatedAt;

  RequestModel({
    required this.id,
    required this.permintaanPerbaikan,
    required this.catatanPermintaan,
    required this.statusPengerjaan,
    required this.catatanPengerjaan,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RequestModel.fromJson(String id, Map<String, dynamic> json) =>
      RequestModel(
        id: id,
        permintaanPerbaikan: json["permintaanPerbaikan"],
        catatanPermintaan: json["catatanPermintaan"],
        statusPengerjaan: json["statusPengerjaan"],
        catatanPengerjaan: json["catatanPengerjaan"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );
}
