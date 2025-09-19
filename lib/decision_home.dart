import 'dart:convert';
import 'dart:math';
import 'package:decision_maker/cards/hint_card.dart';
import 'package:decision_maker/cards/selected_card.dart';
import 'package:decision_maker/empty_list.dart';
import 'package:decision_maker/hero_header.dart';
import 'package:decision_maker/primary_action.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DecisionHome extends StatefulWidget {
  const DecisionHome({super.key});

  @override
  State<DecisionHome> createState() => _DecisionHomeState();
}

class _DecisionHomeState extends State<DecisionHome> with RestorationMixin {
  final TextEditingController _controller = TextEditingController();
  final List<String> _activities = [];
  final Random _rand = Random();
  String? _selected;

  final RestorableString _restoredJson = RestorableString('');

  @override
  String? get restorationId => 'decision_home';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_restoredJson, 'state_json');
    if (_restoredJson.value.isNotEmpty) {
      try {
        final map = jsonDecode(_restoredJson.value) as Map<String, dynamic>;
        final list = (map['activities'] as List).cast<String>();
        _activities
          ..clear()
          ..addAll(list);
        _selected = map['selected'] as String?;
      } catch (_) {}
      setState(() {});
    }
  }

  void _persist() {
    _restoredJson.value = jsonEncode({
      'activities': _activities,
      'selected': _selected,
    });
  }

  void _toast(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text(msg),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _addActivity([String? preset]) {
    final text = (preset ?? _controller.text).trim();
    if (text.isEmpty) {
      _toast('Please type an activity first.');
      return;
    }
    HapticFeedback.selectionClick();
    setState(() {
      _activities.add(text);
      _controller.clear();
      _selected = null;
      _persist();
    });
  }

  void _pickRandom() {
    if (_activities.isEmpty) {
      _toast('Add a few activities first 😊');
      return;
    }
    HapticFeedback.lightImpact();
    setState(() {
      _selected = _activities[_rand.nextInt(_activities.length)];
      _persist();
    });
  }

  Future<void> _clearAll() async {
    if (_activities.isEmpty) {
      _toast('List is already empty.');
      return;
    }
    final confirm = await showDialog<bool>(
      context: context,
      builder: (c) => AlertDialog.adaptive(
        title: const Text('Clear all activities?'),
        content: const Text('This will remove the entire list.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(c, false),
            child: const Text('Cancel'),
          ),
          FilledButton.tonal(
            onPressed: () => Navigator.pop(c, true),
            child: const Text('Clear'),
          ),
        ],
      ),
    );
    if (confirm != true) return;

    HapticFeedback.mediumImpact();
    setState(() {
      _activities.clear();
      _selected = null;
      _persist();
    });
  }

  void _removeAtWithUndo(int index) {
    final removed = _activities[index];
    setState(() {
      _activities.removeAt(index);
      if (_selected == removed) _selected = null;
      _persist();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Removed: $removed'),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'UNDO',
          onPressed: () {
            setState(() {
              _activities.insert(index, removed);
              _persist();
            });
          },
        ),
      ),
    );
  }

  void _reorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) newIndex -= 1;
      final item = _activities.removeAt(oldIndex);
      _activities.insert(newIndex, item);
      _persist();
    });
  }

  final List<String> _quickAdds = [
    'Read a book',
    'Go for a walk',
    'Listen to music',
    'Call a friend',
    'Workout',
    'Watch a tutorial',
  ];

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(title: Text('Decision Maker'), elevation: 0),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _clearAll,
        icon: Icon(Icons.delete_sweep),
        label: Text('Clear List'),
        heroTag: 'fab-clear',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            HeroHeader(selected: _selected),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16, 12, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AnimatedSwitcher(
                      duration: Duration(milliseconds: 260),
                      transitionBuilder: (child, anim) => ScaleTransition(
                        scale: Tween<double>(begin: 0.95, end: 1.0).animate(
                          CurvedAnimation(
                            parent: anim,
                            curve: Curves.easeOutBack,
                          ),
                        ),
                        child: FadeTransition(opacity: anim, child: child),
                      ),
                      child: _selected == null
                          ? HintCard(key: ValueKey('hint'))
                          : SelectedCard(
                              key: ValueKey('sel'),
                              text: _selected!,
                            ),
                    ),
                    SizedBox(height: 20),

                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _controller,
                            textInputAction: TextInputAction.done,
                            onFieldSubmitted: (_) => _addActivity(),
                            cursorColor: Color.fromARGB(255, 1, 113, 102),
                            decoration: InputDecoration(
                              labelText: 'Add an activity',
                              hintText: 'e.g. Finish a chapter',
                              prefixIcon: Icon(Icons.add_task),
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        FilledButton.icon(
                          onPressed: _addActivity,
                          icon: Icon(Icons.add),
                          label: Text('Add'),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),

                    SizedBox(
                      height: 40,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: _quickAdds.length,
                        separatorBuilder: (_, __) => SizedBox(width: 8),
                        itemBuilder: (_, i) => ActionChip(
                          label: Text(_quickAdds[i]),
                          avatar: Icon(Icons.flash_on, size: 16),
                          onPressed: () => _addActivity(_quickAdds[i]),
                        ),
                      ),
                    ),

                    SizedBox(height: 12),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: PrimaryAction(
                            onTap: _pickRandom,
                            label: "What should I do?",
                            icon: Icons.casino,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),

                    Row(
                      children: [
                        Text(
                          'My Activities',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(width: 8),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: cs.surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(
                            '${_activities.length}',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                        Spacer(),
                        Tooltip(
                          message: 'Reorder by long-press & drag',
                          child: Icon(Icons.drag_handle, color: cs.outline),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),

                    Expanded(
                      child: _activities.isEmpty
                          ? EmptyList()
                          : ReorderableListView.builder(
                              itemCount: _activities.length,
                              buildDefaultDragHandles: true,
                              onReorder: _reorder,
                              proxyDecorator: (child, index, anim) => Material(
                                color: Colors.transparent,
                                elevation: 6,
                                borderRadius: BorderRadius.circular(14),
                                child: child,
                              ),
                              itemBuilder: (context, index) {
                                final text = _activities[index];
                                return Dismissible(
                                  key: ValueKey('item_$index$text'),
                                  background: _swipeBg(left: true),
                                  secondaryBackground: _swipeBg(left: false),
                                  onDismissed: (_) => _removeAtWithUndo(index),
                                  child: Card(
                                    margin: EdgeInsets.symmetric(vertical: 6),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    child: ListTile(
                                      title: Text(text),
                                      leading: ReorderableDragStartListener(
                                        index: index,
                                        child: Icon(Icons.drag_indicator),
                                      ),
                                      trailing: IconButton(
                                        tooltip: 'Pick this',
                                        icon: Icon(
                                          _selected == text
                                              ? Icons.check_circle
                                              : Icons.check_circle_outline,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _selected = text;
                                            _persist();
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _swipeBg({required bool left}) => Container(
    alignment: left ? Alignment.centerLeft : Alignment.centerRight,
    padding: EdgeInsets.only(left: left ? 16 : 0, right: left ? 0 : 16),
    decoration: BoxDecoration(
      color: Colors.red.withOpacity(0.1),
      borderRadius: BorderRadius.circular(14),
    ),
    child: Icon(Icons.delete, size: 22),
  );
}
