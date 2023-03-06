import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:new_word_hive/MyFunction/dialogs.dart';
import 'package:new_word_hive/Screens/help_screen.dart';
import 'package:new_word_hive/theme.dart';
import '../widget/drawer.dart';

bool isIconDarkState = true;
final _wordBox = Hive.box('word_box');
List<Map<String, dynamic>> _words = [];

//*: -> Word Dialog Statefull widgets
class WordDialog extends StatefulWidget {
  final int itemKey;
  const WordDialog({Key? key, required this.itemKey}) : super(key: key);

  @override
  State<WordDialog> createState() => _WordDialogState();
}

class _WordDialogState extends State<WordDialog> {
  bool isFavourite = false;
  late String wordHolder;
  late String descHolder;
  late Color iconColor;

  @override
  void initState() {
    super.initState();
    final itemExisted =
        _words.firstWhere((element) => element['key'] == widget.itemKey);
    wordHolder = itemExisted['word'];
    descHolder = itemExisted['description'];
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          Expanded(
            child: Text(
              wordHolder,
              textAlign: TextAlign.center,
            ),
          ),
          GestureDetector(
            child: Icon(
              isFavourite ? Icons.favorite : Icons.favorite_border,
              size: 35.0,
              color: Colors.red.shade900,
            ),
            onTap: () {
              setState(() {
                isFavourite = !isFavourite;
              });
            },
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(
              descHolder,
              style: const TextStyle(fontSize: 16.0, wordSpacing: 5),
            ),
          ],
        ),
      ),
    );
  }
}

//*-> Main App Widget
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // List<Map<String, dynamic>> _words = [];
  final TextEditingController _wordController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  bool isSearchBarVisible = false;
  bool isSearchIconVisible = true;
  // final _wordBox = Hive.box('word_box');

  //*:-> Holders
  String wordHolder = '';
  String descHolder = '';
  double _dialogHeigh = 100;

  bool isDartLightMode = true;
  bool isFavourite = false;
  bool isDelete = false;

  //*:-> Messages
  String message = "Are you sure that you want to delete this item permenently";

  void showSearch() {
    setState(() {
      if (isSearchIconVisible) {
        isSearchBarVisible = true;
        isSearchIconVisible = false;
      }
    });
  }

  void _refresh() {
    isSearchBarVisible = false;
    isSearchIconVisible = true;
  }

  void _clear() {
    _wordController.text = '';
    _descriptionController.text = '';
  }

  @override
  void initState() {
    super.initState();
    currentTheme.addListener(() {
      setState(() {});
    });
    _refresh();
    _refreshUi();
  }

  void _refreshUi() {
    final data = _wordBox.keys.map((key) {
      final item = _wordBox.get(key);
      return {
        "key": key,
        "word": item['word'].toString(),
        "description": item['description'].toString()
      };
    }).toList();

    setState(() {
      _words = data.reversed.toList();
    });
  }

//? -> Adds data(word,desc) to hiveBox(_wordBox)
  Future<void> addItem(Map<String, dynamic> newWord) async {
    await _wordBox.add(newWord);
    _refreshUi();
  }

//? -> Deletes data from the _wordBox
  Future<void> _deleteData(int itemKey) async {
    await _wordBox.delete(itemKey);
    _refreshUi();
  }

  //?-> Show word and description dialog
  Future<void> showWordDialog(BuildContext contex, int? itemKey) {
    if (itemKey != null) {
      final itemExisted =
          _words.firstWhere((element) => element['key'] == itemKey);
      wordHolder = itemExisted['word'];
      descHolder = itemExisted['description'];
    }
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return WordDialog(itemKey: itemKey!);
        });
  }

  //*-> save word dialog
  Future<void> showFieldlDailog(BuildContext context, int? itemKey) {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Center(child: Text("New Word")),
            content: Container(
              height: 250,
              width: 500,
              padding: const EdgeInsets.all(2.0),
              //padding: const EdgeInsets.symmetric(vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextField(
                    controller: _wordController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        filled: true,
                        hintText: 'word'),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(minHeight: _dialogHeigh),
                        child: LayoutBuilder(
                          builder: (BuildContext context,
                              BoxConstraints constraints) {
                            return TextField(
                              maxLines: null,
                              keyboardType: TextInputType.multiline,
                              controller: _descriptionController,
                              onChanged: (value) {
                                setState(() {
                                  _dialogHeigh = constraints.minHeight;
                                });
                              },
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  filled: true,
                                  hintText: 'description'),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 0.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      //?: ->  Save button
                      ElevatedButton(
                          onPressed: () {
                            if (itemKey == null) {
                              if(_wordController.text.isNotEmpty && _descriptionController.text.isNotEmpty){
                                addItem({
                                'word': _wordController.text,
                                'description': _descriptionController.text
                              });
                              }
                              _clear();
                              Navigator.of(context).pop();
                            }
                          },
                          child: const Text('Save')),
                      const SizedBox(
                        width: 5.0,
                      ),
                      //? -> Cancel Button
                      ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            _clear();
                          },
                          child: const Text('Cancel'))
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Words"),
        actions: [
          Row(
            children: [
              IconButton(
                  padding: const EdgeInsets.only(left: 25.0),
                  onPressed: () {},
                  icon: const Icon(Icons.search_outlined)),
              IconButton(
                  padding: const EdgeInsets.only(right: 0.0),
                  onPressed: () {
                    currentTheme.toggleTheme();
                    setState(() {
                      isDartLightMode = !isDartLightMode;
                      isIconDarkState = !isIconDarkState;
                    });
                  },
                  icon: Icon(isDartLightMode
                      ? Icons.dark_mode_rounded
                      : Icons.light_mode_outlined)),
              IconButton(
                  padding: const EdgeInsets.only(right: 10.0),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HelpScreen()));
                  },
                  icon: const Icon(Icons.help_center))
            ],
          )
        ],
      ),
      body: ListView.builder(
          itemCount: _words.length,
          itemBuilder: (context, index) {
            final currentItem = _words[index];
            return GestureDetector(
              onTap: () => showWordDialog(context, currentItem['key']),
              child: Card(
                color: Theme.of(context).colorScheme.secondary,
                margin: const EdgeInsets.all(10.0),
                elevation: 5,
                child: ListTile(
                  title: Text(currentItem['word']),
                  subtitle: Text(
                    currentItem['description'],
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () async {
                            bool? confirm = await Utils.showConfirmationDialog(context, message,true);
                            if(confirm == true)
                            {
                              _deleteData(currentItem['key']);
                            }
                            else{
                              return;
                            }
                          },
                          icon: const Icon(Icons.delete)),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.edit_document))
                    ],
                  ),
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showFieldlDailog(context, null),
        child: const Icon(Icons.add),
      ),
      drawer: const MyDrawer(),
    );
  }
}
