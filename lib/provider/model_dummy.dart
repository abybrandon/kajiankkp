// ignore_for_file: non_constant_identifier_names
import 'package:cloud_firestore/cloud_firestore.dart';

class Kajian {
  String tema_kajian;
  String nama_ustad;
  String tanggal_kajian;
  String gambar;
  String lokasi_kajian;
  String id;
  Timestamp created;
  Timestamp updatedAt;
  String deskripsi;

  Kajian();

  Kajian.fromMap(Map<String, dynamic> data) {
    tema_kajian = data['tema_kajian'];
    nama_ustad = data['nama_ustad'];
    tanggal_kajian = data['tanggal_kajian'];
    gambar = data['gambar'];
    lokasi_kajian = data['lokasi_kajian'];
    id = data['id'];
    created = data["created"];
    updatedAt = data["updatedAt"];
    deskripsi = data['deskripsi'];
  }

  Map<String, dynamic> toMap() {
    return {
      'tema_kajian': tema_kajian,
      'nama_ustad': nama_ustad,
      'tanggal_kajian': tanggal_kajian,
      'gambar': gambar,
      'lokasi_kajian': lokasi_kajian,
      'id': id,
      'created': created,
      'updatedAt': updatedAt,
      'deskripsi': deskripsi,
    };
  }
}

class Food {
  String kode_makanan;
  String nama_makanan;
  String gambar;
  List rasa = [];

  Food();

  Food.fromMap(Map<String, dynamic> data) {
    kode_makanan = data['kode_makanan'];
    nama_makanan = data['nama_makanan'];
    gambar = data['gambar'];
    rasa = data['rasa'];
  }

  Map<String, dynamic> toMap() {
    return {
      'kode_makanan': kode_makanan,
      'nama_makanan': nama_makanan,
      'gambar': gambar,
      'rasa': rasa,
    };
  }
}

class Kegiatan {
  String id;
  String nama_kegiatan;
  String gambar_kegiatan;
  String tanggal_kegiatan;
  String detail_kegiatan;
  String sasaran_kegiatan;
  String lokasi_kegiatan;
  int dana_kegiatan;
  Timestamp created;
  Timestamp updatedAt;

  Kegiatan();

  Kegiatan.fromMap(Map<String, dynamic> data) {
    nama_kegiatan = data['nama_kegiatan'];
    tanggal_kegiatan = data['tanggal_kegiatan'];
    gambar_kegiatan = data['gambar_kegiatan'];
    id = data['id'];
    created = data["created"];
    detail_kegiatan = data["detail_kegiatan"];
    sasaran_kegiatan = data["sasaran_kegiatan"];
    lokasi_kegiatan = data["lokasi_kegiatan"];
    dana_kegiatan = data["dana_kegiatan"];
    updatedAt = data["updatedAt"];
  }

  Map<String, dynamic> toMap() {
    return {
      'nama_kegiatan': nama_kegiatan,
      'tanggal_kegiatan': tanggal_kegiatan,
      'gambar_kegiatan': gambar_kegiatan,
      'id': id,
      'detail_kegiatan': detail_kegiatan,
      'sasaran_kegiatan': sasaran_kegiatan,
      'lokasi_kegiatan': lokasi_kegiatan,
      'dana_kegiatan': dana_kegiatan,
      'created': created,
      'updatedAt': updatedAt,
    };
  }
}

class Organisasi {
  String id;
  String nama;
  String jabatan;
  int no_telp;
  String alamat;
  String agama;
  String tanggal_lahir;
  String jenis_kelamin;
  Timestamp created;
  Timestamp updatedAt;

  Organisasi();

  Organisasi.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    nama = data['nama'];
    jabatan = data['jabatan'];
    no_telp = data['no_telp'];
    alamat = data["alamat"];
    agama = data["agama"];
    tanggal_lahir = data['tanggal_lahir'];
    jenis_kelamin = data["jenis_kelamin"];
    updatedAt = data["updatedAt"];
    created = data["created"];
  }

  Map<String, dynamic> toMap() {
    return {
      'nama': nama,
      'jabatan': jabatan,
      'no_telp': no_telp,
      'id': id,
      'alamat': alamat,
      'agama': agama,
      'tanggal_lahir': tanggal_lahir,
      'jenis_kelamin': jenis_kelamin,
      'created': created,
      'updatedAt': updatedAt,
    };
  }
}
