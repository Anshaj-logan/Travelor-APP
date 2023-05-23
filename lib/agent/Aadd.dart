import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:one/agent/Ahome.dart';
import 'package:one/agent/Apackages.dart';
import 'package:one/user/Upackages.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../api.dart';

class Aadd extends StatefulWidget {
  String index;

  Aadd({required this.index});
  //const Aadd({Key? key}) : super(key: key);

  @override
  State<Aadd> createState() => _AaddState();
}

class _AaddState extends State<Aadd> {
  List category = [];
  String? selectId;

  late final _filename;
  File? imageFile;
  late String storedImage;

  bool _isloading = false;

  TextEditingController package_nameController = TextEditingController();
  TextEditingController categorynameController = TextEditingController();
  TextEditingController citynameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController activityController = TextEditingController();
  TextEditingController daysController = TextEditingController();
  TextEditingController budgetController = TextEditingController();
  TextEditingController distanceController = TextEditingController();
  TextEditingController weatherController = TextEditingController();

  Future getcategories() async {
    var res = await Api().getData('/api/category/view_agent_category');
    var body = json.decode(res.body);
    print(res);
    setState(() {
      print(body);
      category = body['data'];
    });
  }

  @override
  void initState() {
    // TODO: iplement initState
     super.initState();
    getcategories();
  }

  final _formKey = GlobalKey<FormState>();

  void agentAdd() async {
    setState(() {
      _isloading = true;
    });

    /*@override
    void initState() {
      // TODO: implement initState
      super.initState();
      agentAdd();
    }*/

    var data = {
      "package_name": package_nameController.text,
      "categoryname": selectId,
      "cityname": citynameController.text,
      "description": descriptionController.text,
      "distance": distanceController.text,
      "weather": weatherController.text,
      "activity": activityController.text,
      "days": daysController.text,
      "budget": budgetController.text,
    };
    print(data);
    String id = widget.index;
    var res = await Api().authData(data, '/api/agent/agent-AddPackage');
    var body = json.decode(res.body);
    print(res);
    if (body["success"] == true) {
      print(body);
      Fluttertoast.showToast(
          msg: body["message"].toString(), backgroundColor: Colors.grey);
      print('res${res}');
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Apackages()));
    } else {
      Fluttertoast.showToast(
          msg: body["message"].toString(), backgroundColor: Colors.grey);
    }
  }

  /*List location = [];
  String? selectId;*/
  /*List items = [
    "Solo",
    "Family",
    "Friends",
    "Industrial visit",
    "Honeymoon",
    "Weekend"
  ];
  String? selectedValue1;
  List titles = [
    "Waterfall",
    "Hilly region",
    "Temple",
    "Amusement parks",
    "Historic places",
  ];*/

  /*File? _image;
  Future getImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;
    final imageTemporary = File(image.path);
    setState(() {
      this._image = imageTemporary;
    });
  }*/

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Choose from"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: const Text("Gallery"),
                    onTap: () {
                      _getFromGallery();
                      Navigator.pop(context);
                      //  _openGallery(context);
                    },
                  ),
                  SizedBox(height: 10),
                  /*const Padding(padding: EdgeInsets.all(0.0)),
                  GestureDetector(
                    child: const Text("Camera"),
                    onTap: () {
                      _getFromCamera();

                      Navigator.pop(context);
                      //   _openCamera(context);
                    },
                  ),*/
                ],
              ),
            ),
          );
        });
  }

  /*final ImagePicker imagePicker = ImagePicker();
  List <XFile> ImageFileList = [];
  void SelectImages() async {
    final List<XFile>? SelectedImages = await imagePicker.pickMultiImage();
    if(SelectedImages!.isNotEmpty) {
      ImageFileList!.addAll(SelectedImages);
    }
    setState(() {

    });
  }*/

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff00ADB5),
          title: Text('Add package'),
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              //.push(MaterialPageRoute(builder: (context) => const Ahome())),
              icon: Icon(Icons.arrow_back)),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Package Name',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  TextField(
                    controller: package_nameController,
                    style: TextStyle(height: 2),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Name of package'),
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  Container(
                    /* decoration: BoxDecoration(
    image: DecorationImage(
      image: AssetImage('images/bg.jpg')
    )
  ),*/
                    child: imageFile == null
                        ? Container(
                            child: Column(
                              children: <Widget>[
                                ElevatedButton(
                                  onPressed: () {
                                    //    _getFromGallery();
                                    _showChoiceDialog(context);
                                  },
                                  child: Text("Upload Image"),
                                ),
                                Container(
                                  height: 40.0,
                                ),
                              ],
                            ),
                          )
                        : Row(
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Image.file(
                                  imageFile!,
                                  width: 100,
                                  height: 100,
                                  //  fit: BoxFit.cover,
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  //    _getFromGallery();
                                  _showChoiceDialog(context);
                                },
                                child: Text("Upload Image"),
                              ),
                            ],
                          ),
                  ),

                  /*Container(
                    child: _image == null
                        ?Container(
                     child: */
                  /* Column(

                        children: [
                          Text('Upload image',style: TextStyle(fontWeight: FontWeight.bold),),
                          CustomButton(
                            title: 'Pick from gallery',
                            icon: Icons.image_outlined,
                            onClick: () => getImage(ImageSource.gallery),),
                        ],
                      ),



                  _image != null
                      ? Image.file(
                          _image!,
                          width: 250,
                          height: 250,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          'images/city1.jpg',
                          width: 200,
                          height: 200,
                        ),*/
                  SizedBox(
                    height: 40,
                  ),
                  DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.category),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 2.0, style: BorderStyle.solid),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 2),
                        ),
                      ),
                      hint: Text('choose category'),
                      value: selectId,
                      items: category
                          .map((type) => DropdownMenuItem<String>(
                                value: type['_id'].toString(),
                                child: Text(type['categoryname'].toString()),
                              ))
                          .toList(),
                      onChanged: (type) {
                        setState(() {
                          selectId = type;
                        });
                      }),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: citynameController,
                    style: TextStyle(height: 2),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: 'City name'),
                  ),
                  //CustomButton(
                  // title: 'Pick from gallery',
                  //icon: Icons.image_outlined,
                  // onClick: () => getImage(ImageSource.gallery),),
                  /* CustomButton(
                      title: 'Pick from camera',
                      icon: Icons.camera,
                      onClick: () => getImage(ImageSource.camera),),
*/

                  /*  GridView.builder(
                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                       crossAxisCount: 3
                     ),
                    itemCount: ImageFileList.length,
                     itemBuilder: (BuildContext context, int index) {
                      return Image.file(File(ImageFileList[index].path), fit: BoxFit.cover,);
                     },

                  ),
                  SizedBox(height: 5,),
                  MaterialButton(
                      color: Colors.blue,
                      child: Text('Pick your images',style: TextStyle(color: Colors.white,
                          fontWeight: FontWeight.bold),),
                      onPressed: () {SelectImages();
                      }),*/
                  /*Text(
                    'Select travel type',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  DropdownButtonFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.travel_explore),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 2.0, style: BorderStyle.solid),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 1),
                        ),
                      ),
                      hint: Text('Travel type'),
                      value: selectedValue1,
                      items: items
                          .map((type) => DropdownMenuItem<String>(
                                value: type,
                                child: Text(type),
                              ))
                          .toList(),
                      onChanged: (type) {
                        setState(() {
                          selectedValue1 = type;
                        });
                      }),*/
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: descriptionController,
                    style: TextStyle(height: 2),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Description'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  /*TextField(
                    controller: weatherController,
                    style: TextStyle(height: 2),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'weather details'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: distanceController,
                    style: TextStyle(height: 2),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Distance'),
                  ),*/
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: activityController,
                    style: TextStyle(height: 2),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Activities'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: daysController,
                    style: TextStyle(height: 2),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Number of days'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: weatherController,
                    style: TextStyle(height: 2),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Weather'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: distanceController,
                    style: TextStyle(height: 2),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Distance'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: budgetController,
                    style: TextStyle(height: 2),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Budget'),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.cyan),
            onPressed: () {
              setState(() {
                agentAdd();
              });
            },
            child: const Text('Submit'),
          ),
        ),
      ),
    );
  }

  /// Get from gallery
  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
        /*_filename = basename(imageFile!.path);
        final _nameWithoutExtension = basenameWithoutExtension(imageFile!.path);
        final _extenion = extension(imageFile!.path);*/
      });
    }
  }
}
