create procedure render_ir_control_break_toggler(
  p_dynamic_action  in            apex_plugin.t_dynamic_action
, p_plugin          in            apex_plugin.t_plugin
, p_param           in            apex_plugin.t_dynamic_action_render_param
, p_result          in out nocopy apex_plugin.t_dynamic_action_render_result
)
as
begin

  apex_css.add_file(
    p_name      => 'irControlBreakToggler'
  , p_directory => p_plugin.file_prefix
  , p_version   => null
  );

  apex_javascript.add_library(
    p_name      => 'irControlBreakToggler'
  , p_directory => p_plugin.file_prefix
  , p_version   => null
  );

  -- Pass plug-in configuration to the JavaScript initializer.
  p_result.function_name := 'irControlBreakTogglerInit';

  p_result.function_param.open_object;

  p_result.function_param.put(
    'initiallyExpanded'
  , p_dynamic_action.attributes.get_boolean(
      p_static_id => 'initially_expanded'
    )
  );

  p_result.function_param.put(
    'rememberState'
  , p_dynamic_action.attributes.get_varchar2(
      p_static_id => 'remember_state'
    )
  );

  p_result.function_param.put(
    'buttonPosition'
  , p_dynamic_action.attributes.get_varchar2(
      p_static_id => 'button_position'
    )
  );

  p_result.function_param.put(
    'collapseTitle'
  , p_plugin.attributes.get_varchar2(
      p_static_id                 => 'collapse_title'
    , p_do_substitutions          => true
    , p_substitutions_escape_mode => apex_session_state.c_escape_mode_raw
    )
  );

  p_result.function_param.put(
    'collapseIcon'
  , p_plugin.attributes.get_varchar2(
      p_static_id                 => 'collapse_icon'
    , p_do_substitutions          => true
    , p_substitutions_escape_mode => apex_session_state.c_escape_mode_raw
    )
  );

  p_result.function_param.put(
    'expandTitle'
  , p_plugin.attributes.get_varchar2(
      p_static_id                 => 'expand_title'
    , p_do_substitutions          => true
    , p_substitutions_escape_mode => apex_session_state.c_escape_mode_raw
    )
  );

  p_result.function_param.put(
    'expandIcon',
    p_plugin.attributes.get_varchar2(
      p_static_id                 => 'expand_icon'
    , p_do_substitutions          => true
    , p_substitutions_escape_mode => apex_session_state.c_escape_mode_raw
    )
  );

  p_result.function_param.put(
    'buttonCssClasses',
    p_plugin.attributes.get_varchar2(
      p_static_id                 => 'button_css_classes'
    , p_do_substitutions          => true
    , p_substitutions_escape_mode => apex_session_state.c_escape_mode_raw
    )
  );

  p_result.function_param.close_object;

end render_ir_control_break_toggler;
/