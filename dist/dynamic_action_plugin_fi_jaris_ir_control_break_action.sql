prompt --application/set_environment
set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- Oracle APEX export file
--
-- You should run this script using a SQL client connected to the database as
-- the owner (parsing schema) of the application or as a database user with the
-- APEX_ADMINISTRATOR_ROLE role.
--
-- This export file has been automatically generated. Modifying this file is not
-- supported by Oracle and can lead to unexpected application and/or instance
-- behavior now or in the future.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
wwv_flow_imp.import_begin (
 p_version_yyyy_mm_dd=>'2026.03.30'
,p_release=>'26.1.4'
,p_default_workspace_id=>6206094152582709
,p_default_application_id=>104
,p_default_id_offset=>0
,p_default_owner=>'WKSP_SANDBOX'
);
end;
/
 
prompt APPLICATION 104 - Allama
--
-- Application Export:
--   Application:     104
--   Name:            Allama
--   Date and Time:   12:45 Monday September 28, 2026
--   Exported By:     JARI
--   Flashback:       0
--   Export Type:     Component Export
--   Manifest
--     PLUGIN: 10723274034146833
--   Manifest End
--   Version:         26.1.4
--   Instance ID:     2400104630176441
--

begin
  -- replace components
  wwv_flow_imp.g_mode := 'REPLACE';
end;
/
prompt --application/shared_components/plugins/dynamic_action/fi_jaris_ir_control_break_action
begin
wwv_flow_imp_shared.create_plugin(
 p_id=>wwv_flow_imp.id(10723274034146833)
,p_plugin_type=>'DYNAMIC ACTION'
,p_name=>'FI.JARIS.IR.CONTROL_BREAK_ACTION'
,p_display_name=>'IR Control Break Action'
,p_apexlang_name=>'irControlBreakAction'
,p_category=>'COMPONENT'
,p_plsql_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'procedure render_ir_control_break_action(',
'  p_dynamic_action  in            apex_plugin.t_dynamic_action',
', p_plugin          in            apex_plugin.t_plugin',
', p_param           in            apex_plugin.t_dynamic_action_render_param',
', p_result          in out nocopy apex_plugin.t_dynamic_action_render_result',
')',
'as',
'begin',
'',
'  p_result.function_name :=',
'    ''irControlBreakTogglerAction'';',
'',
'  p_result.function_param.open_object;',
'',
'  p_result.function_param.put(',
'    ''action''',
'  , p_dynamic_action.attributes.get_varchar2(',
'      p_static_id => ''action''',
'    )',
'  );',
'',
'  p_result.function_param.close_object;',
'',
'end render_ir_control_break_action;'))
,p_api_version=>3
,p_render_function=>'render_ir_control_break_action'
,p_standard_attributes=>'REGION:REQUIRED'
,p_version_scn=>'SH256:nKfnzbnQaXUxyN-eEPSh1AchD27u19IGyR9ufWyiSTA'
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>',
'Performs an action on an Interactive Report initialized by the',
'<strong>IR Control Break Toggler</strong> plug-in.',
'</p>',
'',
'<p>',
'This plug-in is intended for use with Oracle APEX Trigger Actions.',
'Select the Interactive Report under <strong>Affected Elements</strong>',
'and choose the control-break action to perform.',
'</p>',
'',
'<p>',
'The target Interactive Report must already be initialized by the',
'<strong>IR Control Break Toggler</strong> plug-in.',
'</p>'))
,p_version_identifier=>'1.1.0'
,p_about_url=>'https://github.com/jariolaine/apex-ir-control-break-toggler'
,p_files_version=>2461312095636
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(10723695224154677)
,p_plugin_id=>wwv_flow_imp.id(10723274034146833)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>1
,p_display_sequence=>10
,p_static_id=>'action'
,p_prompt=>'Action'
,p_apexlang_name=>'action'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'COLLAPSE_ALL'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>',
'Specifies the action to perform on the affected Interactive Report.',
'</p>',
'',
'<p>',
'Available options include:',
'</p>',
'',
'<ul>',
'  <li>',
unistr('    <strong>Expand All</strong> \2014 expands all currently displayed'),
'    control-break groups.',
'  </li>',
'  <li>',
unistr('    <strong>Collapse All</strong> \2014 collapses all currently displayed'),
'    control-break groups.',
'  </li>',
'  <li>',
unistr('    <strong>Reset State</strong> \2014 clears remembered state and restores'),
'    the configured Initially Expanded state.',
'  </li>',
'</ul>'))
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(10724822582160429)
,p_plugin_attribute_id=>wwv_flow_imp.id(10723695224154677)
,p_display_sequence=>20
,p_display_value=>'Collapse All'
,p_return_value=>'COLLAPSE_ALL'
,p_apexlang_name=>'collapseAll'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(10724433869159145)
,p_plugin_attribute_id=>wwv_flow_imp.id(10723695224154677)
,p_display_sequence=>10
,p_display_value=>'Expand All'
,p_return_value=>'EXPAND_ALL'
,p_apexlang_name=>'expandAll'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(10725255911161723)
,p_plugin_attribute_id=>wwv_flow_imp.id(10723695224154677)
,p_display_sequence=>30
,p_display_value=>'Reset State'
,p_return_value=>'RESET_STATE'
,p_apexlang_name=>'resetState'
);
end;
/
prompt --application/end_environment
begin
wwv_flow_imp.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false)
);
commit;
end;
/
set verify on feedback on define on
prompt  ...done
