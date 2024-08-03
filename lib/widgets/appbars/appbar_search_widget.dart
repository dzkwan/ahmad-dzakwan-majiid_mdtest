import 'package:fan_test/themes/light_colors.dart';
import 'package:flutter/material.dart';

class AppbarSearchWidget extends StatefulWidget implements PreferredSizeWidget {
  AppbarSearchWidget({
    super.key,
    required this.onCancelSearch,
    required this.onSearchQueryChanged,
  });

  VoidCallback onCancelSearch;
  Function(String) onSearchQueryChanged;

  @override
  Size get preferredSize => Size.fromHeight(56.0);

  @override
  _AppbarSearchWidgetState createState() => _AppbarSearchWidgetState();
}

class _AppbarSearchWidgetState extends State<AppbarSearchWidget>
    with SingleTickerProviderStateMixin {
  String searchQuery = '';
  bool clearButton = false;
  TextEditingController _searchFieldController = TextEditingController();
  FocusNode _focusNode = FocusNode();

  clearSearchQuery() {
    _searchFieldController.clear();
    FocusScope.of(context).requestFocus(_focusNode);
    clearButton = false;
    widget.onSearchQueryChanged('');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: widget.preferredSize.height,
        padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_back, color: LightColors.mainColor),
              onPressed: widget.onCancelSearch,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
                height: kToolbarHeight - 18,
                child: TextField(
                  controller: _searchFieldController,
                  focusNode: _focusNode,
                  autofocus: true,
                  cursorColor: LightColors.mainColor,
                  style: TextStyle(color: LightColors.mainColor),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search...",
                    hintStyle: TextStyle(color: LightColors.mainColor),
                    suffixIcon: clearButton
                        ? InkWell(
                            child:
                                Icon(Icons.close, color: LightColors.mainColor),
                            onTap: clearSearchQuery,
                          )
                        : null,
                  ),
                  onChanged: (value) {
                    if (value != "") {
                      clearButton = true;
                    } else {
                      clearButton = false;
                    }
                    setState(() {});

                    widget.onSearchQueryChanged(value);
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
