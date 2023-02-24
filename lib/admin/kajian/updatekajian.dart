import 'package:flutter/material.dart';
import 'package:testerr/provider/dummy_provider.dart';
import 'package:testerr/provider/model_dummy.dart';
import 'package:testerr/theme.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/services.dart';

class UpdateKajian extends StatefulWidget {
  final bool isUpdating;

  UpdateKajian({this.isUpdating});
  @override
  State<UpdateKajian> createState() => _UpdateKajianState();
}

class _UpdateKajianState extends State<UpdateKajian> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Kajian _currentKajian;
  String _imageUrl;
  File _imageFile;

  void initState() {
    KajianNotifier kajianNotifier =
        Provider.of<KajianNotifier>(context, listen: false);
    if (kajianNotifier.currentKajian != null) {
      _currentKajian = kajianNotifier.currentKajian;
    } else {
      _currentKajian = Kajian();
    }
    _imageUrl = _currentKajian.gambar;
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

  Widget _buildNamaUstadField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Nama Ustad"),
      initialValue: _currentKajian.nama_ustad,
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
        _currentKajian.nama_ustad = value;
      },
    );
  }

  Widget _buildDeskripsiField() {
    return TextFormField(
      maxLines: 5,
      decoration: InputDecoration(labelText: "Deskripsi"),
      initialValue: _currentKajian.deskripsi,
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
        _currentKajian.deskripsi = value;
      },
    );
  }
  Widget _buildTanggalKajian() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Tanggal Kajian"),
      initialValue: _currentKajian.tanggal_kajian,
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
        _currentKajian.tanggal_kajian = value;
      },
    );
  }

  Widget _buildTemaField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Tema Kajian"),
      initialValue: _currentKajian.tema_kajian,
      keyboardType: TextInputType.text,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Mohon diisikan';
        }
        if (value.length < 3) {
          return 'Tema minimal 3';
        }
        return null;
      },
      onSaved: (String value) {
        _currentKajian.tema_kajian = value;
      },
    );
  }
  Widget _buildlokasiField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Lokasi Kajian"),
      initialValue: _currentKajian.lokasi_kajian,
      keyboardType: TextInputType.text,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Mohon diisikan';
        }
        if (value.length < 3) {
          return 'Tema minimal 3';
        }
        return null;
      },
      onSaved: (String value) {
        _currentKajian.lokasi_kajian = value;
      },
    );
  }

  _saveKajian() {
    print("saveKajian Called");
    if (!_formState.currentState.validate()) {
      return;
    }
    _formState.currentState.save();
    print("Form Save");

    uploadKajianAndImage(
        _currentKajian, widget.isUpdating, _imageFile, _onKajianUploaded);
  }

  // _saveKajian() {
  //   if (!_formState.currentState.validate()) {
  //     return;
  //   }
  //   _formState.currentState.save();
  //   uploadKajian(_currentKajian, widget.isUpdating, _onKajianUploaded);
  // }

  _onKajianUploaded(Kajian kajian) {
    KajianNotifier kajianNotifier =
        Provider.of<KajianNotifier>(context, listen: false);
    kajianNotifier.addKajian(kajian);
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
          _showImage(),
          Text(
            widget.isUpdating ? "Edit Posting " : "Post Kajian",
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
          _buildNamaUstadField(),
          _buildTemaField(),
          _buildlokasiField(),
          _buildTanggalKajian(),

          _buildDeskripsiField(),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          FocusScope.of(context).requestFocus(FocusNode());
          _saveKajian();
        },
      ),
    );
  }
}
