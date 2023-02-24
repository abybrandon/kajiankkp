import 'package:flutter/material.dart';
import 'package:testerr/provider/model_dummy.dart';
import 'package:testerr/provider/organisasi_provider.dart';
import 'package:testerr/theme.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/services.dart';

class UpdateOrganisasi extends StatefulWidget {
  final bool isUpdating;

  UpdateOrganisasi({this.isUpdating});
  @override
  State<UpdateOrganisasi> createState() => _UpdateOrganisasi();
}

class _UpdateOrganisasi extends State<UpdateOrganisasi> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Organisasi _currentOrganisasi;
 String anggota = "Anggota";
  void initState() {
    OrganisasiNotifier organisasiNotifier =
        Provider.of<OrganisasiNotifier>(context, listen: false);
    if (organisasiNotifier.currentOrganisasi != null) {
      _currentOrganisasi = organisasiNotifier.currentOrganisasi;
    } else {
      _currentOrganisasi = Organisasi();
    }
  }

  Widget _buildNamaField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Nama Lengkap"),
      initialValue: _currentOrganisasi.nama,
      keyboardType: TextInputType.text,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Mohon diisikan ';
        }
        if (value.length < 3) {
          return 'Nama minimal 3';
        }
        return null;
      },
      onSaved: (String value) {
        _currentOrganisasi.nama = value;
      },
    );
  }

  Widget _buildJabatanField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Jabatan"),
      initialValue: anggota,
      keyboardType: TextInputType.text,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Mohon diisikan ';
        }
        if (value.length < 3) {
          return 'Nama minimal 3';
        }
        return null;
      },
      onSaved: (String value) {
        _currentOrganisasi.jabatan = anggota;
      },
    );
  }

  Widget _buildNoTelpField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "No Telpon"),
      initialValue: _currentOrganisasi.no_telp.toString(),
      keyboardType: TextInputType.phone,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Mohon diisikan ';
        }
        if (value.length < 3) {
          return 'No Telp minimal 3';
        }
        return null;
      },
      onSaved: (String value) {
        _currentOrganisasi.no_telp = int.tryParse(value);
      },
    );
  }

  Widget _buildAlamatField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Alamat "),
      initialValue: _currentOrganisasi.jenis_kelamin,
      keyboardType: TextInputType.text,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Mohon diisikan';
        }
        if (value.length < 3) {
          return 'Alamat minimal 3';
        }
        return null;
      },
      onSaved: (String value) {
        _currentOrganisasi.alamat = value;
      },
    );
  }

  Widget _buildAgamaField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Agama "),
      initialValue: _currentOrganisasi.agama,
      keyboardType: TextInputType.text,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Mohon diisikan';
        }
        if (value.length < 3) {
          return 'Agama minimal 3';
        }
        return null;
      },
      onSaved: (String value) {
        _currentOrganisasi.agama = value;
      },
    );
  }

  Widget _buildJenisKelField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Jenis Kelamin "),
      initialValue: _currentOrganisasi.jenis_kelamin,
      keyboardType: TextInputType.text,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Mohon diisikan';
        }
        if (value.length < 3) {
          return 'Jenis Kelamin minimal 3';
        }
        return null;
      },
      onSaved: (String value) {
        _currentOrganisasi.jenis_kelamin = value;
      },
    );
  }

  Widget _buildTglLhrField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Tanggal Lahir "),
      initialValue: _currentOrganisasi.tanggal_lahir,
      keyboardType: TextInputType.text,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Mohon diisikan';
        }
        if (value.length < 3) {
          return 'Tanggal lahir minimal 3';
        }
        return null;
      },
      onSaved: (String value) {
        _currentOrganisasi.tanggal_lahir = value;
      },
    );
  }

  _saveOrganisasi() {
    print("save Organisasi Called");
    if (!_formState.currentState.validate()) {
      return;
    }
    _formState.currentState.save();
    print("Form Save");
    uploadOrganisasi(
        _currentOrganisasi, widget.isUpdating, _onOrganisasiUploaded);
  }

  // _saveKajian() {
  //   if (!_formState.currentState.validate()) {
  //     return;
  //   }
  //   _formState.currentState.save();
  //   uploadKajian(_currentKajian, widget.isUpdating, _onKajianUploaded);
  // }

  _onOrganisasiUploaded(Organisasi organisasi) {
    OrganisasiNotifier organisasiNotifier =
        Provider.of<OrganisasiNotifier>(context, listen: false);
    organisasiNotifier.addOrganisasi(organisasi);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update"),
      ),
      key: _scaffoldKey,
      body: Form(
        autovalidateMode: AutovalidateMode.always,
        key: _formState,
        child: Column(children: <Widget>[
          _buildNamaField(),
          _buildJabatanField(),
          _buildNoTelpField(),
          _buildAlamatField(),
          _buildAgamaField(),
          _buildTglLhrField(),
          _buildJenisKelField()
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          FocusScope.of(context).requestFocus(FocusNode());
          _saveOrganisasi();
        },
      ),
    );
  }
}
