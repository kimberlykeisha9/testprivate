import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/chat/new_chat/audio/audio_player/audio_player_widget.dart';
import '/flutter_flow/flutter_flow_expanded_image_view.dart';
import '/flutter_flow/flutter_flow_swipeable_stack.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_video_player.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'message_types_link_test_widget.dart' show MessageTypesLinkTestWidget;
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class MessageTypesLinkTestModel
    extends FlutterFlowModel<MessageTypesLinkTestWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for SwipeableStack widget.
  late CardSwiperController swipeableStackController;
  // Model for AudioPlayer component.
  late AudioPlayerModel audioPlayerModel;

  @override
  void initState(BuildContext context) {
    swipeableStackController = CardSwiperController();
    audioPlayerModel = createModel(context, () => AudioPlayerModel());
  }

  @override
  void dispose() {
    audioPlayerModel.dispose();
  }
}
