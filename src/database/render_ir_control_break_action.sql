create or replace procedure render_ir_control_break_action(
  p_dynamic_action  in            apex_plugin.t_dynamic_action
, p_plugin          in            apex_plugin.t_plugin
, p_param           in            apex_plugin.t_dynamic_action_render_param
, p_result          in out nocopy apex_plugin.t_dynamic_action_render_result
)
as
begin

  p_result.function_name :=
    'irControlBreakTogglerAction';

  p_result.function_param.open_object;

  p_result.function_param.put(
    'action'
  , p_dynamic_action.attributes.get_varchar2(
      p_static_id => 'action'
    )
  );

  p_result.function_param.close_object;

end render_ir_control_break_action;
/
