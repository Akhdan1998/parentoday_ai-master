import 'dart:convert';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:flutter_flushbar/flutter_flushbar.dart';
import 'dart:html' as html;
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:universal_io/io.dart';
// import 'dart:io';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:http/http.dart' as http;
import 'package:parentoday_ai/cubits/datauser_dart_cubit.dart';
import 'package:parentoday_ai/cubits/datauser_dart_state.dart';
import 'package:parentoday_ai/models/editProfil.dart';
import 'package:supercharged/supercharged.dart';
import '../cubits/ai_cubit.dart';
import '../cubits/listHistory_cubit.dart';
import '../cubits/listHistory_state.dart';
import '../models/api_return_foto.dart';
import '../models/auth.dart';
import '../models/data_user.dart';
import '../models/history.dart';
import '../models/models.dart';
import '../services/LogReg_services.dart';
import '../widgets/widgets.dart';
import 'dart:typed_data';
import 'package:http_parser/http_parser.dart';
import 'package:file_picker/file_picker.dart';

import 'package:flutter/widgets.dart';

part 'edit.dart';

part 'list_history.dart';

part 'home_page.dart';

part 'login_page.dart';

String? selectedRandomId;
bool showChat = true;
bool showContoh = false;
