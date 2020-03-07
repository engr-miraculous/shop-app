import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product_provider.dart';
import '../providers/products_provider.dart';

class AddAndEditUserProduct extends StatefulWidget {
  static const navName = '/add-edit-product';
  @override
  _AddAndEditUserProductState createState() => _AddAndEditUserProductState();
}

class _AddAndEditUserProductState extends State<AddAndEditUserProduct> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlControler = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _isdidChangeDependency = false;
  var _isLoading = false;
  var editedProduct = Product(
    id: null,
    title: '',
    description: '',
    price: 0.0,
    imageUrl: '',
  );

  var preFilledProduct = {
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': '',
  };

  @override
  void dispose() {
    // TODO: implement dispose
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlControler.removeListener(autoDisplayImage);
    _imageUrlFocusNode.dispose();
    _imageUrlControler.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    _imageUrlControler.addListener(autoDisplayImage);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!_isdidChangeDependency) {
      var id = ModalRoute.of(context).settings.arguments as String;
      if (id != null) {
        editedProduct =
            Provider.of<ProductProvider>(context, listen: false).getById(id);
        preFilledProduct = {
          'title': editedProduct.title,
          'description': editedProduct.description,
          'price': editedProduct.price.toString(),
          'imageUrl': '',
        };
        _imageUrlControler.text = editedProduct.imageUrl;
      }
    }
    _isdidChangeDependency = true;
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  void saveForm() {
    setState(() {
      _isLoading = true;
    });

    if (_form.currentState.validate()) {
      _form.currentState.save();
    } else
      return;

    if (editedProduct.id == null) {
      Provider.of<ProductProvider>(context, listen: false)
          .saveProduct(editedProduct)
          .catchError((error) {
        return showDialog(
          context: context,
          builder: (cntx) => AlertDialog(
            title: Text('Error!'),
            content: Text(
                'We were unable to add a product, please try again later. You can contact customer care if it presist'),
            actions: <Widget>[
              FlatButton(
                child: Text('Close'),
                onPressed: () {
                  Navigator.of(cntx).pop();
                },
              ),
            ],
          ),
        );
      }).then((furure) {
        setState(() {
          _isLoading = false;
        });
        Navigator.pop(context);
      });
    } else {
      Provider.of<ProductProvider>(context, listen: false)
          .editProduct(editedProduct.id, editedProduct);
      setState(() {
        _isLoading = false;
      });
      Navigator.pop(context);
    }

    // print(
    //     '  ${editedProduct.title}  ${editedProduct.price}  ${editedProduct.imageUrl}');
    //Navigator.pop(context);
  }

  void autoDisplayImage() {
    if (!_imageUrlFocusNode.hasFocus) {
      if (!_imageUrlControler.text.startsWith('http') ||
          !_imageUrlControler.text.startsWith('https')) if (!_imageUrlControler
              .text
              .endsWith('jpg') ||
          !_imageUrlControler.text.endsWith('jpeg') ||
          !_imageUrlControler.text.endsWith('png')) return;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add or Edit Product'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: saveForm,
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: EdgeInsets.all(16.0),
              child: Form(
                key: _form,
                child: ListView(children: <Widget>[
                  TextFormField(
                    initialValue: preFilledProduct['title'],
                    decoration: InputDecoration(labelText: 'Title'),
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (input) =>
                        FocusScope.of(context).requestFocus(_priceFocusNode),
                    onSaved: (value) => editedProduct = Product(
                      isFavorite: editedProduct.isFavorite,
                      id: editedProduct.id,
                      title: value,
                      description: editedProduct.description,
                      price: editedProduct.price,
                      imageUrl: editedProduct.imageUrl,
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please type a Title';
                      } else
                        return null;
                    },
                  ),
                  TextFormField(
                    initialValue: preFilledProduct['price'],
                    decoration: InputDecoration(labelText: 'Price'),
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    focusNode: _priceFocusNode,
                    onFieldSubmitted: (input) => FocusScope.of(context)
                        .requestFocus(_descriptionFocusNode),
                    onSaved: (value) => editedProduct = Product(
                      isFavorite: editedProduct.isFavorite,
                      id: editedProduct.id,
                      title: editedProduct.title,
                      description: editedProduct.description,
                      price: double.parse(value),
                      imageUrl: editedProduct.imageUrl,
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please type a Price';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Please type a valid price';
                      }
                      if (double.parse(value) < 1) {
                        return 'Price too small';
                      } else
                        return null;
                    },
                  ),
                  TextFormField(
                    initialValue: preFilledProduct['description'],
                    decoration: InputDecoration(labelText: 'Description'),
                    maxLines: 3,
                    focusNode: _descriptionFocusNode,
                    onSaved: (value) => editedProduct = Product(
                      isFavorite: editedProduct.isFavorite,
                      id: editedProduct.id,
                      title: editedProduct.title,
                      description: value,
                      price: editedProduct.price,
                      imageUrl: editedProduct.imageUrl,
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please type a Description';
                      }
                      if (value.length < 10) {
                        return ' Please make your description above 10 characters';
                      } else
                        return null;
                    },
                    //onFieldSubmitted: (input) => FocusScope.of(context).requestFocus(_priceFocusNode),
                  ),
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          width: 100,
                          height: 100,
                          margin: EdgeInsets.only(top: 8, right: 10),
                          decoration: BoxDecoration(
                            border: Border.all(width: 1),
                            color: Colors.grey,
                          ),
                          child: _imageUrlControler.text.isNotEmpty
                              ? FittedBox(
                                  child: Image.network(
                                  _imageUrlControler.text,
                                  fit: BoxFit.cover,
                                ))
                              : Text('Enter a valid Image Url'),
                        ),
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(labelText: 'Image Url'),
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.url,
                            controller: _imageUrlControler,
                            focusNode: _imageUrlFocusNode,
                            onSaved: (value) => editedProduct = Product(
                              isFavorite: editedProduct.isFavorite,
                              id: editedProduct.id,
                              title: editedProduct.title,
                              description: editedProduct.description,
                              price: editedProduct.price,
                              imageUrl: value,
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please type in a Image Url';
                              }
                              if (!value.startsWith('http') &&
                                  !value.startsWith('https')) {
                                return ' Please enter a valid url';
                              }
                              if (!value.endsWith('.jpg') &&
                                  !value.endsWith('.jpeg') &&
                                  !value.endsWith('.png')) {
                                return 'please use a valid Image Url';
                              } else
                                return null;
                            },
                            onFieldSubmitted: (value) => saveForm,
                          ),
                        ),
                      ]),
                ]),
              ),
            ),
    );
  }
}
