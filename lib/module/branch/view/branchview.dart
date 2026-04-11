import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kemerahrfrontend/core/theme/app_color.dart';
import 'package:kemerahrfrontend/core/theme/text_style.dart';
import 'package:kemerahrfrontend/module/branch/controller/branchcontroller.dart';
import 'package:kemerahrfrontend/share/widgets/customtextfield.dart';
import 'package:kemerahrfrontend/share/widgets/elevated_button.dart';
import 'package:kemerahrfrontend/share/widgets/floatingbutton.dart';
import 'package:kemerahrfrontend/share/widgets/loading.dart';

class Branchview extends StatefulWidget {
  Branchview({super.key});

  @override
  State<Branchview> createState() => _BranchviewState();
}

class _BranchviewState extends State<Branchview> {
  var editingIndex = RxnInt();
  final nameController = TextEditingController();
  final latController = TextEditingController();
  final lngController = TextEditingController();
  final radiusController = TextEditingController();
  final branchcontroller = Get.put(Branchcontroller());
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.get('background', context),
      body: RefreshIndicator(
        color: AppColors.get('primary', context),
        backgroundColor: AppColors.get('background', context),
        onRefresh: () async {
          await branchcontroller.fetchbranch();
        },
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.get('warning', context).withOpacity(0.6),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Obx(
                        () => Text(
                          "សាខាមានចំនួន : ${branchcontroller.branch.length}",
                          style: TextStyles.siemreap(
                            context,
                            color: AppColors.get('text', context),
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "បញ្ជីសាខា",
                    style: TextStyles.moul(
                      context,
                      color: AppColors.get('text', context),
                      fontSize: 25,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    branchcontroller.branch.clear();
                    branchcontroller.fetchbranch();
                  },
                  icon: Icon(
                    Icons.refresh,
                    size: 30,
                    color: AppColors.get('primary', context),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Obx(() {
                if (branchcontroller.isLoading.value) {
                  return CustomLoading();
                }

                if (branchcontroller.branch.isEmpty) {
                  return Center(
                    child: Text(
                      "អត់មានទិន្ន័យ",
                      style: TextStyles.siemreap(context, fontSize: 13),
                    ),
                  );
                }

                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: MediaQuery.of(context).size.width,
                    ),
                    child: DataTable(
                      headingRowColor: WidgetStateProperty.all(
                        AppColors.get('primary', context),
                      ),
                      dataRowColor: WidgetStateProperty.resolveWith((states) {
                        if (states.contains(WidgetState.selected)) {
                          return AppColors.get('border', context);
                        }
                        return AppColors.get('background', context);
                      }),

                      dividerThickness: 0.5,
                      // columnSpacing: 10,
                      //    horizontalMargin: 12,
                      headingRowHeight: 50,
                      dataRowMinHeight: 10,
                      dataRowMaxHeight: 55,
                      border: TableBorder(
                        top: BorderSide(
                          color: AppColors.get('text', context),
                          width: 0.6,
                        ),
                        left: BorderSide(
                          color: AppColors.get('text', context),
                          width: 0.6,
                        ),
                        right: BorderSide(
                          color: AppColors.get('text', context),
                          width: 0.6,
                        ),
                        bottom: BorderSide(
                          color: AppColors.get('text', context),
                          width: 0.6,
                        ),
                        horizontalInside: BorderSide(
                          color: AppColors.get('text', context),
                          width: 0.6,
                        ),
                        verticalInside: BorderSide(
                          color: AppColors.get('text', context),
                          width: 0.6,
                        ),
                      ),
                      columns: [
                        DataColumn(
                          label: Center(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  Text(
                                    "ល.រ",
                                    style: TextStyles.siemreap(
                                      context,
                                      color: AppColors.get(
                                        'background',
                                        context,
                                      ),
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        DataColumn(
                          columnWidth: FlexColumnWidth(1),

                          label: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                Text(
                                  "ឈ្មោះសាខា",
                                  style: TextStyles.siemreap(
                                    color: AppColors.get('background', context),
                                    context,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        DataColumn(
                          columnWidth: FlexColumnWidth(1),
                          label: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                Text(
                                  "Latitude",
                                  style: TextStyles.siemreap(
                                    color: AppColors.get('background', context),
                                    context,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        DataColumn(
                          columnWidth: FlexColumnWidth(1),
                          label: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                Text(
                                  "Longitude",
                                  style: TextStyles.siemreap(
                                    color: AppColors.get('background', context),
                                    context,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        DataColumn(
                          columnWidth: FlexColumnWidth(1),
                          label: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                Text(
                                  "ចម្ងាយដែលអាចស្កែនបាន",
                                  style: TextStyles.siemreap(
                                    color: AppColors.get('background', context),
                                    context,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        DataColumn(
                          columnWidth: FlexColumnWidth(1),
                          label: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                Text(
                                  "ស្ថានភាព",
                                  style: TextStyles.siemreap(
                                    color: AppColors.get('background', context),
                                    context,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        DataColumn(
                          columnWidth: FlexColumnWidth(1),
                          label: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                Text(
                                  "សកម្មភាព",
                                  style: TextStyles.siemreap(
                                    color: AppColors.get('background', context),
                                    context,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                      rows: List.generate(branchcontroller.branch.length, (
                        index,
                      ) {
                        final branch = branchcontroller.branch[index];
                        return DataRow(
                          cells: [
                            // លរ (Index)
                            DataCell(
                              Center(
                                child: Text(
                                  "${index + 1}",
                                  style: TextStyles.siemreap(
                                    context,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                            // ឈ្មោះសាខា
                            DataCell(
                              Obx(() {
                                return branchcontroller.editingIndex.value ==
                                        index
                                    ? SizedBox(
                                        width: 220,
                                        child: CustomTextField(
                                          controller:
                                              branchcontroller.nameController,
                                          hintText: "",
                                        ),
                                      )
                                    : Text(
                                        branch.name ?? "អត់មាន",
                                        style: TextStyles.siemreap(
                                          context,
                                          fontSize: 15,
                                        ),
                                      );
                              }),
                            ),
                            // Latitude
                            DataCell(
                              Obx(() {
                                return branchcontroller.editingIndex.value ==
                                        index
                                    ? SizedBox(
                                        width: 220,
                                        child: CustomTextField(
                                          //  keyboardType: TextInputType.number,
                                          controller:
                                              branchcontroller.latController,
                                          hintText: "",
                                        ),
                                      )
                                    : Text(
                                        branch.latitude ?? "-",
                                        style: TextStyles.siemreap(
                                          context,
                                          fontSize: 15,
                                        ),
                                      );
                              }),
                            ),
                            // Longitude
                            DataCell(
                              Obx(() {
                                return branchcontroller.editingIndex.value ==
                                        index
                                    ? SizedBox(
                                        width: 220,
                                        child: CustomTextField(
                                          controller:
                                              branchcontroller.lngController,
                                          hintText: "",
                                        ),
                                      )
                                    : Text(
                                        branch.longitude ?? "-",
                                        style: TextStyles.siemreap(
                                          context,
                                          fontSize: 15,
                                        ),
                                      );
                              }),
                            ),
                            // Radius
                            DataCell(
                              Obx(() {
                                return branchcontroller.editingIndex.value ==
                                        index
                                    ? SizedBox(
                                        width: 80,
                                        child: CustomTextField(
                                          controller:
                                              branchcontroller.radiusController,
                                          hintText: "",
                                        ),
                                      )
                                    : Text(
                                        branch.radius?.toString() ?? "-",
                                        style: TextStyles.siemreap(
                                          context,
                                          fontSize: 15,
                                        ),
                                      );
                              }),
                            ),
                            // Status
                            DataCell(
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: (branch.isActive == true)
                                      ? Colors.green.withOpacity(0.2)
                                      : Colors.red.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  (branch.isActive == true)
                                      ? "សកម្ម"
                                      : "អសកម្ម",
                                  style: TextStyles.siemreap(
                                    context,
                                    fontSize: 15,
                                    color: (branch.isActive == true)
                                        ? Colors.green
                                        : Colors.red,
                                  ),
                                ),
                              ),
                            ),

                            DataCell(
                              Obx(() {
                                final isEditing =
                                    branchcontroller.editingIndex.value ==
                                    index;

                                return Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if (isEditing) ...[
                                      // ✅ Save
                                      IconButton(
                                        onPressed: () async {
                                          await branchcontroller.updatebranch(
                                            branchid: branch.id!,
                                            name: branchcontroller
                                                .nameController
                                                .text,
                                            latitude: branchcontroller
                                                .latController
                                                .text,
                                            longitude: branchcontroller
                                                .lngController
                                                .text,
                                            radius: int.parse(
                                              branchcontroller
                                                  .radiusController
                                                  .text,
                                            ),
                                          );

                                          branchcontroller.editingIndex.value =
                                              null;
                                        },
                                        icon: Icon(
                                          Icons.check_box,
                                          size: 35,
                                          color: AppColors.get(
                                            'success',
                                            context,
                                          ),
                                        ),
                                      ),

                                      const SizedBox(width: 8),

                                      // ❌ Cancel
                                      IconButton(
                                        onPressed: () {
                                          branchcontroller.editingIndex.value =
                                              null;
                                        },
                                        icon: Icon(
                                          Icons.close,
                                          size: 35,
                                          color: AppColors.get(
                                            'error',
                                            context,
                                          ),
                                        ),
                                      ),
                                    ] else ...[
                                      // ✏️ Edit
                                      InkWell(
                                        onTap: () {
                                          branchcontroller.startEdit(
                                            index,
                                            branch,
                                          );
                                        },
                                        borderRadius: BorderRadius.circular(8),
                                        child: Container(
                                          padding: const EdgeInsets.all(6),
                                          decoration: BoxDecoration(
                                            color: AppColors.get(
                                              'warning',
                                              context,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                          child: Icon(
                                            Icons.edit,
                                            size: 16,
                                            color: AppColors.get(
                                              'text',
                                              context,
                                            ),
                                          ),
                                        ),
                                      ),

                                      const SizedBox(width: 8),

                                      // 🔴 Toggle Status
                                      InkWell(
                                        onTap: () =>
                                            branchcontroller.changestatusbranch(
                                              branchid: branch.id!,
                                            ),
                                        borderRadius: BorderRadius.circular(8),
                                        child: Container(
                                          padding: const EdgeInsets.all(6),
                                          decoration: BoxDecoration(
                                            color: Colors.red.withOpacity(0.15),
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                          child: const Icon(
                                            Icons.power_settings_new,
                                            size: 16,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ],
                                );
                              }),
                            ),
                          ],
                        );
                      }),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
      floatingActionButton: CustomFloatingActionButton(
        heroTag: "gotocreaterole",
        onPressed: () {
          showCreateBranch(context);
        },
      ),
    );
  }

  void showCreateBranchBottomSheet() {
    // ... your existing code
  }

  void showCreateBranch(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Builder(
          builder: (_) {
            final nameController = TextEditingController();
            final radiusController = TextEditingController();
            final latitudeCotroller = TextEditingController();
            final longitudeController = TextEditingController();
            final selectedLat = RxnDouble();
            final selectedLng = RxnDouble();

            return ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: Get.height * 0.8,
                maxWidth: Get.height * 0.5,
              ),
              child: SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.get('border', context)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 50,
                            height: 4,
                            margin: const EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              color: AppColors.get('warning', context),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          Text(
                            "បង្កើតសាខាថ្មី",
                            style: TextStyles.siemreap(
                              context,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 15),

                          // Branch name
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "ឈ្មោះសាខា",
                              style: TextStyles.siemreap(context, fontSize: 12),
                            ),
                          ),
                          const SizedBox(height: 8),
                          CustomTextField(
                            controller: nameController,
                            prefixIcon: Icons.home,
                            hintText: "ឈ្មោះសាខា (ឧ. Toul Kork)",
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'សូមបញ្ចូលឈ្មោះសាខា';
                              }
                              if (value.trim().length < 3) {
                                return 'ត្រូវមានយ៉ាងហោចណាស់ 3 តួអក្សរ';
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 15),

                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "ទីតាំងសាខា",
                              style: TextStyles.siemreap(context, fontSize: 12),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: CustomTextField(
                                  controller: latitudeCotroller,
                                  hintText: "Latitude",
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: CustomTextField(
                                  controller: longitudeController,
                                  hintText: "Longitude",
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                            ],
                          ),

                          // Row(

                          //   children: [
                          //     CustomTextField(
                          //       controller: latitudeCotroller, hintText: "Copy Latitude from GoogleMap"),
                          //       SizedBox(width: 10,),
                          //         CustomTextField(
                          //       controller: longitudeController, hintText: "Copy Longitude from GoogleMap"),

                          //   ],
                          // ),
                          const SizedBox(height: 15),

                          // Radius
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "ចម្ងាយដែលអាចស្កែនបាន (m)",
                              style: TextStyles.siemreap(context, fontSize: 12),
                            ),
                          ),
                          const SizedBox(height: 8),
                          CustomTextField(
                            controller: radiusController,
                            prefixIcon: Icons.circle_outlined,
                            hintText: "ឧ. 20",
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'សូមបញ្ចូលចម្ងាយ';
                              }
                              if (int.tryParse(value.trim()) == null) {
                                return 'សូមបញ្ចូលលេខត្រឹមត្រូវ';
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 20),

                          // Button
                          CustomElevatedButton(
                            text: "រក្សាទុក",
                            onPressed: () async {
                              if (!formKey.currentState!.validate()) return;

                              final int radius = int.parse(
                                radiusController.text.trim(),
                              );

                              // Loading
                              Get.dialog(
                                const Center(
                                  child: CircularProgressIndicator(),
                                ),
                                barrierDismissible: false,
                              );

                              await branchcontroller.createbranch(
                                name: nameController.text.trim(),
                                latitude: latitudeCotroller.text,
                                longitude: longitudeController.text,
                                radius: radius,
                              );

                              Get.back(); // close loading
                              Get.back(); // close dialog
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
