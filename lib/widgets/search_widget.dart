import 'package:flutter/material.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 1),
          child: _isSearching
              ? SizedBox(
            height: 40,
            width: 240,
            child: Center(
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                      color: Colors.black12,
                      width: 1.0,
                    ),
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      setState(() {
                        _searchController.clear();
                      });
                    },
                  ),
                ),
              ),
            ),
          )
              : IconButton(
            key: ValueKey<bool>(_isSearching),
            icon: const Icon(Icons.search, color: Colors.black, size: 48),
            onPressed: () {
              setState(() {
                _isSearching = true;
              });
            },
          ),
        ),
        if (_isSearching)
          IconButton(
            key: ValueKey<bool>(_isSearching),
            icon: const Icon(Icons.arrow_forward_ios_outlined,
                color: Colors.black),
            onPressed: () {
              setState(() {
                _searchController.clear();
                _isSearching = false;
              });
            },
          ),
      ],
    );
  }
}