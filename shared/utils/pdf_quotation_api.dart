import 'package:cpsales/app/model/quote_history.dart';

import 'package:cpsales/app/view/create_quotation/create_quotation_screen.dart';

import 'package:cpsales/shared/utils/file_handler.dart';

import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';

import '../../app/model/quote.dart';
import 'fas.dart';
import 'svg.model.dart';

class PdfQuotationApi {
  static Future generateFromViewTable(
      {required ViewDataSource quoteViewData,
      required ViewDataSourceHistory quoteHistoryData,
      Quote? quote,
      QuoteHistory? quoteHistory,
      required bool isHistory}) async {
    final pdf = pw.Document();

    final tableHeaders = ["Product", "Rate", "Quantity", "Amount"];
    final List<List<dynamic>> tableData;

    final fontData = await rootBundle.load("assets/fonts/Inter-Regular.ttf");
    final semiBoldfontData = await rootBundle.load("assets/fonts/Inter-SemiBold.ttf");

    if (isHistory == true) {
      tableData = quoteHistoryData.products.map((product) {
        return [
          product.productId?.name ?? "", //Product
          rupeesNumberFormat.format((double.parse(
                  product.price?.quoted.toString() ?? "") -
              double.parse(product.productId?.tax?.toString() ?? ""))), // Rate
          product.boughtStock, //Sqft
          rupeesNumberFormat.format(
              ((double.parse(product.price?.quoted.toString() ?? "") -
                      double.parse(product.productId?.tax?.toString() ?? "")) *
                  double.parse(product.boughtStock.toString()))) //Amount
        ];
      }).toList();
    } else {
      tableData = quoteViewData.products.map((product) {
        return [
          product.productId?.name ?? "", //Product
          rupeesNumberFormat.format((double.parse(
                  product.price?.quoted.toString() ?? "") -
              double.parse(product.productId?.tax?.toString() ?? ""))), // Rate
          product.boughtStock, //Sqft
          rupeesNumberFormat.format(
              ((double.parse(product.price?.quoted.toString() ?? "") -
                      double.parse(product.productId?.tax?.toString() ?? "")) *
                  double.parse(product.boughtStock.toString())))
          // (double.parse(product.totalPrice.toString()) -
          //         double.parse(product.price?.tax.toString() ?? ""))
          //     .toString(), //Amount
        ];
      }).toList();
    }

    final double subTotal = isHistory == true
        ? double.parse(quoteHistory!.quoteId!.subTotal.toString())
        : double.parse(quote!.subTotal.toString());
    final double sgst = isHistory == true
        ? double.parse(quoteHistory!.quoteId!.sgst.toString())
        : double.parse(quote!.sgst.toString());
    final double cgst = isHistory == true
        ? double.parse(quoteHistory!.quoteId!.cgst.toString())
        : double.parse(quote!.cgst.toString());
    final double? totalDiscount =
        isHistory == true && quoteHistory!.quoteId?.totalDiscount != null
            ? double.parse(quoteHistory.quoteId!.totalDiscount.toString())
            : quote?.totalDiscount != null
                ? double.parse(quote!.totalDiscount.toString())
                : null;
    final double totalCost = isHistory == true
        ? double.parse(quoteHistory!.quoteId!.totalCost.toString())
        : double.parse(quote!.totalCost.toString());
    final String issuedDate = isHistory == true
        ? DateFormat('dd MMM yyyy').format(quoteHistory!.createdAt!)
        : DateFormat('dd MMM yyyy').format(quote!.createdAt!);

    final String? clientName = isHistory == true
        ? quoteHistory!.leadId!.clientId?.name
        : quote?.leadId?.clientId?.name;

    final String? clientNumber = isHistory == true
        ? quoteHistory!.leadId!.clientId?.phone
        : quote?.leadId?.clientId?.phone;

    final String? clientCity = isHistory == true
        ? quoteHistory!.leadId!.clientId?.location
        : quote?.leadId?.clientId?.location;

    final String? generatedBy = isHistory == true
        ? quoteHistory!.quoteId!.generatedBy?.name
        : quote?.generatedBy?.name;

    final String? generatedByRole = isHistory == true
        ? quoteHistory!.quoteId!.generatedBy?.role
            ?.replaceAll("_", " ")
            .toString()
            .capitalize
        : quote?.generatedBy?.role?.replaceAll("_", " ").toString().capitalize;

    final String? quoteId =
        isHistory == true ? quoteHistory!.quoteId?.uniqueId : quote!.uniqueId;

    // Load the image from the asset folder
    final svgImage = pw.SvgImage(svg: svgRaw);

    pdf.addPage(
      pw.MultiPage(
        build: (context) => [
          // Your PDF content here
          pw.SizedBox(height: 8),
          pw.Container(
            height: 75,
            width: 100,
            child: svgImage,
          ),
          pw.SizedBox(height: 8),

          pw.Row(children: [
            pw.Expanded(
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text("Quotation To",
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                      )),
                  pw.SizedBox(
                    height: 8,
                  ),
                  pw.Text(clientName ?? ""),
                  pw.SizedBox(
                    height: 4,
                  ),
                  pw.Text(clientNumber ?? ""),
                  pw.SizedBox(
                    height: 4,
                  ),
                  pw.Text(clientCity ?? ""),
                ],
              ),
            ),
            pw.Spacer(flex: 3),
            pw.Expanded(
                child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text("Created By",
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                    )),
                pw.SizedBox(
                  height: 8,
                ),
                pw.Text(generatedBy ?? ""),
                pw.SizedBox(
                  height: 4,
                ),
                pw.Text(generatedByRole ?? ""),
              ],
            ))
          ]),
          pw.SizedBox(
            height: 16,
          ),
          pw.Header(
            level: 0,
            child: pw.Row(children: [
              pw.Text('Quotation Id: $quoteId'),
              pw.Spacer(),
              pw.Text('Issued On:$issuedDate'),
            ]),
          ),
          pw.TableHelper.fromTextArray(
            headers: tableHeaders,
            data: tableData,
            cellStyle: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
              font: pw.Font.ttf(fontData.buffer.asByteData()),
            ),
            headerStyle: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
            ),
            border: null,
            headerDecoration: const pw.BoxDecoration(color: PdfColors.grey300),
            oddRowDecoration: const pw.BoxDecoration(color: PdfColors.grey200),
            cellAlignments: {
              0: pw.Alignment.centerLeft, // Product
              1: pw.Alignment.centerRight, // Rate
              2: pw.Alignment.centerRight, // Sqft
              3: pw.Alignment.centerRight, // Amount
            },
          ),
          pw.SizedBox(height: 10),
          pw.Container(
            alignment: pw.Alignment.centerRight,
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.end,
              children: [
                pw.Container(
                  alignment: pw.Alignment.centerRight,
                  width: double.infinity,
                  height: 24,
                  decoration: const pw.BoxDecoration(color: PdfColors.grey200),
                  child:
                  pw.Padding(
                    padding: const pw.EdgeInsets.only(right:2.5),
                    child: pw.Text(
                    'Sub Total:  ${rupeesNumberFormat.format(subTotal)} ',
                    style: pw.TextStyle(
                      font: pw.Font.ttf(fontData.buffer
                          .asByteData()), // Specify the custom font
                    ),
                  ),)
                ),
                pw.Container(
                  alignment: pw.Alignment.centerRight,
                  height: 24,
                  child:
                  pw.Padding(
                    padding: const pw.EdgeInsets.only(right:2.5),
                    child: pw.Text(
                    'SGST:  ${rupeesNumberFormat.format(sgst)} ',
                    style: pw.TextStyle(
                      font: pw.Font.ttf(fontData.buffer
                          .asByteData()), // Specify the custom font
                    ),
                  ),)
                ),
                pw.Container(
                  alignment: pw.Alignment.centerRight,
                  width: double.infinity,
                  height: 24,
                  decoration: const pw.BoxDecoration(color: PdfColors.grey200),
                  child:pw.Padding(
                    padding: const pw.EdgeInsets.only(right:2.5),
                    child:
                   pw.Text(
                    'CGST:  ${rupeesNumberFormat.format(cgst)} ',
                    style: pw.TextStyle(
                      font: pw.Font.ttf(fontData.buffer
                          .asByteData()), // Specify the custom font
                    ),
                  ),)
                ),
                (quoteHistory?.quoteId?.totalDiscount != null ||
                        quote?.totalDiscount != null)
                    ? pw.Container(
                        alignment: pw.Alignment.centerRight,
                        width: double.infinity,
                        height: 24,
                        child:pw.Padding(
                    padding: const pw.EdgeInsets.only(right:2.5),
                    child:
                         pw.Text(
                          'Discount Amount: -${rupeesNumberFormat.format(totalDiscount)} ',
                          style: pw.TextStyle(
                            font: pw.Font.ttf(fontData.buffer
                                .asByteData()), // Specify the custom font
                          ),
                        ),)
                      )
                    : pw.SizedBox(height: 0),
                pw.Container(
                  alignment: pw.Alignment.centerRight,
                  height: 24,
                  width: double.infinity,
                  decoration: pw.BoxDecoration(
                      color: totalDiscount != null
                          ? PdfColors.grey200
                          : PdfColors.white),
                  child:pw.Padding(
                    padding: const pw.EdgeInsets.only(right:2.5),
                    child: pw.Text(
                    'Total Quote Value:  ${rupeesNumberFormat.format(totalCost)} ',
                    style: pw.TextStyle(
                      fontSize: 16,
                      fontWeight: pw.FontWeight.bold,
                      font: pw.Font.ttf(semiBoldfontData.buffer
                          .asByteData()), // Specify the custom font
                    ),
                  ),),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    // Modify as needed for file handling
    return FileHandleApi.saveDocument(name: '$quoteId.pdf', pdf: pdf);
  }
}
