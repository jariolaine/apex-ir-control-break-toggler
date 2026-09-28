create or replace procedure render_ir_control_break_toggler(
  p_dynamic_action  in            apex_plugin.t_dynamic_action
, p_plugin          in            apex_plugin.t_plugin
, p_param           in            apex_plugin.t_dynamic_action_render_param
, p_result          in out nocopy apex_plugin.t_dynamic_action_render_result
)
as

  l_collapse_icon   varchar2(256) :=
    'fa-chevron-down';

  l_collapse_title  varchar2(4000) :=
    apex_lang.get_message( 'APEX.GV.BREAK_COLLAPSE' );

  l_expand_title    varchar2(4000) :=
    apex_lang.get_message( 'APEX.GV.BREAK_EXPAND' );

  l_btn_css_classes varchar2(256) :=
    't-Button t-Button--noLabel t-Button--icon t-Button--small';

begin

  -- Application-scope attributes with defaults.
  l_collapse_icon :=
    p_plugin.attributes.get_varchar2(
      p_static_id     => 'collapse_icon'
    , p_default_value => l_collapse_icon
    );

  l_collapse_title :=
    p_plugin.attributes.get_varchar2(
      p_static_id                 => 'collapse_title'
    , p_default_value             => l_collapse_title
    , p_do_substitutions          => true
    , p_substitutions_escape_mode => apex_session_state.c_escape_mode_raw
    );

  l_expand_title :=
    p_plugin.attributes.get_varchar2(
      p_static_id                 => 'expand_title'
    , p_default_value             => l_expand_title
    , p_do_substitutions          => true
    , p_substitutions_escape_mode => apex_session_state.c_escape_mode_raw
    );

  l_btn_css_classes :=
    p_plugin.attributes.get_varchar2(
      p_static_id     => 'button_css_classes'
    , p_default_value => l_btn_css_classes
    );


  -- Pass plug-in configuration to the JavaScript initializer.
  p_result.function_name := 'irControlBreakTogglerInit';

  p_result.function_param.open_object;

  -- Application-scope attributes
  p_result.function_param.put(
    'collapseTitle'
  , l_collapse_title
  );

  p_result.function_param.put(
    'collapseIcon'
  , l_collapse_icon
  );

  p_result.function_param.put(
    'expandTitle'
  , l_expand_title
  );

  p_result.function_param.put(
    'expandIcon'
  , p_plugin.attributes.get_varchar2(
      p_static_id => 'expand_icon'
    )
  );

  p_result.function_param.put(
    'buttonCssClasses'
  , l_btn_css_classes
  );

  -- Component-scope attributes
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

  p_result.function_param.close_object;

end render_ir_control_break_toggler;
/
