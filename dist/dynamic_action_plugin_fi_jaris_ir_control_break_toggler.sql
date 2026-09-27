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
--   Date and Time:   18:28 Sunday September 27, 2026
--   Exported By:     JARI
--   Flashback:       0
--   Export Type:     Component Export
--   Manifest
--     PLUGIN: 18583403628066902
--   Manifest End
--   Version:         26.1.4
--   Instance ID:     2400104630176441
--

begin
  -- replace components
  wwv_flow_imp.g_mode := 'REPLACE';
end;
/
prompt --application/shared_components/plugins/dynamic_action/fi_jaris_ir_control_break_toggler
begin
wwv_flow_imp_shared.create_plugin(
 p_id=>wwv_flow_imp.id(18583403628066902)
,p_plugin_type=>'DYNAMIC ACTION'
,p_name=>'FI.JARIS.IR_CONTROL_BREAK_TOGGLER'
,p_display_name=>'IR Control Break Toggler'
,p_apexlang_name=>'irControlBreakToggler'
,p_category=>'COMPONENT'
,p_plsql_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'procedure render_ir_control_break_toggler(',
'  p_dynamic_action  in            apex_plugin.t_dynamic_action',
', p_plugin          in            apex_plugin.t_plugin',
', p_param           in            apex_plugin.t_dynamic_action_render_param',
', p_result          in out nocopy apex_plugin.t_dynamic_action_render_result',
')',
'as',
'begin',
'',
'  apex_css.add_file(',
'    p_name      => ''irControlBreakToggler''',
'  , p_directory => p_plugin.file_prefix',
'  , p_version   => null',
'  );',
'',
'  apex_javascript.add_library(',
'    p_name      => ''irControlBreakToggler''',
'  , p_directory => p_plugin.file_prefix',
'  , p_version   => null',
'  );',
'',
'  -- Pass plug-in configuration to the JavaScript initializer.',
'  p_result.function_name := ''irControlBreakTogglerInit'';',
'',
'  p_result.function_param.open_object;',
'',
'  p_result.function_param.put(',
'    ''initiallyExpanded''',
'  , p_dynamic_action.attributes.get_boolean(',
'      p_static_id => ''initially_expanded''',
'    )',
'  );',
'',
'  p_result.function_param.put(',
'    ''rememberState''',
'  , p_dynamic_action.attributes.get_varchar2(',
'      p_static_id => ''remember_state''',
'    )',
'  );',
'',
'  p_result.function_param.put(',
'    ''buttonPosition''',
'  , p_dynamic_action.attributes.get_varchar2(',
'      p_static_id => ''button_position''',
'    )',
'  );',
'',
'  p_result.function_param.put(',
'    ''collapseTitle''',
'  , p_plugin.attributes.get_varchar2(',
'      p_static_id                 => ''collapse_title''',
'    , p_do_substitutions          => true',
'    , p_substitutions_escape_mode => apex_session_state.c_escape_mode_raw',
'    )',
'  );',
'',
'  p_result.function_param.put(',
'    ''collapseIcon''',
'  , p_plugin.attributes.get_varchar2(',
'      p_static_id                 => ''collapse_icon''',
'    , p_do_substitutions          => true',
'    , p_substitutions_escape_mode => apex_session_state.c_escape_mode_raw',
'    )',
'  );',
'',
'  p_result.function_param.put(',
'    ''expandTitle''',
'  , p_plugin.attributes.get_varchar2(',
'      p_static_id                 => ''expand_title''',
'    , p_do_substitutions          => true',
'    , p_substitutions_escape_mode => apex_session_state.c_escape_mode_raw',
'    )',
'  );',
'',
'  p_result.function_param.put(',
'    ''expandIcon'',',
'    p_plugin.attributes.get_varchar2(',
'      p_static_id                 => ''expand_icon''',
'    , p_do_substitutions          => true',
'    , p_substitutions_escape_mode => apex_session_state.c_escape_mode_raw',
'    )',
'  );',
'',
'  p_result.function_param.put(',
'    ''buttonCssClasses'',',
'    p_plugin.attributes.get_varchar2(',
'      p_static_id                 => ''button_css_classes''',
'    , p_do_substitutions          => true',
'    , p_substitutions_escape_mode => apex_session_state.c_escape_mode_raw',
'    )',
'  );',
'',
'  p_result.function_param.close_object;',
'',
'end render_ir_control_break_toggler;'))
,p_api_version=>3
,p_render_function=>'render_ir_control_break_toggler'
,p_standard_attributes=>'ONLOAD'
,p_version_scn=>'SH256:aV0MqaYcTr-gdkRHG3pUKA42rxxzurhyAIvpsrTM1i4'
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>',
'Adds expand and collapse controls to control-break groups in an',
'Interactive Report.',
'</p>',
'',
'<p>',
'Create the Dynamic Action on the Interactive Report region using the',
'<strong>After Refresh</strong> event and enable',
'<strong>Fire on Initialization</strong>.',
'The plug-in operates on the triggering report region, so no Affected Elements',
'configuration is required.',
'</p>',
'',
'<p>',
'When the Dynamic Action runs, the plug-in adds a toggle button to each',
'control-break header. Users can expand or collapse individual',
'control-break groups.',
'</p>',
'',
'<p>',
'The plug-in can optionally remember each group''s state for the current browser',
'session or across future browser sessions. Persistent state is stored in the',
'current browser profile.',
'</p>',
'',
'<p>',
'Application-scope attributes define the button titles, icons, and CSS classes.',
'Component-scope attributes control the initial expanded state, state persistence,',
'and button position.',
'</p>',
'',
'<p>',
'The generated buttons maintain accessible labels, <code>aria-expanded</code>,',
'and <code>aria-controls</code> relationships with the rows they control.',
'</p>',
'',
'<p>',
'The plug-in provides public JavaScript methods for expanding all groups,',
'collapsing all groups, and resetting remembered state for an individual report',
'region. It also exposes the <strong>Control Break Change</strong> Dynamic Action',
'event when control-break state changes through user interaction or the public API.',
'</p>',
'',
'<p>',
'If the Interactive Report contains no control breaks, the plug-in makes no changes.',
'</p>'))
,p_version_identifier=>'1.0.1'
,p_files_version=>2461311182826
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(18994955341614880)
,p_plugin_id=>wwv_flow_imp.id(18583403628066902)
,p_attribute_scope=>'APPLICATION'
,p_attribute_sequence=>5
,p_display_sequence=>50
,p_static_id=>'button_css_classes'
,p_prompt=>'Button CSS Classes'
,p_apexlang_name=>'buttonCssClasses'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_is_translatable=>false
,p_examples=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>',
'<code>t-Button t-Button--noLabel t-Button--icon t-Button--small</code>',
'</p>'))
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>',
'CSS classes applied to each control-break toggle button.',
'</p>',
'',
'<p>',
'The plug-in automatically adds the internal <code>ir-control-break-btn</code>',
'class, so it does not need to be specified here.',
'</p>',
'',
'<p>',
'Leave this value empty to use the plug-in''s built-in default button classes.',
'</p>',
'',
'<p>',
'<strong>Supported Substitutions:</strong> Application, Page Items and',
'System Variables.',
'</p>'))
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(20027962677875283)
,p_plugin_id=>wwv_flow_imp.id(18583403628066902)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>3
,p_display_sequence=>30
,p_static_id=>'button_position'
,p_prompt=>'Button Position'
,p_apexlang_name=>'buttonPosition'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'START'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>',
'Controls where the control-break toggle button is displayed within',
'the control-break header.',
'</p>',
'',
'<p>',
'The button can be placed at the start or end of the header row.',
'The position follows the page text direction, so start and end also',
'work correctly in right-to-left layouts.',
'</p>',
'',
'<p>',
'<strong>Default:</strong> Start',
'</p>'))
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(20029231724880278)
,p_plugin_attribute_id=>wwv_flow_imp.id(20027962677875283)
,p_display_sequence=>20
,p_display_value=>'End'
,p_return_value=>'END'
,p_apexlang_name=>'end'
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>',
'Places the toggle button at the end of the control-break header.',
'</p>',
'',
'<p>',
'In a left-to-right layout, the button appears after the control-break text and',
'is aligned to the end of the row.',
'</p>'))
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(20028896735879458)
,p_plugin_attribute_id=>wwv_flow_imp.id(20027962677875283)
,p_display_sequence=>10
,p_display_value=>'Start'
,p_return_value=>'START'
,p_apexlang_name=>'start'
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>',
'Places the toggle button at the start of the control-break header.',
'</p>',
'',
'<p>',
'In a left-to-right layout, the button appears before the control-break text.',
'</p>'))
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(18990460389595400)
,p_plugin_id=>wwv_flow_imp.id(18583403628066902)
,p_attribute_scope=>'APPLICATION'
,p_attribute_sequence=>2
,p_display_sequence=>20
,p_static_id=>'collapse_icon'
,p_prompt=>'Collapse Icon'
,p_apexlang_name=>'collapseIcon'
,p_attribute_type=>'ICON'
,p_is_required=>false
,p_is_translatable=>false
,p_examples=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>',
'<code>fa-chevron-down</code>',
'</p>'))
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>',
'Icon displayed while a control-break group is expanded.',
'</p>',
'',
'<p>',
'The icon should visually represent the action to collapse the group.',
'Specify an Oracle APEX Font APEX icon class.',
'</p>',
'',
'<p>',
'The icon is decorative and is hidden from assistive technologies;',
'the accessible button name is provided by <strong>Collapse Title</strong>.',
'</p>',
'',
'<p>',
'Leave this value empty to use the plug-in''s built-in default button icon.',
'</p>',
'',
'<p>',
'<strong>Supported Substitutions:</strong> Application, Page Items and',
'System Variables.',
'</p>'))
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(18985218326548506)
,p_plugin_id=>wwv_flow_imp.id(18583403628066902)
,p_attribute_scope=>'APPLICATION'
,p_attribute_sequence=>1
,p_display_sequence=>10
,p_static_id=>'collapse_title'
,p_prompt=>'Collapse Title'
,p_apexlang_name=>'collapseTitle'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_is_translatable=>true
,p_examples=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>',
'Collapse',
'</p>'))
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>',
'Text used as the button title and accessible label while a control-break group is expanded.',
'</p>',
'<p>',
'The text should describe the action performed when the button is activated.',
'</p>',
'<p>',
'Leave this value empty to use the standard Oracle APEX collapse message.',
'</p>',
'<p><strong>Supported Substitutions:</strong> Application, Page Items and',
'System Variables.',
'</p>'))
,p_important_for_accessibility=>true
,p_accessibility_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>',
'This value is used as the button''s accessible label. Use a short,',
'action-oriented label that clearly indicates that activating the button will',
'collapse the associated control-break group.',
'</p>',
'',
'<p>',
'Do not describe the icon itself; describe the action performed by the button.',
'</p>'))
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(18991423814602923)
,p_plugin_id=>wwv_flow_imp.id(18583403628066902)
,p_attribute_scope=>'APPLICATION'
,p_attribute_sequence=>4
,p_display_sequence=>40
,p_static_id=>'expand_icon'
,p_prompt=>'Expand Icon'
,p_apexlang_name=>'expandIcon'
,p_attribute_type=>'ICON'
,p_is_required=>false
,p_is_translatable=>false
,p_examples=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>',
'<code>fa-chevron-right</code>',
'</p>'))
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>',
'Icon displayed while a control-break group is collapsed.',
'</p>',
'',
'<p>',
'The icon should visually represent the action to expand the group. Specify an',
'Oracle APEX Font APEX icon class.',
'</p>',
'',
'<p>',
'The icon is decorative and is hidden from assistive technologies;',
'the accessible button name is provided by <strong>Expand Title</strong>.',
'</p>',
'',
'<p>',
'Leave this value empty to automatically use a directional chevron based on the',
'configured <strong>Button Position</strong> and the page text direction.',
'</p>',
'',
'<p>',
'<strong>Supported Substitutions:</strong> Application, Page Items and',
'System Variables.',
'</p>'))
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(18988065901568817)
,p_plugin_id=>wwv_flow_imp.id(18583403628066902)
,p_attribute_scope=>'APPLICATION'
,p_attribute_sequence=>3
,p_display_sequence=>30
,p_static_id=>'expand_title'
,p_prompt=>'Expand Title'
,p_apexlang_name=>'expandTitle'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_is_translatable=>true
,p_examples=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>',
'Expand',
'</p>'))
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>',
'Text used as the button title and accessible label while a control-break group is collapsed.',
'</p>',
'',
'<p>',
'The text should describe the action performed when the button is activated.',
'</p>',
'',
'<p>',
'Leave this value empty to use the standard Oracle APEX expand message.',
'</p>',
'',
'<p>',
'<strong>Supported Substitutions:</strong> Application, Page Items and',
'System Variables.',
'</p>'))
,p_important_for_accessibility=>true
,p_accessibility_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>',
'This value is used as the button''s accessible label. Use a short,',
'action-oriented label that clearly indicates that activating the button will',
'expand the associated control-break group.',
'</p>',
'',
'<p>',
'Do not describe the icon itself; describe the action performed by the button.',
'</p>'))
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(18586545522148016)
,p_plugin_id=>wwv_flow_imp.id(18583403628066902)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>1
,p_display_sequence=>10
,p_static_id=>'initially_expanded'
,p_prompt=>'Initially Expanded'
,p_apexlang_name=>'initiallyExpanded'
,p_attribute_type=>'CHECKBOX'
,p_is_required=>true
,p_default_value=>'Y'
,p_is_translatable=>false
,p_examples=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<ul>',
unistr('<li><strong>Yes</strong> \2014 initially display control-break groups expanded.</li>'),
unistr('<li><strong>No</strong> \2014 initially display control-break groups collapsed.</li>'),
'</ul>'))
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>',
'Controls the initial state of the Interactive Report control-break groups when',
'the Dynamic Action runs.',
'</p>',
'',
'<p>',
'When enabled, control-break groups are initially expanded and their rows are',
'visible. When disabled, control-break groups are initially collapsed and their',
'rows are hidden.',
'</p>',
'',
'<p>',
'Users can subsequently expand or collapse individual groups using the toggle',
'button in each control-break header.',
'</p>',
'',
'<p>',
'<strong>Default:</strong> Yes',
'</p>'))
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(20004569551275381)
,p_plugin_id=>wwv_flow_imp.id(18583403628066902)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>2
,p_display_sequence=>20
,p_static_id=>'remember_state'
,p_prompt=>'Remember State'
,p_apexlang_name=>'rememberState'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'NO'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>',
'Controls whether the expand/collapse state of each control-break group is',
'remembered after the plug-in runs.',
'</p>',
'',
'<p>',
'The state is stored in the browser and restored when the Interactive Report is',
'refreshed or initialized again.',
'</p>',
'',
'<p>',
'If the <strong>Initially Expanded</strong> setting is changed, previously',
'remembered states are discarded and the new initial setting is applied.',
'</p>',
'',
'<p>',
'<strong>Default:</strong> Do Not Remember',
'</p>'))
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(20010302028409248)
,p_plugin_attribute_id=>wwv_flow_imp.id(20004569551275381)
,p_display_sequence=>10
,p_display_value=>'Do Not Remember'
,p_return_value=>'NO'
,p_apexlang_name=>'no'
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>',
'Does not store the state of control-break groups.',
'</p>',
'',
'<p>',
'Each time the plug-in is initialized, all groups use the configured',
'<strong>Initially Expanded</strong> setting.',
'</p>'))
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(20011112866411821)
,p_plugin_attribute_id=>wwv_flow_imp.id(20004569551275381)
,p_display_sequence=>30
,p_display_value=>'Future Sessions'
,p_return_value=>'PERSISTENT'
,p_apexlang_name=>'persistent'
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>',
'Remembers the state of each control-break group using persistent browser storage.',
'</p>',
'',
'<p>',
'The state is restored after page reloads and future browser sessions until',
'the browser storage is cleared or the plug-in configuration changes.',
'</p>',
'',
'<p>',
'The stored state belongs to the current browser and profile; it does not',
'follow the user to another browser or device.',
'</p>'))
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(20010719929410415)
,p_plugin_attribute_id=>wwv_flow_imp.id(20004569551275381)
,p_display_sequence=>20
,p_display_value=>'Browser Session'
,p_return_value=>'SESSION'
,p_apexlang_name=>'session'
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>',
'Remembers the state of each control-break group for the current browser session.',
'</p>',
'',
'<p>',
'The state is preserved across Interactive Report refreshes and page navigation,',
'but is discarded when the browser session ends.',
'</p>'))
);
wwv_flow_imp_shared.create_plugin_event(
 p_id=>wwv_flow_imp.id(20041347097185401)
,p_plugin_id=>wwv_flow_imp.id(18583403628066902)
,p_name=>'ircontrolbreakchange'
,p_display_name=>'Control Break Change'
);
end;
/
begin
wwv_flow_imp.g_varchar2_table := wwv_flow_imp.empty_varchar2_table;
wwv_flow_imp.g_varchar2_table(1) := '2E69722D636F6E74726F6C2D627265616B2D686561646572207B0A2020646973706C61793A20666C65783B0A2020616C69676E2D6974656D733A2063656E7465723B0A2020696E6C696E652D73697A653A20313030253B0A20206761703A202E3572656D';
wwv_flow_imp.g_varchar2_table(2) := '3B0A7D0A0A2E69722D636F6E74726F6C2D627265616B2D74657874207B0A20206D696E2D696E6C696E652D73697A653A20303B0A7D0A0A2E69722D636F6E74726F6C2D627265616B2D6865616465722D2D656E64202E69722D636F6E74726F6C2D627265';
wwv_flow_imp.g_varchar2_table(3) := '616B2D62746E207B0A20206D617267696E2D696E6C696E652D73746172743A206175746F3B0A7D0A';
null;
end;
/
begin
wwv_flow_imp_shared.create_plugin_file(
 p_id=>wwv_flow_imp.id(20035361987976215)
,p_plugin_id=>wwv_flow_imp.id(18583403628066902)
,p_file_name=>'irControlBreakToggler.css'
,p_mime_type=>'text/css'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_imp.varchar2_to_blob(wwv_flow_imp.g_varchar2_table)
);
end;
/
begin
wwv_flow_imp.g_varchar2_table := wwv_flow_imp.empty_varchar2_table;
wwv_flow_imp.g_varchar2_table(1) := '7661722066695F6A617269735F706C7567696E203D2066695F6A617269735F706C7567696E207C7C207B7D3B0A0A2866756E6374696F6E28242C20706C7567696E29207B0A0A2020706C7567696E2E6972203D20706C7567696E2E6972207C7C207B7D3B';
wwv_flow_imp.g_varchar2_table(2) := '0A0A2020636F6E737420696E7374616E636573203D206E6577205765616B4D617028293B0A0A2020636F6E73742053544F524147455F505245464958203D0A202020202266695F6A617269735F706C7567696E2E6972436F6E74726F6C427265616B546F';
wwv_flow_imp.g_varchar2_table(3) := '67676C6572223B0A0A2020636F6E73742053544F524147455F4B4559203D0A20202020227374617465223B0A0A2020636F6E73742053544F524147455F56455253494F4E203D0A20202020323B0A0A2020636F6E737420434F4E54524F4C5F425245414B';
wwv_flow_imp.g_varchar2_table(4) := '5F53454C4543544F52203D0A202020202274682E612D4952522D6865616465722D2D67726F7570223B0A0A2020636F6E737420425554544F4E5F53454C4543544F52203D0A20202020222E69722D636F6E74726F6C2D627265616B2D62746E223B0A0A20';
wwv_flow_imp.g_varchar2_table(5) := '20636F6E73742049434F4E5F53454C4543544F52203D0A20202020222E69722D636F6E74726F6C2D627265616B2D69636F6E223B0A0A2020636F6E7374204845414445525F434F4E54454E545F53454C4543544F52203D0A20202020222E69722D636F6E';
wwv_flow_imp.g_varchar2_table(6) := '74726F6C2D627265616B2D686561646572223B0A0A2020636F6E7374204348414E47455F4556454E54203D0A20202020226972636F6E74726F6C627265616B6368616E6765223B0A0A2020636F6E73742044454641554C5453203D207B0A20202020696E';
wwv_flow_imp.g_varchar2_table(7) := '697469616C6C79457870616E646564203A20747275652C0A2020202072656D656D626572537461746520202020203A20224E4F222C0A20202020627574746F6E506F736974696F6E202020203A20225354415254222C0A20202020636F6C6C6170736554';
wwv_flow_imp.g_varchar2_table(8) := '69746C6520202020203A20617065782E6C616E672E6765744D6573736167652822415045582E47562E425245414B5F434F4C4C415053452229207C7C2022436F6C6C61707365222C0A20202020657870616E645469746C65202020202020203A20617065';
wwv_flow_imp.g_varchar2_table(9) := '782E6C616E672E6765744D6573736167652822415045582E47562E425245414B5F455850414E442229207C7C2022457870616E64222C0A20202020636F6C6C6170736549636F6E2020202020203A202266612D63686576726F6E2D646F776E222C0A2020';
wwv_flow_imp.g_varchar2_table(10) := '2020627574746F6E437373436C617373657320203A2022742D427574746F6E20742D427574746F6E2D2D6E6F4C6162656C20742D427574746F6E2D2D69636F6E20742D427574746F6E2D2D736D616C6C220A20207D3B0A0A0A20202F2A0A2020202A2052';
wwv_flow_imp.g_varchar2_table(11) := '657475726E207468652064656661756C7420646972656374696F6E616C20657870616E642069636F6E2E0A2020202A0A2020202A20535441525420616E6420454E4420617265206C6F676963616C20706F736974696F6E732C20736F207468652069636F';
wwv_flow_imp.g_varchar2_table(12) := '6E20646972656374696F6E0A2020202A20666F6C6C6F777320746865207465787420646972656374696F6E206F662074686520726567696F6E2E0A2020202A2F0A202066756E6374696F6E2067657444656661756C74457870616E6449636F6E280A2020';
wwv_flow_imp.g_varchar2_table(13) := '2020726567696F6E242C0A20202020627574746F6E506F736974696F6E0A202029207B0A0A20202020636F6E737420697352746C203D0A202020202020726567696F6E242E6373732822646972656374696F6E2229203D3D3D202272746C223B0A0A2020';
wwv_flow_imp.g_varchar2_table(14) := '202069662028627574746F6E506F736974696F6E203D3D3D2022454E442229207B0A0A20202020202072657475726E20697352746C0A20202020202020203F202266612D63686576726F6E2D7269676874220A20202020202020203A202266612D636865';
wwv_flow_imp.g_varchar2_table(15) := '76726F6E2D6C656674223B0A0A202020207D0A0A2020202072657475726E20697352746C0A2020202020203F202266612D63686576726F6E2D6C656674220A2020202020203A202266612D63686576726F6E2D7269676874223B0A0A20207D0A0A0A2020';
wwv_flow_imp.g_varchar2_table(16) := '2F2A0A2020202A205265736F6C7665206F6E65206F72206D6F726520726567696F6E732E0A2020202A0A2020202A20496E697469616C697A6174696F6E2063616E20616363657074206D756C7469706C6520656C656D656E747320736F20746861742061';
wwv_flow_imp.g_varchar2_table(17) := '2044796E616D69630A2020202A20416374696F6E207573696E672061206A51756572792073656C6563746F722063616E20696E697469616C697A65206D756C7469706C65204952732E0A2020202A2F0A202066756E6374696F6E207265736F6C76655265';
wwv_flow_imp.g_varchar2_table(18) := '67696F6E7328726567696F6E29207B0A0A2020202069662028747970656F6620726567696F6E203D3D3D2022737472696E672229207B0A0A2020202020202F2A0A202020202020202A2046697273742074726561742074686520737472696E6720617320';
wwv_flow_imp.g_varchar2_table(19) := '6120706F737369626C6520726567696F6E205374617469632049442E0A202020202020202A2F0A202020202020636F6E737420656C656D656E74203D0A2020202020202020646F63756D656E742E676574456C656D656E744279496428726567696F6E29';
wwv_flow_imp.g_varchar2_table(20) := '3B0A0A20202020202069662028656C656D656E7429207B0A202020202020202072657475726E202428656C656D656E74293B0A2020202020207D0A0A2020202020202F2A0A202020202020202A204F746865727769736520747265617420697420617320';
wwv_flow_imp.g_varchar2_table(21) := '61206A51756572792073656C6563746F722E0A202020202020202A2F0A20202020202072657475726E202428726567696F6E293B0A0A202020207D0A0A2020202072657475726E202428726567696F6E293B0A0A20207D0A0A0A20202F2A0A2020202A20';
wwv_flow_imp.g_varchar2_table(22) := '5265736F6C76652065786163746C79206F6E6520726567696F6E2E0A2020202A0A2020202A205075626C696320415049206D6574686F647320696E74656E74696F6E616C6C79206F706572617465206F6E206F6E6520495220617420612074696D652E0A';
wwv_flow_imp.g_varchar2_table(23) := '2020202A20412073656C6563746F72206D61746368696E67206D756C7469706C6520656C656D656E74732069732072656A65637465642E0A2020202A2F0A202066756E6374696F6E207265736F6C7665526567696F6E28726567696F6E29207B0A0A2020';
wwv_flow_imp.g_varchar2_table(24) := '2020636F6E737420726567696F6E7324203D0A2020202020207265736F6C7665526567696F6E7328726567696F6E293B0A0A2020202072657475726E20726567696F6E73242E6C656E677468203D3D3D20310A2020202020203F20726567696F6E73240A';
wwv_flow_imp.g_varchar2_table(25) := '2020202020203A202428293B0A0A20207D0A0A0A20202F2A0A2020202A204E6F726D616C697A652052656D656D6265722053746174652E0A2020202A0A2020202A20537570706F727465642076616C7565733A0A2020202A0A2020202A2020204E4F0A20';
wwv_flow_imp.g_varchar2_table(26) := '20202A20202053455353494F4E0A2020202A20202050455253495354454E540A2020202A2F0A202066756E6374696F6E206E6F726D616C697A6552656D656D62657253746174652876616C756529207B0A0A202020202F2A0A20202020202A204B656570';
wwv_flow_imp.g_varchar2_table(27) := '20737570706F727420666F7220616E206F6C64657220426F6F6C65616E20636F6E66696775726174696F6E2E0A20202020202A2F0A202020206966202876616C7565203D3D3D207472756529207B0A20202020202072657475726E202253455353494F4E';
wwv_flow_imp.g_varchar2_table(28) := '223B0A202020207D0A0A20202020696620280A20202020202076616C7565203D3D3D2066616C7365207C7C0A20202020202076616C7565203D3D206E756C6C0A2020202029207B0A20202020202072657475726E20224E4F223B0A202020207D0A0A2020';
wwv_flow_imp.g_varchar2_table(29) := '2020636F6E7374206E6F726D616C697A656456616C7565203D0A202020202020537472696E672876616C7565292E746F55707065724361736528293B0A0A2020202072657475726E205B0A202020202020224E4F222C0A2020202020202253455353494F';
wwv_flow_imp.g_varchar2_table(30) := '4E222C0A2020202020202250455253495354454E54220A202020205D2E696E636C75646573286E6F726D616C697A656456616C7565290A2020202020203F206E6F726D616C697A656456616C75650A2020202020203A20224E4F223B0A0A20207D0A0A0A';
wwv_flow_imp.g_varchar2_table(31) := '20202F2A0A2020202A204E6F726D616C697A6520427574746F6E20506F736974696F6E2E0A2020202A0A2020202A20537570706F727465642076616C7565733A0A2020202A0A2020202A20202053544152540A2020202A202020454E440A2020202A2F0A';
wwv_flow_imp.g_varchar2_table(32) := '202066756E6374696F6E206E6F726D616C697A65427574746F6E506F736974696F6E2876616C756529207B0A0A20202020636F6E737420706F736974696F6E203D0A202020202020537472696E67280A202020202020202076616C7565207C7C20225354';
wwv_flow_imp.g_varchar2_table(33) := '415254220A202020202020292E746F55707065724361736528293B0A0A2020202072657475726E20706F736974696F6E203D3D3D2022454E44220A2020202020203F2022454E44220A2020202020203A20225354415254223B0A0A20207D0A0A0A20202F';
wwv_flow_imp.g_varchar2_table(34) := '2A0A2020202A204D6572676520737570706C69656420706C75672D696E2073657474696E677320776974682064656661756C74732E0A2020202A2F0A202066756E6374696F6E206E6F726D616C697A654F7074696F6E73286F7074696F6E7329207B0A0A';
wwv_flow_imp.g_varchar2_table(35) := '20202020636F6E7374206E6F726D616C697A6564203D0A202020202020242E657874656E64280A20202020202020207B7D2C0A202020202020202044454641554C54532C0A20202020202020206F7074696F6E730A202020202020293B0A0A202020206E';
wwv_flow_imp.g_varchar2_table(36) := '6F726D616C697A65642E72656D656D6265725374617465203D0A2020202020206E6F726D616C697A6552656D656D6265725374617465280A20202020202020206E6F726D616C697A65642E72656D656D62657253746174650A202020202020293B0A0A20';
wwv_flow_imp.g_varchar2_table(37) := '2020206E6F726D616C697A65642E627574746F6E506F736974696F6E203D0A2020202020206E6F726D616C697A65427574746F6E506F736974696F6E280A20202020202020206E6F726D616C697A65642E627574746F6E506F736974696F6E0A20202020';
wwv_flow_imp.g_varchar2_table(38) := '2020293B0A0A202020206E6F726D616C697A65642E636F6C6C617073655469746C65203D0A2020202020206E6F726D616C697A65642E636F6C6C617073655469746C65207C7C0A20202020202044454641554C54532E636F6C6C617073655469746C653B';
wwv_flow_imp.g_varchar2_table(39) := '0A0A202020206E6F726D616C697A65642E657870616E645469746C65203D0A2020202020206E6F726D616C697A65642E657870616E645469746C65207C7C0A20202020202044454641554C54532E657870616E645469746C653B0A0A202020206E6F726D';
wwv_flow_imp.g_varchar2_table(40) := '616C697A65642E636F6C6C6170736549636F6E203D0A2020202020206E6F726D616C697A65642E636F6C6C6170736549636F6E207C7C0A20202020202044454641554C54532E636F6C6C6170736549636F6E3B0A0A202020202F2A0A20202020202A204B';
wwv_flow_imp.g_varchar2_table(41) := '65657020657870616E6449636F6E206E756C6C207768656E206E6F206578706C696369742076616C756520697320737570706C6965642E0A20202020202A0A20202020202A20696E6974496E7374616E636528292077696C6C2064657269766520746865';
wwv_flow_imp.g_varchar2_table(42) := '20636F727265637420646972656374696F6E616C2069636F6E0A20202020202A2066726F6D20427574746F6E20506F736974696F6E20616E642074686520726567696F6E207465787420646972656374696F6E2E0A20202020202A2F0A202020206E6F72';
wwv_flow_imp.g_varchar2_table(43) := '6D616C697A65642E657870616E6449636F6E203D0A2020202020206E6F726D616C697A65642E657870616E6449636F6E207C7C0A2020202020206E756C6C3B0A0A202020206E6F726D616C697A65642E627574746F6E437373436C6173736573203D0A20';
wwv_flow_imp.g_varchar2_table(44) := '20202020206E6F726D616C697A65642E627574746F6E437373436C6173736573207C7C0A20202020202044454641554C54532E627574746F6E437373436C61737365733B0A0A2020202072657475726E206E6F726D616C697A65643B0A0A20207D0A0A0A';
wwv_flow_imp.g_varchar2_table(45) := '20202F2A0A2020202A205573656420746F2072657475726E206861736865642067726F7570206B65792E0A2020202A2F0A202066756E6374696F6E2068617368537472696E672876616C756529207B0A0A202020206C65742068617368203D0A20202020';
wwv_flow_imp.g_varchar2_table(46) := '2020307838313163396463353B0A0A20202020666F7220280A2020202020206C65742069203D20303B0A20202020202069203C2076616C75652E6C656E6774683B0A20202020202069202B3D20310A2020202029207B0A0A20202020202068617368205E';
wwv_flow_imp.g_varchar2_table(47) := '3D0A202020202020202076616C75652E63686172436F646541742869293B0A0A20202020202068617368203D0A20202020202020204D6174682E696D756C280A20202020202020202020686173682C0A2020202020202020202030783031303030313933';
wwv_flow_imp.g_varchar2_table(48) := '0A2020202020202020293B0A0A202020207D0A0A2020202072657475726E20280A20202020202068617368203E3E3E20300A20202020292E746F537472696E67283136293B0A0A20207D0A0A20202F2A0A2020202A2052657475726E2041504558207363';
wwv_flow_imp.g_varchar2_table(49) := '6F7065642062726F777365722073746F726167652E0A2020202A2F0A202066756E6374696F6E20676574537461746553746F72616765280A20202020726567696F6E49642C0A2020202072656D656D62657253746174650A202029207B0A0A2020202069';
wwv_flow_imp.g_varchar2_table(50) := '6620280A20202020202021726567696F6E4964207C7C0A20202020202072656D656D6265725374617465203D3D3D20224E4F220A2020202029207B0A20202020202072657475726E206E756C6C3B0A202020207D0A0A20202020636F6E73742073746F72';
wwv_flow_imp.g_varchar2_table(51) := '6167654F7074696F6E73203D207B0A202020202020707265666978202020203A2053544F524147455F5052454649582C0A202020202020757365417070496420203A20747275652C0A202020202020757365506167654964203A20747275652C0A202020';
wwv_flow_imp.g_varchar2_table(52) := '202020726567696F6E496420203A20726567696F6E49640A202020207D3B0A0A202020206966202872656D656D6265725374617465203D3D3D202253455353494F4E2229207B0A0A20202020202072657475726E20617065782E73746F726167650A2020';
wwv_flow_imp.g_varchar2_table(53) := '2020202020202E67657453636F70656453657373696F6E53746F72616765280A2020202020202020202073746F726167654F7074696F6E730A2020202020202020293B0A0A202020207D0A0A202020206966202872656D656D6265725374617465203D3D';
wwv_flow_imp.g_varchar2_table(54) := '3D202250455253495354454E542229207B0A0A20202020202072657475726E20617065782E73746F726167650A20202020202020202E67657453636F7065644C6F63616C53746F72616765280A2020202020202020202073746F726167654F7074696F6E';
wwv_flow_imp.g_varchar2_table(55) := '730A2020202020202020293B0A0A202020207D0A0A2020202072657475726E206E756C6C3B0A0A20207D0A0A0A20202F2A0A2020202A2043726561746520616E20656D7074792073746F7265642D7374617465206F626A6563742E0A2020202A0A202020';
wwv_flow_imp.g_varchar2_table(56) := '2A20696E697469616C6C79457870616E6465642069732073746F726564206173206D6574616461746120736F206368616E67696E6720746861740A2020202A20706C75672D696E2073657474696E6720696E76616C6964617465732070726576696F7573';
wwv_flow_imp.g_varchar2_table(57) := '6C792072656D656D62657265642067726F7570207374617465732E0A2020202A2F0A202066756E6374696F6E2063726561746553746F726564537461746528696E7374616E636529207B0A0A2020202072657475726E207B0A2020202020207665727369';
wwv_flow_imp.g_varchar2_table(58) := '6F6E3A0A202020202020202053544F524147455F56455253494F4E2C0A0A202020202020696E697469616C6C79457870616E6465643A0A2020202020202020696E7374616E63652E6F7074696F6E732E696E697469616C6C79457870616E6465642C0A0A';
wwv_flow_imp.g_varchar2_table(59) := '2020202020207374617465733A0A20202020202020207B7D0A202020207D3B0A0A20207D0A0A0A20202F2A0A2020202A2056616C69646174652072656D656D6265726564207374617465206C6F616465642066726F6D2062726F777365722073746F7261';
wwv_flow_imp.g_varchar2_table(60) := '67652E0A2020202A2F0A202066756E6374696F6E20697356616C696453746F7265645374617465280A20202020696E7374616E63652C0A2020202073746174650A202029207B0A0A2020202072657475726E20426F6F6C65616E280A2020202020207374';
wwv_flow_imp.g_varchar2_table(61) := '6174652026260A20202020202073746174652E76657273696F6E203D3D3D2053544F524147455F56455253494F4E2026260A20202020202073746174652E696E697469616C6C79457870616E646564203D3D3D0A2020202020202020696E7374616E6365';
wwv_flow_imp.g_varchar2_table(62) := '2E6F7074696F6E732E696E697469616C6C79457870616E6465642026260A20202020202073746174652E7374617465732026260A202020202020747970656F662073746174652E737461746573203D3D3D20226F626A656374222026260A202020202020';
wwv_flow_imp.g_varchar2_table(63) := '2141727261792E697341727261792873746174652E737461746573290A20202020293B0A0A20207D0A0A0A20202F2A0A2020202A20536176652072656D656D62657265642073746174652E0A2020202A2F0A202066756E6374696F6E2073617665537461';
wwv_flow_imp.g_varchar2_table(64) := '746528696E7374616E636529207B0A0A202020206966202821696E7374616E63652E737461746553746F7261676529207B0A20202020202072657475726E3B0A202020207D0A0A20202020696E7374616E63652E737461746553746F726167652E736574';
wwv_flow_imp.g_varchar2_table(65) := '4974656D280A20202020202053544F524147455F4B45592C0A2020202020204A534F4E2E737472696E67696679280A2020202020202020696E7374616E63652E73746F72656453746174650A202020202020290A20202020293B0A0A20207D0A0A0A2020';
wwv_flow_imp.g_varchar2_table(66) := '2F2A0A2020202A204C6F61642072656D656D62657265642073746174652E0A2020202A2F0A202066756E6374696F6E206C6F6164537461746528696E7374616E636529207B0A0A20202020696E7374616E63652E73746F7265645374617465203D0A2020';
wwv_flow_imp.g_varchar2_table(67) := '2020202063726561746553746F726564537461746528696E7374616E6365293B0A0A202020206966202821696E7374616E63652E737461746553746F7261676529207B0A20202020202072657475726E3B0A202020207D0A0A20202020636F6E73742073';
wwv_flow_imp.g_varchar2_table(68) := '746F72656456616C7565203D0A202020202020696E7374616E63652E737461746553746F726167652E6765744974656D280A202020202020202053544F524147455F4B45590A202020202020293B0A0A20202020696620282173746F72656456616C7565';
wwv_flow_imp.g_varchar2_table(69) := '29207B0A0A20202020202073617665537461746528696E7374616E6365293B0A0A20202020202072657475726E3B0A0A202020207D0A0A20202020747279207B0A0A202020202020636F6E7374207061727365645374617465203D0A2020202020202020';
wwv_flow_imp.g_varchar2_table(70) := '4A534F4E2E70617273652873746F72656456616C7565293B0A0A202020202020696620280A2020202020202020697356616C696453746F7265645374617465280A20202020202020202020696E7374616E63652C0A202020202020202020207061727365';
wwv_flow_imp.g_varchar2_table(71) := '6453746174650A2020202020202020290A20202020202029207B0A0A2020202020202020696E7374616E63652E73746F7265645374617465203D0A2020202020202020202070617273656453746174653B0A0A202020202020202072657475726E3B0A0A';
wwv_flow_imp.g_varchar2_table(72) := '2020202020207D0A0A202020207D206361746368207B0A0A2020202020202F2A0A202020202020202A2049676E6F726520696E76616C6964206F72206F62736F6C6574652073746F72656420646174612E0A202020202020202A2F0A0A202020207D0A0A';
wwv_flow_imp.g_varchar2_table(73) := '202020202F2A0A20202020202A2053746F7261676520666F726D6174206368616E6765642C2073746F726564206461746120697320696E76616C69642C0A20202020202A206F7220496E697469616C6C7920457870616E64656420686173206368616E67';
wwv_flow_imp.g_varchar2_table(74) := '65642E0A20202020202A2F0A20202020696E7374616E63652E73746F7265645374617465203D0A20202020202063726561746553746F726564537461746528696E7374616E6365293B0A0A2020202073617665537461746528696E7374616E6365293B0A';
wwv_flow_imp.g_varchar2_table(75) := '0A20207D0A0A0A20202F2A0A2020202A2052656D6F76652072656D656D62657265642073746174652066726F6D20626F74682062726F777365722073746F726167652074797065732E0A2020202A0A2020202A20436C656172696E6720626F7468207072';
wwv_flow_imp.g_varchar2_table(76) := '6576656E747320616E206F6C642073746174652066726F6D20756E65787065637465646C790A2020202A207265617070656172696E672069662052656D656D626572205374617465206D6F6465206973206368616E676564206C617465722E0A2020202A';
wwv_flow_imp.g_varchar2_table(77) := '2F0A202066756E6374696F6E20636C65617253746F726564537461746528726567696F6E496429207B0A0A202020206966202821726567696F6E496429207B0A20202020202072657475726E3B0A202020207D0A0A20202020636F6E73742073746F7261';
wwv_flow_imp.g_varchar2_table(78) := '67654F7074696F6E73203D207B0A202020202020707265666978202020203A2053544F524147455F5052454649582C0A202020202020757365417070496420203A20747275652C0A202020202020757365506167654964203A20747275652C0A20202020';
wwv_flow_imp.g_varchar2_table(79) := '2020726567696F6E496420203A20726567696F6E49640A202020207D3B0A0A20202020617065782E73746F726167650A2020202020202E67657453636F70656453657373696F6E53746F72616765280A202020202020202073746F726167654F7074696F';
wwv_flow_imp.g_varchar2_table(80) := '6E730A202020202020290A2020202020202E72656D6F76654974656D280A202020202020202053544F524147455F4B45590A202020202020293B0A0A20202020617065782E73746F726167650A2020202020202E67657453636F7065644C6F63616C5374';
wwv_flow_imp.g_varchar2_table(81) := '6F72616765280A202020202020202073746F726167654F7074696F6E730A202020202020290A2020202020202E72656D6F76654974656D280A202020202020202053544F524147455F4B45590A202020202020293B0A0A20207D0A0A0A20202F2A0A2020';
wwv_flow_imp.g_varchar2_table(82) := '202A2052657475726E2074686520726F777320636F6E74726F6C6C6564206279206F6E6520636F6E74726F6C2D627265616B206865616465722E0A2020202A2F0A202066756E6374696F6E2067657447726F7570526F7773286865616465722429207B0A';
wwv_flow_imp.g_varchar2_table(83) := '0A2020202072657475726E20686561646572240A2020202020202E636C6F736573742822747222290A2020202020202E6E657874556E74696C280A20202020202020206074723A68617328247B434F4E54524F4C5F425245414B5F53454C4543544F527D';
wwv_flow_imp.g_varchar2_table(84) := '29600A202020202020293B0A0A20207D0A0A0A20202F2A0A2020202A20415045582D67656E65726174656420636F6E74726F6C2D627265616B20686561646572204944732061726520706167696E6174696F6E2D6C6F63616C0A2020202A20616E642063';
wwv_flow_imp.g_varchar2_table(85) := '616E20626520726575736564206F6E20616E6F74686572207265706F727420706167652E20557365206E6F726D616C697A65640A2020202A2072656E646572656420636F6E74726F6C2D627265616B207465787420617320746865206C6F676963616C20';
wwv_flow_imp.g_varchar2_table(86) := '67726F7570206964656E746974792E0A2020202A2F0A202066756E6374696F6E2067657447726F75704B6579286865616465722429207B0A0A20202020636F6E737420636C6F6E6524203D0A202020202020686561646572242E636C6F6E6528293B0A0A';
wwv_flow_imp.g_varchar2_table(87) := '20202020636C6F6E65240A2020202020202E66696E64280A2020202020202020425554544F4E5F53454C4543544F520A202020202020290A2020202020202E72656D6F766528293B0A0A20202020636F6E73742076616C7565203D0A202020202020636C';
wwv_flow_imp.g_varchar2_table(88) := '6F6E65240A2020202020202E7465787428290A2020202020202E7265706C616365280A20202020202020202F5C732B2F672C0A20202020202020202220220A202020202020290A2020202020202E7472696D28293B0A0A2020202072657475726E206861';
wwv_flow_imp.g_varchar2_table(89) := '7368537472696E67280A20202020202076616C75650A20202020293B0A0A20207D0A0A0A20202F2A0A2020202A20436F6E7665727420612076616C756520696E746F2061207361666520667261676D656E7420666F722067656E65726174656420494473';
wwv_flow_imp.g_varchar2_table(90) := '2E0A2020202A2F0A202066756E6374696F6E20736166654964506172742876616C756529207B0A0A2020202072657475726E20537472696E672876616C7565290A2020202020202E7265706C616365280A20202020202020202F5B5E412D5A612D7A302D';
wwv_flow_imp.g_varchar2_table(91) := '395F2D5D2F672C0A2020202020202020225F220A202020202020293B0A0A20207D0A0A0A20202F2A0A2020202A20456E7375726520657665727920636F6E74726F6C6C656420726F772068617320616E2049442E0A2020202A0A2020202A20494473206F';
wwv_flow_imp.g_varchar2_table(92) := '6E6C79206E65656420746F20626520756E6971756520696E207468652063757272656E746C792072656E646572656420646F63756D656E742E0A2020202A2052657573696E67207468652073616D652067656E6572617465642049447320616674657220';
wwv_flow_imp.g_varchar2_table(93) := '496E746572616374697665205265706F72740A2020202A20706167696E6174696F6E2069732076616C69642062656361757365207468652070726576696F7573207265706F727420726F77732068617665206265656E0A2020202A207265706C61636564';
wwv_flow_imp.g_varchar2_table(94) := '2E0A2020202A2F0A202066756E6374696F6E20656E73757265436F6E74726F6C6C6564526F77496473280A20202020696E7374616E63652C0A20202020686561646572242C0A2020202067726F7570496E6465780A202029207B0A0A20202020636F6E73';
wwv_flow_imp.g_varchar2_table(95) := '7420726F777324203D0A20202020202067657447726F7570526F77732868656164657224293B0A0A20202020636F6E737420696473203D0A2020202020205B5D3B0A0A20202020636F6E7374206865616465724964203D0A202020202020686561646572';
wwv_flow_imp.g_varchar2_table(96) := '242E617474722822696422293B0A0A20202020636F6E737420726567696F6E50617274203D0A20202020202073616665496450617274280A2020202020202020696E7374616E63652E726567696F6E4964207C7C0A2020202020202020226972220A2020';
wwv_flow_imp.g_varchar2_table(97) := '20202020293B0A0A20202020636F6E73742067726F757050617274203D0A20202020202073616665496450617274280A20202020202020206865616465724964207C7C0A20202020202020206067726F75705F247B67726F7570496E646578202B20317D';
wwv_flow_imp.g_varchar2_table(98) := '600A202020202020293B0A0A20202020726F7773242E656163682866756E6374696F6E28726F77496E64657829207B0A0A202020202020636F6E737420726F7724203D0A2020202020202020242874686973293B0A0A2020202020206C657420726F7749';
wwv_flow_imp.g_varchar2_table(99) := '64203D0A2020202020202020726F77242E617474722822696422293B0A0A2020202020206966202821726F77496429207B0A0A2020202020202020636F6E737420626173654964203D0A2020202020202020202060247B726567696F6E506172747D5F63';
wwv_flow_imp.g_varchar2_table(100) := '625F247B67726F7570506172747D5F726F775F247B726F77496E646578202B20317D603B0A0A2020202020202020726F774964203D0A202020202020202020206261736549643B0A0A20202020202020206C657420636F756E746572203D0A2020202020';
wwv_flow_imp.g_varchar2_table(101) := '2020202020323B0A0A20202020202020202F2A0A2020202020202020202A2050726F7465637420616761696E73742061206475706C69636174652049442074686174206578697374730A2020202020202020202A20696E207468652063757272656E7420';
wwv_flow_imp.g_varchar2_table(102) := '646F63756D656E742E0A2020202020202020202A2F0A20202020202020207768696C6520280A20202020202020202020646F63756D656E742E676574456C656D656E744279496428726F774964292026260A20202020202020202020646F63756D656E74';
wwv_flow_imp.g_varchar2_table(103) := '2E676574456C656D656E744279496428726F7749642920213D3D20746869730A202020202020202029207B0A0A20202020202020202020726F774964203D0A20202020202020202020202060247B6261736549647D5F247B636F756E7465727D603B0A0A';
wwv_flow_imp.g_varchar2_table(104) := '20202020202020202020636F756E746572202B3D20313B0A0A20202020202020207D0A0A2020202020202020726F77242E61747472280A20202020202020202020226964222C0A20202020202020202020726F7749640A2020202020202020293B0A0A20';
wwv_flow_imp.g_varchar2_table(105) := '20202020207D0A0A2020202020206964732E70757368280A2020202020202020726F7749640A202020202020293B0A0A202020207D293B0A0A2020202072657475726E206964733B0A0A20207D0A0A0A20202F2A0A2020202A20456E7375726520746865';
wwv_flow_imp.g_varchar2_table(106) := '20636F6E74726F6C2D627265616B206865616465722068617320616E20696E6E6572206C61796F757420636F6E7461696E65722E0A2020202A0A2020202A20546865203C74683E2072656D61696E732061207461626C652063656C6C2E204F6E6C792074';
wwv_flow_imp.g_varchar2_table(107) := '68652067656E65726174656420696E6E657220636F6E7461696E65720A2020202A207573657320666C6578626F782C2061766F6964696E672074686520766572746963616C2D616C69676E6D656E7420697373756573206361757365642062790A202020';
wwv_flow_imp.g_varchar2_table(108) := '2A20666C6F6174696E672074686520627574746F6E206469726563746C7920696E7369646520746865207461626C652063656C6C2E0A2020202A2F0A202066756E6374696F6E20656E73757265486561646572436F6E74656E7428686561646572242920';
wwv_flow_imp.g_varchar2_table(109) := '7B0A0A202020206C657420636F6E74656E7424203D0A202020202020686561646572242E6368696C6472656E280A20202020202020204845414445525F434F4E54454E545F53454C4543544F520A202020202020292E666972737428293B0A0A20202020';
wwv_flow_imp.g_varchar2_table(110) := '69662028636F6E74656E74242E6C656E67746829207B0A20202020202072657475726E20636F6E74656E74243B0A202020207D0A0A202020202F2A0A20202020202A205072657365727665206120627574746F6E2066726F6D20616E206561726C696572';
wwv_flow_imp.g_varchar2_table(111) := '20696E697469616C697A6174696F6E2C2069662070726573656E742C0A20202020202A207768696C65207772617070696E6720746865206F726967696E616C204150455820636F6E74726F6C2D627265616B20636F6E74656E742E0A20202020202A2F0A';
wwv_flow_imp.g_varchar2_table(112) := '20202020636F6E7374206578697374696E67427574746F6E24203D0A202020202020686561646572242E6368696C6472656E280A2020202020202020425554544F4E5F53454C4543544F520A202020202020292E666972737428292E6465746163682829';
wwv_flow_imp.g_varchar2_table(113) := '3B0A0A20202020636F6E7374207465787424203D0A2020202020202428223C7370616E3E222C207B0A2020202020202020636C617373203A202269722D636F6E74726F6C2D627265616B2D74657874220A2020202020207D293B0A0A2020202074657874';
wwv_flow_imp.g_varchar2_table(114) := '242E617070656E64280A202020202020686561646572242E636F6E74656E747328290A20202020293B0A0A20202020636F6E74656E7424203D0A2020202020202428223C7370616E3E222C207B0A2020202020202020636C617373203A202269722D636F';
wwv_flow_imp.g_varchar2_table(115) := '6E74726F6C2D627265616B2D686561646572220A2020202020207D293B0A0A20202020636F6E74656E74242E617070656E64280A20202020202074657874240A20202020293B0A0A20202020696620286578697374696E67427574746F6E242E6C656E67';
wwv_flow_imp.g_varchar2_table(116) := '746829207B0A0A202020202020636F6E74656E74242E617070656E64280A20202020202020206578697374696E67427574746F6E240A202020202020293B0A0A202020207D0A0A20202020686561646572242E617070656E64280A202020202020636F6E';
wwv_flow_imp.g_varchar2_table(117) := '74656E74240A20202020293B0A0A2020202072657475726E20636F6E74656E74243B0A0A20207D0A0A0A20202F2A0A2020202A20437265617465206F722072657475726E2074686520746F67676C6520627574746F6E20666F72206F6E6520636F6E7472';
wwv_flow_imp.g_varchar2_table(118) := '6F6C20627265616B2E0A2020202A2F0A202066756E6374696F6E20656E73757265427574746F6E280A20202020696E7374616E63652C0A20202020686561646572242C0A2020202067726F7570496E6465780A202029207B0A0A20202020636F6E737420';
wwv_flow_imp.g_varchar2_table(119) := '636F6E74656E7424203D0A202020202020656E73757265486561646572436F6E74656E74280A2020202020202020686561646572240A202020202020293B0A0A202020206C657420627574746F6E24203D0A202020202020636F6E74656E74242E636869';
wwv_flow_imp.g_varchar2_table(120) := '6C6472656E280A2020202020202020425554544F4E5F53454C4543544F520A202020202020292E666972737428293B0A0A202020202F2A0A20202020202A204372656174652074686520627574746F6E207768656E20697420646F65736E277420616C72';
wwv_flow_imp.g_varchar2_table(121) := '656164792065786973742E0A20202020202A2F0A202020206966202821627574746F6E242E6C656E67746829207B0A0A202020202020627574746F6E24203D0A20202020202020202428223C627574746F6E3E222C207B0A202020202020202020207479';
wwv_flow_imp.g_varchar2_table(122) := '7065203A2022627574746F6E220A20202020202020207D293B0A0A202020207D0A0A0A202020202F2A0A20202020202A20456E73757265207468652069636F6E206578697374732E0A20202020202A2F0A202020206C65742069636F6E24203D0A202020';
wwv_flow_imp.g_varchar2_table(123) := '202020627574746F6E242E6368696C6472656E280A202020202020202049434F4E5F53454C4543544F520A202020202020293B0A0A20202020696620282169636F6E242E6C656E67746829207B0A0A20202020202069636F6E24203D0A20202020202020';
wwv_flow_imp.g_varchar2_table(124) := '202428223C7370616E3E222C207B0A2020202020202020202022617269612D68696464656E22203A202274727565222C0A20202020202020202020636C6173732020202020202020203A2022742D49636F6E2066612069722D636F6E74726F6C2D627265';
wwv_flow_imp.g_varchar2_table(125) := '616B2D69636F6E220A20202020202020207D293B0A0A202020202020627574746F6E242E617070656E64280A202020202020202069636F6E240A202020202020293B0A0A202020207D0A0A0A202020202F2A0A20202020202A2052656672657368206275';
wwv_flow_imp.g_varchar2_table(126) := '74746F6E20636C617373657320696E2063617365206170706C69636174696F6E2D73636F70650A20202020202A20706C75672D696E20636F6E66696775726174696F6E206368616E6765642E0A20202020202A2F0A20202020627574746F6E242E617474';
wwv_flow_imp.g_varchar2_table(127) := '72280A20202020202022636C617373222C0A20202020202060247B696E7374616E63652E6F7074696F6E732E627574746F6E437373436C61737365737D2069722D636F6E74726F6C2D627265616B2D62746E600A20202020202020202E7472696D28290A';
wwv_flow_imp.g_varchar2_table(128) := '20202020293B0A0A0A202020202F2A0A20202020202A20506F736974696F6E206973206170706C69656420746F2074686520696E6E657220666C657820636F6E7461696E657220726174686572207468616E0A20202020202A20666C6F6174696E672074';
wwv_flow_imp.g_varchar2_table(129) := '686520627574746F6E20696E7369646520746865207461626C652063656C6C2E0A20202020202A2F0A20202020636F6E74656E74240A2020202020202E746F67676C65436C617373280A20202020202020202269722D636F6E74726F6C2D627265616B2D';
wwv_flow_imp.g_varchar2_table(130) := '6865616465722D2D7374617274222C0A2020202020202020696E7374616E63652E6F7074696F6E732E627574746F6E506F736974696F6E203D3D3D0A20202020202020202020225354415254220A202020202020290A2020202020202E746F67676C6543';
wwv_flow_imp.g_varchar2_table(131) := '6C617373280A20202020202020202269722D636F6E74726F6C2D627265616B2D6865616465722D2D656E64222C0A2020202020202020696E7374616E63652E6F7074696F6E732E627574746F6E506F736974696F6E203D3D3D0A20202020202020202020';
wwv_flow_imp.g_varchar2_table(132) := '22454E44220A202020202020293B0A0A0A202020202F2A0A20202020202A204B65657020444F4D206F7264657220616C69676E656420776974682074686520636F6E66696775726564206C6F676963616C20706F736974696F6E2E0A20202020202A2F0A';
wwv_flow_imp.g_varchar2_table(133) := '20202020696620280A202020202020696E7374616E63652E6F7074696F6E732E627574746F6E506F736974696F6E203D3D3D0A20202020202022454E44220A2020202029207B0A0A202020202020636F6E74656E74242E617070656E64280A2020202020';
wwv_flow_imp.g_varchar2_table(134) := '202020627574746F6E240A202020202020293B0A0A202020207D20656C7365207B0A0A202020202020636F6E74656E74242E70726570656E64280A2020202020202020627574746F6E240A202020202020293B0A0A202020207D0A0A0A202020202F2A0A';
wwv_flow_imp.g_varchar2_table(135) := '20202020202A2045737461626C6973682074686520415249412072656C6174696F6E73686970206265747765656E2074686520627574746F6E0A20202020202A20616E642074686520726F777320636F6E74726F6C6C656420627920746869732067726F';
wwv_flow_imp.g_varchar2_table(136) := '75702E0A20202020202A2F0A20202020636F6E737420636F6E74726F6C6C6564496473203D0A202020202020656E73757265436F6E74726F6C6C6564526F77496473280A2020202020202020696E7374616E63652C0A2020202020202020686561646572';
wwv_flow_imp.g_varchar2_table(137) := '242C0A202020202020202067726F7570496E6465780A202020202020293B0A0A2020202069662028636F6E74726F6C6C65644964732E6C656E67746829207B0A0A202020202020627574746F6E242E61747472280A202020202020202022617269612D63';
wwv_flow_imp.g_varchar2_table(138) := '6F6E74726F6C73222C0A2020202020202020636F6E74726F6C6C65644964732E6A6F696E28222022290A202020202020293B0A0A202020207D20656C7365207B0A0A202020202020627574746F6E242E72656D6F766541747472280A2020202020202020';
wwv_flow_imp.g_varchar2_table(139) := '22617269612D636F6E74726F6C73220A202020202020293B0A0A202020207D0A0A2020202072657475726E20627574746F6E243B0A0A20207D0A0A0A20202F2A0A2020202A20557064617465207469746C652C2061636365737369626C65206C6162656C';
wwv_flow_imp.g_varchar2_table(140) := '2C20657870616E6465642073746174652C20616E642069636F6E2E0A2020202A2F0A202066756E6374696F6E20736574427574746F6E5374617465280A20202020696E7374616E63652C0A20202020627574746F6E242C0A202020206973457870616E64';
wwv_flow_imp.g_varchar2_table(141) := '65640A202029207B0A0A20202020636F6E7374207469746C65203D0A2020202020206973457870616E6465640A20202020202020203F20696E7374616E63652E6F7074696F6E732E636F6C6C617073655469746C650A20202020202020203A20696E7374';
wwv_flow_imp.g_varchar2_table(142) := '616E63652E6F7074696F6E732E657870616E645469746C653B0A0A20202020636F6E73742069636F6E203D0A2020202020206973457870616E6465640A20202020202020203F20696E7374616E63652E6F7074696F6E732E636F6C6C6170736549636F6E';
wwv_flow_imp.g_varchar2_table(143) := '0A20202020202020203A20696E7374616E63652E6F7074696F6E732E657870616E6449636F6E3B0A0A0A20202020627574746F6E240A2020202020202E61747472287B0A20202020202020207469746C653A0A202020202020202020207469746C652C0A';
wwv_flow_imp.g_varchar2_table(144) := '0A202020202020202022617269612D6C6162656C223A0A202020202020202020207469746C652C0A0A202020202020202022617269612D657870616E646564223A0A202020202020202020206973457870616E6465642E746F537472696E6728290A2020';
wwv_flow_imp.g_varchar2_table(145) := '202020207D293B0A0A0A20202020627574746F6E240A2020202020202E6368696C6472656E280A202020202020202049434F4E5F53454C4543544F520A202020202020290A2020202020202E72656D6F7665436C617373280A202020202020202060247B';
wwv_flow_imp.g_varchar2_table(146) := '696E7374616E63652E6F7074696F6E732E636F6C6C6170736549636F6E7D20247B696E7374616E63652E6F7074696F6E732E657870616E6449636F6E7D600A202020202020290A2020202020202E616464436C617373280A202020202020202069636F6E';
wwv_flow_imp.g_varchar2_table(147) := '0A202020202020293B0A0A20207D0A0A0A20202F2A0A2020202A2054726967676572206F6E6520726567696F6E2D6C6576656C206368616E6765206576656E742E0A2020202A0A2020202A20555345523A0A2020202A2020204F6E652067726F7570206B';
wwv_flow_imp.g_varchar2_table(148) := '65792E0A2020202A0A2020202A20455850414E445F414C4C202F20434F4C4C415053455F414C4C202F2052455345543A0A2020202A202020416C6C206368616E6765642067726F7570206B65797320696E206F6E65206576656E742E0A2020202A2F0A20';
wwv_flow_imp.g_varchar2_table(149) := '2066756E6374696F6E20747269676765724368616E67654576656E74280A20202020696E7374616E63652C0A202020206865616465724964732C0A202020206973457870616E6465642C0A20202020736F757263650A202029207B0A0A20202020617065';
wwv_flow_imp.g_varchar2_table(150) := '782E6576656E742E74726967676572280A202020202020696E7374616E63652E726567696F6E242C0A2020202020204348414E47455F4556454E542C0A2020202020207B0A2020202020202020726567696F6E49643A0A20202020202020202020696E73';
wwv_flow_imp.g_varchar2_table(151) := '74616E63652E726567696F6E49642C0A0A20202020202020206865616465724964733A0A202020202020202020206865616465724964732C0A0A2020202020202020657870616E6465643A0A202020202020202020206973457870616E6465642C0A0A20';
wwv_flow_imp.g_varchar2_table(152) := '20202020202020736F757263653A0A20202020202020202020736F757263650A2020202020207D0A20202020293B0A0A20207D0A0A0A20202F2A0A2020202A20536574206F6E6520636F6E74726F6C2D627265616B2067726F757020746F207468652072';
wwv_flow_imp.g_varchar2_table(153) := '65717565737465642073746174652E0A2020202A0A2020202A2070657273697374537461746520757064617465732074686520696E2D6D656D6F72792072656D656D62657265642073746174652E0A2020202A0A2020202A2053746F7261676520697320';
wwv_flow_imp.g_varchar2_table(154) := '7772697474656E206279207468652063616C6C657220736F20746861742062756C6B206F7065726174696F6E730A2020202A206F6E6C79206E65656420746F207772697465206F6E63652E0A2020202A0A2020202A206576656E74536F757263653A0A20';
wwv_flow_imp.g_varchar2_table(155) := '20202A0A2020202A202020555345520A2020202A2020206E756C6C0A2020202A0A2020202A2042756C6B206F7065726174696F6E732070617373206E756C6C206865726520616E6420656D6974206F6E65206167677265676174650A2020202A20657665';
wwv_flow_imp.g_varchar2_table(156) := '6E7420616674657220616C6C2067726F7570732068617665206265656E2070726F6365737365642E0A2020202A2F0A202066756E6374696F6E2073657447726F7570457870616E646564280A20202020696E7374616E63652C0A20202020686561646572';
wwv_flow_imp.g_varchar2_table(157) := '242C0A202020206973457870616E6465642C0A202020207065727369737453746174652C0A202020206576656E74536F757263650A202029207B0A0A20202020636F6E737420627574746F6E24203D0A202020202020686561646572242E66696E64280A';
wwv_flow_imp.g_varchar2_table(158) := '2020202020202020425554544F4E5F53454C4543544F520A202020202020292E666972737428293B0A0A20202020636F6E73742070726576696F7573457870616E646564203D0A202020202020627574746F6E242E61747472280A202020202020202022';
wwv_flow_imp.g_varchar2_table(159) := '617269612D657870616E646564220A20202020202029203D3D3D202274727565223B0A0A20202020636F6E73742067726F75704B6579203D0A20202020202067657447726F75704B6579280A2020202020202020686561646572240A202020202020293B';
wwv_flow_imp.g_varchar2_table(160) := '0A0A20202020736574427574746F6E5374617465280A202020202020696E7374616E63652C0A202020202020627574746F6E242C0A2020202020206973457870616E6465640A20202020293B0A0A2020202067657447726F7570526F7773286865616465';
wwv_flow_imp.g_varchar2_table(161) := '7224290A2020202020202E746F67676C65280A20202020202020206973457870616E6465640A202020202020293B0A0A0A202020202F2A0A20202020202A205570646174652072656D656D62657265642073746174652E0A20202020202A2F0A20202020';
wwv_flow_imp.g_varchar2_table(162) := '696620280A2020202020207065727369737453746174652026260A202020202020696E7374616E63652E737461746553746F726167652026260A20202020202067726F75704B65790A2020202029207B0A0A202020202020696E7374616E63652E73746F';
wwv_flow_imp.g_varchar2_table(163) := '72656453746174650A20202020202020202E7374617465735B67726F75704B65795D203D0A202020202020202020206973457870616E6465643B0A0A202020207D0A0A20202020636F6E7374206368616E676564203D0A20202020202070726576696F75';
wwv_flow_imp.g_varchar2_table(164) := '73457870616E64656420213D3D0A2020202020206973457870616E6465643B0A0A20202020696620280A2020202020206368616E6765642026260A2020202020206576656E74536F757263650A2020202029207B0A0A202020202020636F6E7374206865';
wwv_flow_imp.g_varchar2_table(165) := '616465724964203D0A2020202020202020686561646572242E61747472280A20202020202020202020226964220A2020202020202020293B0A0A202020202020747269676765724368616E67654576656E74280A2020202020202020696E7374616E6365';
wwv_flow_imp.g_varchar2_table(166) := '2C0A202020202020202068656164657249640A202020202020202020203F205B68656164657249645D0A202020202020202020203A205B5D2C0A20202020202020206973457870616E6465642C0A20202020202020206576656E74536F757263650A2020';
wwv_flow_imp.g_varchar2_table(167) := '20202020293B0A0A202020207D0A0A2020202072657475726E206368616E6765643B0A0A20207D0A0A0A20202F2A0A2020202A2052657475726E20616C6C2063757272656E7420636F6E74726F6C2D627265616B206865616465727320666F72206F6E65';
wwv_flow_imp.g_varchar2_table(168) := '20726567696F6E2E0A2020202A2F0A202066756E6374696F6E20676574427265616B4865616465727328696E7374616E636529207B0A0A2020202072657475726E20696E7374616E63652E726567696F6E240A2020202020202E66696E64280A20202020';
wwv_flow_imp.g_varchar2_table(169) := '20202020434F4E54524F4C5F425245414B5F53454C4543544F520A202020202020293B0A0A20207D0A0A0A20202F2A0A2020202A20496E697469616C697A6520616C6C2063757272656E7420636F6E74726F6C2D627265616B2067726F7570732E0A2020';
wwv_flow_imp.g_varchar2_table(170) := '202A2F0A202066756E6374696F6E20696E697469616C697A6547726F75707328696E7374616E636529207B0A0A20202020676574427265616B4865616465727328696E7374616E6365290A2020202020202E656163682866756E6374696F6E2867726F75';
wwv_flow_imp.g_varchar2_table(171) := '70496E64657829207B0A0A2020202020202020636F6E73742068656164657224203D0A20202020202020202020242874686973293B0A0A2020202020202020636F6E73742067726F75704B6579203D0A2020202020202020202067657447726F75704B65';
wwv_flow_imp.g_varchar2_table(172) := '79280A202020202020202020202020686561646572240A20202020202020202020293B0A0A20202020202020206C6574206973457870616E646564203D0A20202020202020202020696E7374616E63652E6F7074696F6E730A2020202020202020202020';
wwv_flow_imp.g_varchar2_table(173) := '202E696E697469616C6C79457870616E6465643B0A0A0A20202020202020202F2A0A2020202020202020202A2052656D656D62657265642073746174652074616B657320707265636564656E63652E0A2020202020202020202A2F0A2020202020202020';
wwv_flow_imp.g_varchar2_table(174) := '696620280A20202020202020202020696E7374616E63652E737461746553746F726167652026260A2020202020202020202067726F75704B65792026260A202020202020202020204F626A6563742E70726F746F747970650A2020202020202020202020';
wwv_flow_imp.g_varchar2_table(175) := '202E6861734F776E50726F70657274792E63616C6C280A2020202020202020202020202020696E7374616E63652E73746F72656453746174652E7374617465732C0A202020202020202020202020202067726F75704B65790A2020202020202020202020';
wwv_flow_imp.g_varchar2_table(176) := '20290A202020202020202029207B0A0A202020202020202020206973457870616E646564203D0A202020202020202020202020696E7374616E63652E73746F72656453746174650A20202020202020202020202020202E7374617465735B67726F75704B';
wwv_flow_imp.g_varchar2_table(177) := '65795D3B0A0A20202020202020207D0A0A2020202020202020656E73757265427574746F6E280A20202020202020202020696E7374616E63652C0A20202020202020202020686561646572242C0A2020202020202020202067726F7570496E6465780A20';
wwv_flow_imp.g_varchar2_table(178) := '20202020202020293B0A0A0A20202020202020202F2A0A2020202020202020202A20496E697469616C697A6174696F6E2F726573746F726174696F6E20646F6573206E6F743A0A2020202020202020202A0A2020202020202020202A202D206372656174';
wwv_flow_imp.g_varchar2_table(179) := '652072656D656D626572656420737461746520656E74726965730A2020202020202020202A202D2066697265206368616E6765206576656E74730A2020202020202020202A2F0A202020202020202073657447726F7570457870616E646564280A202020';
wwv_flow_imp.g_varchar2_table(180) := '20202020202020696E7374616E63652C0A20202020202020202020686561646572242C0A202020202020202020206973457870616E6465642C0A2020202020202020202066616C73652C0A202020202020202020206E756C6C0A2020202020202020293B';
wwv_flow_imp.g_varchar2_table(181) := '0A0A2020202020207D293B0A0A20207D0A0A0A20202F2A0A2020202A20417474616368207468652064656C65676174656420636C69636B2068616E646C65722E0A2020202A2F0A202066756E6374696F6E20617474616368436C69636B48616E646C6572';
wwv_flow_imp.g_varchar2_table(182) := '28696E7374616E636529207B0A0A20202020696E7374616E63652E726567696F6E240A2020202020202E6F6666280A202020202020202022636C69636B2E636F6E74726F6C427265616B546F67676C65220A202020202020290A2020202020202E6F6E28';
wwv_flow_imp.g_varchar2_table(183) := '0A202020202020202022636C69636B2E636F6E74726F6C427265616B546F67676C65222C0A2020202020202020425554544F4E5F53454C4543544F522C0A202020202020202066756E6374696F6E2829207B0A0A20202020202020202020636F6E737420';
wwv_flow_imp.g_varchar2_table(184) := '627574746F6E24203D0A202020202020202020202020242874686973293B0A0A20202020202020202020636F6E73742068656164657224203D0A202020202020202020202020627574746F6E242E636C6F73657374280A20202020202020202020202020';
wwv_flow_imp.g_varchar2_table(185) := '20434F4E54524F4C5F425245414B5F53454C4543544F520A202020202020202020202020293B0A0A20202020202020202020636F6E7374206973457870616E646564203D0A202020202020202020202020627574746F6E242E61747472280A2020202020';
wwv_flow_imp.g_varchar2_table(186) := '20202020202020202022617269612D657870616E646564220A20202020202020202020202029203D3D3D202274727565223B0A0A202020202020202020202F2A0A20202020202020202020202A205573657220696E746572616374696F6E206368616E67';
wwv_flow_imp.g_varchar2_table(187) := '6573206F6E652067726F757020616E64207468657265666F72650A20202020202020202020202A20656D697473206F6E652055534552206368616E6765206576656E742E0A20202020202020202020202A2F0A2020202020202020202073657447726F75';
wwv_flow_imp.g_varchar2_table(188) := '70457870616E646564280A202020202020202020202020696E7374616E63652C0A202020202020202020202020686561646572242C0A202020202020202020202020216973457870616E6465642C0A202020202020202020202020747275652C0A202020';
wwv_flow_imp.g_varchar2_table(189) := '2020202020202020202255534552220A20202020202020202020293B0A0A20202020202020202020736176655374617465280A202020202020202020202020696E7374616E63650A20202020202020202020293B0A0A20202020202020207D0A20202020';
wwv_flow_imp.g_varchar2_table(190) := '2020293B0A0A20207D0A0A0A20202F2A0A2020202A2052657475726E2074686520696E697469616C697A656420696E7374616E636520666F722065786163746C79206F6E6520726567696F6E2E0A2020202A0A2020202A205075626C696320415049206D';
wwv_flow_imp.g_varchar2_table(191) := '6574686F64732075736520746869732068656C7065722E0A2020202A2F0A202066756E6374696F6E20676574496E7374616E636528726567696F6E29207B0A0A20202020636F6E737420726567696F6E24203D0A2020202020207265736F6C7665526567';
wwv_flow_imp.g_varchar2_table(192) := '696F6E280A2020202020202020726567696F6E0A202020202020293B0A0A202020206966202821726567696F6E242E6C656E67746829207B0A20202020202072657475726E206E756C6C3B0A202020207D0A0A2020202072657475726E20696E7374616E';
wwv_flow_imp.g_varchar2_table(193) := '6365732E676574280A202020202020726567696F6E245B305D0A2020202029207C7C206E756C6C3B0A0A20207D0A0A0A20202F2A0A2020202A20496E697469616C697A65206F6E6520496E746572616374697665205265706F727420726567696F6E2E0A';
wwv_flow_imp.g_varchar2_table(194) := '2020202A2F0A202066756E6374696F6E20696E6974496E7374616E6365280A20202020726567696F6E2C0A202020206F7074696F6E730A202029207B0A0A20202020636F6E737420726567696F6E24203D0A2020202020202428726567696F6E292E6669';
wwv_flow_imp.g_varchar2_table(195) := '72737428293B0A0A202020206966202821726567696F6E242E6C656E67746829207B0A20202020202072657475726E2066616C73653B0A202020207D0A0A0A20202020636F6E7374206E6F726D616C697A65644F7074696F6E73203D0A2020202020206E';
wwv_flow_imp.g_varchar2_table(196) := '6F726D616C697A654F7074696F6E73280A20202020202020206F7074696F6E730A202020202020293B0A0A0A202020202F2A0A20202020202A205768656E20457870616E642049636F6E20697320656D7074792C206175746F6D61746963616C6C792073';
wwv_flow_imp.g_varchar2_table(197) := '656C6563740A20202020202A2074686520646972656374696F6E616C2069636F6E206261736564206F6E3A0A20202020202A0A20202020202A202D20427574746F6E20506F736974696F6E0A20202020202A202D204C5452202F2052544C206469726563';
wwv_flow_imp.g_varchar2_table(198) := '74696F6E0A20202020202A2F0A2020202069662028216E6F726D616C697A65644F7074696F6E732E657870616E6449636F6E29207B0A0A2020202020206E6F726D616C697A65644F7074696F6E732E657870616E6449636F6E203D0A2020202020202020';
wwv_flow_imp.g_varchar2_table(199) := '67657444656661756C74457870616E6449636F6E280A20202020202020202020726567696F6E242C0A202020202020202020206E6F726D616C697A65644F7074696F6E732E627574746F6E506F736974696F6E0A2020202020202020293B0A0A20202020';
wwv_flow_imp.g_varchar2_table(200) := '7D0A0A0A20202020636F6E737420726567696F6E4964203D0A202020202020726567696F6E242E617474722822696422293B0A0A0A20202020636F6E737420696E7374616E6365203D207B0A0A202020202020726567696F6E243A0A2020202020202020';
wwv_flow_imp.g_varchar2_table(201) := '726567696F6E242C0A0A202020202020726567696F6E49643A0A2020202020202020726567696F6E49642C0A0A2020202020206F7074696F6E733A0A20202020202020206E6F726D616C697A65644F7074696F6E732C0A0A202020202020737461746553';
wwv_flow_imp.g_varchar2_table(202) := '746F726167653A0A2020202020202020676574537461746553746F72616765280A20202020202020202020726567696F6E49642C0A202020202020202020206E6F726D616C697A65644F7074696F6E732E72656D656D62657253746174650A2020202020';
wwv_flow_imp.g_varchar2_table(203) := '202020292C0A0A20202020202073746F72656453746174653A0A20202020202020206E756C6C0A0A202020207D3B0A0A0A202020206C6F61645374617465280A202020202020696E7374616E63650A20202020293B0A0A0A202020202F2A0A2020202020';
wwv_flow_imp.g_varchar2_table(204) := '2A2053746F7265207468697320726567696F6E20617320616E20696E646570656E64656E7420706C75672D696E20696E7374616E63652E0A20202020202A2F0A20202020696E7374616E6365732E736574280A202020202020726567696F6E245B305D2C';
wwv_flow_imp.g_varchar2_table(205) := '0A202020202020696E7374616E63650A20202020293B0A0A0A20202020617474616368436C69636B48616E646C6572280A202020202020696E7374616E63650A20202020293B0A0A0A20202020696E697469616C697A6547726F757073280A2020202020';
wwv_flow_imp.g_varchar2_table(206) := '20696E7374616E63650A20202020293B0A0A0A2020202072657475726E20747275653B0A0A20207D0A0A0A20202F2A0A2020202A20496E697469616C697A65206F6E65206F72206D6F7265206D61746368696E6720496E74657261637469766520526570';
wwv_flow_imp.g_varchar2_table(207) := '6F727420726567696F6E732E0A2020202A0A2020202A205468697320616C6C6F777320612044796E616D696320416374696F6E207573696E672061206A51756572792073656C6563746F7220746F207461726765740A2020202A206D756C7469706C6520';
wwv_flow_imp.g_varchar2_table(208) := '4952732E0A2020202A0A2020202A2045616368206D61746368656420726567696F6E206973207374696C6C20616E20696E646570656E64656E7420706C75672D696E20696E7374616E63652E0A2020202A2F0A202066756E6374696F6E20696E6974280A';
wwv_flow_imp.g_varchar2_table(209) := '20202020726567696F6E2C0A202020206F7074696F6E730A202029207B0A0A20202020636F6E737420726567696F6E7324203D0A2020202020207265736F6C7665526567696F6E73280A2020202020202020726567696F6E0A202020202020293B0A0A20';
wwv_flow_imp.g_varchar2_table(210) := '2020206966202821726567696F6E73242E6C656E67746829207B0A20202020202072657475726E2066616C73653B0A202020207D0A0A0A202020206C657420696E697469616C697A6564203D0A20202020202066616C73653B0A0A0A2020202072656769';
wwv_flow_imp.g_varchar2_table(211) := '6F6E73240A2020202020202E656163682866756E6374696F6E2829207B0A0A2020202020202020696620280A20202020202020202020696E6974496E7374616E6365280A202020202020202020202020746869732C0A2020202020202020202020206F70';
wwv_flow_imp.g_varchar2_table(212) := '74696F6E730A20202020202020202020290A202020202020202029207B0A0A20202020202020202020696E697469616C697A6564203D0A202020202020202020202020747275653B0A0A20202020202020207D0A0A2020202020207D293B0A0A0A202020';
wwv_flow_imp.g_varchar2_table(213) := '2072657475726E20696E697469616C697A65643B0A0A20207D0A0A0A20202F2A0A2020202A204170706C79206F6E6520737461746520746F20616C6C20636F6E74726F6C2D627265616B2067726F75707320696E2065786163746C790A2020202A206F6E';
wwv_flow_imp.g_varchar2_table(214) := '6520696E697469616C697A656420726567696F6E2E0A2020202A0A2020202A204F6E6C79206F6E65206972636F6E74726F6C627265616B6368616E6765206576656E7420697320656D6974746564206166746572207468650A2020202A206F7065726174';
wwv_flow_imp.g_varchar2_table(215) := '696F6E2C207265676172646C657373206F6620686F77206D616E792067726F757073206368616E6765642E0A2020202A2F0A202066756E6374696F6E20736574416C6C457870616E646564280A20202020726567696F6E2C0A202020206973457870616E';
wwv_flow_imp.g_varchar2_table(216) := '6465642C0A20202020736F757263650A202029207B0A0A20202020636F6E737420696E7374616E6365203D0A202020202020676574496E7374616E6365280A2020202020202020726567696F6E0A202020202020293B0A0A202020206966202821696E73';
wwv_flow_imp.g_varchar2_table(217) := '74616E636529207B0A20202020202072657475726E2066616C73653B0A202020207D0A0A20202020636F6E7374206368616E676564486561646572496473203D0A2020202020205B5D3B0A0A20202020636F6E7374206368616E67656447726F75704B65';
wwv_flow_imp.g_varchar2_table(218) := '7973203D0A2020202020205B5D3B0A0A0A20202020676574427265616B48656164657273280A202020202020696E7374616E63650A20202020290A2020202020202E656163682866756E6374696F6E2867726F7570496E64657829207B0A0A2020202020';
wwv_flow_imp.g_varchar2_table(219) := '202020636F6E73742068656164657224203D0A20202020202020202020242874686973293B0A0A0A20202020202020202F2A0A2020202020202020202A204E6F726D616C6C7920616C72656164792070726573656E742C2062757420656E737572652074';
wwv_flow_imp.g_varchar2_table(220) := '686520627574746F6E206578697374730A2020202020202020202A20696E206361736520746865204150492069732063616C6C656420616674657220444F4D206368616E6765732E0A2020202020202020202A2F0A2020202020202020656E7375726542';
wwv_flow_imp.g_varchar2_table(221) := '7574746F6E280A20202020202020202020696E7374616E63652C0A20202020202020202020686561646572242C0A2020202020202020202067726F7570496E6465780A2020202020202020293B0A0A0A2020202020202020636F6E7374206368616E6765';
wwv_flow_imp.g_varchar2_table(222) := '64203D0A2020202020202020202073657447726F7570457870616E646564280A202020202020202020202020696E7374616E63652C0A202020202020202020202020686561646572242C0A2020202020202020202020206973457870616E6465642C0A20';
wwv_flow_imp.g_varchar2_table(223) := '2020202020202020202020747275652C0A2020202020202020202020206E756C6C0A20202020202020202020293B0A0A2020202020202020696620286368616E67656429207B0A0A20202020202020202020636F6E7374206865616465724964203D0A20';
wwv_flow_imp.g_varchar2_table(224) := '2020202020202020202020686561646572242E61747472280A2020202020202020202020202020226964220A202020202020202020202020293B0A2020202020202020202069662028686561646572496429207B0A0A2020202020202020202020206368';
wwv_flow_imp.g_varchar2_table(225) := '616E6765644865616465724964732E70757368280A202020202020202020202020202068656164657249640A202020202020202020202020293B0A0A202020202020202020207D0A0A0A20202020202020202020636F6E73742067726F75704B6579203D';
wwv_flow_imp.g_varchar2_table(226) := '0A20202020202020202020202067657447726F75704B6579280A2020202020202020202020202020686561646572240A202020202020202020202020293B0A0A202020202020202020206966202867726F75704B657929207B0A0A202020202020202020';
wwv_flow_imp.g_varchar2_table(227) := '2020206368616E67656447726F75704B6579732E70757368280A202020202020202020202020202067726F75704B65790A202020202020202020202020293B0A0A202020202020202020207D0A0A20202020202020207D0A0A2020202020207D293B0A0A';
wwv_flow_imp.g_varchar2_table(228) := '0A202020202F2A0A20202020202A205065727369737420616C6C206368616E676564207374617465732077697468206F6E652073746F726167652077726974652E0A20202020202A2F0A20202020736176655374617465280A202020202020696E737461';
wwv_flow_imp.g_varchar2_table(229) := '6E63650A20202020293B0A0A0A202020202F2A0A20202020202A20456D6974206F6E6520616767726567617465206368616E6765206576656E742E0A20202020202A2F0A20202020696620286368616E67656447726F75704B6579732E6C656E67746829';
wwv_flow_imp.g_varchar2_table(230) := '207B0A0A202020202020747269676765724368616E67654576656E74280A2020202020202020696E7374616E63652C0A20202020202020206368616E6765644865616465724964732C0A20202020202020206973457870616E6465642C0A202020202020';
wwv_flow_imp.g_varchar2_table(231) := '2020736F757263650A202020202020293B0A0A202020207D0A0A0A2020202072657475726E20747275653B0A0A20207D0A0A0A20202F2A0A2020202A20457870616E6420657665727920636F6E74726F6C2D627265616B2067726F757020696E206F6E65';
wwv_flow_imp.g_varchar2_table(232) := '20726567696F6E2E0A2020202A0A2020202A20726567696F6E206D757374207265736F6C766520746F2065786163746C79206F6E6520696E697469616C697A656420726567696F6E2E0A2020202A2F0A202066756E6374696F6E20657870616E64416C6C';
wwv_flow_imp.g_varchar2_table(233) := '28726567696F6E29207B0A0A2020202072657475726E20736574416C6C457870616E646564280A202020202020726567696F6E2C0A202020202020747275652C0A20202020202022455850414E445F414C4C220A20202020293B0A0A20207D0A0A0A2020';
wwv_flow_imp.g_varchar2_table(234) := '2F2A0A2020202A20436F6C6C6170736520657665727920636F6E74726F6C2D627265616B2067726F757020696E206F6E6520726567696F6E2E0A2020202A0A2020202A20726567696F6E206D757374207265736F6C766520746F2065786163746C79206F';
wwv_flow_imp.g_varchar2_table(235) := '6E6520696E697469616C697A656420726567696F6E2E0A2020202A2F0A202066756E6374696F6E20636F6C6C61707365416C6C28726567696F6E29207B0A0A2020202072657475726E20736574416C6C457870616E646564280A20202020202072656769';
wwv_flow_imp.g_varchar2_table(236) := '6F6E2C0A20202020202066616C73652C0A20202020202022434F4C4C415053455F414C4C220A20202020293B0A0A20207D0A0A0A20202F2A0A2020202A20436C6561722072656D656D626572656420737461746520666F72206F6E6520726567696F6E20';
wwv_flow_imp.g_varchar2_table(237) := '616E6420726573746F72650A2020202A2074686520636F6E6669677572656420496E697469616C6C7920457870616E6465642076616C75652E0A2020202A0A2020202A20426F74682073657373696F6E20616E642070657273697374656E742062726F77';
wwv_flow_imp.g_varchar2_table(238) := '7365722073746174652061726520636C65617265642E0A2020202A0A2020202A204F6E65205245534554206576656E7420697320656D6974746564206966206F6E65206F72206D6F72652063757272656E742067726F7570730A2020202A206163747561';
wwv_flow_imp.g_varchar2_table(239) := '6C6C79206368616E67652073746174652E0A2020202A2F0A202066756E6374696F6E207265736574537461746528726567696F6E29207B0A0A20202020636F6E737420696E7374616E6365203D0A202020202020676574496E7374616E6365280A202020';
wwv_flow_imp.g_varchar2_table(240) := '2020202020726567696F6E0A202020202020293B0A0A202020206966202821696E7374616E636529207B0A20202020202072657475726E2066616C73653B0A202020207D0A0A0A20202020636C65617253746F7265645374617465280A20202020202069';
wwv_flow_imp.g_varchar2_table(241) := '6E7374616E63652E726567696F6E49640A20202020293B0A0A0A20202020696E7374616E63652E73746F7265645374617465203D0A20202020202063726561746553746F7265645374617465280A2020202020202020696E7374616E63650A2020202020';
wwv_flow_imp.g_varchar2_table(242) := '20293B0A0A0A20202020636F6E7374206368616E676564486561646572496473203D0A2020202020205B5D3B0A0A20202020636F6E7374206368616E67656447726F75704B657973203D0A2020202020205B5D3B0A0A0A20202020676574427265616B48';
wwv_flow_imp.g_varchar2_table(243) := '656164657273280A202020202020696E7374616E63650A20202020290A2020202020202E656163682866756E6374696F6E2867726F7570496E64657829207B0A0A2020202020202020636F6E73742068656164657224203D0A2020202020202020202024';
wwv_flow_imp.g_varchar2_table(244) := '2874686973293B0A0A2020202020202020656E73757265427574746F6E280A20202020202020202020696E7374616E63652C0A20202020202020202020686561646572242C0A2020202020202020202067726F7570496E6465780A202020202020202029';
wwv_flow_imp.g_varchar2_table(245) := '3B0A0A0A2020202020202020636F6E7374206368616E676564203D0A2020202020202020202073657447726F7570457870616E646564280A202020202020202020202020696E7374616E63652C0A202020202020202020202020686561646572242C0A20';
wwv_flow_imp.g_varchar2_table(246) := '2020202020202020202020696E7374616E63652E6F7074696F6E732E696E697469616C6C79457870616E6465642C0A20202020202020202020202066616C73652C0A2020202020202020202020206E756C6C0A20202020202020202020293B0A0A0A2020';
wwv_flow_imp.g_varchar2_table(247) := '202020202020696620286368616E67656429207B0A0A20202020202020202020636F6E7374206865616465724964203D0A202020202020202020202020686561646572242E61747472280A2020202020202020202020202020226964220A202020202020';
wwv_flow_imp.g_varchar2_table(248) := '202020202020293B0A0A2020202020202020202069662028686561646572496429207B0A0A2020202020202020202020206368616E6765644865616465724964732E70757368280A202020202020202020202020202068656164657249640A2020202020';
wwv_flow_imp.g_varchar2_table(249) := '20202020202020293B0A0A202020202020202020207D0A0A0A20202020202020202020636F6E73742067726F75704B6579203D0A20202020202020202020202067657447726F75704B6579280A2020202020202020202020202020686561646572240A20';
wwv_flow_imp.g_varchar2_table(250) := '2020202020202020202020293B0A0A202020202020202020206966202867726F75704B657929207B0A0A2020202020202020202020206368616E67656447726F75704B6579732E70757368280A202020202020202020202020202067726F75704B65790A';
wwv_flow_imp.g_varchar2_table(251) := '202020202020202020202020293B0A0A202020202020202020207D0A0A20202020202020207D0A0A2020202020207D293B0A0A0A202020202F2A0A20202020202A2049662072656D656D626572696E6720697320656E61626C65642C2072656372656174';
wwv_flow_imp.g_varchar2_table(252) := '652073746F7261676520776974683A0A20202020202A0A20202020202A202D2063757272656E742073746F726167652076657273696F6E0A20202020202A202D2063757272656E7420496E697469616C6C7920457870616E6465642073657474696E670A';
wwv_flow_imp.g_varchar2_table(253) := '20202020202A202D206E6F207065722D67726F7570206F76657272696465730A20202020202A2F0A20202020736176655374617465280A202020202020696E7374616E63650A20202020293B0A0A0A202020202F2A0A20202020202A20456D6974206F6E';
wwv_flow_imp.g_varchar2_table(254) := '6520616767726567617465205245534554206576656E742E0A20202020202A2F0A20202020696620286368616E67656447726F75704B6579732E6C656E67746829207B0A0A202020202020747269676765724368616E67654576656E74280A2020202020';
wwv_flow_imp.g_varchar2_table(255) := '202020696E7374616E63652C0A20202020202020206368616E6765644865616465724964732C0A2020202020202020696E7374616E63652E6F7074696F6E732E696E697469616C6C79457870616E6465642C0A2020202020202020225245534554220A20';
wwv_flow_imp.g_varchar2_table(256) := '2020202020293B0A0A202020207D0A0A0A2020202072657475726E20747275653B0A0A20207D0A0A0A20202F2A0A2020202A205075626C6963204150492E0A2020202A0A2020202A20696E697428293A0A2020202A2020204D617920696E697469616C69';
wwv_flow_imp.g_varchar2_table(257) := '7A65206F6E65206F72206D6F7265206D61746368656420726567696F6E732E0A2020202A0A2020202A20657870616E64416C6C28293A0A2020202A20636F6C6C61707365416C6C28293A0A2020202A207265736574537461746528293A0A2020202A2020';
wwv_flow_imp.g_varchar2_table(258) := '20496E74656E74696F6E616C6C79206F706572617465206F6E2065786163746C79206F6E6520726567696F6E2E0A2020202A2F0A2020706C7567696E2E69722E636F6E74726F6C427265616B546F67676C6572203D207B0A0A20202020696E69743A0A20';
wwv_flow_imp.g_varchar2_table(259) := '2020202020696E69742C0A0A20202020657870616E64416C6C3A0A202020202020657870616E64416C6C2C0A0A20202020636F6C6C61707365416C6C3A0A202020202020636F6C6C61707365416C6C2C0A0A20202020726573657453746174653A0A2020';
wwv_flow_imp.g_varchar2_table(260) := '20202020726573657453746174650A0A20207D3B0A0A0A7D2928617065782E6A51756572792C2066695F6A617269735F706C7567696E293B0A0A0A2F2A0A202A205468652044796E616D696320416374696F6E2073686F756C64206E6F726D616C6C7920';
wwv_flow_imp.g_varchar2_table(261) := '6265206372656174656420776974683A0A202A0A202A2020204576656E743A20416674657220526566726573680A202A0A202A204120526567696F6E2073656C656374696F6E206E6F726D616C6C7920737570706C696573206F6E652074726967676572';
wwv_flow_imp.g_varchar2_table(262) := '696E672049522E0A202A0A202A2041206A51756572792053656C6563746F722063616E20737570706C79206F6E65206F72206D6F7265206D61746368696E67204952733B0A202A20696E6974282920747265617473206561636820617320616E20696E64';
wwv_flow_imp.g_varchar2_table(263) := '6570656E64656E7420706C75672D696E20696E7374616E63652E0A202A0A202A204E6F20416666656374656420456C656D656E747320636F6E66696775726174696F6E20697320726571756972656420626563617573650A202A2074686520706C75672D';
wwv_flow_imp.g_varchar2_table(264) := '696E2075736573206461436F6E6669672E74726967676572696E67456C656D656E742E0A202A2F0A77696E646F772E6972436F6E74726F6C427265616B546F67676C6572496E6974203D20280A202073657474696E67732C0A20206461436F6E6669670A';
wwv_flow_imp.g_varchar2_table(265) := '29203D3E207B0A0A202066695F6A617269735F706C7567696E2E69720A202020202E636F6E74726F6C427265616B546F67676C65720A202020202E696E6974280A2020202020206461436F6E6669672E74726967676572696E67456C656D656E742C0A20';
wwv_flow_imp.g_varchar2_table(266) := '202020202073657474696E67730A20202020293B0A0A7D3B0A';
null;
end;
/
begin
wwv_flow_imp_shared.create_plugin_file(
 p_id=>wwv_flow_imp.id(18583952308114475)
,p_plugin_id=>wwv_flow_imp.id(18583403628066902)
,p_file_name=>'irControlBreakToggler.js'
,p_mime_type=>'text/javascript'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_imp.varchar2_to_blob(wwv_flow_imp.g_varchar2_table)
);
end;
/
begin
wwv_flow_imp.g_varchar2_table := wwv_flow_imp.empty_varchar2_table;
wwv_flow_imp.g_varchar2_table(1) := '2E69722D636F6E74726F6C2D627265616B2D686561646572207B646973706C61793A20666C65783B616C69676E2D6974656D733A2063656E7465723B696E6C696E652D73697A653A20313030253B6761703A202E3572656D3B7D2E69722D636F6E74726F';
wwv_flow_imp.g_varchar2_table(2) := '6C2D627265616B2D74657874207B6D696E2D696E6C696E652D73697A653A20303B7D2E69722D636F6E74726F6C2D627265616B2D6865616465722D2D656E64202E69722D636F6E74726F6C2D627265616B2D62746E207B6D617267696E2D696E6C696E65';
wwv_flow_imp.g_varchar2_table(3) := '2D73746172743A206175746F3B7D';
null;
end;
/
begin
wwv_flow_imp_shared.create_plugin_file(
 p_id=>wwv_flow_imp.id(20037120166011243)
,p_plugin_id=>wwv_flow_imp.id(18583403628066902)
,p_file_name=>'irControlBreakToggler.min.css'
,p_mime_type=>'text/css'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_imp.varchar2_to_blob(wwv_flow_imp.g_varchar2_table)
);
end;
/
begin
wwv_flow_imp.g_varchar2_table := wwv_flow_imp.empty_varchar2_table;
wwv_flow_imp.g_varchar2_table(1) := '7661722066695F6A617269735F706C7567696E3D66695F6A617269735F706C7567696E7C7C7B7D3B2166756E6374696F6E28742C65297B652E69723D652E69727C7C7B7D3B636F6E7374206E3D6E6577205765616B4D61702C6F3D2266695F6A61726973';
wwv_flow_imp.g_varchar2_table(2) := '5F706C7567696E2E6972436F6E74726F6C427265616B546F67676C6572222C723D227374617465222C693D2274682E612D4952522D6865616465722D2D67726F7570222C613D222E69722D636F6E74726F6C2D627265616B2D62746E222C733D222E6972';
wwv_flow_imp.g_varchar2_table(3) := '2D636F6E74726F6C2D627265616B2D69636F6E222C6C3D7B696E697469616C6C79457870616E6465643A21302C72656D656D62657253746174653A224E4F222C627574746F6E506F736974696F6E3A225354415254222C636F6C6C617073655469746C65';
wwv_flow_imp.g_varchar2_table(4) := '3A617065782E6C616E672E6765744D6573736167652822415045582E47562E425245414B5F434F4C4C4150534522297C7C22436F6C6C61707365222C657870616E645469746C653A617065782E6C616E672E6765744D6573736167652822415045582E47';
wwv_flow_imp.g_varchar2_table(5) := '562E425245414B5F455850414E4422297C7C22457870616E64222C636F6C6C6170736549636F6E3A2266612D63686576726F6E2D646F776E222C627574746F6E437373436C61737365733A22742D427574746F6E20742D427574746F6E2D2D6E6F4C6162';
wwv_flow_imp.g_varchar2_table(6) := '656C20742D427574746F6E2D2D69636F6E20742D427574746F6E2D2D736D616C6C227D3B66756E6374696F6E20632865297B69662822737472696E67223D3D747970656F662065297B636F6E7374206E3D646F63756D656E742E676574456C656D656E74';
wwv_flow_imp.g_varchar2_table(7) := '427949642865293B72657475726E2074286E3F6E3A65297D72657475726E20742865297D66756E6374696F6E20752865297B636F6E7374206E3D742E657874656E64287B7D2C6C2C65293B766172206F3B72657475726E206E2E72656D656D6265725374';
wwv_flow_imp.g_varchar2_table(8) := '6174653D66756E6374696F6E2874297B69662821303D3D3D742972657475726E2253455353494F4E223B69662821313D3D3D747C7C6E756C6C3D3D742972657475726E224E4F223B636F6E737420653D537472696E672874292E746F5570706572436173';
wwv_flow_imp.g_varchar2_table(9) := '6528293B72657475726E5B224E4F222C2253455353494F4E222C2250455253495354454E54225D2E696E636C756465732865293F653A224E4F227D286E2E72656D656D6265725374617465292C6E2E627574746F6E506F736974696F6E3D286F3D6E2E62';
wwv_flow_imp.g_varchar2_table(10) := '7574746F6E506F736974696F6E2C22454E44223D3D3D537472696E67286F7C7C22535441525422292E746F55707065724361736528293F22454E44223A22535441525422292C6E2E636F6C6C617073655469746C653D6E2E636F6C6C617073655469746C';
wwv_flow_imp.g_varchar2_table(11) := '657C7C6C2E636F6C6C617073655469746C652C6E2E657870616E645469746C653D6E2E657870616E645469746C657C7C6C2E657870616E645469746C652C6E2E636F6C6C6170736549636F6E3D6E2E636F6C6C6170736549636F6E7C7C6C2E636F6C6C61';
wwv_flow_imp.g_varchar2_table(12) := '70736549636F6E2C6E2E657870616E6449636F6E3D6E2E657870616E6449636F6E7C7C6E756C6C2C6E2E627574746F6E437373436C61737365733D6E2E627574746F6E437373436C61737365737C7C6C2E627574746F6E437373436C61737365732C6E7D';
wwv_flow_imp.g_varchar2_table(13) := '66756E6374696F6E207028742C65297B69662821747C7C224E4F223D3D3D652972657475726E206E756C6C3B636F6E7374206E3D7B7072656669783A6F2C75736541707049643A21302C7573655061676549643A21302C726567696F6E49643A747D3B72';
wwv_flow_imp.g_varchar2_table(14) := '657475726E2253455353494F4E223D3D3D653F617065782E73746F726167652E67657453636F70656453657373696F6E53746F72616765286E293A2250455253495354454E54223D3D3D653F617065782E73746F726167652E67657453636F7065644C6F';
wwv_flow_imp.g_varchar2_table(15) := '63616C53746F72616765286E293A6E756C6C7D66756E6374696F6E20642874297B72657475726E7B76657273696F6E3A322C696E697469616C6C79457870616E6465643A742E6F7074696F6E732E696E697469616C6C79457870616E6465642C73746174';
wwv_flow_imp.g_varchar2_table(16) := '65733A7B7D7D7D66756E6374696F6E20672874297B742E737461746553746F726167652626742E737461746553746F726167652E7365744974656D28722C4A534F4E2E737472696E6769667928742E73746F726564537461746529297D66756E6374696F';
wwv_flow_imp.g_varchar2_table(17) := '6E20662874297B696628742E73746F72656453746174653D642874292C21742E737461746553746F726167652972657475726E3B636F6E737420653D742E737461746553746F726167652E6765744974656D2872293B69662865297B7472797B636F6E73';
wwv_flow_imp.g_varchar2_table(18) := '74206E3D4A534F4E2E70617273652865293B69662866756E6374696F6E28742C65297B72657475726E20426F6F6C65616E28652626323D3D3D652E76657273696F6E2626652E696E697469616C6C79457870616E6465643D3D3D742E6F7074696F6E732E';
wwv_flow_imp.g_varchar2_table(19) := '696E697469616C6C79457870616E6465642626652E7374617465732626226F626A656374223D3D747970656F6620652E73746174657326262141727261792E6973417272617928652E73746174657329297D28742C6E292972657475726E20766F696428';
wwv_flow_imp.g_varchar2_table(20) := '742E73746F72656453746174653D6E297D63617463687B7D742E73746F72656453746174653D642874292C672874297D656C736520672874297D66756E6374696F6E20532874297B72657475726E20742E636C6F736573742822747222292E6E65787455';
wwv_flow_imp.g_varchar2_table(21) := '6E74696C286074723A68617328247B697D2960297D66756E6374696F6E20682874297B636F6E737420653D742E636C6F6E6528293B652E66696E642861292E72656D6F766528293B72657475726E2066756E6374696F6E2874297B6C657420653D323136';
wwv_flow_imp.g_varchar2_table(22) := '363133363236313B666F72286C6574206E3D303B6E3C742E6C656E6774683B6E2B3D3129655E3D742E63686172436F64654174286E292C653D4D6174682E696D756C28652C3136373737363139293B72657475726E28653E3E3E30292E746F537472696E';
wwv_flow_imp.g_varchar2_table(23) := '67283136297D28652E7465787428292E7265706C616365282F5C732B2F672C222022292E7472696D2829297D66756E6374696F6E20782874297B72657475726E20537472696E672874292E7265706C616365282F5B5E412D5A612D7A302D395F2D5D2F67';
wwv_flow_imp.g_varchar2_table(24) := '2C225F22297D66756E6374696F6E204928652C6E2C6F297B636F6E737420723D66756E6374696F6E2865297B6C6574206E3D652E6368696C6472656E28222E69722D636F6E74726F6C2D627265616B2D68656164657222292E666972737428293B696628';
wwv_flow_imp.g_varchar2_table(25) := '6E2E6C656E6774682972657475726E206E3B636F6E7374206F3D652E6368696C6472656E2861292E666972737428292E64657461636828292C723D7428223C7370616E3E222C7B636C6173733A2269722D636F6E74726F6C2D627265616B2D7465787422';
wwv_flow_imp.g_varchar2_table(26) := '7D293B72657475726E20722E617070656E6428652E636F6E74656E74732829292C6E3D7428223C7370616E3E222C7B636C6173733A2269722D636F6E74726F6C2D627265616B2D686561646572227D292C6E2E617070656E642872292C6F2E6C656E6774';
wwv_flow_imp.g_varchar2_table(27) := '6826266E2E617070656E64286F292C652E617070656E64286E292C6E7D286E293B6C657420693D722E6368696C6472656E2861292E666972737428293B692E6C656E6774687C7C28693D7428223C627574746F6E3E222C7B747970653A22627574746F6E';
wwv_flow_imp.g_varchar2_table(28) := '227D29293B6C6574206C3D692E6368696C6472656E2873293B6C2E6C656E6774687C7C286C3D7428223C7370616E3E222C7B22617269612D68696464656E223A2274727565222C636C6173733A22742D49636F6E2066612069722D636F6E74726F6C2D62';
wwv_flow_imp.g_varchar2_table(29) := '7265616B2D69636F6E227D292C692E617070656E64286C29292C692E617474722822636C617373222C60247B652E6F7074696F6E732E627574746F6E437373436C61737365737D2069722D636F6E74726F6C2D627265616B2D62746E602E7472696D2829';
wwv_flow_imp.g_varchar2_table(30) := '292C722E746F67676C65436C617373282269722D636F6E74726F6C2D627265616B2D6865616465722D2D7374617274222C225354415254223D3D3D652E6F7074696F6E732E627574746F6E506F736974696F6E292E746F67676C65436C61737328226972';
wwv_flow_imp.g_varchar2_table(31) := '2D636F6E74726F6C2D627265616B2D6865616465722D2D656E64222C22454E44223D3D3D652E6F7074696F6E732E627574746F6E506F736974696F6E292C22454E44223D3D3D652E6F7074696F6E732E627574746F6E506F736974696F6E3F722E617070';
wwv_flow_imp.g_varchar2_table(32) := '656E642869293A722E70726570656E642869293B636F6E737420633D66756E6374696F6E28652C6E2C6F297B636F6E737420723D53286E292C693D5B5D2C613D6E2E617474722822696422292C733D7828652E726567696F6E49647C7C22697222292C6C';
wwv_flow_imp.g_varchar2_table(33) := '3D7828617C7C6067726F75705F247B6F2B317D60293B72657475726E20722E656163682866756E6374696F6E2865297B636F6E7374206E3D742874686973293B6C6574206F3D6E2E617474722822696422293B696628216F297B636F6E737420743D6024';
wwv_flow_imp.g_varchar2_table(34) := '7B737D5F63625F247B6C7D5F726F775F247B652B317D603B6F3D743B6C657420723D323B666F72283B646F63756D656E742E676574456C656D656E7442794964286F292626646F63756D656E742E676574456C656D656E7442794964286F29213D3D7468';
wwv_flow_imp.g_varchar2_table(35) := '69733B296F3D60247B747D5F247B727D602C722B3D313B6E2E6174747228226964222C6F297D692E70757368286F297D292C697D28652C6E2C6F293B72657475726E20632E6C656E6774683F692E617474722822617269612D636F6E74726F6C73222C63';
wwv_flow_imp.g_varchar2_table(36) := '2E6A6F696E2822202229293A692E72656D6F7665417474722822617269612D636F6E74726F6C7322292C697D66756E6374696F6E204528742C652C6E2C6F297B617065782E6576656E742E7472696767657228742E726567696F6E242C226972636F6E74';
wwv_flow_imp.g_varchar2_table(37) := '726F6C627265616B6368616E6765222C7B726567696F6E49643A742E726567696F6E49642C6865616465724964733A652C657870616E6465643A6E2C736F757263653A6F7D297D66756E6374696F6E206228742C652C6E2C6F2C72297B636F6E73742069';
wwv_flow_imp.g_varchar2_table(38) := '3D652E66696E642861292E666972737428292C6C3D2274727565223D3D3D692E617474722822617269612D657870616E64656422292C633D682865293B2166756E6374696F6E28742C652C6E297B636F6E7374206F3D6E3F742E6F7074696F6E732E636F';
wwv_flow_imp.g_varchar2_table(39) := '6C6C617073655469746C653A742E6F7074696F6E732E657870616E645469746C652C723D6E3F742E6F7074696F6E732E636F6C6C6170736549636F6E3A742E6F7074696F6E732E657870616E6449636F6E3B652E61747472287B7469746C653A6F2C2261';
wwv_flow_imp.g_varchar2_table(40) := '7269612D6C6162656C223A6F2C22617269612D657870616E646564223A6E2E746F537472696E6728297D292C652E6368696C6472656E2873292E72656D6F7665436C6173732860247B742E6F7074696F6E732E636F6C6C6170736549636F6E7D20247B74';
wwv_flow_imp.g_varchar2_table(41) := '2E6F7074696F6E732E657870616E6449636F6E7D60292E616464436C6173732872297D28742C692C6E292C532865292E746F67676C65286E292C6F2626742E737461746553746F72616765262663262628742E73746F72656453746174652E7374617465';
wwv_flow_imp.g_varchar2_table(42) := '735B635D3D6E293B636F6E737420753D6C213D3D6E3B69662875262672297B636F6E7374206F3D652E617474722822696422293B4528742C6F3F5B6F5D3A5B5D2C6E2C72297D72657475726E20757D66756E6374696F6E20542874297B72657475726E20';
wwv_flow_imp.g_varchar2_table(43) := '742E726567696F6E242E66696E642869297D66756E6374696F6E206D2865297B636F6E7374206F3D66756E6374696F6E2865297B636F6E7374206E3D632865293B72657475726E20313D3D3D6E2E6C656E6774683F6E3A7428297D2865293B7265747572';
wwv_flow_imp.g_varchar2_table(44) := '6E206F2E6C656E67746826266E2E676574286F5B305D297C7C6E756C6C7D66756E6374696F6E204128652C6F297B636F6E737420723D742865292E666972737428293B69662821722E6C656E6774682972657475726E21313B636F6E737420733D75286F';
wwv_flow_imp.g_varchar2_table(45) := '293B732E657870616E6449636F6E7C7C28732E657870616E6449636F6E3D66756E6374696F6E28742C65297B636F6E7374206E3D2272746C223D3D3D742E6373732822646972656374696F6E22293B72657475726E22454E44223D3D3D653F6E3F226661';
wwv_flow_imp.g_varchar2_table(46) := '2D63686576726F6E2D7269676874223A2266612D63686576726F6E2D6C656674223A6E3F2266612D63686576726F6E2D6C656674223A2266612D63686576726F6E2D7269676874227D28722C732E627574746F6E506F736974696F6E29293B636F6E7374';
wwv_flow_imp.g_varchar2_table(47) := '206C3D722E617474722822696422292C633D7B726567696F6E243A722C726567696F6E49643A6C2C6F7074696F6E733A732C737461746553746F726167653A70286C2C732E72656D656D6265725374617465292C73746F72656453746174653A6E756C6C';
wwv_flow_imp.g_varchar2_table(48) := '7D3B72657475726E20662863292C6E2E73657428725B305D2C63292C66756E6374696F6E2865297B652E726567696F6E242E6F66662822636C69636B2E636F6E74726F6C427265616B546F67676C6522292E6F6E2822636C69636B2E636F6E74726F6C42';
wwv_flow_imp.g_varchar2_table(49) := '7265616B546F67676C65222C612C66756E6374696F6E28297B636F6E7374206E3D742874686973292C6F3D6E2E636C6F736573742869292C723D2274727565223D3D3D6E2E617474722822617269612D657870616E64656422293B6228652C6F2C21722C';
wwv_flow_imp.g_varchar2_table(50) := '21302C225553455222292C672865297D297D2863292C66756E6374696F6E2865297B542865292E656163682866756E6374696F6E286E297B636F6E7374206F3D742874686973292C723D68286F293B6C657420693D652E6F7074696F6E732E696E697469';
wwv_flow_imp.g_varchar2_table(51) := '616C6C79457870616E6465643B652E737461746553746F7261676526267226264F626A6563742E70726F746F747970652E6861734F776E50726F70657274792E63616C6C28652E73746F72656453746174652E7374617465732C7229262628693D652E73';
wwv_flow_imp.g_varchar2_table(52) := '746F72656453746174652E7374617465735B725D292C4928652C6F2C6E292C6228652C6F2C692C21312C6E756C6C297D297D2863292C21307D66756E6374696F6E204328652C6E2C6F297B636F6E737420723D6D2865293B69662821722972657475726E';
wwv_flow_imp.g_varchar2_table(53) := '21313B636F6E737420693D5B5D2C613D5B5D3B72657475726E20542872292E656163682866756E6374696F6E2865297B636F6E7374206F3D742874686973293B4928722C6F2C65293B6966286228722C6F2C6E2C21302C6E756C6C29297B636F6E737420';
wwv_flow_imp.g_varchar2_table(54) := '743D6F2E617474722822696422293B742626692E707573682874293B636F6E737420653D68286F293B652626612E707573682865297D7D292C672872292C612E6C656E67746826264528722C692C6E2C6F292C21307D652E69722E636F6E74726F6C4272';
wwv_flow_imp.g_varchar2_table(55) := '65616B546F67676C65723D7B696E69743A66756E6374696F6E28742C65297B636F6E7374206E3D632874293B696628216E2E6C656E6774682972657475726E21313B6C6574206F3D21313B72657475726E206E2E656163682866756E6374696F6E28297B';
wwv_flow_imp.g_varchar2_table(56) := '4128746869732C65292626286F3D2130297D292C6F7D2C657870616E64416C6C3A66756E6374696F6E2874297B72657475726E204328742C21302C22455850414E445F414C4C22297D2C636F6C6C61707365416C6C3A66756E6374696F6E2874297B7265';
wwv_flow_imp.g_varchar2_table(57) := '7475726E204328742C21312C22434F4C4C415053455F414C4C22297D2C726573657453746174653A66756E6374696F6E2865297B636F6E7374206E3D6D2865293B696628216E2972657475726E21313B2166756E6374696F6E2874297B69662821742972';
wwv_flow_imp.g_varchar2_table(58) := '657475726E3B636F6E737420653D7B7072656669783A6F2C75736541707049643A21302C7573655061676549643A21302C726567696F6E49643A747D3B617065782E73746F726167652E67657453636F70656453657373696F6E53746F72616765286529';
wwv_flow_imp.g_varchar2_table(59) := '2E72656D6F76654974656D2872292C617065782E73746F726167652E67657453636F7065644C6F63616C53746F726167652865292E72656D6F76654974656D2872297D286E2E726567696F6E4964292C6E2E73746F72656453746174653D64286E293B63';
wwv_flow_imp.g_varchar2_table(60) := '6F6E737420693D5B5D2C613D5B5D3B72657475726E2054286E292E656163682866756E6374696F6E2865297B636F6E7374206F3D742874686973293B49286E2C6F2C65293B69662862286E2C6F2C6E2E6F7074696F6E732E696E697469616C6C79457870';
wwv_flow_imp.g_varchar2_table(61) := '616E6465642C21312C6E756C6C29297B636F6E737420743D6F2E617474722822696422293B742626692E707573682874293B636F6E737420653D68286F293B652626612E707573682865297D7D292C67286E292C612E6C656E677468262645286E2C692C';
wwv_flow_imp.g_varchar2_table(62) := '6E2E6F7074696F6E732E696E697469616C6C79457870616E6465642C22524553455422292C21307D7D7D28617065782E6A51756572792C66695F6A617269735F706C7567696E292C77696E646F772E6972436F6E74726F6C427265616B546F67676C6572';
wwv_flow_imp.g_varchar2_table(63) := '496E69743D28742C65293D3E7B66695F6A617269735F706C7567696E2E69722E636F6E74726F6C427265616B546F67676C65722E696E697428652E74726967676572696E67456C656D656E742C74297D3B';
null;
end;
/
begin
wwv_flow_imp_shared.create_plugin_file(
 p_id=>wwv_flow_imp.id(18584799470115924)
,p_plugin_id=>wwv_flow_imp.id(18583403628066902)
,p_file_name=>'irControlBreakToggler.min.js'
,p_mime_type=>'text/javascript'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_imp.varchar2_to_blob(wwv_flow_imp.g_varchar2_table)
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
