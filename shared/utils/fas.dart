import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../app/model/delivery_address.dart';

import 'package:pdf/widgets.dart' as pw;

import '../../core/screen_utils.dart';
import '../dialog/app_snackbar.dart';
import '../widgets/app_cached_image.dart';
import '../widgets/app_svg.dart';

bool isLocationPermissionGranted = true;

LatLng? currentLocation;

Future<LatLng?> getCurrentLocation({bool isCheckPermission = true}) async {
  try {
    isLocationPermissionGranted = true;
    final GeolocatorPlatform geoLocatorPlatform = GeolocatorPlatform.instance;

    if (isCheckPermission) {
      LocationPermission permission = await geoLocatorPlatform.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await geoLocatorPlatform.requestPermission();
        if (permission == LocationPermission.denied) {
          debugPrint("LOCATION DENIED");
          isLocationPermissionGranted = false;
          return null;
        }
      }
      if (permission == LocationPermission.deniedForever) {
        // Geolocator.openLocationSettings();
        // Screen.open(const LocationEnablePage());
        debugPrint("LOCATION DENIED");
        isLocationPermissionGranted = false;
        return null;
      }
    }

    Position location = await geoLocatorPlatform.getCurrentPosition(locationSettings: const LocationSettings(accuracy: LocationAccuracy.high));
    currentLocation = LatLng(location.latitude, location.longitude);
    return LatLng(location.latitude, location.longitude);
  } catch (e) {
    isLocationPermissionGranted = false;

    return null;
  }
}

// Future<AddressDetails?> setUserDefaultLocation({LatLng? selectedLatLng}) async {
//   final latLng = selectedLatLng ?? await getCurrentLocation();
//   if (latLng == null) {
//     userAddress = null;
//     return null;
//   }

//   final address = AddressDetails(addressType: "Home");
//   address.geocoordinates = "${latLng.latitude},${latLng.longitude}";
//   userAddress = await setAddressFromCoordinatesString(address);

//   if (userAddress != null) {
//     // SharedPref.save(key: "address", value: userAddress);
//   }

//   return userAddress;
// }

Future<AddressDetails?> setAddressFromCoordinatesString(AddressDetails? address) async {
  if (address == null) return address;

  final latLng = getLatLngFromString(address.geocoordinates!);
  final placeMark = await getAddress(location: latLng);
  if (placeMark != null) {
    address.locationName = placeMark.locality;
    address.streetAddress = "${placeMark.street} ${placeMark.postalCode}";
    address.city = placeMark.subLocality ?? placeMark.locality ?? placeMark.locality;
    address.district = placeMark.subAdministrativeArea;
    address.state = placeMark.administrativeArea;
  }
  return address;
}

LatLng getLatLngFromString(String coordinateString) {
  final coordinates = coordinateString.split(",");
  return LatLng(double.parse(coordinates[0]), double.parse(coordinates[1]));
}

Future<Placemark?> getAddress({required LatLng location}) async {
  try {
    List<Placemark> placeMark = await placemarkFromCoordinates(location.latitude, location.longitude);

    return placeMark.first;
  } catch (e) {
    return null;
  }
}

Future<void> makePhoneCall(String number) async {
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: number,
  );
  await launchUrl(launchUri);
  if (await canLaunchUrl(launchUri)) {
    await launchUrl(launchUri);
  } else {
    debugPrint('Cannot launch the dialer');
  }
}

// screenshot(ScreenshotController screenshotController,
//     {Quote? quote, required bool isShare}) {
//   if (!isShare) showLoader();
//   screenshotController
//       .capture(delay: const Duration(milliseconds: 10))
//       .then((capturedImage) async {
//     captureAndShareAndDownloadPDF(
//         capturedImage!, quote?.uniqueId ?? "", isShare);
//   }).catchError((onError) {
//     showToast(onError);
//   });
// }

// screenshotHistory(ScreenshotController screenshotController,
//     {QuoteId? quote, required bool isShare}) {
//   if (!isShare) showLoader();
//   screenshotController
//       .capture(delay: const Duration(milliseconds: 10))
//       .then((capturedImage) async {
//     captureAndShareAndDownloadPDF(
//         capturedImage!, quote?.uniqueId ?? "", isShare);
//   }).catchError((onError) {
//     showToast(onError);
//   });
// }

Future<void> captureAndShareAndDownloadPDF(Uint8List capturedImage, String qouoteName, bool isShare) async {
  final pdf = pw.Document();
  final image = pw.MemoryImage(capturedImage);

  pdf.addPage(
    pw.Page(
      build: (pw.Context context) {
        return pw.Center(
          child: pw.Image(image),
        );
      },
    ),
  );

  try {
    final dir = await getApplicationDocumentsDirectory();

    // Construct the file name with date and time
    String fileName = "$qouoteName.pdf";
    final file = File('${dir.path}/$fileName');
    await file.writeAsBytes(await pdf.save());
    if (isShare) await Share.shareXFiles([XFile(file.path)]);
    if (!isShare) showLoader();
    if (!isShare) saveFileToDownload(pdf.save(), fileName);
    if (!isShare) hideLoader();
    // snackBar(context, message: "save");
  } catch (e) {
    // Handle the exception
    showToast(e.toString());
  }
}

Future<void> saveFileToDownload(Future<Uint8List> pdf, String fileName) async {
  hideLoader();
  try {
    // Check and request storage permission
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }

    // Get the downloads directory
    Directory? downloadsDirectory;
    if (Platform.isAndroid) {
      downloadsDirectory = Directory('/storage/emulated/0/Download');
    } else {
      // For iOS, find an appropriate directory (like documents)
      downloadsDirectory = await getApplicationDocumentsDirectory();
    }

    // Write the file
    File file = File('${downloadsDirectory.path}/$fileName');
    await file.writeAsBytes(await pdf);

    // Optionally, show a toast or a message to the user
    showToast('File is saved to download folder.', isError: false);
  } catch (e) {
    showToast('Error saving file: $e');
  }
}

String? validateNumber(String? value) {
  if (value == null || value.isEmpty) {
    return null;
  }
  final RegExp numericRegex = RegExp(r'^[1-9][0-9]*$');

  if (!numericRegex.hasMatch(value)) {
    return 'Enter valid Number';
  }

  return null;
}

// String? validateFilterNumber(String? value) {
//   if (value == null || value.isEmpty) {
//     return "This field is required";
//   }
//   final RegExp numericRegex = RegExp(r'^[1-9][0-9]*$');

//   if (!numericRegex.hasMatch(value)) {
//     return 'Enter valid Number';
//   }

//   return null;
// }

String getFileExtension(String url) {
  // Split the URL by '.' and get the last part
  List<String> parts = url.split('.');
  if (parts.length > 1) {
    return parts.last;
  } else {
    return '';
  }
}

locationView({String? lat, String? lon}) async {
  debugPrint("Location Debug");
  String appleUrl = 'https://maps.apple.com/?saddr=&daddr=$lat,$lon&directionsmode=driving';
  String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$lat,$lon';

  Uri appleUri = Uri.parse(appleUrl);
  Uri googleUri = Uri.parse(googleUrl);

  if (Platform.isIOS) {
    if (await canLaunchUrl(appleUri)) {
      await launchUrl(appleUri, mode: LaunchMode.externalApplication);
    } else {
      if (await canLaunchUrl(googleUri)) {
        await launchUrl(googleUri, mode: LaunchMode.externalApplication);
      }
    }
  } else {
    if (await canLaunchUrl(googleUri)) {
      await launchUrl(googleUri, mode: LaunchMode.externalApplication);
    }
  }
}

Future<dynamic> previewImage(BuildContext context, {required String imageUrl}) {
  return showDialog(
      barrierColor: Colors.black,
      context: context,
      builder: (context) => Stack(
            children: [
              InteractiveViewer(
                child: CachedImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.contain,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
              Positioned(
                  top: 30,
                  right: 16,
                  child: AppSvg.clickable(
                    assetName: "imageview_close",
                    onPressed: () {
                      Screen.closeDialog();
                    },
                  ))
            ],
          ));
}

var rupeesFormat = NumberFormat.compactCurrency(locale: 'en_US', symbol: '₹');
var rupeesNumberFormat = NumberFormat.currency(locale: 'en_IN', symbol: '₹');
