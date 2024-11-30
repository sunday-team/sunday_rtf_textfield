import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sunday_rtf_textfield/sunday_rtf_textfield.dart';

/// A `RTFTextField` that uses a `RTFTextFieldController` to control the text.
/// The only relevance of this widget over `RTFTextField` is that it listens to changes in the controller and rebuilds on text align change.
class RTFTextField extends RichTextField {
  @override
  // ignore: overridden_fields
  final RTFTextFieldController controller;

  /// Called when the user changes the selection of text (including the cursor location).
  @override
  ValueChanged<TextSelection>? get onSelectionChanged => super.onSelectionChanged;

  const RTFTextField({
    super.key,
    required this.controller,
    super.focusNode,
    super.decoration = const RichInputDecoration(),
    TextInputType? keyboardType,
    super.textInputAction,
    super.textCapitalization = TextCapitalization.none,
    super.style,
    super.strutStyle,
    super.textAlign = TextAlign.start,
    super.textAlignVertical,
    super.textDirection,
    super.readOnly = false,
    super.showCursor,
    super.autofocus = false,
    super.obscuringCharacter = '•',
    super.obscureText = false,
    super.autocorrect = true,
    SmartDashesType? smartDashesType,
    SmartQuotesType? smartQuotesType,
    super.enableSuggestions = true,
    super.maxLines = 1,
    super.minLines,
    super.expands = false,
    super.maxLength,
    super.maxLengthEnforcement,
    super.onChanged,
    super.onEditingComplete,
    super.onSubmitted,
    super.onAppPrivateCommand,
    super.inputFormatters,
    super.enabled,
    super.cursorWidth = 2.0,
    super.cursorHeight,
    super.cursorRadius,
    super.cursorColor,
    super.selectionHeightStyle = BoxHeightStyle.tight,
    super.selectionWidthStyle = BoxWidthStyle.tight,
    super.keyboardAppearance,
    super.scrollPadding = const EdgeInsets.all(20.0),
    super.dragStartBehavior = DragStartBehavior.start,
    bool? enableInteractiveSelection,
    super.selectionControls,
    super.onTap,
    super.onTapOutside,
    super.mouseCursor,
    super.buildCounter,
    super.scrollController,
    super.scrollPhysics,
    super.autofillHints = const <String>[],
    super.clipBehavior = Clip.hardEdge,
    super.restorationId,
    super.scribbleEnabled = true,
    super.enableIMEPersonalizedLearning = true,
    super.contextMenuBuilder,
    super.spellCheckConfiguration,
    super.magnifierConfiguration,
  });

  @override
  State<RTFTextField> createState() => _RTFTextFieldState();
}

class _RTFTextFieldState extends State<RTFTextField> {
  late RTFTextFieldController controller = widget.controller;

  @override
  Widget build(BuildContext context) {
    // Get the current brightness
    final brightness = MediaQuery.platformBrightnessOf(context);
    final defaultTextColor = brightness == Brightness.dark 
        ? Colors.white 
        : Colors.black;

    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller,
      builder: (context, controllerValue, __) {
        // Initialize or update controller with brightness-aware color
        if (controller.metadata == null || 
            (controller.metadata?.color == Colors.black || controller.metadata?.color == Colors.white)) {
          controller.metadata = (controller.metadata ?? RTFTextFieldController.defaultMetadata)
              .copyWith(color: defaultTextColor);
        }
        
        return RichTextField(
          keyboardType: widget.keyboardType,
          key: widget.key,
          controller: widget.controller,
          focusNode: widget.focusNode,
          decoration: widget.decoration,
          textInputAction: widget.textInputAction,
          textCapitalization: widget.textCapitalization,
          style: widget.style?.copyWith(
            color: defaultTextColor,
          ) ?? TextStyle(
            color: defaultTextColor,
          ),
          strutStyle: widget.strutStyle,
          textAlign: controller.metadata?.alignment ?? widget.textAlign,
          textAlignVertical: widget.textAlignVertical,
          textDirection: widget.textDirection,
          readOnly: widget.readOnly,
          showCursor: widget.showCursor,
          autofocus: widget.autofocus,
          obscuringCharacter: widget.obscuringCharacter,
          obscureText: widget.obscureText,
          autocorrect: widget.autocorrect,
          enableSuggestions: widget.enableSuggestions,
          maxLines: widget.maxLines,
          minLines: widget.minLines,
          expands: widget.expands,
          maxLength: widget.maxLength,
          maxLengthEnforcement: widget.maxLengthEnforcement,
          onChanged: widget.onChanged,
          onEditingComplete: widget.onEditingComplete,
          onSubmitted: widget.onSubmitted,
          onAppPrivateCommand: widget.onAppPrivateCommand,
          inputFormatters: widget.inputFormatters,
          enabled: widget.enabled,
          cursorWidth: widget.cursorWidth,
          cursorHeight: widget.cursorHeight,
          cursorRadius: widget.cursorRadius,
          cursorColor: widget.cursorColor,
          selectionHeightStyle: widget.selectionHeightStyle,
          selectionWidthStyle: widget.selectionWidthStyle,
          keyboardAppearance: widget.keyboardAppearance,
          scrollPadding: widget.scrollPadding,
          dragStartBehavior: widget.dragStartBehavior,
          enableInteractiveSelection: widget.enableInteractiveSelection,
          selectionControls: widget.selectionControls,
          onTap: widget.onTap,
          onTapOutside: widget.onTapOutside,
          mouseCursor: widget.mouseCursor,
          buildCounter: widget.buildCounter,
          scrollController: widget.scrollController,
          scrollPhysics: widget.scrollPhysics,
          autofillHints: widget.autofillHints,
          clipBehavior: widget.clipBehavior,
          restorationId: widget.restorationId,
          scribbleEnabled: widget.scribbleEnabled,
          enableIMEPersonalizedLearning: widget.enableIMEPersonalizedLearning,
          contextMenuBuilder: widget.contextMenuBuilder,
          spellCheckConfiguration: widget.spellCheckConfiguration,
          magnifierConfiguration: widget.magnifierConfiguration,
          onSelectionChanged: (selection) {
            // Update internal selection
            controller.selection = selection;
            
            // Call user's callback if provided
            widget.onSelectionChanged?.call(selection);
          },
        );
      },
    );
  }

  @override
  void didUpdateWidget(RTFTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      controller = widget.controller;
    }
  }
}
