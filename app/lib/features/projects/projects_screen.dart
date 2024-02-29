import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:synergy/logic/stores/project_store.dart';
import 'package:synergy/utils/utils.dart';

import 'view_project/features/dashboard/views/screens/dashboard_screen.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key});

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  String searchQuery = '';
  var gotPermission = false;
  var isMoving = false;
  var fullScreen = false;
  var isSearching = false;

  final TextEditingController addProjectController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {},
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(8),
              const Text('Projects', style: Typo.headlineMedium),
              Divider(color: Colors.grey.shade800),
              const Gap(8),
              Row(
                children: [
                  const Icon(Icons.search),
                  const Gap(8),
                  Expanded(
                    child: SizedBox(
                      height: 40,
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            isSearching = true;
                            searchQuery = value;
                            if (searchQuery.isEmpty || searchQuery == "" || searchQuery == " ") {
                              isSearching = false;
                            }
                          });
                        },
                        decoration: InputDecoration(
                          suffixIcon: const Icon(Icons.search),
                          filled: true,
                          // fillColor: Colors.grey[200],
                          hintText: 'Search Files',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.0),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Gap(8),
                  IconButton(
                    icon: const Icon(Icons.apps),
                    onPressed: () {},
                  ),
                ],
              ),
              const Gap(8),
              const Center(child: CustomSegmentedControl()),
              const Gap(8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  GestureDetector(
                    onTap: () {
                      // Config config = new Config();
                      // PdftronFlutter.openDocument("https://www.pdftron.com/webviewer/demo/gallery/Report_2011.pdf", config: config);
                      void _showAddProjectModal(BuildContext context) {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: MediaQuery.of(context).size.height * 0.8,
                              padding: EdgeInsets.all(16),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextFormField(
                                    controller: addProjectController,
                                    decoration: InputDecoration(
                                      hintText: 'Enter project name',
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  ElevatedButton(
                                    onPressed: () {
                                      context.read<ProjectStore>().projects.add(addProjectController.text);
                                      context.read<ProjectStore>().notifyListeners();
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Add Project'),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }

                      _showAddProjectModal(context);
                    },
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add, color: Colors.white),
                            Gap(8),
                            Text('Add Project', style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  for (int i = 0; i < context.watch<ProjectStore>().projects.length; i++) ProjectItem(title: 'Project ${context.watch<ProjectStore>().projects[i]}'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

  class ProjectItem extends StatelessWidget {
    ProjectItem({
      super.key,
      required this.title,
    });

    final String title;

    final List<Color> colors = [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.purple,
      Colors.orange,
      Colors.teal,
      Colors.pink,
      Colors.indigo,
      Colors.amber,
      Colors.cyan,
    ];

    @override
    Widget build(BuildContext context) {
      return GestureDetector(
        onTap: () {
          // Config config = new Config();
          // PdftronFlutter.openDocument("https://www.pdftron.com/webviewer/demo/gallery/Report_2011.pdf", config: config);

          //  Nav to DashboardScreen
          Get.put(DashboardController());
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => DashboardScreen()));
        },
        child: Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            color: colors[Random().nextInt(colors.length)],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title, style: const TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ),
      );
    }
  }

  class CustomSegmentedControl extends StatefulWidget {
    const CustomSegmentedControl({super.key});

    @override
    CustomSegmentedControlState createState() => CustomSegmentedControlState();
  }

  class CustomSegmentedControlState extends State<CustomSegmentedControl> {
    int _selectedIndex = 0;

    @override
    Widget build(BuildContext context) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildSegment('Date', 0),
            _buildSegment('Name', 1),
            _buildSegment('Type', 2),
          ],
        ),
      );
    }

    Widget _buildSegment(String text, int index) {
      final bool isSelected = _selectedIndex == index;
      return GestureDetector(
        onTap: () {
          setState(() {
            _selectedIndex = index;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: isSelected ? Colors.grey[600] : Colors.transparent,
          ),
          child: Text(
            text,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.white54,
              fontSize: 14,
            ),
          ),
        ),
      );
    }
  }
