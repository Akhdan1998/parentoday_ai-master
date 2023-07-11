import 'dart:convert';
import 'dart:html';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:http/http.dart' as http;
import 'package:parentoday_ai/cubits/datauser_dart_cubit.dart';
import 'package:parentoday_ai/cubits/datauser_dart_state.dart';
import 'package:supercharged/supercharged.dart';
import '../cubits/ai_cubit.dart';
import '../cubits/listHistory_cubit.dart';
import '../cubits/listHistory_state.dart';
import '../models/auth.dart';
import '../models/history.dart';
import '../models/models.dart';
import '../services/LogReg_services.dart';
import '../widgets/widgets.dart';
part 'edit.dart';
part 'list_history.dart';
part 'home_page.dart';
part 'login_page.dart';

String? selectedRandomId;