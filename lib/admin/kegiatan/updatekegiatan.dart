import 'package:flutter/material.dart';
import 'package:testerr/provider/kegiatan_provider.dart';
import 'package:testerr/provider/model_dummy.dart';
import 'package:testerr/theme.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/services.dart';

class UpdateKegiatan extends StatefulWidget {
  final bool isUpdating;

  UpdateKegiatan({this.isUpdating});
  @override
  State<UpdateKegiatan> createState() => _UpdateKegiatanState();
}

class _UpdateKegiatanState extends State<UpdateKegiatan> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Kegiatan _currentKegiatan;
  String _imageUrl;
  File _imageFile;

  void initState() {
    KegiatanNotifier kegiatanNotifier =
        Provider.of<KegiatanNotifier>(context, listen: false);
    if (kegiatanNotifier.currentKegiatan != null) {
      _currentKegiatan = kegiatanNotifier.currentKegiatan;
    } else {
      _currentKegiatan = Kegiatan();
    }
    _imageUrl = _currentKegiatan.gambar_kegiatan;
  }

  Widget _showImage() {
    if (_imageFile == null && _imageUrl == null) {
      return Text("Image Post");
    } else if (_imageFile != null) {
      print("showing image from local file");

      return Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: <Widget>[
          Image.file(
            _imageFile,
            fit: BoxFit.cover,
            height: 240,
          ),
          // ignore: deprecated_member_use
          TextButton(
            style: ButtonStyle(foregroundColor: MaterialStateProperty.all(Colors.black54)),
             
              child: Text(
                "Change Image",
                style: regularTextStyle.copyWith(color: Colors.white),
              ),
              onPressed: () => _getLocalImage())
        ],
      );
    } else if (_imageUrl != null) {
      print("showing image from url");

      return Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: <Widget>[
          Image.network(
            _imageUrl,
            fit: BoxFit.cover,
            height: 240,
          ),
          // ignore: deprecated_member_use
          TextButton(
         
              child: Text(
                "Change Image",
                style: regularTextStyle.copyWith(color: Colors.white),
              ),
              onPressed: () => _getLocalImage())
        ],
      );
    }
  }

  _getLocalImage() async {
    File imageFile = await ImagePicker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 720,
      maxWidth: 720,
      imageQuality: 30,
    );

    if (imageFile != null) {
      setState(() {
        _imageFile = imageFile;
      });
    }
  }

  Widget _buildNamaKegiatanField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Nama Kegiatan"),
      initialValue: _currentKegiatan.nama_kegiatan,
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
        _currentKegiatan.nama_kegiatan = value;
      },
    );
  }

  Widget _buildDanaField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Dana Kegiatan"),
      initialValue: _currentKegiatan.dana_kegiatan.toString(),
      keyboardType: TextInputType.number,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Mohon diisikan ';
        }
        if (value.length < 3) {
          return 'Dana minimal 3';
        }
        return null;
      },
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      onSaved: (String value) {
        _currentKegiatan.dana_kegiatan = int.tryParse(value);
      },
    );
  }

  Widget _buildSasaranField() {
    return TextFormField(
      
      decoration: InputDecoration(labelText: "Sasaran Kegiatan"),
      initialValue: _currentKegiatan.sasaran_kegiatan,
      keyboardType: TextInputType.text,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Mohon diisikan ';
        }
        if (value.length < 3) {
          return 'Sasaran minimal 3';
        }
        return null;
      },
      onSaved: (String value) {
        _currentKegiatan.sasaran_kegiatan = value;
      },
    );
  }

  Widget _buildLokasiField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Lokasi Kegiatan"),
      initialValue: _currentKegiatan.lokasi_kegiatan,
      keyboardType: TextInputType.text,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Mohon diisikan ';
        }
        if (value.length < 3) {
          return 'Lokasi minimal 3';
        }
        return null;
      },
      onSaved: (String value) {
        _currentKegiatan.lokasi_kegiatan = value;
      },
    );
  }

  Widget _buildDetailField() {
    return TextFormField(
       maxLines: 5,
      decoration: InputDecoration(labelText: "Detail Kegiatan"),
      initialValue: _currentKegiatan.detail_kegiatan,
      keyboardType: TextInputType.text,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Mohon diisikan ';
        }
        if (value.length < 3) {
          return 'Deskripsi minimal 3';
        }
        return null;
      },
      onSaved: (String value) {
        _currentKegiatan.detail_kegiatan = value;
      },
    );
  }

  Widget _buildLoksiField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Lokasi Kegiatan"),
      initialValue: _currentKegiatan.lokasi_kegiatan,
      keyboardType: TextInputType.text,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Mohon diisikan';
        }
        if (value.length < 3) {
          return 'Lokasi minimal 3';
        }
        return null;
      },
      onSaved: (String value) {
        _currentKegiatan.lokasi_kegiatan = value;
      },
    );
  }

  Widget _buildTanggalField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Tanggal Kegiatan"),
      initialValue: _currentKegiatan.tanggal_kegiatan,
      keyboardType: TextInputType.text,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Mohon diisikan ';
        }
        if (value.length < 3) {
          return 'Tanggal minimal 3';
        }
        return null;
      },
      onSaved: (String value) {
        _currentKegiatan.tanggal_kegiatan = value;
      },
    );
  }

  _saveKegiatan() {
    print("saveKegiatan Called");
    if (!_formState.currentState.validate()) {
      return;
    }
    _formState.currentState.save();
    print("Form Save");

    uploadkegiatanAndImage(
        _currentKegiatan, widget.isUpdating, _imageFile, _onKegiatanUploaded);
  }

  // _saveKajian() {
  //   if (!_formState.currentState.validate()) {
  //     return;
  //   }
  //   _formState.currentState.save();
  //   uploadKajian(_currentKajian, widget.isUpdating, _onKajianUploaded);
  // }

  _onKegiatanUploaded(Kegiatan kegiatan) {
    KegiatanNotifier kegiatanNotifier =
        Provider.of<KegiatanNotifier>(context, listen: false);
    kegiatanNotifier.addKegiatan(kegiatan);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update"),
      ),
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Form(
          autovalidateMode: AutovalidateMode.always,
          key: _formState,
          child: Column(children: <Widget>[
            _showImage(),
            Text(
              widget.isUpdating ? "Edit Posting " : "Post Kegiatan",
              style: regularTextStyle,
            ),
            SizedBox(
              height: 16,
            ),
            _imageFile == null && _imageUrl == null
                ? ButtonTheme(
                    child: ElevatedButton(
                        child: Text("Add Image"),
                        onPressed: () => _getLocalImage()),
                  )
                : SizedBox(
                    height: 0,
                  ),
            _buildNamaKegiatanField(),
            _buildTanggalField(),
            _buildLokasiField(),
       
            _buildSasaranField(),
            _buildDanaField(),
                 _buildDetailField(),
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          FocusScope.of(context).requestFocus(FocusNode());
          _saveKegiatan();
        },
      ),
    );
  }
}
