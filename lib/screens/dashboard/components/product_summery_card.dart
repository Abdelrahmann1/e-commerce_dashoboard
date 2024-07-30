import 'package:admin/screens/dashboard/components/product_details_page.dart';
import 'package:admin/screens/dashboard/components/product_summery_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../Getx/Products/models.dart';
import '../../../utility/constants.dart';
import '../../../models/product_summery_info.dart';


// class ProductSummeryCard extends StatelessWidget {
//   const ProductSummeryCard({
//     Key? key,
//     required this.info, required this.onTap,
//   }) : super(key: key);
//
//   final ProductSummeryInfo info;
//   final Function(String?) onTap;
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: (){
//         onTap(info.title);
//       },
//       child: Container(
//         padding: EdgeInsets.all(defaultPadding),
//         decoration: BoxDecoration(
//           color: secondaryColor,
//           borderRadius: const BorderRadius.all(Radius.circular(10)),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Container(
//                   padding: EdgeInsets.all(defaultPadding * 0.75),
//                   height: 40,
//                   width: 40,
//                   decoration: BoxDecoration(
//                     color: info.color!.withOpacity(0.1),
//                     borderRadius: const BorderRadius.all(Radius.circular(10)),
//                   ),
//                   child: SvgPicture.asset(
//                     info.svgSrc!,
//                     colorFilter: ColorFilter.mode(
//                         info.color ?? Colors.black, BlendMode.srcIn),
//                   ),
//                 ),
//                 Icon(Icons.more_vert, color: Colors.white54)
//               ],
//             ),
//             Text(
//               info.title!,
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//             ),
//             ProgressLine(
//               color: info.color,
//               percentage: info.percentage,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   "${info.productsCount} Product",
//                   style: Theme.of(context)
//                       .textTheme
//                       .bodySmall!
//                       .copyWith(color: Colors.white70),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

class ProductSummaryCards extends StatelessWidget {
  const ProductSummaryCards({
    Key? key,
    required this.summary,
    //required this.product,
    required this.onTap,
  }) : super(key: key);

  final ProductSummary summary;
  final Function(ProductCategory) onTap;
  //final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(summary.category),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(8.0),
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: summary.color.withOpacity(0.1),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: SvgPicture.asset(
                    summary.svgSrc,
                    colorFilter: ColorFilter.mode(summary.color, BlendMode.srcIn),
                  ),
                ),
                const Icon(Icons.more_vert, color: Colors.white54)
              ],
            ),
            Text(
              summary.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            ProgressLine(
              color: summary.color,
              percentage: summary.percentage,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${summary.count} Products",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.white70),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
class ProductSummeryCard extends StatelessWidget {
  const ProductSummeryCard({
    Key? key,
    required this.info,
    required this.onTap,
  }) : super(key: key);

  final ProductSummeryInfo info;
  final Function(String?) onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap(info.title);
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => ProductDetailsPage(info: info),
        //   ),
        // );
      },
      child: Container(
        padding: EdgeInsets.all(defaultPadding),
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(defaultPadding * 0.75),
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: info.color!.withOpacity(0.1),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: SvgPicture.asset(
                    info.svgSrc!,
                    colorFilter: ColorFilter.mode(
                        info.color ?? Colors.black, BlendMode.srcIn),
                  ),
                ),
                Icon(Icons.more_vert, color: Colors.white54),
              ],
            ),
            Text(
              info.title!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            ProgressLine(
              color: info.color,
              percentage: info.percentage,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${info.productsCount} Products",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: Colors.white70),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ProgressLine extends StatelessWidget {
  const ProgressLine({
    Key? key,
    this.color = primaryColor,
    required this.percentage,
  }) : super(key: key);

  final Color? color;
  final double? percentage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 5,
          decoration: BoxDecoration(
            color: color!.withOpacity(0.1),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        LayoutBuilder(
          builder: (context, constraints) => Container(
            width: constraints.maxWidth * (percentage! / 100),
            height: 5,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
      ],
    );
  }
}
