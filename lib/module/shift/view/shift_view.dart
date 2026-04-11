import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kemerahrfrontend/core/theme/app_color.dart';
import 'package:kemerahrfrontend/core/theme/text_style.dart';
import 'package:kemerahrfrontend/module/branch/controller/branchcontroller.dart';
import 'package:kemerahrfrontend/module/shift/controller/shift_controller.dart';
import 'package:kemerahrfrontend/share/widgets/customdropdown.dart';
import 'package:kemerahrfrontend/share/widgets/customtextfield.dart';
import 'package:kemerahrfrontend/share/widgets/elevated_button.dart';
import 'package:kemerahrfrontend/share/widgets/floatingbutton.dart';
import 'package:kemerahrfrontend/share/widgets/loading.dart';

class ShiftView extends StatefulWidget {
  ShiftView({super.key});

  @override
  State<ShiftView> createState() => _ShiftViewState();
}

class _ShiftViewState extends State<ShiftView> {
  var editingIndex = RxnInt();
  final nameController = TextEditingController();
  final selectbranchid = Rxn<int>();
  final shiftcontrolller = Get.put(ShiftController());
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
          await shiftcontrolller.fetchshift();
        },
        child: Column(
          children: [
            Row(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
               Expanded(
                 child: Row(
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
                               "វេនធ្វេីសរុបមានចំនួន : ${shiftcontrolller.shift.length}",
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
                 
                     // 🔥 FIX HERE
                     Padding(
                       padding: const EdgeInsets.all(4.0),
                       child: SizedBox(
                        height: 50,
                        width: 200,
                         child: CustomDropdown(
                           selectedValue: shiftcontrolller.selectbranchid,
                           items: branchcontroller.branch,
                           hintText: "ស្វែងរកតាមរយ:សាខា",
                           onChanged: (value) async {
                             await shiftcontrolller.fetchshiftbybranchid(value!);
                           },
                         ),
                       ),
                     ),
                   ],
                 ),
               ),
                Expanded(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "បញ្ជីវេនធ្វេីការ",
                          style: TextStyles.moul(
                            context,
                            color: AppColors.get('text', context),
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        shiftcontrolller.selectbranchid.value = null;
                        shiftcontrolller.shift.clear();
                        shiftcontrolller.fetchshift();
                      },
                      icon: Icon(
                        Icons.refresh,
                        size: 30,
                        color: AppColors.get('primary', context),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Obx(() {
                if (shiftcontrolller.isLoading.value) {
                  return CustomLoading();
                }

                if (shiftcontrolller.shift.isEmpty) {
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
                                  SelectableText(
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
                                SelectableText(
                                  "ឈ្មោះវេនធ្វេីការ",
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
                                SelectableText(
                                  "ស្ថិតក្នុងសាខា",
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
                                SelectableText(
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
                                SelectableText(
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
                      rows: List.generate(shiftcontrolller.shift.length, (
                        index,
                      ) {
                        final shift = shiftcontrolller.shift[index];
                        return DataRow(
                          cells: [
                            // លរ (Index)
                            DataCell(
                              Center(
                                child: SelectableText(
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
                                return shiftcontrolller.editingIndex.value ==
                                        index
                                    ? SizedBox(
                                        width: 220,
                                        child: CustomTextField(
                                          controller:
                                              shiftcontrolller.nameController,
                                          hintText: "",
                                          onSubmitted: (Value) async {
                                            await shiftcontrolller.updateshift(
                                              branchid: shiftcontrolller
                                                  .selectbranchid
                                                  .value!,
                                              name: shiftcontrolller
                                                  .nameController
                                                  .text,
                                              shiftid: shift.id!,
                                            );
                                            shiftcontrolller
                                                    .editingIndex
                                                    .value =
                                                null;
                                          },
                                        ),
                                      )
                                    : GestureDetector(
                                        onDoubleTap: () {
                                          shiftcontrolller.startEdit(
                                            index,
                                            shift,
                                          );
                                        },
                                        child: SelectableText(
                                          shift.name ?? "អត់មាន",
                                          style: TextStyles.siemreap(
                                            context,
                                            fontSize: 15,
                                          ),
                                        ),
                                      );
                              }),
                            ),
                            // Latitude
                            DataCell(
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Obx(() {
                                  return shiftcontrolller.editingIndex.value ==
                                          index
                                      ? SizedBox(
                                          width: 220,
                                          child: CustomDropdown(
                                            selectedValue:
                                                shiftcontrolller.selectbranchid,
                                            items: branchcontroller.branch,
                                            hintText: "",
                                            onChanged: (value) async {
                                              await shiftcontrolller.updateshift(
                                                branchid: shiftcontrolller
                                                    .selectbranchid
                                                    .value!,
                                                name: shiftcontrolller
                                                    .nameController
                                                    .text,
                                                shiftid: shift.id!,
                                              );
                                              shiftcontrolller
                                                      .editingIndex
                                                      .value =
                                                  null;
                                            },
                                          ),
                                        )
                                      : GestureDetector(
                                        onDoubleTap: () {
                                          shiftcontrolller.startEdit(
                                            index,
                                            shift,
                                          );
                                        },
                                        child: SelectableText(
                                            shift.branchName ?? "-",
                                            style: TextStyles.siemreap(
                                              context,
                                              fontSize: 15,
                                            ),
                                          ),
                                      );
                                }),
                              ),
                            ),

                            // Status
                            DataCell(
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: (shift.isActive == true)
                                      ? Colors.green.withOpacity(0.2)
                                      : Colors.red.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  (shift.isActive == true) ? "សកម្ម" : "អសកម្ម",
                                  style: TextStyles.siemreap(
                                    context,
                                    fontSize: 15,
                                    color: (shift.isActive == true)
                                        ? Colors.green
                                        : Colors.red,
                                  ),
                                ),
                              ),
                            ),

                            DataCell(
                              Obx(() {
                                final isEditing =
                                    shiftcontrolller.editingIndex.value ==
                                    index;

                                return Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if (isEditing) ...[
                                      // ✅ Save
                                      IconButton(
                                        onPressed: () async {
                                          await shiftcontrolller.updateshift(
                                            branchid: shiftcontrolller
                                                .selectbranchid
                                                .value!,
                                            name: shiftcontrolller
                                                .nameController
                                                .text,
                                            shiftid: shift.id!,
                                          );
                                          shiftcontrolller.editingIndex.value =
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
                                          shiftcontrolller.editingIndex.value =
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
                                          shiftcontrolller.startEdit(
                                            index,
                                            shift,
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
                                            shiftcontrolller.changestatusshift(
                                              shiftid: shift.id!,
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
          showCreateShift(context);
        },
      ),
    );
  }

  void showCreateShift(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Builder(
          builder: (_) {
            final nameController = TextEditingController();
            final selectbranchid = Rxn<int>();

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
                            "បង្កើតវ៉េនធ្វេីការថ្មី",
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
                              "ឈ្មោះវ៉េនធ្វេីការ",
                              style: TextStyles.siemreap(context, fontSize: 12),
                            ),
                          ),
                          const SizedBox(height: 8),
                          CustomTextField(
                            controller: nameController,
                            prefixIcon: Icons.home,
                            hintText:
                                "ឈ្មោះវេនធ្វើការ (ឧ. សម្រាប់បុគ្គលិកពេញសិទ្ធ)",
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'សូមបញ្ចូលឈ្មោះវេនធ្វើការ';
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
                              "ស្ថិតក្នុងសាខា",
                              style: TextStyles.siemreap(context, fontSize: 12),
                            ),
                          ),

                          const SizedBox(height: 15),

                          CustomDropdown(
                            selectedValue: selectbranchid,
                            items: branchcontroller.branch,
                            hintText: "ជ្រេីសរេីសសាខា",
                            onChanged: (value) {
                              selectbranchid.value = value;
                            },
                          ),

                          const SizedBox(height: 20),

                          // Button
                          CustomElevatedButton(
                            text: "រក្សាទុក",
                            onPressed: () async {
                              if (!formKey.currentState!.validate()) return;

                              await shiftcontrolller.createshift(
                                name: nameController.text.trim(),
                                branchid: selectbranchid.value!,
                              );
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
