import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_posresto_app/presentation/setting/bloc/discount/discount_bloc.dart';
import '../../home/widgets/custom_tab_bar.dart';
import '../dialogs/form_discount_dialog.dart';
import '../models/discount_model.dart';
import '../widgets/add_data.dart';
import '../widgets/manage_discount_card.dart';
import '../widgets/settings_title.dart';

class DiscountPage extends StatefulWidget {
  const DiscountPage({super.key});

  @override
  State<DiscountPage> createState() => _DiscountPageState();
}

class _DiscountPageState extends State<DiscountPage> {
  void onEditTap(DiscountModel item) {
    showDialog(
      context: context,
      builder: (context) => FormDiscountDialog(data: item),
    );
  }

  void onAddDataTap() {
    showDialog(
      context: context,
      builder: (context) => const FormDiscountDialog(),
    );
  }

  @override
  void initState() {
    context.read<DiscountBloc>().add(const DiscountEvent.getDiscount());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SettingsTitle('Kelola Diskon'),
          const SizedBox(height: 24),
          CustomTabBar(
              tabTitles: const ['Semua'],
              initialTabIndex: 0,
              tabViews: [
                // SEMUA TAB
                SizedBox(
                  child: BlocBuilder<DiscountBloc, DiscountState>(
                    builder: (context, state) {
                      return state.maybeWhen(
                        orElse: () {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                        laoded: (discounts) {
                          return GridView.builder(
                            shrinkWrap: true,
                            itemCount: discounts.length + 1,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 0.85,
                              crossAxisCount: 3,
                              crossAxisSpacing: 30.0,
                              mainAxisSpacing: 30.0,
                            ),
                            itemBuilder: (context, index) {
                              if (index == 0) {
                                return AddData(
                                  title: 'Tambah Diskon Baru',
                                  onPressed: onAddDataTap,
                                );
                              }
                              final item = discounts[index - 1];
                              return ManageDiscountCard(
                                data: item,
                                onEditTap: () {},
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ]),
        ],
      ),
    );
  }
}
