import 'package:auto_size_text/auto_size_text.dart';
import 'package:clipboard/clipboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_flushbar/flutter_flushbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_network/image_network.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:overlay_tooltip/overlay_tooltip.dart';
import 'package:parentoday_ai/models/auth.dart';
import 'package:supercharged/supercharged.dart';
import 'package:typewritertext/typewritertext.dart';

import '../cubits/datauser_dart_cubit.dart';
import '../cubits/datauser_dart_state.dart';
import '../models/data_user.dart';
import '../models/models.dart';
import '../pages/pages.dart';
import '../theme/color.dart';

part 'chat_card.dart';
