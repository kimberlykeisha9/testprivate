// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:collection';

import 'package:flutter/widgets.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
// Set your widget name, define your parameter, and then add the
// boilerplate code using the button on the right!
import 'package:flutter/services.dart';
import 'package:flutter_mentions/flutter_mentions.dart';
import 'package:rxdart/rxdart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../backend/schema/user_record.dart';
import 'dart:convert';
import '../../auth/firebase_auth/auth_util.dart';

class OptionListV2 extends StatelessWidget {
  OptionListV2({
    required this.data,
    required this.onTap,
    required this.suggestionListHeight,
    required this.suggestionPosition,
    this.suggestionBuilder,
    this.suggestionListDecoration,
  });

  final Widget Function(Map<String, dynamic>)? suggestionBuilder;

  final List<Map<String, dynamic>> data;

  final Function(Map<String, dynamic>) onTap;

  final double suggestionListHeight;

  final BoxDecoration? suggestionListDecoration;

  final SuggestionPosition suggestionPosition;

  @override
  Widget build(BuildContext context) {
    return data.isNotEmpty
        ? SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.only(left: 10, right: 20),
                width: MediaQuery.of(context).size.width,
                constraints: BoxConstraints(
                  maxHeight: suggestionListHeight,
                  minHeight: 0,
                ),
                child: Container(
                  decoration: (suggestionListDecoration != null &&
                          suggestionPosition == SuggestionPosition.Bottom)
                      ? suggestionListDecoration
                      : BoxDecoration(color: Colors.transparent),
                  child: _getListView(),
                )))
        : Container();
  }

  Widget _getListView() {
    final listView = ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: data.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            onTap(data[index]);
          },
          child: suggestionBuilder != null
              ? suggestionBuilder!(data[index])
              : Container(
                  color: Colors.blue,
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    data[index]['display'],
                    style: TextStyle(fontSize: 16),
                  ),
                ),
        );
      },
    );

    if (suggestionPosition == SuggestionPosition.Bottom) {
      return listView;
    }

    return Align(
        alignment: Alignment.bottomCenter,
        child:
            Container(child: listView, decoration: suggestionListDecoration));
  }
}

class UserMentionTextInputV2 extends StatefulWidget {
  const UserMentionTextInputV2(
      {Key? key,
      required this.mentionSuggestionListSize,
      required this.minLines,
      required this.maxLines,
      this.hint,
      this.width,
      this.height,
      this.integrationMode})
      : super(key: key);

  final double? width;
  final double? height;
  final int mentionSuggestionListSize;
  final int minLines;
  final int maxLines;
  final String? hint;
  final String? integrationMode;

  @override
  _UserMentionTextInputState createState() =>
      _UserMentionTextInputState(mentionSuggestionListSize);
}

class _UserMentionTextInputState extends State<UserMentionTextInputV2> {
  _UserMentionTextInputState(this._mentionSuggestionListSize);

  final int _mentionSuggestionListSize;
  final BehaviorSubject<String> _userInputStream = BehaviorSubject();
  final List<UserMention> _addedUserMentions = List.empty(growable: true);
  List<UserMention> _currUserMentions = List.empty();
  List<Object> _userTribeGroups = List.empty();

  @override
  void initState() {
    super.initState();
    _configureUserInputMentionStream();

    queryUserRecordOnce(
            queryBuilder: (userRecord) =>
                userRecord.where('uid', isEqualTo: currentUserUid),
            singleRecord: true)
        .then(
            (value) => {
                  if (value.length > 0)
                    {
                      _userTribeGroups = value[0]
                          .tribeGroups
                          .map((e) => {
                                "TribeGroupID": e.tribeGroupID,
                                "groupRef": e.groupRef,
                                "role": e.role
                              })
                          .toList(),
                      print("Loaded user tribe groups: $_userTribeGroups")
                    }
                },
            onError: (err) => {print("Error loading user groups: $err")});
  }

  void _configureUserInputMentionStream() {
    _userInputStream
        .doOnData(
            (event) => print("User input stream emitted a new value: [$event]"))
        .where((event) => event.isNotEmpty)
        .asyncMap((input) => FirebaseFirestore.instance
            .collection('user')
            .where(Filter.or(
                Filter.and(
                    Filter('display_name', isGreaterThanOrEqualTo: input),
                    Filter('display_name', isLessThanOrEqualTo: "$input~")),
                Filter.and(
                    Filter('display_name',
                        isGreaterThanOrEqualTo:
                            "${input[0].toUpperCase()}${input.substring(1)}"),
                    Filter('display_name',
                        isLessThanOrEqualTo:
                            "${input[0].toUpperCase()}${input.substring(1)}~"))))
            .whereArrayContainsAny('TribeGroups', _userTribeGroups)
            .limit(_mentionSuggestionListSize)
            .get())
        .doOnData((snapshot) {
          print("Firebase returns snapshot with size: ${snapshot.size}");
        })
        .map((snapshot) => snapshot.docs
            .map((docSnapshot) => UserRecord.fromSnapshot(docSnapshot)))
        .map((userRecords) => userRecords.map((userRecord) => UserMention(
            id: userRecord.reference.id,
            display: userRecord.displayName,
            photo: userRecord.photoUrl)))
        .listen((userMentions) {
          print("Updating user mention state with: ${userMentions.length}");

          setState(() {
            _currUserMentions = userMentions.toList();
          });
        });
  }

  SuggestionPosition getWidgetSuggestionPosition() {
    return SuggestionPosition.Bottom;
  }

  TextStyle? getWidgetTextStyle() {
    return FlutterFlowTheme.of(context).bodyMedium.override(
          fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
          fontSize: 18.0, // Set your specific font size here
          fontWeight: FontWeight.normal, // Set font weight to normal
          color: Colors.black, // or your desired color for the input text
          useGoogleFonts: GoogleFonts.asMap()
              .containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
        );
  }

  InputDecoration getWidgetInputDecoration() {
    return InputDecoration(
      hintText: 'What would you like to share?',
      hintStyle: FlutterFlowTheme.of(context).bodyMedium.override(
            fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
            color: FlutterFlowTheme.of(context).secondaryText,
            fontSize: 18.0, // Set your specific font size here
            fontWeight: FontWeight.normal, // Set font weight to normal
            useGoogleFonts: GoogleFonts.asMap()
                .containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
          ),
      enabledBorder: InputBorder.none,
      focusedBorder: InputBorder.none,
      errorBorder: InputBorder.none,
      focusedErrorBorder: InputBorder.none,
      contentPadding:
          const EdgeInsetsDirectional.fromSTEB(15.0, 15.0, 15.0, 12.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMentionsV3(
      key: context.widget.key,
      suggestionPosition: getWidgetSuggestionPosition(),
      style: getWidgetTextStyle(),
      decoration: getWidgetInputDecoration(),
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      onSearchChanged: (t1, t2) => _onSearchInputChange(t2),
      onChanged: _onInputTextChanged,
      onMentionAdd: _onUserMentioned,
      mentions: [
        Mention(
          trigger: "@",
          disableMarkup: false,
          data: UserMention.toJsonMapList(_currUserMentions),
          matchAll: true,
          suggestionBuilder: _buildSuggestionWidget,
          style: TextStyle(
            fontWeight: FontWeight.bold, // Make the mentioned names bold
            color: Colors.blue, // Optional: Set a color for the mentioned names
          ),
        ),
      ],
      suggestionListDecoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
    );
  }

  void _onInputTextChanged(String text) {
    FFAppState().userMentionTextInputUserRefs =
        getValidatedMentionedUserRefs(text);
    FFAppState().userMentionTextInputText = getFormattedText(text);
  }

  List<DocumentReference> getValidatedMentionedUserRefs(String inputText) {
    if (_addedUserMentions.isEmpty) {
      return List.empty();
    }

    return _addedUserMentions
        .where((user) => inputText.contains(user.display))
        .map((user) =>
            FirebaseFirestore.instance.collection("user").doc(user.id))
        .toList();
  }

  String getFormattedText(String inputText) {
    if (_addedUserMentions.isEmpty) {
      return inputText;
    }

    String newText = inputText;

    for (var mention in _addedUserMentions) {
      newText =
          newText.replaceAll(mention.display, "<b>${mention.display}</b>");
    }

    return newText;
  }

  Widget _buildSuggestionWidget(Map<String, dynamic> input) {
    final UserMention userMention = UserMention.fromJson(input);
    final int index =
        _currUserMentions.indexWhere((t) => t.id == userMention.id);

    return Container(
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: _getSuggestionListBorderRadiusFor(index),
            color: Color(0XFFFEFEFE),
          ),
          padding: EdgeInsets.all(12),
          child: Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundImage: userMention.photo != null
                    ? NetworkImage(userMention.photo!)
                    : null,
              ),
              SizedBox(width: 10),
              Text(
                userMention.display,
                strutStyle: null,
                style: TextStyle(
                  decoration: TextDecoration.none,
                  color: Colors.black87,
                  fontSize: 12,
                  fontFamily: 'Poppins',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ));
  }

  BorderRadiusGeometry? _getSuggestionListBorderRadiusFor(int index) {
    if (index == 0) {
      return BorderRadius.only(
          topLeft: Radius.circular(10), topRight: Radius.circular(10));
    } else if (index == _currUserMentions.length - 1) {
      return BorderRadius.only(
          bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10));
    }

    return null;
  }

  void _onUserMentioned(Map<String, dynamic> rawMention) {
    final UserMention userMention = UserMention.fromJson(rawMention);

    setState(() {
      _currUserMentions = List.empty();
      _addedUserMentions.add(userMention);
    });
  }

  void _onSearchInputChange(String input) {
    _userInputStream.add(input);
  }

  @override
  void dispose() {
    _userInputStream.close();
    super.dispose();
  }
}

class UserMention {
  String id;
  String display;
  String? photo;

  UserMention({required this.id, required this.display, this.photo});

  factory UserMention.fromJson(Map<String, dynamic> json) {
    return UserMention(
        id: json['id'], display: json['display'], photo: json['photo_url']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'display': display, 'photo_url': photo};
  }

  @override
  String toString() {
    return 'UserMention(id: $id, display: $display, photo: $photo)';
  }

  // Static method to parse JSON array to a list of UserMention instances
  static List<UserMention> fromJsonList(String jsonString) {
    final parsed = jsonDecode(jsonString).cast<Map<String, dynamic>>();
    return parsed
        .map<UserMention>((json) => UserMention.fromJson(json))
        .toList();
  }

  static String toJsonList(List<UserMention> userMentions) {
    final List<Map<String, dynamic>> jsonData =
        userMentions.map((userMention) => userMention.toJson()).toList();
    return jsonEncode(jsonData);
  }

  static List<Map<String, dynamic>> toJsonMapList(
      List<UserMention> userMentions) {
    return userMentions.map((userMention) => userMention.toJson()).toList();
  }
}

class CustomAnnotationEditingController extends TextEditingController {
  Map<String, Annotation> _mapping;
  String? _pattern;
  final Set<String> _mentionedStrings = HashSet();

  // Generate the Regex pattern for matching all the suggestions in one.
  CustomAnnotationEditingController(this._mapping)
      : _pattern = _mapping.keys.isNotEmpty
            ? "(${_mapping.keys.map((key) => RegExp.escape(key)).join('|')})"
            : null;

  /// Can be used to get the markup from the controller directly.
  String get markupText {
    final someVal = _mapping.isEmpty
        ? text
        : text.splitMapJoin(
            RegExp('$_pattern'),
            onMatch: (Match match) {
              final mention = _mapping[match[0]!] ??
                  _mapping[_mapping.keys.firstWhere((element) {
                    final reg = RegExp(element);

                    return reg.hasMatch(match[0]!);
                  })]!;

              // Default markup format for mentions
              if (!mention.disableMarkup) {
                return mention.markupBuilder != null
                    ? mention.markupBuilder!(
                        mention.trigger, mention.id!, mention.display!)
                    : '${mention.trigger}[__${mention.id}__](__${mention.display}__)';
              } else {
                return match[0]!;
              }
            },
            onNonMatch: (String text) {
              return text;
            },
          );

    return someVal;
  }

  Map<String, Annotation> get mapping {
    return _mapping;
  }

  void addMentioned(String value) {
    _mentionedStrings.add(value);
  }

  set mapping(Map<String, Annotation> _mapping) {
    this._mapping = _mapping;

    _pattern = "(${_mapping.keys.map((key) => RegExp.escape(key)).join('|')})";
  }

  @override
  TextSpan buildTextSpan(
      {BuildContext? context, TextStyle? style, bool? withComposing}) {
    var children = <InlineSpan>[];
    var mentionedPattern =
        _mentionedStrings.isEmpty ? "()" : "@(${_mentionedStrings.join("|")})";

    if (mentionedPattern == '()') {
      children.add(TextSpan(text: text, style: style));
    } else {
      text.splitMapJoin(
        RegExp(mentionedPattern),
        onMatch: (Match match) {
          if (_mapping.isNotEmpty) {
            final mention = _mapping[match[0]!] ??
                _mapping[_mapping.keys.firstWhere((element) {
                  final reg = RegExp(element);

                  return reg.hasMatch(match[0]!);
                })]!;

            children.add(
              TextSpan(
                text: match[0],
                style: style!.merge(mention.style),
              ),
            );
          }

          return '';
        },
        onNonMatch: (String text) {
          children.add(TextSpan(text: text, style: style));
          return '';
        },
      );
    }

    return TextSpan(style: style, children: children);
  }
}

class FlutterMentionsV3 extends StatefulWidget {
  FlutterMentionsV3({
    required this.mentions,
    Key? key,
    this.defaultText,
    this.suggestionPosition = SuggestionPosition.Bottom,
    this.suggestionListHeight = 300.0,
    this.onMarkupChanged,
    this.onMentionAdd,
    this.onSearchChanged,
    this.leading = const [],
    this.trailing = const [],
    this.suggestionListDecoration,
    this.focusNode,
    this.decoration = const InputDecoration(),
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.style,
    this.strutStyle,
    this.textAlign = TextAlign.start,
    this.textDirection,
    this.autofocus = false,
    this.autocorrect = true,
    this.enableSuggestions = true,
    this.maxLines = 1,
    this.minLines,
    this.expands = false,
    this.readOnly = false,
    this.showCursor,
    this.maxLength,
    this.maxLengthEnforcement = MaxLengthEnforcement.none,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.enabled,
    this.cursorWidth = 2.0,
    this.cursorRadius,
    this.cursorColor,
    this.keyboardAppearance,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.enableInteractiveSelection = true,
    this.onTap,
    this.buildCounter,
    this.scrollPhysics,
    this.scrollController,
    this.autofillHints,
    this.appendSpaceOnAdd = true,
    this.hideSuggestionList = false,
    this.onSuggestionVisibleChanged,
  }) : super(key: key);

  final bool hideSuggestionList;

  /// default text for the Mention Input.
  final String? defaultText;

  /// Triggers when the suggestion list visibility changed.
  final Function(bool)? onSuggestionVisibleChanged;

  /// List of Mention that the user is allowed to triggered
  final List<Mention> mentions;

  /// Leading widgets to show before teh Input box, helps preseve the size
  /// size for the Portal widget size.
  final List<Widget> leading;

  /// Trailing widgets to show before teh Input box, helps preseve the size
  /// size for the Portal widget size.
  final List<Widget> trailing;

  /// Suggestion modal position, can be alligned to top or bottom.
  ///
  /// Defaults to [SuggestionPosition.Bottom].
  final SuggestionPosition suggestionPosition;

  /// Triggers when the suggestion was added by tapping on suggestion.
  final Function(Map<String, dynamic>)? onMentionAdd;

  /// Max height for the suggestion list
  ///
  /// Defaults to `300.0`
  final double suggestionListHeight;

  /// A Functioned which is triggered when ever the input changes
  /// but with the markup of the selected mentions
  ///
  /// This is an optional porperty.
  final ValueChanged<String>? onMarkupChanged;

  final void Function(String trigger, String value)? onSearchChanged;

  /// Decoration for the Suggestion list.
  final BoxDecoration? suggestionListDecoration;

  /// Focus node for controlling the focus of the Input.
  final FocusNode? focusNode;

  /// Should selecting a suggestion add a space at the end or not.
  final bool appendSpaceOnAdd;

  /// The decoration to show around the text field.
  final InputDecoration decoration;

  /// {@macro flutter.widgets.editableText.keyboardType}
  final TextInputType? keyboardType;

  /// The type of action button to use for the keyboard.
  ///
  /// Defaults to [TextInputAction.newline] if [keyboardType] is
  /// [TextInputType.multiline] and [TextInputAction.done] otherwise.
  final TextInputAction? textInputAction;

  /// {@macro flutter.widgets.editableText.textCapitalization}
  final TextCapitalization textCapitalization;

  /// The style to use for the text being edited.
  ///
  /// This text style is also used as the base style for the [decoration].
  ///
  /// If null, defaults to the `subtitle1` text style from the current [Theme].
  final TextStyle? style;

  /// {@macro flutter.widgets.editableText.strutStyle}
  final StrutStyle? strutStyle;

  /// {@macro flutter.widgets.editableText.textAlign}
  final TextAlign textAlign;

  /// {@macro flutter.widgets.editableText.textDirection}
  final TextDirection? textDirection;

  /// {@macro flutter.widgets.editableText.autofocus}
  final bool autofocus;

  /// {@macro flutter.widgets.editableText.autocorrect}
  final bool autocorrect;

  /// {@macro flutter.services.textInput.enableSuggestions}
  final bool enableSuggestions;

  /// {@macro flutter.widgets.editableText.maxLines}
  final int maxLines;

  /// {@macro flutter.widgets.editableText.minLines}
  final int? minLines;

  /// {@macro flutter.widgets.editableText.expands}
  final bool expands;

  /// {@macro flutter.widgets.editableText.readOnly}
  final bool readOnly;

  /// {@macro flutter.widgets.editableText.showCursor}
  final bool? showCursor;

  /// If [maxLength] is set to this value, only the "current input length"
  /// part of the character counter is shown.
  static const int noMaxLength = -1;

  /// The maximum number of characters (Unicode scalar values) to allow in the
  /// text field.
  final int? maxLength;

  /// If true, prevents the field from allowing more than [maxLength]
  /// characters.
  ///
  /// If [maxLength] is set, [maxLengthEnforcement] indicates whether or not to
  /// enforce the limit, or merely provide a character counter and warning when
  /// [maxLength] is exceeded.
  final MaxLengthEnforcement maxLengthEnforcement;

  /// {@macro flutter.widgets.editableText.onChanged}
  final ValueChanged<String>? onChanged;

  /// {@macro flutter.widgets.editableText.onEditingComplete}
  final VoidCallback? onEditingComplete;

  /// {@macro flutter.widgets.editableText.onSubmitted}
  final ValueChanged<String>? onSubmitted;

  /// If false the text field is "disabled": it ignores taps and its
  /// [decoration] is rendered in grey.
  ///
  /// If non-null this property overrides the [decoration]'s
  /// [Decoration.enabled] property.
  final bool? enabled;

  /// {@macro flutter.widgets.editableText.cursorWidth}
  final double cursorWidth;

  /// {@macro flutter.widgets.editableText.cursorRadius}
  final Radius? cursorRadius;

  /// The color to use when painting the cursor.
  ///
  /// Defaults to [ThemeData.cursorColor] or [CupertinoTheme.primaryColor]
  /// depending on [ThemeData.platform] .
  final Color? cursorColor;

  /// The appearance of the keyboard.
  ///
  /// This setting is only honored on iOS devices.
  ///
  /// If unset, defaults to the brightness of [ThemeData.primaryColorBrightness].
  final Brightness? keyboardAppearance;

  /// {@macro flutter.widgets.editableText.scrollPadding}
  final EdgeInsets scrollPadding;

  /// {@macro flutter.widgets.editableText.enableInteractiveSelection}
  final bool enableInteractiveSelection;

  /// {@macro flutter.rendering.editable.selectionEnabled}
  bool get selectionEnabled => enableInteractiveSelection;

  /// {@template flutter.material.textfield.onTap}
  /// Called for each distinct tap except for every second tap of a double tap.
  final GestureTapCallback? onTap;

  /// Callback that generates a custom [InputDecorator.counter] widget.
  ///
  /// See [InputCounterWidgetBuilder] for an explanation of the passed in
  /// arguments.  The returned widget will be placed below the line in place of
  /// the default widget built when [counterText] is specified.
  ///
  /// The returned widget will be wrapped in a [Semantics] widget for
  /// accessibility, but it also needs to be accessible itself.  For example,
  /// if returning a Text widget, set the [semanticsLabel] property.
  final InputCounterWidgetBuilder? buildCounter;

  /// {@macro flutter.widgets.editableText.scrollPhysics}
  final ScrollPhysics? scrollPhysics;

  /// {@macro flutter.widgets.editableText.scrollController}
  final ScrollController? scrollController;

  /// {@macro flutter.widgets.editableText.autofillHints}
  /// {@macro flutter.services.autofill.autofillHints}
  final Iterable<String>? autofillHints;

  @override
  FlutterMentionsState createState() => FlutterMentionsState();
}

class FlutterMentionsState extends State<FlutterMentionsV3> {
  CustomAnnotationEditingController? controller;
  ValueNotifier<bool> showSuggestions = ValueNotifier(false);
  LengthMap? _selectedMention;
  String _pattern = '';
  final LayerLink layerLink = LayerLink();
  OverlayEntry? overlayEntry;
  GlobalKey key = GlobalKey();
  late VoidCallback globalStateListener;

  Map<String, Annotation> mapToAnotation() {
    final data = <String, Annotation>{};

    // Loop over all the mention items and generate a suggestions matching list
    widget.mentions.forEach((element) {
      // if matchAll is set to true add a general regex patteren to match with
      if (element.matchAll) {
        data['${element.trigger}([A-Za-z0-9])*'] = Annotation(
          style: element.style,
          id: null,
          display: null,
          trigger: element.trigger,
          disableMarkup: element.disableMarkup,
          markupBuilder: element.markupBuilder,
        );
      }

      element.data.forEach(
        (e) => data["${element.trigger}${e['display']}"] = e['style'] != null
            ? Annotation(
                style: e['style'],
                id: e['id'],
                display: e['display'],
                trigger: element.trigger,
                disableMarkup: element.disableMarkup,
                markupBuilder: element.markupBuilder,
              )
            : Annotation(
                style: element.style,
                id: e['id'],
                display: e['display'],
                trigger: element.trigger,
                disableMarkup: element.disableMarkup,
                markupBuilder: element.markupBuilder,
              ),
      );
    });

    return data;
  }

  void _initGlobalStateListener() {
    globalStateListener = () {
      if (mounted && FFAppState().userMentionTextInputClearState) {
        controller?.clear();
        FFAppState().update(() {
          FFAppState().userMentionTextInputClearState = false;
          FFAppState().userMentionTextInputText = "";
        });
      }
    };

    FFAppState().addListener(globalStateListener);
  }

  void addMention(Map<String, dynamic> value, [Mention? list]) {
    final selectedMention = _selectedMention!;

    setState(() {
      _selectedMention = null;
    });

    final _list = widget.mentions
        .firstWhere((element) => selectedMention.str.contains(element.trigger));

    controller!.addMentioned(value['display']);

    // find the text by range and replace with the new value.
    controller!.text = controller!.value.text.replaceRange(
      selectedMention.start,
      selectedMention.end,
      "${_list.trigger}${value['display']}${widget.appendSpaceOnAdd ? ' ' : ''}",
    );

    if (widget.onMentionAdd != null) widget.onMentionAdd!(value);

    // Move the cursor to next position after the new mentioned item.
    var nextCursorPosition =
        selectedMention.start + 1 + value['display']?.length as int? ?? 0;
    if (widget.appendSpaceOnAdd) nextCursorPosition++;
    controller!.selection =
        TextSelection.fromPosition(TextPosition(offset: nextCursorPosition));
  }

  void suggestionListerner() {
    final cursorPos = controller!.selection.baseOffset;

    if (cursorPos >= 0) {
      var _pos = 0;

      final lengthMap = <LengthMap>[];

      // split on each word and generate a list with start & end position of each word.
      controller!.value.text.split(RegExp(r'(\s)')).forEach((element) {
        lengthMap.add(
            LengthMap(str: element, start: _pos, end: _pos + element.length));

        _pos = _pos + element.length + 1;
      });

      final val = lengthMap.indexWhere((element) {
        _pattern = widget.mentions.map((e) => e.trigger).join('|');

        return element.end == cursorPos &&
            element.str.toLowerCase().contains(RegExp(_pattern));
      });

      showSuggestions.value = val != -1;

      if (widget.onSuggestionVisibleChanged != null) {
        widget.onSuggestionVisibleChanged!(val != -1);
      }

      setState(() {
        _selectedMention = val == -1 ? null : lengthMap[val];
      });
    }
  }

  void hidePopup() {
    overlayEntry?.remove();
    overlayEntry = null;
  }

  void inputListeners() {
    if (widget.onChanged != null) {
      widget.onChanged!(controller!.text);
    }

    if (widget.onMarkupChanged != null) {
      widget.onMarkupChanged!(controller!.markupText);
    }

    if (widget.onSearchChanged != null && _selectedMention?.str != null) {
      final str = _selectedMention!.str.toLowerCase();

      widget.onSearchChanged!(str[0], str.substring(1));
    }
  }

  @override
  void initState() {
    final data = mapToAnotation();

    controller = CustomAnnotationEditingController(data);

    if (widget.defaultText != null) {
      controller!.text = widget.defaultText!;
    }

    controller!.addListener(suggestionListerner);
    controller!.addListener(inputListeners);
    _initGlobalStateListener();

    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  @override
  void dispose() {
    controller!.removeListener(suggestionListerner);
    controller!.removeListener(inputListeners);
    FFAppState().removeListener(globalStateListener);

    super.dispose();
  }

  @override
  void didUpdateWidget(widget) {
    super.didUpdateWidget(widget);
    controller!.mapping = mapToAnotation();
  }

  @override
  Widget build(BuildContext context) {
    showPopup();

    return Stack(
      children: [
        Row(children: [
          ...widget.leading,
          Expanded(
              child: CompositedTransformTarget(
            link: layerLink,
            child: TextField(
              key: key,
              maxLines: widget.maxLines,
              minLines: widget.minLines,
              maxLength: widget.maxLength,
              focusNode: widget.focusNode,
              keyboardType: widget.keyboardType,
              keyboardAppearance: widget.keyboardAppearance,
              textInputAction: widget.textInputAction,
              textCapitalization: widget.textCapitalization,
              style: widget.style,
              textAlign: widget.textAlign,
              readOnly: widget.readOnly,
              showCursor: widget.showCursor,
              autofocus: widget.autofocus,
              autocorrect: widget.autocorrect,
              maxLengthEnforcement: widget.maxLengthEnforcement,
              cursorColor: widget.cursorColor,
              cursorRadius: widget.cursorRadius,
              cursorWidth: widget.cursorWidth,
              buildCounter: widget.buildCounter,
              autofillHints: widget.autofillHints,
              decoration: widget.decoration,
              expands: widget.expands,
              onEditingComplete: widget.onEditingComplete,
              onTap: widget.onTap,
              onSubmitted: widget.onSubmitted,
              enabled: widget.enabled,
              enableInteractiveSelection: widget.enableInteractiveSelection,
              enableSuggestions: widget.enableSuggestions,
              scrollController: widget.scrollController,
              scrollPadding: widget.scrollPadding,
              scrollPhysics: widget.scrollPhysics,
              controller: controller,
            ),
          )),
          ...widget.trailing,
        ]),
      ],
    );
  }

  void showPopup() {
    if (overlayEntry != null) {
      hidePopup();
    }

    overlayEntry = OverlayEntry(
      builder: (context) {
        RenderBox? renderBox =
            key.currentContext?.findRenderObject() as RenderBox?;
        final size = renderBox?.size ?? Size(0, 0);
        final width =
            layerLink.leaderSize?.width ?? MediaQuery.of(context).size.width;

        return Positioned(
            width: width,
            child: CompositedTransformFollower(
              link: layerLink,
              showWhenUnlinked: false,
              offset: Offset(
                0,
                widget.suggestionPosition == SuggestionPosition.Top
                    ? -(size.height * 5.5 + ((size.height / 2) + size.height))
                    : (size.height),
              ),
              child: ValueListenableBuilder(
                valueListenable: showSuggestions,
                builder: (BuildContext context, bool value, Widget? child) {
                  final list = _selectedMention != null
                      ? widget.mentions.firstWhere((element) =>
                          _selectedMention!.str.contains(element.trigger))
                      : (widget.mentions.length > 0
                          ? widget.mentions[0]
                          : null);

                  if (!value || list == null) {
                    return Container();
                  }

                  return OptionListV2(
                    suggestionListHeight: widget.suggestionListHeight,
                    suggestionBuilder: list.suggestionBuilder,
                    suggestionListDecoration: widget.suggestionListDecoration,
                    suggestionPosition: widget.suggestionPosition,
                    data: list.data.where((element) {
                      final ele = element['display'].toLowerCase();
                      final str = _selectedMention?.str
                          .toLowerCase()
                          .replaceAll(RegExp(_pattern), '');

                      return ele == str ? false : ele.contains(str);
                    }).toList(),
                    onTap: (value) {
                      addMention(value, list);
                      showSuggestions.value = false;
                    },
                  );
                },
              ),
            ));
      },
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Overlay.of(context).insert(overlayEntry!);
    });
  }
}
