import 'package:flutter/material.dart';

class CustomSearchableDropdown extends StatefulWidget {
  final String selectedValue;
  final ValueChanged<String?> onChange;
  final List<String> items;
  final String hintText;

  const CustomSearchableDropdown({
    super.key,
    required this.selectedValue,
    required this.onChange,
    required this.items,
    this.hintText = "Select an option",
  });

  @override
  State<CustomSearchableDropdown> createState() => _CustomSearchableDropdownState();
}

class _CustomSearchableDropdownState extends State<CustomSearchableDropdown> {
  Future<void> _openDropdown() async {
    final result = await showDialog<String>(
      context: context,
      builder: (context) {
        return _SearchableDropdownDialog(items: widget.items);
      },
    );

    if (result != null) {
      widget.onChange(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _openDropdown,
      child: InputDecorator(
        decoration: InputDecoration(
          hintText: widget.hintText,
          border: const OutlineInputBorder(),
        ),
        child: Text(
          widget.selectedValue.isNotEmpty ? widget.selectedValue : '',
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}

class _SearchableDropdownDialog extends StatefulWidget {
  final List<String> items;
  const _SearchableDropdownDialog({required this.items});

  @override
  __SearchableDropdownDialogState createState() => __SearchableDropdownDialogState();
}

class __SearchableDropdownDialogState extends State<_SearchableDropdownDialog> {
  late TextEditingController _searchController;
  String _filter = "";

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Filter items based on the search input.
    final filteredItems = widget.items.where((item) => item.toLowerCase().contains(_filter.toLowerCase())).toList();

    return AlertDialog(
      title: const Text('Select an Ingredient'),
      // Here we give the content a fixed size to avoid intrinsic measurement.
      content: SizedBox(
        width: double.maxFinite,
        height: 300,
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: "Search",
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _filter = value;
                });
              },
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: filteredItems.length,
                itemBuilder: (context, index) {
                  final item = filteredItems[index];
                  return ListTile(
                    title: Text(item),
                    onTap: () {
                      Navigator.of(context).pop(item);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        )
      ],
    );
  }
}
