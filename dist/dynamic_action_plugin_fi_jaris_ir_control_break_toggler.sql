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
--   Date and Time:   16:26 Saturday September 26, 2026
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
,p_version_scn=>'SH256:Y6x6c2QHjXw-dw9BMkqDc7KHjebgx8Jas-j2EH2Ppm0'
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
,p_version_identifier=>'1.0.0'
,p_files_version=>2461310153042
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
wwv_flow_imp.g_varchar2_table(1) := '2E69722D636F6E74726F6C2D627265616B2D62746E2D2D7374617274207B0A2020666C6F61743A20696E6C696E652D73746172743B0A20206D617267696E2D696E6C696E652D656E643A202E3572656D3B0A7D0A0A2E69722D636F6E74726F6C2D627265';
wwv_flow_imp.g_varchar2_table(2) := '616B2D62746E2D2D656E64207B0A2020666C6F61743A20696E6C696E652D656E643B0A20206D617267696E2D696E6C696E652D73746172743A202E3572656D3B0A7D0A';
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
wwv_flow_imp.g_varchar2_table(3) := '67676C6572223B0A0A2020636F6E73742053544F524147455F4B4559203D0A20202020227374617465223B0A0A2020636F6E73742053544F524147455F56455253494F4E203D0A20202020313B0A0A2020636F6E737420434F4E54524F4C5F425245414B';
wwv_flow_imp.g_varchar2_table(4) := '5F53454C4543544F52203D0A202020202274682E612D4952522D6865616465722D2D67726F7570223B0A0A2020636F6E737420425554544F4E5F53454C4543544F52203D0A20202020222E69722D636F6E74726F6C2D627265616B2D62746E223B0A0A20';
wwv_flow_imp.g_varchar2_table(5) := '20636F6E73742049434F4E5F53454C4543544F52203D0A20202020222E69722D636F6E74726F6C2D627265616B2D69636F6E223B0A0A2020636F6E7374204348414E47455F4556454E54203D0A20202020226972636F6E74726F6C627265616B6368616E';
wwv_flow_imp.g_varchar2_table(6) := '6765223B0A0A2020636F6E73742044454641554C5453203D207B0A20202020696E697469616C6C79457870616E646564203A20747275652C0A2020202072656D656D626572537461746520202020203A20224E4F222C0A20202020627574746F6E506F73';
wwv_flow_imp.g_varchar2_table(7) := '6974696F6E202020203A20225354415254222C0A20202020636F6C6C617073655469746C6520202020203A20617065782E6C616E672E6765744D6573736167652822415045582E47562E425245414B5F434F4C4C415053452229207C7C2022436F6C6C61';
wwv_flow_imp.g_varchar2_table(8) := '707365222C0A20202020657870616E645469746C65202020202020203A20617065782E6C616E672E6765744D6573736167652822415045582E47562E425245414B5F455850414E442229207C7C2022457870616E64222C0A20202020636F6C6C61707365';
wwv_flow_imp.g_varchar2_table(9) := '49636F6E2020202020203A202266612D63686576726F6E2D646F776E222C0A20202020627574746F6E437373436C617373657320203A2022742D427574746F6E20742D427574746F6E2D2D6E6F4C6162656C20742D427574746F6E2D2D69636F6E20742D';
wwv_flow_imp.g_varchar2_table(10) := '427574746F6E2D2D736D616C6C220A20207D3B0A0A0A20202F2A0A2020202A2052657475726E207468652064656661756C7420646972656374696F6E616C20657870616E642069636F6E2E0A2020202A0A2020202A20535441525420616E6420454E4420';
wwv_flow_imp.g_varchar2_table(11) := '617265206C6F676963616C20706F736974696F6E732C20736F207468652069636F6E20646972656374696F6E0A2020202A20666F6C6C6F777320746865207465787420646972656374696F6E206F662074686520726567696F6E2E0A2020202A2F0A2020';
wwv_flow_imp.g_varchar2_table(12) := '66756E6374696F6E2067657444656661756C74457870616E6449636F6E280A20202020726567696F6E242C0A20202020627574746F6E506F736974696F6E0A202029207B0A0A20202020636F6E737420697352746C203D0A202020202020726567696F6E';
wwv_flow_imp.g_varchar2_table(13) := '242E6373732822646972656374696F6E2229203D3D3D202272746C223B0A0A2020202069662028627574746F6E506F736974696F6E203D3D3D2022454E442229207B0A0A20202020202072657475726E20697352746C0A20202020202020203F20226661';
wwv_flow_imp.g_varchar2_table(14) := '2D63686576726F6E2D7269676874220A20202020202020203A202266612D63686576726F6E2D6C656674223B0A0A202020207D0A0A2020202072657475726E20697352746C0A2020202020203F202266612D63686576726F6E2D6C656674220A20202020';
wwv_flow_imp.g_varchar2_table(15) := '20203A202266612D63686576726F6E2D7269676874223B0A0A20207D0A0A0A20202F2A0A2020202A205265736F6C7665206F6E65206F72206D6F726520726567696F6E732E0A2020202A0A2020202A20496E697469616C697A6174696F6E2063616E2061';
wwv_flow_imp.g_varchar2_table(16) := '6363657074206D756C7469706C6520656C656D656E747320736F207468617420612044796E616D69630A2020202A20416374696F6E207573696E672061206A51756572792073656C6563746F722063616E20696E697469616C697A65206D756C7469706C';
wwv_flow_imp.g_varchar2_table(17) := '65204952732E0A2020202A2F0A202066756E6374696F6E207265736F6C7665526567696F6E7328726567696F6E29207B0A0A2020202069662028747970656F6620726567696F6E203D3D3D2022737472696E672229207B0A0A2020202020202F2A0A2020';
wwv_flow_imp.g_varchar2_table(18) := '20202020202A2046697273742074726561742074686520737472696E67206173206120706F737369626C6520726567696F6E205374617469632049442E0A202020202020202A2F0A202020202020636F6E737420656C656D656E74203D0A202020202020';
wwv_flow_imp.g_varchar2_table(19) := '2020646F63756D656E742E676574456C656D656E744279496428726567696F6E293B0A0A20202020202069662028656C656D656E7429207B0A202020202020202072657475726E202428656C656D656E74293B0A2020202020207D0A0A2020202020202F';
wwv_flow_imp.g_varchar2_table(20) := '2A0A202020202020202A204F74686572776973652074726561742069742061732061206A51756572792073656C6563746F722E0A202020202020202A2F0A20202020202072657475726E202428726567696F6E293B0A0A202020207D0A0A202020207265';
wwv_flow_imp.g_varchar2_table(21) := '7475726E202428726567696F6E293B0A0A20207D0A0A0A20202F2A0A2020202A205265736F6C76652065786163746C79206F6E6520726567696F6E2E0A2020202A0A2020202A205075626C696320415049206D6574686F647320696E74656E74696F6E61';
wwv_flow_imp.g_varchar2_table(22) := '6C6C79206F706572617465206F6E206F6E6520495220617420612074696D652E0A2020202A20412073656C6563746F72206D61746368696E67206D756C7469706C6520656C656D656E74732069732072656A65637465642E0A2020202A2F0A202066756E';
wwv_flow_imp.g_varchar2_table(23) := '6374696F6E207265736F6C7665526567696F6E28726567696F6E29207B0A0A20202020636F6E737420726567696F6E7324203D0A2020202020207265736F6C7665526567696F6E7328726567696F6E293B0A0A2020202072657475726E20726567696F6E';
wwv_flow_imp.g_varchar2_table(24) := '73242E6C656E677468203D3D3D20310A2020202020203F20726567696F6E73240A2020202020203A202428293B0A0A20207D0A0A0A20202F2A0A2020202A204E6F726D616C697A652052656D656D6265722053746174652E0A2020202A0A2020202A2053';
wwv_flow_imp.g_varchar2_table(25) := '7570706F727465642076616C7565733A0A2020202A0A2020202A2020204E4F0A2020202A20202053455353494F4E0A2020202A20202050455253495354454E540A2020202A2F0A202066756E6374696F6E206E6F726D616C697A6552656D656D62657253';
wwv_flow_imp.g_varchar2_table(26) := '746174652876616C756529207B0A0A202020202F2A0A20202020202A204B65657020737570706F727420666F7220616E206F6C64657220426F6F6C65616E20636F6E66696775726174696F6E2E0A20202020202A2F0A202020206966202876616C756520';
wwv_flow_imp.g_varchar2_table(27) := '3D3D3D207472756529207B0A20202020202072657475726E202253455353494F4E223B0A202020207D0A0A20202020696620280A20202020202076616C7565203D3D3D2066616C7365207C7C0A20202020202076616C7565203D3D206E756C6C0A202020';
wwv_flow_imp.g_varchar2_table(28) := '2029207B0A20202020202072657475726E20224E4F223B0A202020207D0A0A20202020636F6E7374206E6F726D616C697A656456616C7565203D0A202020202020537472696E672876616C7565292E746F55707065724361736528293B0A0A2020202072';
wwv_flow_imp.g_varchar2_table(29) := '657475726E205B0A202020202020224E4F222C0A2020202020202253455353494F4E222C0A2020202020202250455253495354454E54220A202020205D2E696E636C75646573286E6F726D616C697A656456616C7565290A2020202020203F206E6F726D';
wwv_flow_imp.g_varchar2_table(30) := '616C697A656456616C75650A2020202020203A20224E4F223B0A0A20207D0A0A0A20202F2A0A2020202A204E6F726D616C697A6520427574746F6E20506F736974696F6E2E0A2020202A0A2020202A20537570706F727465642076616C7565733A0A2020';
wwv_flow_imp.g_varchar2_table(31) := '202A0A2020202A20202053544152540A2020202A202020454E440A2020202A2F0A202066756E6374696F6E206E6F726D616C697A65427574746F6E506F736974696F6E2876616C756529207B0A0A20202020636F6E737420706F736974696F6E203D0A20';
wwv_flow_imp.g_varchar2_table(32) := '2020202020537472696E67280A202020202020202076616C7565207C7C20225354415254220A202020202020292E746F55707065724361736528293B0A0A2020202072657475726E20706F736974696F6E203D3D3D2022454E44220A2020202020203F20';
wwv_flow_imp.g_varchar2_table(33) := '22454E44220A2020202020203A20225354415254223B0A0A20207D0A0A0A20202F2A0A2020202A204D6572676520737570706C69656420706C75672D696E2073657474696E677320776974682064656661756C74732E0A2020202A2F0A202066756E6374';
wwv_flow_imp.g_varchar2_table(34) := '696F6E206E6F726D616C697A654F7074696F6E73286F7074696F6E7329207B0A0A20202020636F6E7374206E6F726D616C697A6564203D0A202020202020242E657874656E64280A20202020202020207B7D2C0A202020202020202044454641554C5453';
wwv_flow_imp.g_varchar2_table(35) := '2C0A20202020202020206F7074696F6E730A202020202020293B0A0A202020206E6F726D616C697A65642E72656D656D6265725374617465203D0A2020202020206E6F726D616C697A6552656D656D6265725374617465280A20202020202020206E6F72';
wwv_flow_imp.g_varchar2_table(36) := '6D616C697A65642E72656D656D62657253746174650A202020202020293B0A0A202020206E6F726D616C697A65642E627574746F6E506F736974696F6E203D0A2020202020206E6F726D616C697A65427574746F6E506F736974696F6E280A2020202020';
wwv_flow_imp.g_varchar2_table(37) := '2020206E6F726D616C697A65642E627574746F6E506F736974696F6E0A202020202020293B0A0A202020206E6F726D616C697A65642E636F6C6C617073655469746C65203D0A2020202020206E6F726D616C697A65642E636F6C6C617073655469746C65';
wwv_flow_imp.g_varchar2_table(38) := '207C7C0A20202020202044454641554C54532E636F6C6C617073655469746C653B0A0A202020206E6F726D616C697A65642E657870616E645469746C65203D0A2020202020206E6F726D616C697A65642E657870616E645469746C65207C7C0A20202020';
wwv_flow_imp.g_varchar2_table(39) := '202044454641554C54532E657870616E645469746C653B0A0A202020206E6F726D616C697A65642E636F6C6C6170736549636F6E203D0A2020202020206E6F726D616C697A65642E636F6C6C6170736549636F6E207C7C0A20202020202044454641554C';
wwv_flow_imp.g_varchar2_table(40) := '54532E636F6C6C6170736549636F6E3B0A0A202020202F2A0A20202020202A204B65657020657870616E6449636F6E206E756C6C207768656E206E6F206578706C696369742076616C756520697320737570706C6965642E0A20202020202A0A20202020';
wwv_flow_imp.g_varchar2_table(41) := '202A20696E6974496E7374616E636528292077696C6C206465726976652074686520636F727265637420646972656374696F6E616C2069636F6E0A20202020202A2066726F6D20427574746F6E20506F736974696F6E20616E642074686520726567696F';
wwv_flow_imp.g_varchar2_table(42) := '6E207465787420646972656374696F6E2E0A20202020202A2F0A202020206E6F726D616C697A65642E657870616E6449636F6E203D0A2020202020206E6F726D616C697A65642E657870616E6449636F6E207C7C0A2020202020206E756C6C3B0A0A2020';
wwv_flow_imp.g_varchar2_table(43) := '20206E6F726D616C697A65642E627574746F6E437373436C6173736573203D0A2020202020206E6F726D616C697A65642E627574746F6E437373436C6173736573207C7C0A20202020202044454641554C54532E627574746F6E437373436C6173736573';
wwv_flow_imp.g_varchar2_table(44) := '3B0A0A2020202072657475726E206E6F726D616C697A65643B0A0A20207D0A0A0A20202F2A0A2020202A2052657475726E20415045582073636F7065642062726F777365722073746F726167652E0A2020202A2F0A202066756E6374696F6E2067657453';
wwv_flow_imp.g_varchar2_table(45) := '7461746553746F72616765280A20202020726567696F6E49642C0A2020202072656D656D62657253746174650A202029207B0A0A20202020696620280A20202020202021726567696F6E4964207C7C0A20202020202072656D656D626572537461746520';
wwv_flow_imp.g_varchar2_table(46) := '3D3D3D20224E4F220A2020202029207B0A20202020202072657475726E206E756C6C3B0A202020207D0A0A20202020636F6E73742073746F726167654F7074696F6E73203D207B0A202020202020707265666978202020203A2053544F524147455F5052';
wwv_flow_imp.g_varchar2_table(47) := '454649582C0A202020202020757365417070496420203A20747275652C0A202020202020757365506167654964203A20747275652C0A202020202020726567696F6E496420203A20726567696F6E49640A202020207D3B0A0A202020206966202872656D';
wwv_flow_imp.g_varchar2_table(48) := '656D6265725374617465203D3D3D202253455353494F4E2229207B0A0A20202020202072657475726E20617065782E73746F726167650A20202020202020202E67657453636F70656453657373696F6E53746F72616765280A2020202020202020202073';
wwv_flow_imp.g_varchar2_table(49) := '746F726167654F7074696F6E730A2020202020202020293B0A0A202020207D0A0A202020206966202872656D656D6265725374617465203D3D3D202250455253495354454E542229207B0A0A20202020202072657475726E20617065782E73746F726167';
wwv_flow_imp.g_varchar2_table(50) := '650A20202020202020202E67657453636F7065644C6F63616C53746F72616765280A2020202020202020202073746F726167654F7074696F6E730A2020202020202020293B0A0A202020207D0A0A2020202072657475726E206E756C6C3B0A0A20207D0A';
wwv_flow_imp.g_varchar2_table(51) := '0A0A20202F2A0A2020202A2043726561746520616E20656D7074792073746F7265642D7374617465206F626A6563742E0A2020202A0A2020202A20696E697469616C6C79457870616E6465642069732073746F726564206173206D657461646174612073';
wwv_flow_imp.g_varchar2_table(52) := '6F206368616E67696E6720746861740A2020202A20706C75672D696E2073657474696E6720696E76616C6964617465732070726576696F75736C792072656D656D62657265642067726F7570207374617465732E0A2020202A2F0A202066756E6374696F';
wwv_flow_imp.g_varchar2_table(53) := '6E2063726561746553746F726564537461746528696E7374616E636529207B0A0A2020202072657475726E207B0A20202020202076657273696F6E3A0A202020202020202053544F524147455F56455253494F4E2C0A0A202020202020696E697469616C';
wwv_flow_imp.g_varchar2_table(54) := '6C79457870616E6465643A0A2020202020202020696E7374616E63652E6F7074696F6E732E696E697469616C6C79457870616E6465642C0A0A2020202020207374617465733A0A20202020202020207B7D0A202020207D3B0A0A20207D0A0A0A20202F2A';
wwv_flow_imp.g_varchar2_table(55) := '0A2020202A2056616C69646174652072656D656D6265726564207374617465206C6F616465642066726F6D2062726F777365722073746F726167652E0A2020202A2F0A202066756E6374696F6E20697356616C696453746F7265645374617465280A2020';
wwv_flow_imp.g_varchar2_table(56) := '2020696E7374616E63652C0A2020202073746174650A202029207B0A0A2020202072657475726E20426F6F6C65616E280A20202020202073746174652026260A20202020202073746174652E76657273696F6E203D3D3D2053544F524147455F56455253';
wwv_flow_imp.g_varchar2_table(57) := '494F4E2026260A20202020202073746174652E696E697469616C6C79457870616E646564203D3D3D0A2020202020202020696E7374616E63652E6F7074696F6E732E696E697469616C6C79457870616E6465642026260A20202020202073746174652E73';
wwv_flow_imp.g_varchar2_table(58) := '74617465732026260A202020202020747970656F662073746174652E737461746573203D3D3D20226F626A656374222026260A2020202020202141727261792E697341727261792873746174652E737461746573290A20202020293B0A0A20207D0A0A0A';
wwv_flow_imp.g_varchar2_table(59) := '20202F2A0A2020202A20536176652072656D656D62657265642073746174652E0A2020202A2F0A202066756E6374696F6E2073617665537461746528696E7374616E636529207B0A0A202020206966202821696E7374616E63652E737461746553746F72';
wwv_flow_imp.g_varchar2_table(60) := '61676529207B0A20202020202072657475726E3B0A202020207D0A0A20202020696E7374616E63652E737461746553746F726167652E7365744974656D280A20202020202053544F524147455F4B45592C0A2020202020204A534F4E2E737472696E6769';
wwv_flow_imp.g_varchar2_table(61) := '6679280A2020202020202020696E7374616E63652E73746F72656453746174650A202020202020290A20202020293B0A0A20207D0A0A0A20202F2A0A2020202A204C6F61642072656D656D62657265642073746174652E0A2020202A2F0A202066756E63';
wwv_flow_imp.g_varchar2_table(62) := '74696F6E206C6F6164537461746528696E7374616E636529207B0A0A20202020696E7374616E63652E73746F7265645374617465203D0A20202020202063726561746553746F726564537461746528696E7374616E6365293B0A0A202020206966202821';
wwv_flow_imp.g_varchar2_table(63) := '696E7374616E63652E737461746553746F7261676529207B0A20202020202072657475726E3B0A202020207D0A0A20202020636F6E73742073746F72656456616C7565203D0A202020202020696E7374616E63652E737461746553746F726167652E6765';
wwv_flow_imp.g_varchar2_table(64) := '744974656D280A202020202020202053544F524147455F4B45590A202020202020293B0A0A20202020696620282173746F72656456616C756529207B0A0A20202020202073617665537461746528696E7374616E6365293B0A0A20202020202072657475';
wwv_flow_imp.g_varchar2_table(65) := '726E3B0A0A202020207D0A0A20202020747279207B0A0A202020202020636F6E7374207061727365645374617465203D0A20202020202020204A534F4E2E70617273652873746F72656456616C7565293B0A0A202020202020696620280A202020202020';
wwv_flow_imp.g_varchar2_table(66) := '2020697356616C696453746F7265645374617465280A20202020202020202020696E7374616E63652C0A2020202020202020202070617273656453746174650A2020202020202020290A20202020202029207B0A0A2020202020202020696E7374616E63';
wwv_flow_imp.g_varchar2_table(67) := '652E73746F7265645374617465203D0A2020202020202020202070617273656453746174653B0A0A202020202020202072657475726E3B0A0A2020202020207D0A0A202020207D206361746368207B0A0A2020202020202F2A0A202020202020202A2049';
wwv_flow_imp.g_varchar2_table(68) := '676E6F726520696E76616C6964206F72206F62736F6C6574652073746F72656420646174612E0A202020202020202A2F0A0A202020207D0A0A202020202F2A0A20202020202A2053746F7261676520666F726D6174206368616E6765642C2073746F7265';
wwv_flow_imp.g_varchar2_table(69) := '64206461746120697320696E76616C69642C0A20202020202A206F7220496E697469616C6C7920457870616E64656420686173206368616E6765642E0A20202020202A2F0A20202020696E7374616E63652E73746F7265645374617465203D0A20202020';
wwv_flow_imp.g_varchar2_table(70) := '202063726561746553746F726564537461746528696E7374616E6365293B0A0A2020202073617665537461746528696E7374616E6365293B0A0A20207D0A0A0A20202F2A0A2020202A2052656D6F76652072656D656D6265726564207374617465206672';
wwv_flow_imp.g_varchar2_table(71) := '6F6D20626F74682062726F777365722073746F726167652074797065732E0A2020202A0A2020202A20436C656172696E6720626F74682070726576656E747320616E206F6C642073746174652066726F6D20756E65787065637465646C790A2020202A20';
wwv_flow_imp.g_varchar2_table(72) := '7265617070656172696E672069662052656D656D626572205374617465206D6F6465206973206368616E676564206C617465722E0A2020202A2F0A202066756E6374696F6E20636C65617253746F726564537461746528726567696F6E496429207B0A0A';
wwv_flow_imp.g_varchar2_table(73) := '202020206966202821726567696F6E496429207B0A20202020202072657475726E3B0A202020207D0A0A20202020636F6E73742073746F726167654F7074696F6E73203D207B0A202020202020707265666978202020203A2053544F524147455F505245';
wwv_flow_imp.g_varchar2_table(74) := '4649582C0A202020202020757365417070496420203A20747275652C0A202020202020757365506167654964203A20747275652C0A202020202020726567696F6E496420203A20726567696F6E49640A202020207D3B0A0A20202020617065782E73746F';
wwv_flow_imp.g_varchar2_table(75) := '726167650A2020202020202E67657453636F70656453657373696F6E53746F72616765280A202020202020202073746F726167654F7074696F6E730A202020202020290A2020202020202E72656D6F76654974656D280A202020202020202053544F5241';
wwv_flow_imp.g_varchar2_table(76) := '47455F4B45590A202020202020293B0A0A20202020617065782E73746F726167650A2020202020202E67657453636F7065644C6F63616C53746F72616765280A202020202020202073746F726167654F7074696F6E730A202020202020290A2020202020';
wwv_flow_imp.g_varchar2_table(77) := '202E72656D6F76654974656D280A202020202020202053544F524147455F4B45590A202020202020293B0A0A20207D0A0A0A20202F2A0A2020202A2052657475726E2074686520726F777320636F6E74726F6C6C6564206279206F6E6520636F6E74726F';
wwv_flow_imp.g_varchar2_table(78) := '6C2D627265616B206865616465722E0A2020202A2F0A202066756E6374696F6E2067657447726F7570526F7773286865616465722429207B0A0A2020202072657475726E20686561646572240A2020202020202E636C6F736573742822747222290A2020';
wwv_flow_imp.g_varchar2_table(79) := '202020202E6E657874556E74696C280A20202020202020206074723A68617328247B434F4E54524F4C5F425245414B5F53454C4543544F527D29600A202020202020293B0A0A20207D0A0A0A20202F2A0A2020202A20436F6E7665727420612076616C75';
wwv_flow_imp.g_varchar2_table(80) := '6520696E746F2061207361666520667261676D656E7420666F722067656E6572617465642048544D4C204944732E0A2020202A2F0A202066756E6374696F6E20736166654964506172742876616C756529207B0A0A2020202072657475726E2053747269';
wwv_flow_imp.g_varchar2_table(81) := '6E672876616C7565290A2020202020202E7265706C616365280A20202020202020202F5B5E412D5A612D7A302D395F2D5D2F672C0A2020202020202020225F220A202020202020293B0A0A20207D0A0A0A20202F2A0A2020202A20456E73757265206576';
wwv_flow_imp.g_varchar2_table(82) := '65727920636F6E74726F6C6C656420726F772068617320616E2049442E0A2020202A0A2020202A2054686520726F772049447320617265207573656420627920617269612D636F6E74726F6C73206F6E2074686520746F67676C6520627574746F6E2E0A';
wwv_flow_imp.g_varchar2_table(83) := '2020202A204578697374696E67204944732067656E6572617465642062792041504558206F72206170706C69636174696F6E20636F646520617265207072657365727665642E0A2020202A2F0A202066756E6374696F6E20656E73757265436F6E74726F';
wwv_flow_imp.g_varchar2_table(84) := '6C6C6564526F77496473280A20202020696E7374616E63652C0A20202020686561646572242C0A2020202067726F7570496E6465780A202029207B0A0A20202020636F6E737420726F777324203D0A20202020202067657447726F7570526F7773280A20';
wwv_flow_imp.g_varchar2_table(85) := '20202020202020686561646572240A202020202020293B0A0A20202020636F6E737420696473203D0A2020202020205B5D3B0A0A20202020636F6E7374206865616465724964203D0A202020202020686561646572242E617474722822696422293B0A0A';
wwv_flow_imp.g_varchar2_table(86) := '20202020636F6E737420726567696F6E50617274203D0A20202020202073616665496450617274280A2020202020202020696E7374616E63652E726567696F6E4964207C7C0A2020202020202020226972220A202020202020293B0A0A20202020636F6E';
wwv_flow_imp.g_varchar2_table(87) := '73742067726F757050617274203D0A20202020202073616665496450617274280A20202020202020206865616465724964207C7C0A20202020202020206067726F75705F247B67726F7570496E646578202B20317D600A202020202020293B0A0A202020';
wwv_flow_imp.g_varchar2_table(88) := '20726F7773242E656163682866756E6374696F6E28726F77496E64657829207B0A0A202020202020636F6E737420726F7724203D0A2020202020202020242874686973293B0A0A2020202020206C657420726F774964203D0A2020202020202020726F77';
wwv_flow_imp.g_varchar2_table(89) := '242E617474722822696422293B0A0A2020202020206966202821726F77496429207B0A0A2020202020202020636F6E737420626173654964203D0A2020202020202020202060247B726567696F6E506172747D5F63625F247B67726F7570506172747D5F';
wwv_flow_imp.g_varchar2_table(90) := '726F775F247B726F77496E646578202B20317D603B0A0A2020202020202020726F774964203D0A202020202020202020206261736549643B0A0A20202020202020206C657420636F756E746572203D0A20202020202020202020323B0A0A202020202020';
wwv_flow_imp.g_varchar2_table(91) := '20202F2A0A2020202020202020202A2050726F7465637420616761696E737420756E6578706563746564206475706C6963617465204944732E0A2020202020202020202A2F0A20202020202020207768696C6520280A20202020202020202020646F6375';
wwv_flow_imp.g_varchar2_table(92) := '6D656E742E676574456C656D656E744279496428726F774964292026260A20202020202020202020646F63756D656E742E676574456C656D656E744279496428726F7749642920213D3D20746869730A202020202020202029207B0A0A20202020202020';
wwv_flow_imp.g_varchar2_table(93) := '202020726F774964203D0A20202020202020202020202060247B6261736549647D5F247B636F756E7465727D603B0A0A20202020202020202020636F756E746572202B3D20313B0A0A20202020202020207D0A0A2020202020202020726F77242E617474';
wwv_flow_imp.g_varchar2_table(94) := '72280A20202020202020202020226964222C0A20202020202020202020726F7749640A2020202020202020293B0A0A2020202020207D0A0A2020202020206964732E70757368280A2020202020202020726F7749640A202020202020293B0A0A20202020';
wwv_flow_imp.g_varchar2_table(95) := '7D293B0A0A2020202072657475726E206964733B0A0A20207D0A0A0A20202F2A0A2020202A20437265617465206F722072657475726E2074686520746F67676C6520627574746F6E20666F72206F6E6520636F6E74726F6C20627265616B2E0A2020202A';
wwv_flow_imp.g_varchar2_table(96) := '2F0A202066756E6374696F6E20656E73757265427574746F6E280A20202020696E7374616E63652C0A20202020686561646572242C0A2020202067726F7570496E6465780A202029207B0A0A202020206C657420627574746F6E24203D0A202020202020';
wwv_flow_imp.g_varchar2_table(97) := '686561646572242E6368696C6472656E280A2020202020202020425554544F4E5F53454C4543544F520A202020202020293B0A0A202020202F2A0A20202020202A204372656174652074686520627574746F6E207768656E20697420646F65736E277420';
wwv_flow_imp.g_varchar2_table(98) := '616C72656164792065786973742E0A20202020202A2F0A202020206966202821627574746F6E242E6C656E67746829207B0A0A202020202020627574746F6E24203D0A20202020202020202428223C627574746F6E3E222C207B0A202020202020202020';
wwv_flow_imp.g_varchar2_table(99) := '2074797065203A2022627574746F6E220A20202020202020207D293B0A0A202020207D0A0A0A202020202F2A0A20202020202A20456E73757265207468652069636F6E206578697374732E0A20202020202A2F0A202020206C65742069636F6E24203D0A';
wwv_flow_imp.g_varchar2_table(100) := '202020202020627574746F6E242E6368696C6472656E280A202020202020202049434F4E5F53454C4543544F520A202020202020293B0A0A20202020696620282169636F6E242E6C656E67746829207B0A0A20202020202069636F6E24203D0A20202020';
wwv_flow_imp.g_varchar2_table(101) := '202020202428223C7370616E3E222C207B0A2020202020202020202022617269612D68696464656E22203A202274727565222C0A20202020202020202020636C6173732020202020202020203A2022742D49636F6E2066612069722D636F6E74726F6C2D';
wwv_flow_imp.g_varchar2_table(102) := '627265616B2D69636F6E220A20202020202020207D293B0A0A202020202020627574746F6E242E617070656E64280A202020202020202069636F6E240A202020202020293B0A0A202020207D0A0A0A202020202F2A0A20202020202A2052656672657368';
wwv_flow_imp.g_varchar2_table(103) := '20627574746F6E20636C617373657320696E2063617365206170706C69636174696F6E2D73636F70650A20202020202A20706C75672D696E20636F6E66696775726174696F6E206368616E6765642E0A20202020202A2F0A20202020627574746F6E242E';
wwv_flow_imp.g_varchar2_table(104) := '61747472280A20202020202022636C617373222C0A20202020202060247B696E7374616E63652E6F7074696F6E732E627574746F6E437373436C61737365737D2069722D636F6E74726F6C2D627265616B2D62746E600A20202020202020202E7472696D';
wwv_flow_imp.g_varchar2_table(105) := '28290A20202020293B0A0A0A202020202F2A0A20202020202A2041646420706F736974696F6E2D737065636966696320636C617373657320666F72207374796C696E672E0A20202020202A2F0A20202020627574746F6E240A2020202020202E746F6767';
wwv_flow_imp.g_varchar2_table(106) := '6C65436C617373280A20202020202020202269722D636F6E74726F6C2D627265616B2D62746E2D2D7374617274222C0A2020202020202020696E7374616E63652E6F7074696F6E732E627574746F6E506F736974696F6E203D3D3D0A2020202020202020';
wwv_flow_imp.g_varchar2_table(107) := '2020225354415254220A202020202020290A2020202020202E746F67676C65436C617373280A20202020202020202269722D636F6E74726F6C2D627265616B2D62746E2D2D656E64222C0A2020202020202020696E7374616E63652E6F7074696F6E732E';
wwv_flow_imp.g_varchar2_table(108) := '627574746F6E506F736974696F6E203D3D3D0A2020202020202020202022454E44220A202020202020293B0A0A0A202020202F2A0A20202020202A204D6F76652074686520627574746F6E20746F2074686520726571756573746564206C6F676963616C';
wwv_flow_imp.g_varchar2_table(109) := '2073696465206F660A20202020202A2074686520636F6E74726F6C2D627265616B206865616465722E0A20202020202A0A20202020202A20435353206F6E207468652073746172742F656E6420636C617373657320616C69676E73207468652062757474';
wwv_flow_imp.g_varchar2_table(110) := '6F6E0A20202020202A2076697375616C6C7920746F207468652065646765206F662074686520726F772E0A20202020202A2F0A20202020696620280A202020202020696E7374616E63652E6F7074696F6E732E627574746F6E506F736974696F6E203D3D';
wwv_flow_imp.g_varchar2_table(111) := '3D0A20202020202022454E44220A2020202029207B0A0A202020202020686561646572242E617070656E64280A2020202020202020627574746F6E240A202020202020293B0A0A202020207D20656C7365207B0A0A202020202020686561646572242E70';
wwv_flow_imp.g_varchar2_table(112) := '726570656E64280A2020202020202020627574746F6E240A202020202020293B0A0A202020207D0A0A0A202020202F2A0A20202020202A2045737461626C6973682074686520415249412072656C6174696F6E73686970206265747765656E2074686520';
wwv_flow_imp.g_varchar2_table(113) := '627574746F6E0A20202020202A20616E642074686520726F777320636F6E74726F6C6C656420627920746869732067726F75702E0A20202020202A2F0A20202020636F6E737420636F6E74726F6C6C6564496473203D0A202020202020656E7375726543';
wwv_flow_imp.g_varchar2_table(114) := '6F6E74726F6C6C6564526F77496473280A2020202020202020696E7374616E63652C0A2020202020202020686561646572242C0A202020202020202067726F7570496E6465780A202020202020293B0A0A2020202069662028636F6E74726F6C6C656449';
wwv_flow_imp.g_varchar2_table(115) := '64732E6C656E67746829207B0A0A202020202020627574746F6E242E61747472280A202020202020202022617269612D636F6E74726F6C73222C0A2020202020202020636F6E74726F6C6C65644964732E6A6F696E28222022290A202020202020293B0A';
wwv_flow_imp.g_varchar2_table(116) := '0A202020207D20656C7365207B0A0A202020202020627574746F6E242E72656D6F766541747472280A202020202020202022617269612D636F6E74726F6C73220A202020202020293B0A0A202020207D0A0A2020202072657475726E20627574746F6E24';
wwv_flow_imp.g_varchar2_table(117) := '3B0A0A20207D0A0A0A20202F2A0A2020202A20557064617465207469746C652C2061636365737369626C65206C6162656C2C20657870616E6465642073746174652C20616E642069636F6E2E0A2020202A2F0A202066756E6374696F6E20736574427574';
wwv_flow_imp.g_varchar2_table(118) := '746F6E5374617465280A20202020696E7374616E63652C0A20202020627574746F6E242C0A202020206973457870616E6465640A202029207B0A0A20202020636F6E7374207469746C65203D0A2020202020206973457870616E6465640A202020202020';
wwv_flow_imp.g_varchar2_table(119) := '20203F20696E7374616E63652E6F7074696F6E732E636F6C6C617073655469746C650A20202020202020203A20696E7374616E63652E6F7074696F6E732E657870616E645469746C653B0A0A20202020636F6E73742069636F6E203D0A20202020202069';
wwv_flow_imp.g_varchar2_table(120) := '73457870616E6465640A20202020202020203F20696E7374616E63652E6F7074696F6E732E636F6C6C6170736549636F6E0A20202020202020203A20696E7374616E63652E6F7074696F6E732E657870616E6449636F6E3B0A0A0A20202020627574746F';
wwv_flow_imp.g_varchar2_table(121) := '6E240A2020202020202E61747472287B0A20202020202020207469746C653A0A202020202020202020207469746C652C0A0A202020202020202022617269612D6C6162656C223A0A202020202020202020207469746C652C0A0A20202020202020202261';
wwv_flow_imp.g_varchar2_table(122) := '7269612D657870616E646564223A0A202020202020202020206973457870616E6465642E746F537472696E6728290A2020202020207D293B0A0A0A20202020627574746F6E240A2020202020202E6368696C6472656E280A202020202020202049434F4E';
wwv_flow_imp.g_varchar2_table(123) := '5F53454C4543544F520A202020202020290A2020202020202E72656D6F7665436C617373280A202020202020202060247B696E7374616E63652E6F7074696F6E732E636F6C6C6170736549636F6E7D20247B696E7374616E63652E6F7074696F6E732E65';
wwv_flow_imp.g_varchar2_table(124) := '7870616E6449636F6E7D600A202020202020290A2020202020202E616464436C617373280A202020202020202069636F6E0A202020202020293B0A0A20207D0A0A0A20202F2A0A2020202A2054726967676572206F6E6520726567696F6E2D6C6576656C';
wwv_flow_imp.g_varchar2_table(125) := '206368616E6765206576656E742E0A2020202A0A2020202A20555345523A0A2020202A2020204F6E65206865616465722049442E0A2020202A0A2020202A20455850414E445F414C4C202F20434F4C4C415053455F414C4C202F2052455345543A0A2020';
wwv_flow_imp.g_varchar2_table(126) := '202A202020416C6C206368616E676564206865616465722049447320696E206F6E65206576656E742E0A2020202A2F0A202066756E6374696F6E20747269676765724368616E67654576656E74280A20202020696E7374616E63652C0A20202020686561';
wwv_flow_imp.g_varchar2_table(127) := '6465724964732C0A202020206973457870616E6465642C0A20202020736F757263650A202029207B0A0A20202020617065782E6576656E742E74726967676572280A202020202020696E7374616E63652E726567696F6E242C0A2020202020204348414E';
wwv_flow_imp.g_varchar2_table(128) := '47455F4556454E542C0A2020202020207B0A2020202020202020726567696F6E49643A0A20202020202020202020696E7374616E63652E726567696F6E49642C0A0A20202020202020206865616465724964733A0A202020202020202020206865616465';
wwv_flow_imp.g_varchar2_table(129) := '724964732C0A0A2020202020202020657870616E6465643A0A202020202020202020206973457870616E6465642C0A0A2020202020202020736F757263653A0A20202020202020202020736F757263650A2020202020207D0A20202020293B0A0A20207D';
wwv_flow_imp.g_varchar2_table(130) := '0A0A0A20202F2A0A2020202A20536574206F6E6520636F6E74726F6C2D627265616B2067726F757020746F20746865207265717565737465642073746174652E0A2020202A0A2020202A2070657273697374537461746520757064617465732074686520';
wwv_flow_imp.g_varchar2_table(131) := '696E2D6D656D6F72792072656D656D62657265642073746174652E0A2020202A0A2020202A2053746F72616765206973207772697474656E206279207468652063616C6C657220736F20746861742062756C6B206F7065726174696F6E730A2020202A20';
wwv_flow_imp.g_varchar2_table(132) := '6F6E6C79206E65656420746F207772697465206F6E63652E0A2020202A0A2020202A206576656E74536F757263653A0A2020202A0A2020202A202020555345520A2020202A2020206E756C6C0A2020202A0A2020202A2042756C6B206F7065726174696F';
wwv_flow_imp.g_varchar2_table(133) := '6E732070617373206E756C6C206865726520616E6420656D6974206F6E65206167677265676174650A2020202A206576656E7420616674657220616C6C2067726F7570732068617665206265656E2070726F6365737365642E0A2020202A2F0A20206675';
wwv_flow_imp.g_varchar2_table(134) := '6E6374696F6E2073657447726F7570457870616E646564280A20202020696E7374616E63652C0A20202020686561646572242C0A202020206973457870616E6465642C0A202020207065727369737453746174652C0A202020206576656E74536F757263';
wwv_flow_imp.g_varchar2_table(135) := '650A202029207B0A0A20202020636F6E737420627574746F6E24203D0A202020202020686561646572242E6368696C6472656E280A2020202020202020425554544F4E5F53454C4543544F520A202020202020293B0A0A20202020636F6E737420707265';
wwv_flow_imp.g_varchar2_table(136) := '76696F7573457870616E646564203D0A202020202020627574746F6E242E61747472280A202020202020202022617269612D657870616E646564220A20202020202029203D3D3D202274727565223B0A0A0A20202020736574427574746F6E5374617465';
wwv_flow_imp.g_varchar2_table(137) := '280A202020202020696E7374616E63652C0A202020202020627574746F6E242C0A2020202020206973457870616E6465640A20202020293B0A0A0A2020202067657447726F7570526F7773280A202020202020686561646572240A20202020290A202020';
wwv_flow_imp.g_varchar2_table(138) := '2020202E746F67676C65280A20202020202020206973457870616E6465640A202020202020293B0A0A0A202020202F2A0A20202020202A205570646174652072656D656D62657265642073746174652E0A20202020202A2F0A20202020696620280A2020';
wwv_flow_imp.g_varchar2_table(139) := '202020207065727369737453746174652026260A202020202020696E7374616E63652E737461746553746F726167650A2020202029207B0A0A202020202020636F6E7374206865616465724964203D0A2020202020202020686561646572242E61747472';
wwv_flow_imp.g_varchar2_table(140) := '2822696422293B0A0A20202020202069662028686561646572496429207B0A0A2020202020202020696E7374616E63652E73746F72656453746174650A202020202020202020202E7374617465735B68656164657249645D203D0A202020202020202020';
wwv_flow_imp.g_varchar2_table(141) := '2020206973457870616E6465643B0A0A2020202020207D0A0A202020207D0A0A0A20202020636F6E7374206368616E676564203D0A20202020202070726576696F7573457870616E64656420213D3D0A2020202020206973457870616E6465643B0A0A0A';
wwv_flow_imp.g_varchar2_table(142) := '202020202F2A0A20202020202A20496E646976696475616C2075736572206368616E67657320656D6974206F6E65206576656E7420696D6D6564696174656C792E0A20202020202A2F0A20202020696620280A2020202020206368616E6765642026260A';
wwv_flow_imp.g_varchar2_table(143) := '2020202020206576656E74536F757263650A2020202029207B0A0A202020202020636F6E7374206865616465724964203D0A2020202020202020686561646572242E617474722822696422293B0A0A202020202020747269676765724368616E67654576';
wwv_flow_imp.g_varchar2_table(144) := '656E74280A2020202020202020696E7374616E63652C0A202020202020202068656164657249640A202020202020202020203F205B68656164657249645D0A202020202020202020203A205B5D2C0A20202020202020206973457870616E6465642C0A20';
wwv_flow_imp.g_varchar2_table(145) := '202020202020206576656E74536F757263650A202020202020293B0A0A202020207D0A0A2020202072657475726E206368616E6765643B0A0A20207D0A0A0A20202F2A0A2020202A2052657475726E20616C6C2063757272656E7420636F6E74726F6C2D';
wwv_flow_imp.g_varchar2_table(146) := '627265616B206865616465727320666F72206F6E6520726567696F6E2E0A2020202A2F0A202066756E6374696F6E20676574427265616B4865616465727328696E7374616E636529207B0A0A2020202072657475726E20696E7374616E63652E72656769';
wwv_flow_imp.g_varchar2_table(147) := '6F6E240A2020202020202E66696E64280A2020202020202020434F4E54524F4C5F425245414B5F53454C4543544F520A202020202020293B0A0A20207D0A0A0A20202F2A0A2020202A20496E697469616C697A6520616C6C2063757272656E7420636F6E';
wwv_flow_imp.g_varchar2_table(148) := '74726F6C2D627265616B2067726F7570732E0A2020202A2F0A202066756E6374696F6E20696E697469616C697A6547726F75707328696E7374616E636529207B0A0A20202020636F6E737420627265616B4865616465727324203D0A2020202020206765';
wwv_flow_imp.g_varchar2_table(149) := '74427265616B48656164657273280A2020202020202020696E7374616E63650A202020202020293B0A0A20202020627265616B48656164657273240A2020202020202E656163682866756E6374696F6E2867726F7570496E64657829207B0A0A20202020';
wwv_flow_imp.g_varchar2_table(150) := '20202020636F6E73742068656164657224203D0A20202020202020202020242874686973293B0A0A2020202020202020636F6E7374206865616465724964203D0A20202020202020202020686561646572242E617474722822696422293B0A0A20202020';
wwv_flow_imp.g_varchar2_table(151) := '202020202F2A0A2020202020202020202A20496E697469616C6C7920457870616E646564206973207468652064656661756C742073746174652E0A2020202020202020202A2F0A20202020202020206C6574206973457870616E646564203D0A20202020';
wwv_flow_imp.g_varchar2_table(152) := '202020202020696E7374616E63652E6F7074696F6E730A2020202020202020202020202E696E697469616C6C79457870616E6465643B0A0A0A20202020202020202F2A0A2020202020202020202A2052656D656D62657265642073746174652074616B65';
wwv_flow_imp.g_varchar2_table(153) := '7320707265636564656E63652E0A2020202020202020202A2F0A2020202020202020696620280A20202020202020202020696E7374616E63652E737461746553746F726167652026260A2020202020202020202068656164657249642026260A20202020';
wwv_flow_imp.g_varchar2_table(154) := '2020202020204F626A6563742E70726F746F747970650A2020202020202020202020202E6861734F776E50726F70657274792E63616C6C280A2020202020202020202020202020696E7374616E63652E73746F72656453746174652E7374617465732C0A';
wwv_flow_imp.g_varchar2_table(155) := '202020202020202020202020202068656164657249640A202020202020202020202020290A202020202020202029207B0A0A202020202020202020206973457870616E646564203D0A202020202020202020202020696E7374616E63652E73746F726564';
wwv_flow_imp.g_varchar2_table(156) := '53746174650A20202020202020202020202020202E7374617465735B68656164657249645D3B0A0A20202020202020207D0A0A0A2020202020202020656E73757265427574746F6E280A20202020202020202020696E7374616E63652C0A202020202020';
wwv_flow_imp.g_varchar2_table(157) := '20202020686561646572242C0A2020202020202020202067726F7570496E6465780A2020202020202020293B0A0A0A20202020202020202F2A0A2020202020202020202A20496E697469616C697A6174696F6E2F726573746F726174696F6E20646F6573';
wwv_flow_imp.g_varchar2_table(158) := '206E6F743A0A2020202020202020202A0A2020202020202020202A202D206372656174652072656D656D626572656420737461746520656E74726965730A2020202020202020202A202D2066697265206368616E6765206576656E74730A202020202020';
wwv_flow_imp.g_varchar2_table(159) := '2020202A2F0A202020202020202073657447726F7570457870616E646564280A20202020202020202020696E7374616E63652C0A20202020202020202020686561646572242C0A202020202020202020206973457870616E6465642C0A20202020202020';
wwv_flow_imp.g_varchar2_table(160) := '20202066616C73652C0A202020202020202020206E756C6C0A2020202020202020293B0A0A2020202020207D293B0A0A20207D0A0A0A20202F2A0A2020202A20417474616368207468652064656C65676174656420636C69636B2068616E646C65722E0A';
wwv_flow_imp.g_varchar2_table(161) := '2020202A2F0A202066756E6374696F6E20617474616368436C69636B48616E646C657228696E7374616E636529207B0A0A20202020696E7374616E63652E726567696F6E240A2020202020202E6F6666280A202020202020202022636C69636B2E636F6E';
wwv_flow_imp.g_varchar2_table(162) := '74726F6C427265616B546F67676C65220A202020202020290A2020202020202E6F6E280A202020202020202022636C69636B2E636F6E74726F6C427265616B546F67676C65222C0A2020202020202020425554544F4E5F53454C4543544F522C0A202020';
wwv_flow_imp.g_varchar2_table(163) := '202020202066756E6374696F6E2829207B0A0A20202020202020202020636F6E737420627574746F6E24203D0A202020202020202020202020242874686973293B0A0A20202020202020202020636F6E73742068656164657224203D0A20202020202020';
wwv_flow_imp.g_varchar2_table(164) := '2020202020627574746F6E242E636C6F73657374280A2020202020202020202020202020434F4E54524F4C5F425245414B5F53454C4543544F520A202020202020202020202020293B0A0A20202020202020202020636F6E7374206973457870616E6465';
wwv_flow_imp.g_varchar2_table(165) := '64203D0A202020202020202020202020627574746F6E242E61747472280A202020202020202020202020202022617269612D657870616E646564220A20202020202020202020202029203D3D3D202274727565223B0A0A20202020202020202020636F6E';
wwv_flow_imp.g_varchar2_table(166) := '7374206E6577457870616E646564203D0A202020202020202020202020216973457870616E6465643B0A0A0A202020202020202020202F2A0A20202020202020202020202A205573657220696E746572616374696F6E206368616E676573206F6E652067';
wwv_flow_imp.g_varchar2_table(167) := '726F757020616E64207468657265666F72650A20202020202020202020202A20656D697473206F6E652055534552206368616E6765206576656E742E0A20202020202020202020202A2F0A2020202020202020202073657447726F7570457870616E6465';
wwv_flow_imp.g_varchar2_table(168) := '64280A202020202020202020202020696E7374616E63652C0A202020202020202020202020686561646572242C0A2020202020202020202020206E6577457870616E6465642C0A202020202020202020202020747275652C0A2020202020202020202020';
wwv_flow_imp.g_varchar2_table(169) := '202255534552220A20202020202020202020293B0A0A0A20202020202020202020736176655374617465280A202020202020202020202020696E7374616E63650A20202020202020202020293B0A0A20202020202020207D0A202020202020293B0A0A20';
wwv_flow_imp.g_varchar2_table(170) := '207D0A0A0A20202F2A0A2020202A2052657475726E2074686520696E697469616C697A656420696E7374616E636520666F722065786163746C79206F6E6520726567696F6E2E0A2020202A0A2020202A205075626C696320415049206D6574686F647320';
wwv_flow_imp.g_varchar2_table(171) := '75736520746869732068656C7065722E0A2020202A2F0A202066756E6374696F6E20676574496E7374616E636528726567696F6E29207B0A0A20202020636F6E737420726567696F6E24203D0A2020202020207265736F6C7665526567696F6E280A2020';
wwv_flow_imp.g_varchar2_table(172) := '202020202020726567696F6E0A202020202020293B0A0A202020206966202821726567696F6E242E6C656E67746829207B0A20202020202072657475726E206E756C6C3B0A202020207D0A0A2020202072657475726E20696E7374616E6365732E676574';
wwv_flow_imp.g_varchar2_table(173) := '280A202020202020726567696F6E245B305D0A2020202029207C7C206E756C6C3B0A0A20207D0A0A0A20202F2A0A2020202A20496E697469616C697A65206F6E6520496E746572616374697665205265706F727420726567696F6E2E0A2020202A2F0A20';
wwv_flow_imp.g_varchar2_table(174) := '2066756E6374696F6E20696E6974496E7374616E6365280A20202020726567696F6E2C0A202020206F7074696F6E730A202029207B0A0A20202020636F6E737420726567696F6E24203D0A2020202020202428726567696F6E292E666972737428293B0A';
wwv_flow_imp.g_varchar2_table(175) := '0A202020206966202821726567696F6E242E6C656E67746829207B0A20202020202072657475726E2066616C73653B0A202020207D0A0A0A20202020636F6E7374206E6F726D616C697A65644F7074696F6E73203D0A2020202020206E6F726D616C697A';
wwv_flow_imp.g_varchar2_table(176) := '654F7074696F6E73280A20202020202020206F7074696F6E730A202020202020293B0A0A0A202020202F2A0A20202020202A205768656E20457870616E642049636F6E20697320656D7074792C206175746F6D61746963616C6C792073656C6563740A20';
wwv_flow_imp.g_varchar2_table(177) := '202020202A2074686520646972656374696F6E616C2069636F6E206261736564206F6E3A0A20202020202A0A20202020202A202D20427574746F6E20506F736974696F6E0A20202020202A202D204C5452202F2052544C20646972656374696F6E0A2020';
wwv_flow_imp.g_varchar2_table(178) := '2020202A2F0A2020202069662028216E6F726D616C697A65644F7074696F6E732E657870616E6449636F6E29207B0A0A2020202020206E6F726D616C697A65644F7074696F6E732E657870616E6449636F6E203D0A202020202020202067657444656661';
wwv_flow_imp.g_varchar2_table(179) := '756C74457870616E6449636F6E280A20202020202020202020726567696F6E242C0A202020202020202020206E6F726D616C697A65644F7074696F6E732E627574746F6E506F736974696F6E0A2020202020202020293B0A0A202020207D0A0A0A202020';
wwv_flow_imp.g_varchar2_table(180) := '20636F6E737420726567696F6E4964203D0A202020202020726567696F6E242E617474722822696422293B0A0A0A20202020636F6E737420696E7374616E6365203D207B0A0A202020202020726567696F6E243A0A2020202020202020726567696F6E24';
wwv_flow_imp.g_varchar2_table(181) := '2C0A0A202020202020726567696F6E49643A0A2020202020202020726567696F6E49642C0A0A2020202020206F7074696F6E733A0A20202020202020206E6F726D616C697A65644F7074696F6E732C0A0A202020202020737461746553746F726167653A';
wwv_flow_imp.g_varchar2_table(182) := '0A2020202020202020676574537461746553746F72616765280A20202020202020202020726567696F6E49642C0A202020202020202020206E6F726D616C697A65644F7074696F6E732E72656D656D62657253746174650A2020202020202020292C0A0A';
wwv_flow_imp.g_varchar2_table(183) := '20202020202073746F72656453746174653A0A20202020202020206E756C6C0A0A202020207D3B0A0A0A202020206C6F61645374617465280A202020202020696E7374616E63650A20202020293B0A0A0A202020202F2A0A20202020202A2053746F7265';
wwv_flow_imp.g_varchar2_table(184) := '207468697320726567696F6E20617320616E20696E646570656E64656E7420706C75672D696E20696E7374616E63652E0A20202020202A2F0A20202020696E7374616E6365732E736574280A202020202020726567696F6E245B305D2C0A202020202020';
wwv_flow_imp.g_varchar2_table(185) := '696E7374616E63650A20202020293B0A0A0A20202020617474616368436C69636B48616E646C6572280A202020202020696E7374616E63650A20202020293B0A0A0A20202020696E697469616C697A6547726F757073280A202020202020696E7374616E';
wwv_flow_imp.g_varchar2_table(186) := '63650A20202020293B0A0A0A2020202072657475726E20747275653B0A0A20207D0A0A0A20202F2A0A2020202A20496E697469616C697A65206F6E65206F72206D6F7265206D61746368696E6720496E746572616374697665205265706F727420726567';
wwv_flow_imp.g_varchar2_table(187) := '696F6E732E0A2020202A0A2020202A205468697320616C6C6F777320612044796E616D696320416374696F6E207573696E672061206A51756572792073656C6563746F7220746F207461726765740A2020202A206D756C7469706C65204952732E0A2020';
wwv_flow_imp.g_varchar2_table(188) := '202A0A2020202A2045616368206D61746368656420726567696F6E206973207374696C6C20616E20696E646570656E64656E7420706C75672D696E20696E7374616E63652E0A2020202A2F0A202066756E6374696F6E20696E6974280A20202020726567';
wwv_flow_imp.g_varchar2_table(189) := '696F6E2C0A202020206F7074696F6E730A202029207B0A0A20202020636F6E737420726567696F6E7324203D0A2020202020207265736F6C7665526567696F6E73280A2020202020202020726567696F6E0A202020202020293B0A0A2020202069662028';
wwv_flow_imp.g_varchar2_table(190) := '21726567696F6E73242E6C656E67746829207B0A20202020202072657475726E2066616C73653B0A202020207D0A0A0A202020206C657420696E697469616C697A6564203D0A20202020202066616C73653B0A0A0A20202020726567696F6E73240A2020';
wwv_flow_imp.g_varchar2_table(191) := '202020202E656163682866756E6374696F6E2829207B0A0A2020202020202020696620280A20202020202020202020696E6974496E7374616E6365280A202020202020202020202020746869732C0A2020202020202020202020206F7074696F6E730A20';
wwv_flow_imp.g_varchar2_table(192) := '202020202020202020290A202020202020202029207B0A0A20202020202020202020696E697469616C697A6564203D0A202020202020202020202020747275653B0A0A20202020202020207D0A0A2020202020207D293B0A0A0A2020202072657475726E';
wwv_flow_imp.g_varchar2_table(193) := '20696E697469616C697A65643B0A0A20207D0A0A0A20202F2A0A2020202A204170706C79206F6E6520737461746520746F20616C6C20636F6E74726F6C2D627265616B2067726F75707320696E2065786163746C790A2020202A206F6E6520696E697469';
wwv_flow_imp.g_varchar2_table(194) := '616C697A656420726567696F6E2E0A2020202A0A2020202A204F6E6C79206F6E65206972636F6E74726F6C627265616B6368616E6765206576656E7420697320656D6974746564206166746572207468650A2020202A206F7065726174696F6E2C207265';
wwv_flow_imp.g_varchar2_table(195) := '676172646C657373206F6620686F77206D616E792067726F757073206368616E6765642E0A2020202A2F0A202066756E6374696F6E20736574416C6C457870616E646564280A20202020726567696F6E2C0A202020206973457870616E6465642C0A2020';
wwv_flow_imp.g_varchar2_table(196) := '2020736F757263650A202029207B0A0A20202020636F6E737420696E7374616E6365203D0A202020202020676574496E7374616E6365280A2020202020202020726567696F6E0A202020202020293B0A0A202020206966202821696E7374616E63652920';
wwv_flow_imp.g_varchar2_table(197) := '7B0A20202020202072657475726E2066616C73653B0A202020207D0A0A0A20202020636F6E7374206368616E676564486561646572496473203D0A2020202020205B5D3B0A0A0A20202020676574427265616B48656164657273280A202020202020696E';
wwv_flow_imp.g_varchar2_table(198) := '7374616E63650A20202020290A2020202020202E656163682866756E6374696F6E2867726F7570496E64657829207B0A0A2020202020202020636F6E73742068656164657224203D0A20202020202020202020242874686973293B0A0A0A202020202020';
wwv_flow_imp.g_varchar2_table(199) := '20202F2A0A2020202020202020202A204E6F726D616C6C7920616C72656164792070726573656E742C2062757420656E737572652074686520627574746F6E206578697374730A2020202020202020202A20696E20636173652074686520415049206973';
wwv_flow_imp.g_varchar2_table(200) := '2063616C6C656420616674657220444F4D206368616E6765732E0A2020202020202020202A2F0A2020202020202020656E73757265427574746F6E280A20202020202020202020696E7374616E63652C0A20202020202020202020686561646572242C0A';
wwv_flow_imp.g_varchar2_table(201) := '2020202020202020202067726F7570496E6465780A2020202020202020293B0A0A0A2020202020202020636F6E7374206368616E676564203D0A2020202020202020202073657447726F7570457870616E646564280A202020202020202020202020696E';
wwv_flow_imp.g_varchar2_table(202) := '7374616E63652C0A202020202020202020202020686561646572242C0A2020202020202020202020206973457870616E6465642C0A202020202020202020202020747275652C0A2020202020202020202020206E756C6C0A20202020202020202020293B';
wwv_flow_imp.g_varchar2_table(203) := '0A0A0A2020202020202020696620286368616E67656429207B0A0A20202020202020202020636F6E7374206865616465724964203D0A202020202020202020202020686561646572242E617474722822696422293B0A0A20202020202020202020696620';
wwv_flow_imp.g_varchar2_table(204) := '28686561646572496429207B0A0A2020202020202020202020206368616E6765644865616465724964732E70757368280A202020202020202020202020202068656164657249640A202020202020202020202020293B0A0A202020202020202020207D0A';
wwv_flow_imp.g_varchar2_table(205) := '0A20202020202020207D0A0A2020202020207D293B0A0A0A202020202F2A0A20202020202A205065727369737420616C6C206368616E676564207374617465732077697468206F6E652073746F726167652077726974652E0A20202020202A2F0A202020';
wwv_flow_imp.g_varchar2_table(206) := '20736176655374617465280A202020202020696E7374616E63650A20202020293B0A0A0A202020202F2A0A20202020202A20456D6974206F6E6520616767726567617465206368616E6765206576656E742E0A20202020202A2F0A202020206966202863';
wwv_flow_imp.g_varchar2_table(207) := '68616E6765644865616465724964732E6C656E67746829207B0A0A202020202020747269676765724368616E67654576656E74280A2020202020202020696E7374616E63652C0A20202020202020206368616E6765644865616465724964732C0A202020';
wwv_flow_imp.g_varchar2_table(208) := '20202020206973457870616E6465642C0A2020202020202020736F757263650A202020202020293B0A0A202020207D0A0A0A2020202072657475726E20747275653B0A0A20207D0A0A0A20202F2A0A2020202A20457870616E6420657665727920636F6E';
wwv_flow_imp.g_varchar2_table(209) := '74726F6C2D627265616B2067726F757020696E206F6E6520726567696F6E2E0A2020202A0A2020202A20726567696F6E206D757374207265736F6C766520746F2065786163746C79206F6E6520696E697469616C697A656420726567696F6E2E0A202020';
wwv_flow_imp.g_varchar2_table(210) := '2A2F0A202066756E6374696F6E20657870616E64416C6C28726567696F6E29207B0A0A2020202072657475726E20736574416C6C457870616E646564280A202020202020726567696F6E2C0A202020202020747275652C0A20202020202022455850414E';
wwv_flow_imp.g_varchar2_table(211) := '445F414C4C220A20202020293B0A0A20207D0A0A0A20202F2A0A2020202A20436F6C6C6170736520657665727920636F6E74726F6C2D627265616B2067726F757020696E206F6E6520726567696F6E2E0A2020202A0A2020202A20726567696F6E206D75';
wwv_flow_imp.g_varchar2_table(212) := '7374207265736F6C766520746F2065786163746C79206F6E6520696E697469616C697A656420726567696F6E2E0A2020202A2F0A202066756E6374696F6E20636F6C6C61707365416C6C28726567696F6E29207B0A0A2020202072657475726E20736574';
wwv_flow_imp.g_varchar2_table(213) := '416C6C457870616E646564280A202020202020726567696F6E2C0A20202020202066616C73652C0A20202020202022434F4C4C415053455F414C4C220A20202020293B0A0A20207D0A0A0A20202F2A0A2020202A20436C6561722072656D656D62657265';
wwv_flow_imp.g_varchar2_table(214) := '6420737461746520666F72206F6E6520726567696F6E20616E6420726573746F72650A2020202A2074686520636F6E6669677572656420496E697469616C6C7920457870616E6465642076616C75652E0A2020202A0A2020202A20426F74682073657373';
wwv_flow_imp.g_varchar2_table(215) := '696F6E20616E642070657273697374656E742062726F777365722073746174652061726520636C65617265642E0A2020202A0A2020202A204F6E65205245534554206576656E7420697320656D6974746564206966206F6E65206F72206D6F7265206375';
wwv_flow_imp.g_varchar2_table(216) := '7272656E742067726F7570730A2020202A2061637475616C6C79206368616E67652073746174652E0A2020202A2F0A202066756E6374696F6E207265736574537461746528726567696F6E29207B0A0A20202020636F6E737420696E7374616E6365203D';
wwv_flow_imp.g_varchar2_table(217) := '0A202020202020676574496E7374616E6365280A2020202020202020726567696F6E0A202020202020293B0A0A202020206966202821696E7374616E636529207B0A20202020202072657475726E2066616C73653B0A202020207D0A0A0A20202020636C';
wwv_flow_imp.g_varchar2_table(218) := '65617253746F7265645374617465280A202020202020696E7374616E63652E726567696F6E49640A20202020293B0A0A0A20202020696E7374616E63652E73746F7265645374617465203D0A20202020202063726561746553746F726564537461746528';
wwv_flow_imp.g_varchar2_table(219) := '0A2020202020202020696E7374616E63650A202020202020293B0A0A0A20202020636F6E7374206368616E676564486561646572496473203D0A2020202020205B5D3B0A0A0A20202020676574427265616B48656164657273280A202020202020696E73';
wwv_flow_imp.g_varchar2_table(220) := '74616E63650A20202020290A2020202020202E656163682866756E6374696F6E2867726F7570496E64657829207B0A0A2020202020202020636F6E73742068656164657224203D0A20202020202020202020242874686973293B0A0A0A20202020202020';
wwv_flow_imp.g_varchar2_table(221) := '20656E73757265427574746F6E280A20202020202020202020696E7374616E63652C0A20202020202020202020686561646572242C0A2020202020202020202067726F7570496E6465780A2020202020202020293B0A0A0A2020202020202020636F6E73';
wwv_flow_imp.g_varchar2_table(222) := '74206368616E676564203D0A2020202020202020202073657447726F7570457870616E646564280A202020202020202020202020696E7374616E63652C0A202020202020202020202020686561646572242C0A202020202020202020202020696E737461';
wwv_flow_imp.g_varchar2_table(223) := '6E63652E6F7074696F6E732E696E697469616C6C79457870616E6465642C0A20202020202020202020202066616C73652C0A2020202020202020202020206E756C6C0A20202020202020202020293B0A0A0A2020202020202020696620286368616E6765';
wwv_flow_imp.g_varchar2_table(224) := '6429207B0A0A20202020202020202020636F6E7374206865616465724964203D0A202020202020202020202020686561646572242E617474722822696422293B0A0A2020202020202020202069662028686561646572496429207B0A0A20202020202020';
wwv_flow_imp.g_varchar2_table(225) := '20202020206368616E6765644865616465724964732E70757368280A202020202020202020202020202068656164657249640A202020202020202020202020293B0A0A202020202020202020207D0A0A20202020202020207D0A0A2020202020207D293B';
wwv_flow_imp.g_varchar2_table(226) := '0A0A0A202020202F2A0A20202020202A2049662072656D656D626572696E6720697320656E61626C65642C2072656372656174652073746F7261676520776974683A0A20202020202A0A20202020202A202D2063757272656E742073746F726167652076';
wwv_flow_imp.g_varchar2_table(227) := '657273696F6E0A20202020202A202D2063757272656E7420496E697469616C6C7920457870616E6465642073657474696E670A20202020202A202D206E6F207065722D67726F7570206F76657272696465730A20202020202A2F0A202020207361766553';
wwv_flow_imp.g_varchar2_table(228) := '74617465280A202020202020696E7374616E63650A20202020293B0A0A0A202020202F2A0A20202020202A20456D6974206F6E6520616767726567617465205245534554206576656E742E0A20202020202A2F0A20202020696620286368616E67656448';
wwv_flow_imp.g_varchar2_table(229) := '65616465724964732E6C656E67746829207B0A0A202020202020747269676765724368616E67654576656E74280A2020202020202020696E7374616E63652C0A20202020202020206368616E6765644865616465724964732C0A2020202020202020696E';
wwv_flow_imp.g_varchar2_table(230) := '7374616E63652E6F7074696F6E732E696E697469616C6C79457870616E6465642C0A2020202020202020225245534554220A202020202020293B0A0A202020207D0A0A0A2020202072657475726E20747275653B0A0A20207D0A0A0A20202F2A0A202020';
wwv_flow_imp.g_varchar2_table(231) := '2A205075626C6963204150492E0A2020202A0A2020202A20696E697428293A0A2020202A2020204D617920696E697469616C697A65206F6E65206F72206D6F7265206D61746368656420726567696F6E732E0A2020202A0A2020202A20657870616E6441';
wwv_flow_imp.g_varchar2_table(232) := '6C6C28293A0A2020202A20636F6C6C61707365416C6C28293A0A2020202A207265736574537461746528293A0A2020202A202020496E74656E74696F6E616C6C79206F706572617465206F6E2065786163746C79206F6E6520726567696F6E2E0A202020';
wwv_flow_imp.g_varchar2_table(233) := '2A2F0A2020706C7567696E2E69722E636F6E74726F6C427265616B546F67676C6572203D207B0A0A20202020696E69743A0A202020202020696E69742C0A0A20202020657870616E64416C6C3A0A202020202020657870616E64416C6C2C0A0A20202020';
wwv_flow_imp.g_varchar2_table(234) := '636F6C6C61707365416C6C3A0A202020202020636F6C6C61707365416C6C2C0A0A20202020726573657453746174653A0A202020202020726573657453746174650A0A20207D3B0A0A0A7D2928617065782E6A51756572792C2066695F6A617269735F70';
wwv_flow_imp.g_varchar2_table(235) := '6C7567696E293B0A0A0A2F2A0A202A205468652044796E616D696320416374696F6E2073686F756C64206E6F726D616C6C79206265206372656174656420776974683A0A202A0A202A2020204576656E743A20416674657220526566726573680A202A0A';
wwv_flow_imp.g_varchar2_table(236) := '202A204120526567696F6E2073656C656374696F6E206E6F726D616C6C7920737570706C696573206F6E652074726967676572696E672049522E0A202A0A202A2041206A51756572792053656C6563746F722063616E20737570706C79206F6E65206F72';
wwv_flow_imp.g_varchar2_table(237) := '206D6F7265206D61746368696E67204952733B0A202A20696E6974282920747265617473206561636820617320616E20696E646570656E64656E7420706C75672D696E20696E7374616E63652E0A202A0A202A204E6F20416666656374656420456C656D';
wwv_flow_imp.g_varchar2_table(238) := '656E747320636F6E66696775726174696F6E20697320726571756972656420626563617573650A202A2074686520706C75672D696E2075736573206461436F6E6669672E74726967676572696E67456C656D656E742E0A202A2F0A77696E646F772E6972';
wwv_flow_imp.g_varchar2_table(239) := '436F6E74726F6C427265616B546F67676C6572496E6974203D20280A202073657474696E67732C0A20206461436F6E6669670A29203D3E207B0A0A202066695F6A617269735F706C7567696E2E69720A202020202E636F6E74726F6C427265616B546F67';
wwv_flow_imp.g_varchar2_table(240) := '676C65720A202020202E696E6974280A2020202020206461436F6E6669672E74726967676572696E67456C656D656E742C0A20202020202073657474696E67730A20202020293B0A0A7D3B0A';
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
wwv_flow_imp.g_varchar2_table(1) := '2E69722D636F6E74726F6C2D627265616B2D62746E2D2D7374617274207B666C6F61743A20696E6C696E652D73746172743B6D617267696E2D696E6C696E652D656E643A202E3572656D3B7D2E69722D636F6E74726F6C2D627265616B2D62746E2D2D65';
wwv_flow_imp.g_varchar2_table(2) := '6E64207B666C6F61743A20696E6C696E652D656E643B6D617267696E2D696E6C696E652D73746172743A202E3572656D3B7D';
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
wwv_flow_imp.g_varchar2_table(1) := '7661722066695F6A617269735F706C7567696E3D66695F6A617269735F706C7567696E7C7C7B7D3B2166756E6374696F6E28742C6E297B6E2E69723D6E2E69727C7C7B7D3B636F6E737420653D6E6577205765616B4D61702C6F3D2266695F6A61726973';
wwv_flow_imp.g_varchar2_table(2) := '5F706C7567696E2E6972436F6E74726F6C427265616B546F67676C6572222C723D227374617465222C693D2274682E612D4952522D6865616465722D2D67726F7570222C613D222E69722D636F6E74726F6C2D627265616B2D62746E222C733D222E6972';
wwv_flow_imp.g_varchar2_table(3) := '2D636F6E74726F6C2D627265616B2D69636F6E222C6C3D7B696E697469616C6C79457870616E6465643A21302C72656D656D62657253746174653A224E4F222C627574746F6E506F736974696F6E3A225354415254222C636F6C6C617073655469746C65';
wwv_flow_imp.g_varchar2_table(4) := '3A617065782E6C616E672E6765744D6573736167652822415045582E47562E425245414B5F434F4C4C4150534522297C7C22436F6C6C61707365222C657870616E645469746C653A617065782E6C616E672E6765744D6573736167652822415045582E47';
wwv_flow_imp.g_varchar2_table(5) := '562E425245414B5F455850414E4422297C7C22457870616E64222C636F6C6C6170736549636F6E3A2266612D63686576726F6E2D646F776E222C627574746F6E437373436C61737365733A22742D427574746F6E20742D427574746F6E2D2D6E6F4C6162';
wwv_flow_imp.g_varchar2_table(6) := '656C20742D427574746F6E2D2D69636F6E20742D427574746F6E2D2D736D616C6C227D3B66756E6374696F6E2063286E297B69662822737472696E67223D3D747970656F66206E297B636F6E737420653D646F63756D656E742E676574456C656D656E74';
wwv_flow_imp.g_varchar2_table(7) := '42794964286E293B72657475726E207428653F653A6E297D72657475726E2074286E297D66756E6374696F6E2075286E297B636F6E737420653D742E657874656E64287B7D2C6C2C6E293B766172206F3B72657475726E20652E72656D656D6265725374';
wwv_flow_imp.g_varchar2_table(8) := '6174653D66756E6374696F6E2874297B69662821303D3D3D742972657475726E2253455353494F4E223B69662821313D3D3D747C7C6E756C6C3D3D742972657475726E224E4F223B636F6E7374206E3D537472696E672874292E746F5570706572436173';
wwv_flow_imp.g_varchar2_table(9) := '6528293B72657475726E5B224E4F222C2253455353494F4E222C2250455253495354454E54225D2E696E636C75646573286E293F6E3A224E4F227D28652E72656D656D6265725374617465292C652E627574746F6E506F736974696F6E3D286F3D652E62';
wwv_flow_imp.g_varchar2_table(10) := '7574746F6E506F736974696F6E2C22454E44223D3D3D537472696E67286F7C7C22535441525422292E746F55707065724361736528293F22454E44223A22535441525422292C652E636F6C6C617073655469746C653D652E636F6C6C617073655469746C';
wwv_flow_imp.g_varchar2_table(11) := '657C7C6C2E636F6C6C617073655469746C652C652E657870616E645469746C653D652E657870616E645469746C657C7C6C2E657870616E645469746C652C652E636F6C6C6170736549636F6E3D652E636F6C6C6170736549636F6E7C7C6C2E636F6C6C61';
wwv_flow_imp.g_varchar2_table(12) := '70736549636F6E2C652E657870616E6449636F6E3D652E657870616E6449636F6E7C7C6E756C6C2C652E627574746F6E437373436C61737365733D652E627574746F6E437373436C61737365737C7C6C2E627574746F6E437373436C61737365732C657D';
wwv_flow_imp.g_varchar2_table(13) := '66756E6374696F6E207028742C6E297B69662821747C7C224E4F223D3D3D6E2972657475726E206E756C6C3B636F6E737420653D7B7072656669783A6F2C75736541707049643A21302C7573655061676549643A21302C726567696F6E49643A747D3B72';
wwv_flow_imp.g_varchar2_table(14) := '657475726E2253455353494F4E223D3D3D6E3F617065782E73746F726167652E67657453636F70656453657373696F6E53746F726167652865293A2250455253495354454E54223D3D3D6E3F617065782E73746F726167652E67657453636F7065644C6F';
wwv_flow_imp.g_varchar2_table(15) := '63616C53746F726167652865293A6E756C6C7D66756E6374696F6E20642874297B72657475726E7B76657273696F6E3A312C696E697469616C6C79457870616E6465643A742E6F7074696F6E732E696E697469616C6C79457870616E6465642C73746174';
wwv_flow_imp.g_varchar2_table(16) := '65733A7B7D7D7D66756E6374696F6E20672874297B742E737461746553746F726167652626742E737461746553746F726167652E7365744974656D28722C4A534F4E2E737472696E6769667928742E73746F726564537461746529297D66756E6374696F';
wwv_flow_imp.g_varchar2_table(17) := '6E20662874297B696628742E73746F72656453746174653D642874292C21742E737461746553746F726167652972657475726E3B636F6E7374206E3D742E737461746553746F726167652E6765744974656D2872293B6966286E297B7472797B636F6E73';
wwv_flow_imp.g_varchar2_table(18) := '7420653D4A534F4E2E7061727365286E293B69662866756E6374696F6E28742C6E297B72657475726E20426F6F6C65616E286E2626313D3D3D6E2E76657273696F6E26266E2E696E697469616C6C79457870616E6465643D3D3D742E6F7074696F6E732E';
wwv_flow_imp.g_varchar2_table(19) := '696E697469616C6C79457870616E64656426266E2E7374617465732626226F626A656374223D3D747970656F66206E2E73746174657326262141727261792E69734172726179286E2E73746174657329297D28742C65292972657475726E20766F696428';
wwv_flow_imp.g_varchar2_table(20) := '742E73746F72656453746174653D65297D63617463687B7D742E73746F72656453746174653D642874292C672874297D656C736520672874297D66756E6374696F6E20532874297B72657475726E20742E636C6F736573742822747222292E6E65787455';
wwv_flow_imp.g_varchar2_table(21) := '6E74696C286074723A68617328247B697D2960297D66756E6374696F6E20682874297B72657475726E20537472696E672874292E7265706C616365282F5B5E412D5A612D7A302D395F2D5D2F672C225F22297D66756E6374696F6E2049286E2C652C6F29';
wwv_flow_imp.g_varchar2_table(22) := '7B6C657420723D652E6368696C6472656E2861293B722E6C656E6774687C7C28723D7428223C627574746F6E3E222C7B747970653A22627574746F6E227D29293B6C657420693D722E6368696C6472656E2873293B692E6C656E6774687C7C28693D7428';
wwv_flow_imp.g_varchar2_table(23) := '223C7370616E3E222C7B22617269612D68696464656E223A2274727565222C636C6173733A22742D49636F6E2066612069722D636F6E74726F6C2D627265616B2D69636F6E227D292C722E617070656E64286929292C722E617474722822636C61737322';
wwv_flow_imp.g_varchar2_table(24) := '2C60247B6E2E6F7074696F6E732E627574746F6E437373436C61737365737D2069722D636F6E74726F6C2D627265616B2D62746E602E7472696D2829292C722E746F67676C65436C617373282269722D636F6E74726F6C2D627265616B2D62746E2D2D73';
wwv_flow_imp.g_varchar2_table(25) := '74617274222C225354415254223D3D3D6E2E6F7074696F6E732E627574746F6E506F736974696F6E292E746F67676C65436C617373282269722D636F6E74726F6C2D627265616B2D62746E2D2D656E64222C22454E44223D3D3D6E2E6F7074696F6E732E';
wwv_flow_imp.g_varchar2_table(26) := '627574746F6E506F736974696F6E292C22454E44223D3D3D6E2E6F7074696F6E732E627574746F6E506F736974696F6E3F652E617070656E642872293A652E70726570656E642872293B636F6E7374206C3D66756E6374696F6E286E2C652C6F297B636F';
wwv_flow_imp.g_varchar2_table(27) := '6E737420723D532865292C693D5B5D2C613D652E617474722822696422292C733D68286E2E726567696F6E49647C7C22697222292C6C3D6828617C7C6067726F75705F247B6F2B317D60293B72657475726E20722E656163682866756E6374696F6E286E';
wwv_flow_imp.g_varchar2_table(28) := '297B636F6E737420653D742874686973293B6C6574206F3D652E617474722822696422293B696628216F297B636F6E737420743D60247B737D5F63625F247B6C7D5F726F775F247B6E2B317D603B6F3D743B6C657420723D323B666F72283B646F63756D';
wwv_flow_imp.g_varchar2_table(29) := '656E742E676574456C656D656E7442794964286F292626646F63756D656E742E676574456C656D656E7442794964286F29213D3D746869733B296F3D60247B747D5F247B727D602C722B3D313B652E6174747228226964222C6F297D692E70757368286F';
wwv_flow_imp.g_varchar2_table(30) := '297D292C697D286E2C652C6F293B72657475726E206C2E6C656E6774683F722E617474722822617269612D636F6E74726F6C73222C6C2E6A6F696E2822202229293A722E72656D6F7665417474722822617269612D636F6E74726F6C7322292C727D6675';
wwv_flow_imp.g_varchar2_table(31) := '6E6374696F6E207828742C6E2C652C6F297B617065782E6576656E742E7472696767657228742E726567696F6E242C226972636F6E74726F6C627265616B6368616E6765222C7B726567696F6E49643A742E726567696F6E49642C686561646572496473';
wwv_flow_imp.g_varchar2_table(32) := '3A6E2C657870616E6465643A652C736F757263653A6F7D297D66756E6374696F6E204528742C6E2C652C6F2C72297B636F6E737420693D6E2E6368696C6472656E2861292C6C3D2274727565223D3D3D692E617474722822617269612D657870616E6465';
wwv_flow_imp.g_varchar2_table(33) := '6422293B69662866756E6374696F6E28742C6E2C65297B636F6E7374206F3D653F742E6F7074696F6E732E636F6C6C617073655469746C653A742E6F7074696F6E732E657870616E645469746C652C723D653F742E6F7074696F6E732E636F6C6C617073';
wwv_flow_imp.g_varchar2_table(34) := '6549636F6E3A742E6F7074696F6E732E657870616E6449636F6E3B6E2E61747472287B7469746C653A6F2C22617269612D6C6162656C223A6F2C22617269612D657870616E646564223A652E746F537472696E6728297D292C6E2E6368696C6472656E28';
wwv_flow_imp.g_varchar2_table(35) := '73292E72656D6F7665436C6173732860247B742E6F7074696F6E732E636F6C6C6170736549636F6E7D20247B742E6F7074696F6E732E657870616E6449636F6E7D60292E616464436C6173732872297D28742C692C65292C53286E292E746F67676C6528';
wwv_flow_imp.g_varchar2_table(36) := '65292C6F2626742E737461746553746F72616765297B636F6E7374206F3D6E2E617474722822696422293B6F262628742E73746F72656453746174652E7374617465735B6F5D3D65297D636F6E737420633D6C213D3D653B69662863262672297B636F6E';
wwv_flow_imp.g_varchar2_table(37) := '7374206F3D6E2E617474722822696422293B7828742C6F3F5B6F5D3A5B5D2C652C72297D72657475726E20637D66756E6374696F6E20622874297B72657475726E20742E726567696F6E242E66696E642869297D66756E6374696F6E2054286E297B636F';
wwv_flow_imp.g_varchar2_table(38) := '6E7374206F3D66756E6374696F6E286E297B636F6E737420653D63286E293B72657475726E20313D3D3D652E6C656E6774683F653A7428297D286E293B72657475726E206F2E6C656E6774682626652E676574286F5B305D297C7C6E756C6C7D66756E63';
wwv_flow_imp.g_varchar2_table(39) := '74696F6E206D286E2C6F297B636F6E737420723D74286E292E666972737428293B69662821722E6C656E6774682972657475726E21313B636F6E737420733D75286F293B732E657870616E6449636F6E7C7C28732E657870616E6449636F6E3D66756E63';
wwv_flow_imp.g_varchar2_table(40) := '74696F6E28742C6E297B636F6E737420653D2272746C223D3D3D742E6373732822646972656374696F6E22293B72657475726E22454E44223D3D3D6E3F653F2266612D63686576726F6E2D7269676874223A2266612D63686576726F6E2D6C656674223A';
wwv_flow_imp.g_varchar2_table(41) := '653F2266612D63686576726F6E2D6C656674223A2266612D63686576726F6E2D7269676874227D28722C732E627574746F6E506F736974696F6E29293B636F6E7374206C3D722E617474722822696422292C633D7B726567696F6E243A722C726567696F';
wwv_flow_imp.g_varchar2_table(42) := '6E49643A6C2C6F7074696F6E733A732C737461746553746F726167653A70286C2C732E72656D656D6265725374617465292C73746F72656453746174653A6E756C6C7D3B72657475726E20662863292C652E73657428725B305D2C63292C66756E637469';
wwv_flow_imp.g_varchar2_table(43) := '6F6E286E297B6E2E726567696F6E242E6F66662822636C69636B2E636F6E74726F6C427265616B546F67676C6522292E6F6E2822636C69636B2E636F6E74726F6C427265616B546F67676C65222C612C66756E6374696F6E28297B636F6E737420653D74';
wwv_flow_imp.g_varchar2_table(44) := '2874686973292C6F3D652E636C6F736573742869292C723D2274727565223D3D3D652E617474722822617269612D657870616E64656422293B45286E2C6F2C21722C21302C225553455222292C67286E297D297D2863292C66756E6374696F6E286E297B';
wwv_flow_imp.g_varchar2_table(45) := '62286E292E656163682866756E6374696F6E2865297B636F6E7374206F3D742874686973292C723D6F2E617474722822696422293B6C657420693D6E2E6F7074696F6E732E696E697469616C6C79457870616E6465643B6E2E737461746553746F726167';
wwv_flow_imp.g_varchar2_table(46) := '6526267226264F626A6563742E70726F746F747970652E6861734F776E50726F70657274792E63616C6C286E2E73746F72656453746174652E7374617465732C7229262628693D6E2E73746F72656453746174652E7374617465735B725D292C49286E2C';
wwv_flow_imp.g_varchar2_table(47) := '6F2C65292C45286E2C6F2C692C21312C6E756C6C297D297D2863292C21307D66756E6374696F6E2041286E2C652C6F297B636F6E737420723D54286E293B69662821722972657475726E21313B636F6E737420693D5B5D3B72657475726E20622872292E';
wwv_flow_imp.g_varchar2_table(48) := '656163682866756E6374696F6E286E297B636F6E7374206F3D742874686973293B4928722C6F2C6E293B6966284528722C6F2C652C21302C6E756C6C29297B636F6E737420743D6F2E617474722822696422293B742626692E707573682874297D7D292C';
wwv_flow_imp.g_varchar2_table(49) := '672872292C692E6C656E67746826267828722C692C652C6F292C21307D6E2E69722E636F6E74726F6C427265616B546F67676C65723D7B696E69743A66756E6374696F6E28742C6E297B636F6E737420653D632874293B69662821652E6C656E67746829';
wwv_flow_imp.g_varchar2_table(50) := '72657475726E21313B6C6574206F3D21313B72657475726E20652E656163682866756E6374696F6E28297B6D28746869732C6E292626286F3D2130297D292C6F7D2C657870616E64416C6C3A66756E6374696F6E2874297B72657475726E204128742C21';
wwv_flow_imp.g_varchar2_table(51) := '302C22455850414E445F414C4C22297D2C636F6C6C61707365416C6C3A66756E6374696F6E2874297B72657475726E204128742C21312C22434F4C4C415053455F414C4C22297D2C726573657453746174653A66756E6374696F6E286E297B636F6E7374';
wwv_flow_imp.g_varchar2_table(52) := '20653D54286E293B69662821652972657475726E21313B2166756E6374696F6E2874297B69662821742972657475726E3B636F6E7374206E3D7B7072656669783A6F2C75736541707049643A21302C7573655061676549643A21302C726567696F6E4964';
wwv_flow_imp.g_varchar2_table(53) := '3A747D3B617065782E73746F726167652E67657453636F70656453657373696F6E53746F72616765286E292E72656D6F76654974656D2872292C617065782E73746F726167652E67657453636F7065644C6F63616C53746F72616765286E292E72656D6F';
wwv_flow_imp.g_varchar2_table(54) := '76654974656D2872297D28652E726567696F6E4964292C652E73746F72656453746174653D642865293B636F6E737420693D5B5D3B72657475726E20622865292E656163682866756E6374696F6E286E297B636F6E7374206F3D742874686973293B4928';
wwv_flow_imp.g_varchar2_table(55) := '652C6F2C6E293B6966284528652C6F2C652E6F7074696F6E732E696E697469616C6C79457870616E6465642C21312C6E756C6C29297B636F6E737420743D6F2E617474722822696422293B742626692E707573682874297D7D292C672865292C692E6C65';
wwv_flow_imp.g_varchar2_table(56) := '6E67746826267828652C692C652E6F7074696F6E732E696E697469616C6C79457870616E6465642C22524553455422292C21307D7D7D28617065782E6A51756572792C66695F6A617269735F706C7567696E292C77696E646F772E6972436F6E74726F6C';
wwv_flow_imp.g_varchar2_table(57) := '427265616B546F67676C6572496E69743D28742C6E293D3E7B66695F6A617269735F706C7567696E2E69722E636F6E74726F6C427265616B546F67676C65722E696E6974286E2E74726967676572696E67456C656D656E742C74297D3B';
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
