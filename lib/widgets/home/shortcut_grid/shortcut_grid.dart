import "package:connector/constants/colors_constants.dart";
import "package:connector/models/dashboard/chart/finance_model.dart";
import "package:connector/widgets/home/chart/finance_bar_chart.dart";
import "package:flutter/material.dart";
import "package:flutter_image_stack/flutter_image_stack.dart";
import "package:get/get.dart";
import "package:horizon/widgets/builders/custom_list_view.dart";
import "package:horizon/widgets/containers/custom_container.dart";
import "package:horizon/widgets/media/custom_media_viewer.dart";
import "package:horizon/widgets/texts/custom_text.dart";
import "package:horizon/widgets/texts/custom_text_rich.dart";
import "package:reorderable_grid_view/reorderable_grid_view.dart";
import "package:simple_ripple_animation/simple_ripple_animation.dart";

class ShortcutGrid extends StatelessWidget {
  const ShortcutGrid({
    required this.rxOrder,
    required this.onReorder,
    super.key,
  });
  final RxList<String> rxOrder;
  final void Function(int, int) onReorder;

  Widget buildWidget(String key, BuildContext context) {
    switch (key) {
      case "wellbeing":
        return wellBeingWidget(context);
      case "community":
        return communityWidget(context);
      case "calendar":
        return calendarWidget(context);
      case "scout":
        return scoutAndContributeWidget(context);
      case "medview":
        return medViewWidget(context);
      case "finance":
        return financeWidget(context);
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ReorderableGridView.builder(
        itemCount: rxOrder.length,
        itemBuilder: (BuildContext context, int index) {
          final String key = rxOrder[index];

          return KeyedSubtree(
            key: ValueKey<String>(key),
            child: buildWidget(key, context),
          );
        },
        onReorder: onReorder,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        shrinkWrap: true,
        controller: ScrollController(),
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        physics: const NeverScrollableScrollPhysics(),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        dragEnabled: true,
        onDragStart: (int dragIndex) {},
        onDragUpdate: (int dragIndex, Offset position, Offset delta) {},
        dragWidgetBuilderV2: DragWidgetBuilderV2(
          isScreenshotDragWidget: true,
          builder: (int index, Widget child, ImageProvider? screenshot) {
            if (screenshot == null) {
              return child;
            }

            return Image(image: screenshot);
          },
        ),
      );
    });
  }

  Widget wellBeingWidget(BuildContext context) {
    return CustomContainer(
      padding: const EdgeInsets.all(8.0),
      child: AspectRatio(
        aspectRatio: 3 / 3,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      CustomText(
                        data: "Well-being",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                CustomContainer(
                  borderRadius: BorderRadius.circular(360),
                  child: const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Icon(Icons.open_in_new, size: 16),
                  ),
                ),
              ],
            ),
            Expanded(child: wellBeingWidgetDependent(context, 3)),
          ],
        ),
      ),
    );
  }

  Widget communityWidget(BuildContext context) {
    return CustomContainer(
      padding: const EdgeInsets.all(8.0),
      child: AspectRatio(
        aspectRatio: 3 / 3,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      CustomText(
                        data: "Community",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                CustomContainer(
                  borderRadius: BorderRadius.circular(360),
                  child: const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Icon(Icons.open_in_new, size: 16),
                  ),
                ),
              ],
            ),
            Expanded(child: communityWidgetDependent(context, 3)),
          ],
        ),
      ),
    );
  }

  Widget calendarWidget(BuildContext context) {
    return CustomContainer(
      padding: const EdgeInsets.all(8.0),
      child: AspectRatio(
        aspectRatio: 3 / 3,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      CustomText(
                        data: "Calendar",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                CustomContainer(
                  borderRadius: BorderRadius.circular(360),
                  child: const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Icon(Icons.open_in_new, size: 16),
                  ),
                ),
              ],
            ),
            Expanded(child: calendarWidgetDependent(context, 3)),
          ],
        ),
      ),
    );
  }

  Widget scoutAndContributeWidget(BuildContext context) {
    return CustomContainer(
      padding: const EdgeInsets.all(8.0),
      child: AspectRatio(
        aspectRatio: 3 / 3,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      CustomText(
                        data: "Scout & Contribute",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                CustomContainer(
                  borderRadius: BorderRadius.circular(360),
                  child: const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Icon(Icons.open_in_new, size: 16),
                  ),
                ),
              ],
            ),
            Expanded(child: scoutAndContributeWidgetDependent(context, 3)),
          ],
        ),
      ),
    );
  }

  Widget medViewWidget(BuildContext context) {
    return CustomContainer(
      padding: const EdgeInsets.all(8.0),
      child: AspectRatio(
        aspectRatio: 3 / 3,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      CustomText(
                        data: "Med View",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                CustomContainer(
                  borderRadius: BorderRadius.circular(360),
                  child: const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Icon(Icons.open_in_new, size: 16),
                  ),
                ),
              ],
            ),
            Expanded(child: medViewWidgetDependent(context, 3)),
            const CustomTextRich(
              textSpan: TextSpan(
                children: <InlineSpan>[
                  TextSpan(
                    text: "Last updated: ",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  TextSpan(
                    text: "31st Aug 2024",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }

  Widget financeWidget(BuildContext context) {
    return CustomContainer(
      padding: const EdgeInsets.all(8.0),
      child: AspectRatio(
        aspectRatio: 3 / 3,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      CustomText(
                        data: "Finance",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                CustomContainer(
                  borderRadius: BorderRadius.circular(360),
                  child: const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Icon(Icons.open_in_new, size: 16),
                  ),
                ),
              ],
            ),
            Expanded(child: financeWidgetDependent(context, 3)),
          ],
        ),
      ),
    );
  }

  //

  Widget wellBeingWidgetDependent(BuildContext context, int length) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CustomTextRich(
          textSpan: TextSpan(
            children: <InlineSpan>[
              TextSpan(
                text: "$length",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const TextSpan(
                text: " goals today",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
              ),
            ],
          ),
          maxLines: 1,
        ),
        const SizedBox(height: 8),
        Expanded(
          child: CustomListView<String>(
            items: List<String>.generate(length, (int index) {
              return "Goal ${index + 1}";
            }),
            itemBuilder: (BuildContext context, int index, String item) {
              Color color = ColorsConstants().transparent;

              switch (index) {
                case 0:
                  color = ColorsConstants().blue;
                  break;

                case 1:
                  color = ColorsConstants().green;
                  break;

                case 2:
                  color = ColorsConstants().red;
                  break;
              }

              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(
                        height: kToolbarHeight - 16,
                        width: kToolbarHeight - 16,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(color),
                          backgroundColor: Theme.of(
                            context,
                          ).hintColor.withValues(alpha: 0.24),
                          padding: const EdgeInsets.all(2.0),
                          value: (index + 1) / length,
                          strokeWidth: 2,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: CustomText(
                          data: item,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget communityWidgetDependent(BuildContext context, int length) {
    final List<String> guestsList = List<String>.generate(10, (int index) {
      return "People $index";
    });

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CustomTextRich(
          textSpan: TextSpan(
            children: <InlineSpan>[
              TextSpan(
                text: "$length",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const TextSpan(
                text: " events today",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
              ),
            ],
          ),
          maxLines: 1,
        ),
        const SizedBox(height: 8),
        Expanded(
          child: CustomListView<String>(
            items: List<String>.generate(length, (int index) {
              return "Goal ${index + 1}";
            }),
            itemBuilder: (BuildContext context, int index, String item) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      CustomText(
                        data: "Event ${index + 1}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 0),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: FlutterImageStack(
                          imageList: List<String>.generate(guestsList.length, (
                            int index,
                          ) {
                            final String displayName = guestsList[index];

                            return "https://ui-avatars.com/api/?name=$displayName";
                          }),
                          totalCount: guestsList.length,
                          itemRadius: 32,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget calendarWidgetDependent(BuildContext context, int length) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const CustomTextRich(
          textSpan: TextSpan(
            children: <InlineSpan>[
              TextSpan(
                text: "Saturday",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
              ),
            ],
          ),
          maxLines: 1,
        ),
        CustomTextRich(
          textSpan: TextSpan(
            children: <InlineSpan>[
              TextSpan(
                text: "$length",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const TextSpan(
                text: " september, 2025",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
              ),
            ],
          ),
          maxLines: 1,
        ),
        const SizedBox(height: 8),
        Expanded(
          child: CustomListView<String>(
            items: List<String>.generate(length, (int index) {
              return "Medical ${index + 1}";
            }),
            itemBuilder: (BuildContext context, int index, String item) {
              Color color = ColorsConstants().transparent;

              switch (index) {
                case 0:
                  color = ColorsConstants().blue;
                  break;

                case 1:
                  color = ColorsConstants().green;
                  break;

                case 2:
                  color = ColorsConstants().red;
                  break;
              }

              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(
                        height: kToolbarHeight / 2,
                        child: VerticalDivider(
                          radius: BorderRadius.circular(360),
                          width: 4,
                          thickness: 4,
                          color: color,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: CustomText(
                          data: item,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget scoutAndContributeWidgetDependent(BuildContext context, int length) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CustomTextRich(
          textSpan: TextSpan(
            children: <InlineSpan>[
              TextSpan(
                text: "$length",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const TextSpan(
                text: " new opportunities",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
              ),
            ],
          ),
          maxLines: 1,
        ),
        const SizedBox(height: 8),
        Expanded(
          child: CustomListView<String>(
            items: List<String>.generate(length, (int index) {
              return "Goal ${index + 1}";
            }),
            itemBuilder: (BuildContext context, int index, String item) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  CustomContainer(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ClipOval(
                          child: SizedBox(
                            height: kToolbarHeight - 24,
                            width: kToolbarHeight - 24,
                            child: CustomMediaViewer(
                              data: "https://ui-avatars.com/api/?name=$item",
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const CustomTextRich(
                                textSpan: TextSpan(
                                  children: <InlineSpan>[
                                    TextSpan(
                                      text: "Name",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    TextSpan(
                                      text: " | ",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    TextSpan(
                                      text: "22",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                maxLines: 1,
                              ),
                              const SizedBox(height: 4),
                              CustomListView<String>(
                                scrollDirection: Axis.horizontal,
                                items: List<String>.generate(5, (int index) {
                                  return "Item ${index + 1}";
                                }),
                                itemBuilder:
                                    (
                                      BuildContext context,
                                      int index,
                                      String item,
                                    ) {
                                      return CustomContainer(
                                        padding: const EdgeInsets.all(4.0),
                                        margin: const EdgeInsets.only(
                                          right: 8.0,
                                        ),
                                        child: CustomText(
                                          data: item,
                                          style: const TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.normal,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      );
                                    },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget medViewWidgetDependent(BuildContext context, int length) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CustomTextRich(
          textSpan: TextSpan(
            children: <InlineSpan>[
              TextSpan(
                text: "$length",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const TextSpan(
                text: " medications today",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
              ),
            ],
          ),
          maxLines: 1,
        ),
        const SizedBox(height: 8),
        Expanded(
          child: CustomListView<String>(
            items: List<String>.generate(length, (int index) {
              return "Medical ${index + 1}";
            }),
            itemBuilder: (BuildContext context, int index, String item) {
              Color color = ColorsConstants().transparent;

              switch (index) {
                case 0:
                  color = ColorsConstants().blue;
                  break;

                case 1:
                  color = ColorsConstants().green;
                  break;

                case 2:
                  color = ColorsConstants().red;
                  break;
              }

              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      RippleAnimation(
                        repeat: true,
                        ripplesCount: 0,
                        color: color,
                        minRadius: 16,
                        maxRadius: 16,
                        delay: const Duration(seconds: 1),
                        child: CircleAvatar(
                          foregroundColor: color,
                          backgroundColor: ColorsConstants().transparent,
                          minRadius: 16,
                          maxRadius: 16,
                          child: const Icon(Icons.circle, size: 16),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: CustomText(
                          data: item,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget financeWidgetDependent(BuildContext context, int length) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CustomTextRich(
          textSpan: TextSpan(
            children: <InlineSpan>[
              TextSpan(
                text: "$length",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const TextSpan(
                text: " Major spends found",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
              ),
            ],
          ),
          maxLines: 1,
        ),
        const SizedBox(height: 8),
        Expanded(child: FinanceBarChart(rxBars: sampleChartDataFinancial.obs)),
      ],
    );
  }
}
