import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:http/http.dart' as http;
import 'package:supercharged/supercharged.dart';

import '../cubits/ai_cubit.dart';
import '../models/models.dart';
import '../widgets/widgets.dart';

part 'home_page.dart';