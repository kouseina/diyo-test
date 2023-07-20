// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:diyo_test/enum.dart';
import 'package:diyo_test/features/main/entity/menu_entity.dart';
import 'package:diyo_test/features/main/entity/table_entity.dart';
import 'package:flutter/material.dart';

class OrderPage extends StatefulWidget {
  OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final tableList = List.generate(
      6,
      (index) => TableEntity(
          status: TableStatus.available, id: index + 1, menuList: []));
  final menuList = List.generate(
      9,
      (index) => MenuEntity(
          id: index + 1, price: Random().nextInt(20) + 10, quantity: 0));

  TableEntity? tableActived;
  bool isMenu = false;

  int getTotalPriceActived() {
    int total = 0;

    for (MenuEntity element in tableActived?.menuList ?? []) {
      total += element.price * element.quantity;
    }

    return total;
  }

  @override
  Widget build(BuildContext context) {
    Widget rightSideWidget() {
      Widget content(TableStatus? tableStatus) {
        Widget button(
            {required String title, required void Function()? onPressed}) {
          return SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ButtonStyle(
                padding: const MaterialStatePropertyAll(EdgeInsets.all(20)),
                backgroundColor: MaterialStatePropertyAll(Colors.red.shade400),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
              onPressed: onPressed,
              child: Text(
                title,
                style: const TextStyle(fontSize: 25),
              ),
            ),
          );
        }

        switch (tableStatus) {
          case TableStatus.available:
            return Column(
              children: [
                const Text(
                  'Action',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                button(
                  title: "Print QR",
                  onPressed: () {
                    TableEntity getTableById = tableList
                        .where((element) => element.id == tableActived?.id)
                        .first;

                    setState(() {
                      getTableById.status = TableStatus.seated;
                      tableActived?.status = TableStatus.seated;
                    });
                  },
                ),
              ],
            );
          case TableStatus.seated:
            if (isMenu) {
              return Column(
                children: [
                  const Text(
                    'Ordered Menu',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: tableActived?.menuList.length,
                    itemBuilder: (context, index) {
                      var item = tableActived?.menuList[index];

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Row(
                          children: [
                            Text(
                              "Menu ${item?.id}  x  ${item?.quantity}  Rp. ${item?.price}.000",
                              style: const TextStyle(fontSize: 18),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            GestureDetector(
                              onTap: () {
                                TableEntity getTableById = tableList
                                    .where((element) =>
                                        element.id == tableActived?.id)
                                    .first;

                                setState(() {
                                  getTableById.menuList.removeWhere(
                                      (element) => element.id == item?.id);
                                  tableActived?.menuList.removeWhere(
                                      (element) => element.id == item?.id);
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.red.shade400),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.remove,
                                  color: Colors.red.shade400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  if (tableActived?.menuList.isNotEmpty ?? false)
                    Column(
                      children: [
                        Text(
                          "Total : Rp. ${getTotalPriceActived()}.000",
                          style: const TextStyle(
                            fontSize: 28,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        button(
                          title: "Add Order",
                          onPressed: () {
                            TableEntity getTableById = tableList
                                .where(
                                    (element) => element.id == tableActived?.id)
                                .first;

                            setState(() {
                              isMenu = false;
                              getTableById.status = TableStatus.ordered;
                              tableActived?.status = TableStatus.ordered;
                            });
                          },
                        ),
                      ],
                    ),
                ],
              );
            } else {
              return button(
                title: "Make an Order",
                onPressed: () {
                  setState(() {
                    isMenu = true;
                  });
                },
              );
            }
          case TableStatus.ordered:
            return Column(
              children: [
                const Text(
                  'Ordered Menu',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: tableActived?.menuList.length,
                  itemBuilder: (context, index) {
                    var item = tableActived?.menuList[index];

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Row(
                        children: [
                          Text(
                            "Menu ${item?.id}  x  ${item?.quantity}  Rp. ${item?.price}.000",
                            style: const TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 60,
                ),
                if (tableActived?.menuList.isNotEmpty ?? false)
                  Column(
                    children: [
                      Text(
                        "Total : Rp. ${getTotalPriceActived()}.000",
                        style: const TextStyle(
                          fontSize: 28,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Divider(
                        height: 4,
                        color: Colors.black87,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      button(
                        title: "Add Order",
                        onPressed: () {
                          TableEntity getTableById = tableList
                              .where(
                                  (element) => element.id == tableActived?.id)
                              .first;

                          setState(() {
                            isMenu = true;
                            getTableById.status = TableStatus.seated;
                            tableActived?.status = TableStatus.seated;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      button(
                        title: "Billing",
                        onPressed: () {
                          TableEntity getTableById = tableList
                              .where(
                                  (element) => element.id == tableActived?.id)
                              .first;

                          setState(() {
                            getTableById.status = TableStatus.billing;
                            tableActived?.status = TableStatus.billing;
                          });
                        },
                      ),
                    ],
                  ),
              ],
            );
          case TableStatus.billing:
            PaymentMethod? groupValue = PaymentMethod.cash;

            return Column(
              children: [
                const Text(
                  'Action',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                ListTile(
                  leading: Radio<PaymentMethod>(
                    value: PaymentMethod.cash,
                    groupValue: groupValue,
                    onChanged: (value) {
                      setState(() {
                        groupValue = value;
                      });
                    },
                  ),
                  title: Text(
                    PaymentMethod.cash.getTitle(),
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                ListTile(
                  leading: Radio<PaymentMethod>(
                    value: PaymentMethod.creditCard,
                    groupValue: groupValue,
                    onChanged: (value) {
                      setState(() {
                        groupValue = value;
                      });
                    },
                  ),
                  title: Text(
                    PaymentMethod.creditCard.getTitle(),
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                ListTile(
                  leading: Radio<PaymentMethod>(
                    value: PaymentMethod.debitCard,
                    groupValue: groupValue,
                    onChanged: (value) {
                      setState(() {
                        groupValue = value;
                      });
                    },
                  ),
                  title: Text(
                    PaymentMethod.debitCard.getTitle(),
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                ListTile(
                  leading: Radio<PaymentMethod>(
                    value: PaymentMethod.qris,
                    groupValue: groupValue,
                    onChanged: (value) {
                      setState(() {
                        groupValue = value;
                      });
                    },
                  ),
                  title: Text(
                    PaymentMethod.qris.getTitle(),
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                button(
                  title: "Payment",
                  onPressed: () {
                    TableEntity getTableById = tableList
                        .where((element) => element.id == tableActived?.id)
                        .first;

                    setState(() {
                      getTableById.status = TableStatus.available;
                      tableActived?.status = TableStatus.available;
                    });
                  },
                ),
              ],
            );
          default:
            return const SizedBox();
        }
      }

      return Container(
        height: double.infinity,
        width: tableActived != null ? 350 : 0,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black87,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
            child: Column(
              children: [
                Text(
                  'Table ${tableActived?.id}',
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 25,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Status : ${tableActived?.status.name}',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                content(tableActived?.status),
              ],
            ),
          ),
        ),
      );
    }

    return Row(
      children: [
        if (isMenu)
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(40),
                child: Wrap(
                  children: menuList.asMap().entries.map((e) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 40, bottom: 40),
                      child: InkWell(
                        onTap: () {
                          TableEntity getTableById = tableList
                              .where(
                                  (element) => element.id == tableActived?.id)
                              .first;

                          List<MenuEntity> getMenuById = getTableById.menuList
                              .where((element) => element.id == e.value.id)
                              .toList();

                          setState(() {
                            if (getMenuById.isEmpty) {
                              getTableById.menuList.add(e.value..quantity = 1);
                            } else {
                              getMenuById.first.quantity += 1;
                            }

                            tableActived = getTableById;
                          });
                        },
                        child: Container(
                          height: 130,
                          width: 130,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                          ),
                          child: Center(
                            child: Text(
                              "Menu ${e.value.id}",
                              style: const TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          )
        else
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(40),
                child: Column(
                  children: [
                    Wrap(
                      children: tableList.asMap().entries.map((e) {
                        TableEntity item = e.value;

                        return Padding(
                          padding: const EdgeInsets.only(right: 40, bottom: 40),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                tableActived =
                                    tableActived?.id == item.id ? null : item;
                              });
                            },
                            child: Container(
                              height: 130,
                              width: 130,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: item.status.getBgColor(),
                                border: Border.all(
                                    color: item.status.getTextColor()),
                              ),
                              child: Center(
                                child: Text(
                                  "Table ${e.key + 1}",
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: item.status.getTextColor(),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Column(
                      children: [
                        StatusTile(
                          color: Colors.white,
                          title: "Available",
                        ),
                        StatusTile(
                          color: Colors.red,
                          title: "Seated",
                        ),
                        StatusTile(
                          color: Colors.yellow,
                          title: "Ordered",
                        ),
                        StatusTile(
                          color: Colors.blue,
                          title: "Billing",
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        rightSideWidget(),
      ],
    );
  }
}

class StatusTile extends StatelessWidget {
  final Color color;
  final String title;

  const StatusTile({
    Key? key,
    required this.color,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: color,
              border: Border.all(
                  color: color != Colors.white ? color : Colors.black87),
            ),
          ),
          const SizedBox(
            width: 30,
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 28,
            ),
          ),
        ],
      ),
    );
  }
}
