import 'package:flutter/material.dart';
import 'package:quizapp/models/item_model.dart';

// ignore: must_be_immutable
class ItemDropDown extends StatefulWidget {

  ItemModel defaultItem;
  List<ItemModel> items;
  Function(String id) selectedId;

  ItemDropDown({Key key, this.defaultItem, this.items, this.selectedId}) : super(key: key);

  @override
  _ItemDropDownState createState() => _ItemDropDownState();
}

class _ItemDropDownState extends State<ItemDropDown> {

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
        child: DropdownButton<ItemModel>(
          value: widget.defaultItem,
          isExpanded: true,
          icon: Icon(Icons.arrow_drop_down),
          iconSize: 35,
          underline: SizedBox(),
          onChanged: (ItemModel newValue) {
            setState(() {
              widget.defaultItem = newValue;
              widget.selectedId(newValue.id);
            });
          },
          items: widget.items.map<DropdownMenuItem<ItemModel>>((ItemModel value) {
            return DropdownMenuItem<ItemModel>(
              value: value,
              child: Text(
                value.type,
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'Monteserrat',
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
