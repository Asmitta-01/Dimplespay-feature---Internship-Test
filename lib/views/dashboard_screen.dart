import 'package:dimplespay_feature_implementation/controllers/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardScreen extends GetView<DashboardController> {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(builder: (controller) {
      return Scaffold(
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 48),
          shrinkWrap: true,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: CircleAvatar(
                radius: 18,
                backgroundColor: Get.theme.colorScheme.primary,
                child: Icon(
                  Icons.person_outline_rounded,
                  color: Get.theme.colorScheme.onPrimary,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              "Account",
              style: Get.textTheme.headlineMedium,
            ),
            const SizedBox(height: 12),
            _buildWalletCard(),
            const SizedBox(height: 24),
            Row(
              textBaseline: TextBaseline.alphabetic,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              children: [
                Text(
                  "Transactions",
                  style: Get.textTheme.headlineSmall!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                InkWell(
                  onTap: controller.goToTransactionsScreen,
                  child: Text(
                    "See all",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Get.theme.colorScheme.onSurface.withOpacity(.5),
                    ),
                  ),
                )
              ],
            ),
            _buildTransactionList()
          ],
        ),
      );
    });
  }

  ListView _buildTransactionList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(top: 12),
      itemCount: controller.transactions.length,
      itemBuilder: (context, index) {
        String type = controller.transactions[index].type;
        String status = controller.transactions[index].status;
        return Opacity(
          opacity: status == 'failed' ? .5 : 1,
          child: ListTile(
            visualDensity: VisualDensity.compact,
            contentPadding: EdgeInsets.zero,
            leading: Stack(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor:
                      Get.theme.colorScheme.primary.withOpacity(.1),
                  child: Icon(
                    type == 'transfer'
                        ? Icons.sync_alt_outlined
                        : type == 'refund'
                            ? Icons.arrow_downward
                            : type == 'topup'
                                ? Icons.add
                                : Icons.payment,
                    color: Get.theme.colorScheme.primary,
                  ),
                ),
                if (status == 'pending')
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Get.theme.colorScheme.primary,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.timelapse,
                        size: 12,
                        color: Get.theme.colorScheme.onPrimary,
                      ),
                    ),
                  )
              ],
            ),
            title: Text(
              controller.transactions[index].description,
              overflow: TextOverflow.ellipsis,
              style: Get.textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Row(
              children: [
                Text(
                  controller.transactions[index].status.capitalize!,
                  style: Get.textTheme.bodySmall!.copyWith(
                    color: Get.theme.colorScheme.onSurface.withOpacity(.5),
                  ),
                ),
                const SizedBox(width: 4),
                const Text('•'),
                const SizedBox(width: 4),
                Text(
                  "Yesterday",
                  style: Get.textTheme.bodySmall!.copyWith(
                    color: Get.theme.colorScheme.onSurface.withOpacity(.5),
                  ),
                ),
              ],
            ),
            trailing: Text(
              "CFA ${controller.transactions[index].amount}",
              style: Get.textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildWalletCard() {
    return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Get.theme.colorScheme.surface,
          boxShadow: [
            BoxShadow(
              blurRadius: 3,
              color: Get.theme.colorScheme.onSurface.withOpacity(.15),
            )
          ],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "CFA 20,120.3",
              style: Get.textTheme.headlineSmall!
                  .copyWith(fontWeight: FontWeight.w600),
            ),
            const Text("Central African Franc"),
            const SizedBox(height: 18),
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: () {},
                  label: const Text("Add Money"),
                  icon: const Icon(Icons.add, size: 20),
                  iconAlignment: IconAlignment.start,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Get.theme.colorScheme.primary.withOpacity(.1),
                    foregroundColor: Get.theme.colorScheme.primary,
                    textStyle: Get.textTheme.labelLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton.icon(
                  onPressed: controller.transfer,
                  label: const Text("Transfer"),
                  icon: const Icon(Icons.sync_alt_outlined, size: 20),
                  iconAlignment: IconAlignment.start,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Get.theme.colorScheme.primary.withOpacity(.1),
                    foregroundColor: Get.theme.colorScheme.primary,
                    textStyle: Get.textTheme.labelLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    iconAlignment: IconAlignment.start,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Get.theme.colorScheme.primary.withOpacity(.1),
                      foregroundColor: Get.theme.colorScheme.primary,
                      textStyle: Get.textTheme.labelLarge!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    child: const Icon(Icons.more_horiz, size: 20),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}