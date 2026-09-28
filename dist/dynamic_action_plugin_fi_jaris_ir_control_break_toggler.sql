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
,p_javascript_file_urls=>'#PLUGIN_FILES#irControlBreakToggler#MIN#.js'
,p_css_file_urls=>'#PLUGIN_FILES#irControlBreakToggler#MIN#.css'
,p_plsql_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'procedure render_ir_control_break_toggler(',
'  p_dynamic_action  in            apex_plugin.t_dynamic_action',
', p_plugin          in            apex_plugin.t_plugin',
', p_param           in            apex_plugin.t_dynamic_action_render_param',
', p_result          in out nocopy apex_plugin.t_dynamic_action_render_result',
')',
'as',
'',
'  l_collapse_icon   varchar2(256) :=',
'    ''fa-chevron-down'';',
'',
'  l_collapse_title  varchar2(4000) :=',
'    apex_lang.get_message( ''APEX.GV.BREAK_COLLAPSE'' );',
'',
'  l_expand_title    varchar2(4000) :=',
'    apex_lang.get_message( ''APEX.GV.BREAK_EXPAND'' );',
'',
'  l_btn_css_classes varchar2(256) :=',
'    ''t-Button t-Button--noLabel t-Button--icon t-Button--small'';',
'',
'begin',
'',
'  -- Application-scope attributes with default values.',
'  -- Note: The expand button''s default icon is handled via JavaScript and',
'  -- is intentionally left out from this PL/SQL procedure.',
'  l_collapse_title :=',
'    p_plugin.attributes.get_varchar2(',
'      p_static_id                 => ''collapse_title''',
'    , p_default_value             => l_collapse_title',
'    , p_do_substitutions          => true',
'    , p_substitutions_escape_mode => apex_session_state.c_escape_mode_raw',
'    );',
'',
'  l_collapse_icon :=',
'    p_plugin.attributes.get_varchar2(',
'      p_static_id     => ''collapse_icon''',
'    , p_default_value => l_collapse_icon',
'    );',
'',
'  l_expand_title :=',
'    p_plugin.attributes.get_varchar2(',
'      p_static_id                 => ''expand_title''',
'    , p_default_value             => l_expand_title',
'    , p_do_substitutions          => true',
'    , p_substitutions_escape_mode => apex_session_state.c_escape_mode_raw',
'    );',
'',
'  l_btn_css_classes :=',
'    p_plugin.attributes.get_varchar2(',
'      p_static_id     => ''button_css_classes''',
'    , p_default_value => l_btn_css_classes',
'    );',
'',
'',
'  -- Pass plug-in configuration to the JavaScript initializer.',
'  p_result.function_name := ''irControlBreakTogglerInit'';',
'',
'  p_result.function_param.open_object;',
'',
'  -- Application-scope attributes',
'  p_result.function_param.put(',
'    ''collapseTitle''',
'  , l_collapse_title',
'  );',
'',
'  p_result.function_param.put(',
'    ''collapseIcon''',
'  , l_collapse_icon',
'  );',
'',
'  p_result.function_param.put(',
'    ''expandTitle''',
'  , l_expand_title',
'  );',
'',
'  p_result.function_param.put(',
'    ''expandIcon''',
'  , p_plugin.attributes.get_varchar2(',
'      p_static_id => ''expand_icon''',
'    )',
'  );',
'',
'  p_result.function_param.put(',
'    ''buttonCssClasses''',
'  , l_btn_css_classes',
'  );',
'',
'  -- Component-scope attributes',
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
'  p_result.function_param.close_object;',
'',
'end render_ir_control_break_toggler;'))
,p_api_version=>3
,p_render_function=>'render_ir_control_break_toggler'
,p_standard_attributes=>'ONLOAD'
,p_version_scn=>'SH256:WBrH21RIxhp0vH7TnSMW-Ctcd4XWvICMv-rUDEV_RZA'
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
,p_version_identifier=>'1.1.0'
,p_about_url=>'https://github.com/jariolaine/apex-ir-control-break-toggler'
,p_files_version=>2461312123547
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
,p_display_length=>40
,p_max_length=>200
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
,p_display_length=>40
,p_max_length=>200
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
,p_display_length=>40
,p_max_length=>200
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
wwv_flow_imp.g_varchar2_table(2) := '0A0A2020636F6E737420696E7374616E636573203D206E6577205765616B4D617028293B0A0A2020636F6E73742044454641554C545F504C5547494E5F4E414D45203D0A2020202022495220436F6E74726F6C20427265616B20546F67676C6572223B0A';
wwv_flow_imp.g_varchar2_table(3) := '0A2020636F6E73742053544F524147455F505245464958203D0A202020202266695F6A617269735F706C7567696E2E6972436F6E74726F6C427265616B546F67676C6572223B0A0A2020636F6E73742053544F524147455F4B4559203D0A202020202273';
wwv_flow_imp.g_varchar2_table(4) := '74617465223B0A0A2020636F6E73742053544F524147455F56455253494F4E203D0A20202020323B0A0A2020636F6E737420434F4E54524F4C5F425245414B5F53454C4543544F52203D0A202020202274682E612D4952522D6865616465722D2D67726F';
wwv_flow_imp.g_varchar2_table(5) := '7570223B0A0A2020636F6E737420425554544F4E5F53454C4543544F52203D0A20202020222E69722D636F6E74726F6C2D627265616B2D62746E223B0A0A2020636F6E73742049434F4E5F53454C4543544F52203D0A20202020222E69722D636F6E7472';
wwv_flow_imp.g_varchar2_table(6) := '6F6C2D627265616B2D69636F6E223B0A0A2020636F6E7374204845414445525F434F4E54454E545F53454C4543544F52203D0A20202020222E69722D636F6E74726F6C2D627265616B2D686561646572223B0A0A2020636F6E737420425554544F4E5F45';
wwv_flow_imp.g_varchar2_table(7) := '56454E545F48414E444C4552203D0A2020202022636C69636B2E636F6E74726F6C427265616B546F67676C65223B0A0A2020636F6E7374204348414E47455F4556454E54203D0A20202020226972636F6E74726F6C627265616B6368616E6765223B0A0A';
wwv_flow_imp.g_varchar2_table(8) := '0A20202F2A0A20202A2052657475726E207468652044796E616D696320416374696F6E20706C75672D696E206E616D6520666F72206465627567206D657373616765732E0A20202A2F0A202066756E6374696F6E20676574506C7567696E4E616D652864';
wwv_flow_imp.g_varchar2_table(9) := '61436F6E66696729207B0A0A2020202072657475726E20280A2020202020206461436F6E6669672026260A2020202020206461436F6E6669672E616374696F6E2026260A2020202020206461436F6E6669672E616374696F6E2E616374696F6E0A202020';
wwv_flow_imp.g_varchar2_table(10) := '2029207C7C2044454641554C545F504C5547494E5F4E414D453B0A0A20207D0A0A0A20202F2A0A2020202A2052657475726E207468652064656661756C7420646972656374696F6E616C20657870616E642069636F6E2E0A2020202A0A2020202A205354';
wwv_flow_imp.g_varchar2_table(11) := '41525420616E6420454E4420617265206C6F676963616C20706F736974696F6E732C20736F207468652069636F6E20646972656374696F6E0A2020202A20666F6C6C6F777320746865207465787420646972656374696F6E206F66207468652072656769';
wwv_flow_imp.g_varchar2_table(12) := '6F6E2E0A2020202A2F0A202066756E6374696F6E2067657444656661756C74457870616E6449636F6E280A20202020726567696F6E242C0A20202020627574746F6E506F736974696F6E0A202029207B0A0A20202020636F6E737420697352746C203D0A';
wwv_flow_imp.g_varchar2_table(13) := '202020202020726567696F6E242E6373732822646972656374696F6E2229203D3D3D202272746C223B0A0A2020202069662028627574746F6E506F736974696F6E203D3D3D2022454E442229207B0A0A20202020202072657475726E20697352746C0A20';
wwv_flow_imp.g_varchar2_table(14) := '202020202020203F202266612D63686576726F6E2D7269676874220A20202020202020203A202266612D63686576726F6E2D6C656674223B0A0A202020207D0A0A2020202072657475726E20697352746C0A2020202020203F202266612D63686576726F';
wwv_flow_imp.g_varchar2_table(15) := '6E2D6C656674220A2020202020203A202266612D63686576726F6E2D7269676874223B0A0A20207D0A0A0A20202F2A0A2020202A205265736F6C7665206F6E65206F72206D6F726520726567696F6E732E0A2020202A0A2020202A20496E697469616C69';
wwv_flow_imp.g_varchar2_table(16) := '7A6174696F6E2063616E20616363657074206D756C7469706C6520656C656D656E747320736F207468617420612044796E616D69630A2020202A20416374696F6E207573696E672061206A51756572792073656C6563746F722063616E20696E69746961';
wwv_flow_imp.g_varchar2_table(17) := '6C697A65206D756C7469706C65204952732E0A2020202A2F0A202066756E6374696F6E207265736F6C7665526567696F6E7328726567696F6E29207B0A0A2020202069662028747970656F6620726567696F6E203D3D3D2022737472696E672229207B0A';
wwv_flow_imp.g_varchar2_table(18) := '0A2020202020202F2A0A202020202020202A2046697273742074726561742074686520737472696E67206173206120706F737369626C6520726567696F6E205374617469632049442E0A202020202020202A2F0A202020202020636F6E737420656C656D';
wwv_flow_imp.g_varchar2_table(19) := '656E74203D0A2020202020202020646F63756D656E742E676574456C656D656E744279496428726567696F6E293B0A0A20202020202069662028656C656D656E7429207B0A202020202020202072657475726E202428656C656D656E74293B0A20202020';
wwv_flow_imp.g_varchar2_table(20) := '20207D0A0A2020202020202F2A0A202020202020202A204F74686572776973652074726561742069742061732061206A51756572792073656C6563746F722E0A202020202020202A2F0A20202020202072657475726E202428726567696F6E293B0A0A20';
wwv_flow_imp.g_varchar2_table(21) := '2020207D0A0A2020202072657475726E202428726567696F6E293B0A0A20207D0A0A0A20202F2A0A2020202A205265736F6C76652065786163746C79206F6E6520726567696F6E2E0A2020202A0A2020202A205075626C696320415049206D6574686F64';
wwv_flow_imp.g_varchar2_table(22) := '7320696E74656E74696F6E616C6C79206F706572617465206F6E206F6E6520495220617420612074696D652E0A2020202A20412073656C6563746F72206D61746368696E67206D756C7469706C6520656C656D656E74732069732072656A65637465642E';
wwv_flow_imp.g_varchar2_table(23) := '0A2020202A2F0A202066756E6374696F6E207265736F6C7665526567696F6E280A20202020726567696F6E2C0A20202020706C7567696E4E616D650A202029207B0A0A20202020636F6E737420726567696F6E7324203D0A2020202020207265736F6C76';
wwv_flow_imp.g_varchar2_table(24) := '65526567696F6E7328726567696F6E293B0A0A2020202069662028726567696F6E73242E6C656E677468203E203129207B0A0A202020202020617065782E64656275672E7761726E280A2020202020202020706C7567696E4E616D65207C7C2044454641';
wwv_flow_imp.g_varchar2_table(25) := '554C545F504C5547494E5F4E414D452C0A2020202020202020224578706563746564206F6E6520726567696F6E20627574206D756C7469706C6520726567696F6E73206D6174636865643A222C0A2020202020202020726567696F6E73242E6C656E6774';
wwv_flow_imp.g_varchar2_table(26) := '680A202020202020293B0A0A202020207D0A0A2020202072657475726E20726567696F6E73242E6C656E677468203D3D3D20310A2020202020203F20726567696F6E73240A2020202020203A202428293B0A0A20207D0A0A0A20202F2A0A2020202A2052';
wwv_flow_imp.g_varchar2_table(27) := '657475726E20415045582073636F7065642062726F777365722073746F726167652E0A2020202A2F0A202066756E6374696F6E20676574537461746553746F72616765280A20202020726567696F6E49642C0A2020202072656D656D6265725374617465';
wwv_flow_imp.g_varchar2_table(28) := '2C0A20202020706C7567696E4E616D650A202029207B0A0A202020206966202872656D656D6265725374617465203D3D3D20224E4F2229207B0A20202020202072657475726E206E756C6C3B0A202020207D0A0A202020206966202821726567696F6E49';
wwv_flow_imp.g_varchar2_table(29) := '6429207B0A0A202020202020617065782E64656275672E7761726E280A2020202020202020706C7567696E4E616D652C0A20202020202020202252656D656D62657220537461746520697320656E61626C65642C206275742074686520726567696F6E20';
wwv_flow_imp.g_varchar2_table(30) := '686173206E6F2049442E220A202020202020293B0A0A20202020202072657475726E206E756C6C3B0A0A202020207D0A0A20202020636F6E73742073746F726167654F7074696F6E73203D207B0A202020202020707265666978202020203A2053544F52';
wwv_flow_imp.g_varchar2_table(31) := '4147455F5052454649582C0A202020202020757365417070496420203A20747275652C0A202020202020757365506167654964203A20747275652C0A202020202020726567696F6E496420203A20726567696F6E49640A202020207D3B0A0A2020202069';
wwv_flow_imp.g_varchar2_table(32) := '66202872656D656D6265725374617465203D3D3D202253455353494F4E2229207B0A0A20202020202072657475726E20617065782E73746F726167650A20202020202020202E67657453636F70656453657373696F6E53746F72616765280A2020202020';
wwv_flow_imp.g_varchar2_table(33) := '202020202073746F726167654F7074696F6E730A2020202020202020293B0A0A202020207D0A0A202020206966202872656D656D6265725374617465203D3D3D202250455253495354454E542229207B0A0A20202020202072657475726E20617065782E';
wwv_flow_imp.g_varchar2_table(34) := '73746F726167650A20202020202020202E67657453636F7065644C6F63616C53746F72616765280A2020202020202020202073746F726167654F7074696F6E730A2020202020202020293B0A0A202020207D0A0A20202020617065782E64656275672E77';
wwv_flow_imp.g_varchar2_table(35) := '61726E280A202020202020706C7567696E4E616D652C0A20202020202022556E737570706F727465642052656D656D6265722053746174652076616C75653A222C0A20202020202072656D656D62657253746174650A20202020293B0A0A202020207265';
wwv_flow_imp.g_varchar2_table(36) := '7475726E206E756C6C3B0A0A20207D0A0A0A20202F2A0A2020202A2043726561746520616E20656D7074792073746F7265642D7374617465206F626A6563742E0A2020202A0A2020202A20696E697469616C6C79457870616E6465642069732073746F72';
wwv_flow_imp.g_varchar2_table(37) := '6564206173206D6574616461746120736F206368616E67696E6720746861740A2020202A20706C75672D696E2073657474696E6720696E76616C6964617465732070726576696F75736C792072656D656D62657265642067726F7570207374617465732E';
wwv_flow_imp.g_varchar2_table(38) := '0A2020202A2F0A202066756E6374696F6E2063726561746553746F726564537461746528696E7374616E636529207B0A0A2020202072657475726E207B0A20202020202076657273696F6E3A0A202020202020202053544F524147455F56455253494F4E';
wwv_flow_imp.g_varchar2_table(39) := '2C0A0A202020202020696E697469616C6C79457870616E6465643A0A2020202020202020696E7374616E63652E6F7074696F6E732E696E697469616C6C79457870616E6465642C0A0A2020202020207374617465733A0A20202020202020207B7D0A2020';
wwv_flow_imp.g_varchar2_table(40) := '20207D3B0A0A20207D0A0A0A20202F2A0A2020202A2056616C69646174652072656D656D6265726564207374617465206C6F616465642066726F6D2062726F777365722073746F726167652E0A2020202A2F0A202066756E6374696F6E20697356616C69';
wwv_flow_imp.g_varchar2_table(41) := '6453746F7265645374617465280A20202020696E7374616E63652C0A2020202073746174650A202029207B0A0A2020202072657475726E20426F6F6C65616E280A20202020202073746174652026260A20202020202073746174652E76657273696F6E20';
wwv_flow_imp.g_varchar2_table(42) := '3D3D3D2053544F524147455F56455253494F4E2026260A20202020202073746174652E696E697469616C6C79457870616E646564203D3D3D0A2020202020202020696E7374616E63652E6F7074696F6E732E696E697469616C6C79457870616E64656420';
wwv_flow_imp.g_varchar2_table(43) := '26260A20202020202073746174652E7374617465732026260A202020202020747970656F662073746174652E737461746573203D3D3D20226F626A656374222026260A2020202020202141727261792E697341727261792873746174652E737461746573';
wwv_flow_imp.g_varchar2_table(44) := '290A20202020293B0A0A20207D0A0A0A20202F2A0A2020202A20536176652072656D656D62657265642073746174652E0A2020202A2F0A202066756E6374696F6E2073617665537461746528696E7374616E636529207B0A0A202020206966202821696E';
wwv_flow_imp.g_varchar2_table(45) := '7374616E63652E737461746553746F7261676529207B0A20202020202072657475726E3B0A202020207D0A0A20202020696E7374616E63652E737461746553746F726167652E7365744974656D280A20202020202053544F524147455F4B45592C0A2020';
wwv_flow_imp.g_varchar2_table(46) := '202020204A534F4E2E737472696E67696679280A2020202020202020696E7374616E63652E73746F72656453746174650A202020202020290A20202020293B0A0A20207D0A0A0A20202F2A0A2020202A204C6F61642072656D656D626572656420737461';
wwv_flow_imp.g_varchar2_table(47) := '74652E0A2020202A2F0A202066756E6374696F6E206C6F6164537461746528696E7374616E636529207B0A0A20202020696E7374616E63652E73746F7265645374617465203D0A20202020202063726561746553746F726564537461746528696E737461';
wwv_flow_imp.g_varchar2_table(48) := '6E6365293B0A0A202020206966202821696E7374616E63652E737461746553746F7261676529207B0A20202020202072657475726E3B0A202020207D0A0A20202020636F6E73742073746F72656456616C7565203D0A202020202020696E7374616E6365';
wwv_flow_imp.g_varchar2_table(49) := '2E737461746553746F726167652E6765744974656D280A202020202020202053544F524147455F4B45590A202020202020293B0A0A20202020696620282173746F72656456616C756529207B0A0A20202020202073617665537461746528696E7374616E';
wwv_flow_imp.g_varchar2_table(50) := '6365293B0A0A20202020202072657475726E3B0A0A202020207D0A0A20202020747279207B0A0A202020202020636F6E7374207061727365645374617465203D0A20202020202020204A534F4E2E70617273652873746F72656456616C7565293B0A0A20';
wwv_flow_imp.g_varchar2_table(51) := '2020202020696620280A2020202020202020697356616C696453746F7265645374617465280A20202020202020202020696E7374616E63652C0A2020202020202020202070617273656453746174650A2020202020202020290A20202020202029207B0A';
wwv_flow_imp.g_varchar2_table(52) := '0A2020202020202020696E7374616E63652E73746F7265645374617465203D0A2020202020202020202070617273656453746174653B0A0A202020202020202072657475726E3B0A0A2020202020207D0A0A202020207D206361746368207B0A0A202020';
wwv_flow_imp.g_varchar2_table(53) := '2020202F2A0A202020202020202A2049676E6F726520696E76616C6964206F72206F62736F6C6574652073746F72656420646174612E0A202020202020202A2F0A0A202020207D0A0A202020202F2A0A20202020202A2053746F7261676520666F726D61';
wwv_flow_imp.g_varchar2_table(54) := '74206368616E6765642C2073746F726564206461746120697320696E76616C69642C0A20202020202A206F7220496E697469616C6C7920457870616E64656420686173206368616E6765642E0A20202020202A2F0A20202020696E7374616E63652E7374';
wwv_flow_imp.g_varchar2_table(55) := '6F7265645374617465203D0A20202020202063726561746553746F726564537461746528696E7374616E6365293B0A0A2020202073617665537461746528696E7374616E6365293B0A0A20207D0A0A0A20202F2A0A2020202A2052656D6F76652072656D';
wwv_flow_imp.g_varchar2_table(56) := '656D62657265642073746174652066726F6D20626F74682062726F777365722073746F726167652074797065732E0A2020202A0A2020202A20436C656172696E6720626F74682070726576656E747320616E206F6C642073746174652066726F6D20756E';
wwv_flow_imp.g_varchar2_table(57) := '65787065637465646C790A2020202A207265617070656172696E672069662052656D656D626572205374617465206D6F6465206973206368616E676564206C617465722E0A2020202A2F0A202066756E6374696F6E20636C65617253746F726564537461';
wwv_flow_imp.g_varchar2_table(58) := '746528726567696F6E496429207B0A0A202020206966202821726567696F6E496429207B0A20202020202072657475726E3B0A202020207D0A0A20202020636F6E73742073746F726167654F7074696F6E73203D207B0A20202020202070726566697820';
wwv_flow_imp.g_varchar2_table(59) := '2020203A2053544F524147455F5052454649582C0A202020202020757365417070496420203A20747275652C0A202020202020757365506167654964203A20747275652C0A202020202020726567696F6E496420203A20726567696F6E49640A20202020';
wwv_flow_imp.g_varchar2_table(60) := '7D3B0A0A20202020617065782E73746F726167650A2020202020202E67657453636F70656453657373696F6E53746F72616765280A202020202020202073746F726167654F7074696F6E730A202020202020290A2020202020202E72656D6F7665497465';
wwv_flow_imp.g_varchar2_table(61) := '6D280A202020202020202053544F524147455F4B45590A202020202020293B0A0A20202020617065782E73746F726167650A2020202020202E67657453636F7065644C6F63616C53746F72616765280A202020202020202073746F726167654F7074696F';
wwv_flow_imp.g_varchar2_table(62) := '6E730A202020202020290A2020202020202E72656D6F76654974656D280A202020202020202053544F524147455F4B45590A202020202020293B0A0A20207D0A0A0A20202F2A0A2020202A2052657475726E2074686520726F777320636F6E74726F6C6C';
wwv_flow_imp.g_varchar2_table(63) := '6564206279206F6E6520636F6E74726F6C2D627265616B206865616465722E0A2020202A2F0A202066756E6374696F6E2067657447726F7570526F7773286865616465722429207B0A0A2020202072657475726E20686561646572240A2020202020202E';
wwv_flow_imp.g_varchar2_table(64) := '636C6F736573742822747222290A2020202020202E6E657874556E74696C280A20202020202020206074723A68617328247B434F4E54524F4C5F425245414B5F53454C4543544F527D29600A202020202020293B0A0A20207D0A0A0A20202F2A0A202020';
wwv_flow_imp.g_varchar2_table(65) := '2A2052657475726E206120636F6D706163742064657465726D696E6973746963206861736820666F72206120737472696E672E0A2020202A2F0A202066756E6374696F6E2068617368537472696E672876616C756529207B0A0A202020206C6574206861';
wwv_flow_imp.g_varchar2_table(66) := '7368203D0A202020202020307838313163396463353B0A0A20202020666F7220280A2020202020206C657420696E646578203D20303B0A202020202020696E646578203C2076616C75652E6C656E6774683B0A202020202020696E646578202B3D20310A';
wwv_flow_imp.g_varchar2_table(67) := '2020202029207B0A0A20202020202068617368205E3D0A202020202020202076616C75652E63686172436F6465417428696E646578293B0A0A20202020202068617368203D0A20202020202020204D6174682E696D756C280A2020202020202020202068';
wwv_flow_imp.g_varchar2_table(68) := '6173682C0A20202020202020202020307830313030303139330A2020202020202020293B0A0A202020207D0A0A2020202072657475726E20280A20202020202068617368203E3E3E20300A20202020292E746F537472696E67283136293B0A0A20207D0A';
wwv_flow_imp.g_varchar2_table(69) := '0A0A20202F2A0A2020202A20415045582D67656E65726174656420636F6E74726F6C2D627265616B20686561646572204944732061726520706167696E6174696F6E2D6C6F63616C0A2020202A20616E642063616E20626520726575736564206F6E2061';
wwv_flow_imp.g_varchar2_table(70) := '6E6F74686572207265706F727420706167652E0A2020202A0A2020202A20557365206E6F726D616C697A65642072656E646572656420636F6E74726F6C2D627265616B207465787420617320746865206C6F676963616C2067726F75700A2020202A2069';
wwv_flow_imp.g_varchar2_table(71) := '64656E7469747920616E642068617368206974206265666F7265207573696E6720697420617320612062726F777365722D73746F72616765206B65792E0A2020202A2F0A202066756E6374696F6E2067657447726F75704B657928686561646572242920';
wwv_flow_imp.g_varchar2_table(72) := '7B0A0A20202020636F6E737420636C6F6E6524203D0A202020202020686561646572242E636C6F6E6528293B0A0A20202020636C6F6E65240A2020202020202E66696E64280A2020202020202020425554544F4E5F53454C4543544F520A202020202020';
wwv_flow_imp.g_varchar2_table(73) := '290A2020202020202E72656D6F766528293B0A0A20202020636F6E73742068656164657254657874203D0A202020202020636C6F6E65240A20202020202020202E7465787428290A20202020202020202E7265706C616365280A20202020202020202020';
wwv_flow_imp.g_varchar2_table(74) := '2F5C732B2F672C0A202020202020202020202220220A2020202020202020290A20202020202020202E7472696D28293B0A0A2020202072657475726E20686561646572546578740A2020202020203F2068617368537472696E67280A2020202020202020';
wwv_flow_imp.g_varchar2_table(75) := '2020686561646572546578740A2020202020202020290A2020202020203A2022223B0A0A20207D0A0A0A20202F2A0A2020202A20436F6E7665727420612076616C756520696E746F2061207361666520667261676D656E7420666F722067656E65726174';
wwv_flow_imp.g_varchar2_table(76) := '6564204944732E0A2020202A2F0A202066756E6374696F6E20736166654964506172742876616C756529207B0A0A2020202072657475726E20537472696E672876616C7565290A2020202020202E7265706C616365280A20202020202020202F5B5E412D';
wwv_flow_imp.g_varchar2_table(77) := '5A612D7A302D395F2D5D2F672C0A2020202020202020225F220A202020202020293B0A0A20207D0A0A0A20202F2A0A2020202A20456E7375726520657665727920636F6E74726F6C6C656420726F772068617320616E2049442E0A2020202A0A2020202A';
wwv_flow_imp.g_varchar2_table(78) := '20494473206F6E6C79206E65656420746F20626520756E6971756520696E207468652063757272656E746C792072656E646572656420646F63756D656E742E0A2020202A2052657573696E67207468652073616D652067656E6572617465642049447320';
wwv_flow_imp.g_varchar2_table(79) := '616674657220496E746572616374697665205265706F72740A2020202A20706167696E6174696F6E2069732076616C69642062656361757365207468652070726576696F7573207265706F727420726F77732068617665206265656E0A2020202A207265';
wwv_flow_imp.g_varchar2_table(80) := '706C616365642E0A2020202A2F0A202066756E6374696F6E20656E73757265436F6E74726F6C6C6564526F77496473280A20202020696E7374616E63652C0A20202020686561646572242C0A2020202067726F7570496E6465780A202029207B0A0A2020';
wwv_flow_imp.g_varchar2_table(81) := '2020636F6E737420726F777324203D0A20202020202067657447726F7570526F77732868656164657224293B0A0A20202020636F6E737420696473203D0A2020202020205B5D3B0A0A20202020636F6E7374206865616465724964203D0A202020202020';
wwv_flow_imp.g_varchar2_table(82) := '686561646572242E617474722822696422293B0A0A20202020636F6E737420726567696F6E50617274203D0A20202020202073616665496450617274280A2020202020202020696E7374616E63652E726567696F6E4964207C7C0A202020202020202022';
wwv_flow_imp.g_varchar2_table(83) := '6972220A202020202020293B0A0A20202020636F6E73742067726F757050617274203D0A20202020202073616665496450617274280A20202020202020206865616465724964207C7C0A20202020202020206067726F75705F247B67726F7570496E6465';
wwv_flow_imp.g_varchar2_table(84) := '78202B20317D600A202020202020293B0A0A20202020726F7773242E656163682866756E6374696F6E28726F77496E64657829207B0A0A202020202020636F6E737420726F7724203D0A2020202020202020242874686973293B0A0A2020202020206C65';
wwv_flow_imp.g_varchar2_table(85) := '7420726F774964203D0A2020202020202020726F77242E617474722822696422293B0A0A2020202020206966202821726F77496429207B0A0A2020202020202020636F6E737420626173654964203D0A2020202020202020202060247B726567696F6E50';
wwv_flow_imp.g_varchar2_table(86) := '6172747D5F63625F247B67726F7570506172747D5F726F775F247B726F77496E646578202B20317D603B0A0A2020202020202020726F774964203D0A202020202020202020206261736549643B0A0A20202020202020206C657420636F756E746572203D';
wwv_flow_imp.g_varchar2_table(87) := '0A20202020202020202020323B0A0A20202020202020202F2A0A2020202020202020202A2050726F7465637420616761696E73742061206475706C69636174652049442074686174206578697374730A2020202020202020202A20696E20746865206375';
wwv_flow_imp.g_varchar2_table(88) := '7272656E7420646F63756D656E742E0A2020202020202020202A2F0A20202020202020207768696C6520280A20202020202020202020646F63756D656E742E676574456C656D656E744279496428726F774964292026260A20202020202020202020646F';
wwv_flow_imp.g_varchar2_table(89) := '63756D656E742E676574456C656D656E744279496428726F7749642920213D3D20746869730A202020202020202029207B0A0A20202020202020202020726F774964203D0A20202020202020202020202060247B6261736549647D5F247B636F756E7465';
wwv_flow_imp.g_varchar2_table(90) := '727D603B0A0A20202020202020202020636F756E746572202B3D20313B0A0A20202020202020207D0A0A2020202020202020726F77242E61747472280A20202020202020202020226964222C0A20202020202020202020726F7749640A20202020202020';
wwv_flow_imp.g_varchar2_table(91) := '20293B0A0A2020202020207D0A0A2020202020206964732E70757368280A2020202020202020726F7749640A202020202020293B0A0A202020207D293B0A0A2020202072657475726E206964733B0A0A20207D0A0A0A20202F2A0A2020202A20456E7375';
wwv_flow_imp.g_varchar2_table(92) := '72652074686520636F6E74726F6C2D627265616B206865616465722068617320616E20696E6E6572206C61796F757420636F6E7461696E65722E0A2020202A0A2020202A20546865203C74683E2072656D61696E732061207461626C652063656C6C2E20';
wwv_flow_imp.g_varchar2_table(93) := '4F6E6C79207468652067656E65726174656420696E6E65720A2020202A20636F6E7461696E6572207573657320666C6578626F782E0A2020202A2F0A202066756E6374696F6E20656E73757265486561646572436F6E74656E7428686561646572242920';
wwv_flow_imp.g_varchar2_table(94) := '7B0A0A202020206C657420636F6E74656E7424203D0A202020202020686561646572242E6368696C6472656E280A20202020202020204845414445525F434F4E54454E545F53454C4543544F520A202020202020292E666972737428293B0A0A20202020';
wwv_flow_imp.g_varchar2_table(95) := '69662028636F6E74656E74242E6C656E67746829207B0A20202020202072657475726E20636F6E74656E74243B0A202020207D0A0A202020202F2A0A20202020202A205072657365727665206120627574746F6E2066726F6D20616E206561726C696572';
wwv_flow_imp.g_varchar2_table(96) := '20696E697469616C697A6174696F6E2C2069662070726573656E742C0A20202020202A207768696C65207772617070696E6720746865206F726967696E616C204150455820636F6E74726F6C2D627265616B20636F6E74656E742E0A20202020202A2F0A';
wwv_flow_imp.g_varchar2_table(97) := '20202020636F6E7374206578697374696E67427574746F6E24203D0A202020202020686561646572242E6368696C6472656E280A2020202020202020425554544F4E5F53454C4543544F520A202020202020290A20202020202020202E66697273742829';
wwv_flow_imp.g_varchar2_table(98) := '0A20202020202020202E64657461636828293B0A0A20202020636F6E7374207465787424203D0A2020202020202428223C7370616E3E222C207B0A2020202020202020636C617373203A202269722D636F6E74726F6C2D627265616B2D74657874220A20';
wwv_flow_imp.g_varchar2_table(99) := '20202020207D293B0A0A2020202074657874242E617070656E64280A202020202020686561646572242E636F6E74656E747328290A20202020293B0A0A20202020636F6E74656E7424203D0A2020202020202428223C7370616E3E222C207B0A20202020';
wwv_flow_imp.g_varchar2_table(100) := '20202020636C617373203A202269722D636F6E74726F6C2D627265616B2D686561646572220A2020202020207D293B0A0A20202020636F6E74656E74242E617070656E64280A20202020202074657874240A20202020293B0A0A20202020696620286578';
wwv_flow_imp.g_varchar2_table(101) := '697374696E67427574746F6E242E6C656E67746829207B0A0A202020202020636F6E74656E74242E617070656E64280A20202020202020206578697374696E67427574746F6E240A202020202020293B0A0A202020207D0A0A2020202068656164657224';
wwv_flow_imp.g_varchar2_table(102) := '2E617070656E64280A202020202020636F6E74656E74240A20202020293B0A0A2020202072657475726E20636F6E74656E74243B0A0A20207D0A0A0A20202F2A0A2020202A20437265617465206F722072657475726E2074686520746F67676C65206275';
wwv_flow_imp.g_varchar2_table(103) := '74746F6E20666F72206F6E6520636F6E74726F6C20627265616B2E0A2020202A2F0A202066756E6374696F6E20656E73757265427574746F6E280A20202020696E7374616E63652C0A20202020686561646572242C0A2020202067726F7570496E646578';
wwv_flow_imp.g_varchar2_table(104) := '0A202029207B0A0A20202020636F6E737420636F6E74656E7424203D0A202020202020656E73757265486561646572436F6E74656E74280A2020202020202020686561646572240A202020202020293B0A0A202020206C657420627574746F6E24203D0A';
wwv_flow_imp.g_varchar2_table(105) := '202020202020636F6E74656E74242E6368696C6472656E280A2020202020202020425554544F4E5F53454C4543544F520A202020202020292E666972737428293B0A0A202020202F2A0A20202020202A204372656174652074686520627574746F6E2077';
wwv_flow_imp.g_varchar2_table(106) := '68656E20697420646F65736E277420616C72656164792065786973742E0A20202020202A2F0A202020206966202821627574746F6E242E6C656E67746829207B0A0A202020202020627574746F6E24203D0A20202020202020202428223C627574746F6E';
wwv_flow_imp.g_varchar2_table(107) := '3E222C207B0A2020202020202020202074797065203A2022627574746F6E220A20202020202020207D293B0A0A202020207D0A0A0A202020202F2A0A20202020202A20456E73757265207468652069636F6E206578697374732E0A20202020202A2F0A20';
wwv_flow_imp.g_varchar2_table(108) := '2020206C65742069636F6E24203D0A202020202020627574746F6E242E6368696C6472656E280A202020202020202049434F4E5F53454C4543544F520A202020202020293B0A0A20202020696620282169636F6E242E6C656E67746829207B0A0A202020';
wwv_flow_imp.g_varchar2_table(109) := '20202069636F6E24203D0A20202020202020202428223C7370616E3E222C207B0A2020202020202020202022617269612D68696464656E22203A202274727565222C0A20202020202020202020636C6173732020202020202020203A2022742D49636F6E';
wwv_flow_imp.g_varchar2_table(110) := '2066612069722D636F6E74726F6C2D627265616B2D69636F6E220A20202020202020207D293B0A0A202020202020627574746F6E242E617070656E64280A202020202020202069636F6E240A202020202020293B0A0A202020207D0A0A0A202020202F2A';
wwv_flow_imp.g_varchar2_table(111) := '0A20202020202A205265667265736820627574746F6E20636C617373657320696E2063617365206170706C69636174696F6E2D73636F70650A20202020202A20706C75672D696E20636F6E66696775726174696F6E206368616E6765642E0A2020202020';
wwv_flow_imp.g_varchar2_table(112) := '2A2F0A20202020627574746F6E242E61747472280A20202020202022636C617373222C0A20202020202060247B696E7374616E63652E6F7074696F6E732E627574746F6E437373436C61737365737D2069722D636F6E74726F6C2D627265616B2D62746E';
wwv_flow_imp.g_varchar2_table(113) := '600A20202020202020202E7472696D28290A20202020293B0A0A0A202020202F2A0A20202020202A20506F736974696F6E206973206170706C69656420746F2074686520696E6E657220666C657820636F6E7461696E657220726174686572207468616E';
wwv_flow_imp.g_varchar2_table(114) := '0A20202020202A20666C6F6174696E672074686520627574746F6E20696E7369646520746865207461626C652063656C6C2E0A20202020202A2F0A20202020636F6E74656E74240A2020202020202E746F67676C65436C617373280A2020202020202020';
wwv_flow_imp.g_varchar2_table(115) := '2269722D636F6E74726F6C2D627265616B2D6865616465722D2D7374617274222C0A2020202020202020696E7374616E63652E6F7074696F6E732E627574746F6E506F736974696F6E203D3D3D0A20202020202020202020225354415254220A20202020';
wwv_flow_imp.g_varchar2_table(116) := '2020290A2020202020202E746F67676C65436C617373280A20202020202020202269722D636F6E74726F6C2D627265616B2D6865616465722D2D656E64222C0A2020202020202020696E7374616E63652E6F7074696F6E732E627574746F6E506F736974';
wwv_flow_imp.g_varchar2_table(117) := '696F6E203D3D3D0A2020202020202020202022454E44220A202020202020293B0A0A0A202020202F2A0A20202020202A204B65657020444F4D206F7264657220616C69676E656420776974682074686520636F6E66696775726564206C6F676963616C20';
wwv_flow_imp.g_varchar2_table(118) := '706F736974696F6E2E0A20202020202A2F0A20202020696620280A202020202020696E7374616E63652E6F7074696F6E732E627574746F6E506F736974696F6E203D3D3D0A20202020202022454E44220A2020202029207B0A0A202020202020636F6E74';
wwv_flow_imp.g_varchar2_table(119) := '656E74242E617070656E64280A2020202020202020627574746F6E240A202020202020293B0A0A202020207D20656C7365207B0A0A202020202020636F6E74656E74242E70726570656E64280A2020202020202020627574746F6E240A20202020202029';
wwv_flow_imp.g_varchar2_table(120) := '3B0A0A202020207D0A0A0A202020202F2A0A20202020202A2045737461626C6973682074686520415249412072656C6174696F6E73686970206265747765656E2074686520627574746F6E0A20202020202A20616E642074686520726F777320636F6E74';
wwv_flow_imp.g_varchar2_table(121) := '726F6C6C656420627920746869732067726F75702E0A20202020202A2F0A20202020636F6E737420636F6E74726F6C6C6564496473203D0A202020202020656E73757265436F6E74726F6C6C6564526F77496473280A2020202020202020696E7374616E';
wwv_flow_imp.g_varchar2_table(122) := '63652C0A2020202020202020686561646572242C0A202020202020202067726F7570496E6465780A202020202020293B0A0A2020202069662028636F6E74726F6C6C65644964732E6C656E67746829207B0A0A202020202020627574746F6E242E617474';
wwv_flow_imp.g_varchar2_table(123) := '72280A202020202020202022617269612D636F6E74726F6C73222C0A2020202020202020636F6E74726F6C6C65644964732E6A6F696E28222022290A202020202020293B0A0A202020207D20656C7365207B0A0A202020202020627574746F6E242E7265';
wwv_flow_imp.g_varchar2_table(124) := '6D6F766541747472280A202020202020202022617269612D636F6E74726F6C73220A202020202020293B0A0A202020207D0A0A2020202072657475726E20627574746F6E243B0A0A20207D0A0A0A20202F2A0A2020202A20557064617465207469746C65';
wwv_flow_imp.g_varchar2_table(125) := '2C2061636365737369626C65206C6162656C2C20657870616E6465642073746174652C20616E642069636F6E2E0A2020202A2F0A202066756E6374696F6E20736574427574746F6E5374617465280A20202020696E7374616E63652C0A20202020627574';
wwv_flow_imp.g_varchar2_table(126) := '746F6E242C0A202020206973457870616E6465640A202029207B0A0A20202020636F6E7374207469746C65203D0A2020202020206973457870616E6465640A20202020202020203F20696E7374616E63652E6F7074696F6E732E636F6C6C617073655469';
wwv_flow_imp.g_varchar2_table(127) := '746C650A20202020202020203A20696E7374616E63652E6F7074696F6E732E657870616E645469746C653B0A0A20202020636F6E73742069636F6E203D0A2020202020206973457870616E6465640A20202020202020203F20696E7374616E63652E6F70';
wwv_flow_imp.g_varchar2_table(128) := '74696F6E732E636F6C6C6170736549636F6E0A20202020202020203A20696E7374616E63652E6F7074696F6E732E657870616E6449636F6E3B0A0A0A20202020627574746F6E240A2020202020202E61747472287B0A20202020202020207469746C653A';
wwv_flow_imp.g_varchar2_table(129) := '0A202020202020202020207469746C652C0A0A202020202020202022617269612D6C6162656C223A0A202020202020202020207469746C652C0A0A202020202020202022617269612D657870616E646564223A0A20202020202020202020697345787061';
wwv_flow_imp.g_varchar2_table(130) := '6E6465642E746F537472696E6728290A2020202020207D293B0A0A0A20202020627574746F6E240A2020202020202E6368696C6472656E280A202020202020202049434F4E5F53454C4543544F520A202020202020290A2020202020202E72656D6F7665';
wwv_flow_imp.g_varchar2_table(131) := '436C617373280A202020202020202060247B696E7374616E63652E6F7074696F6E732E636F6C6C6170736549636F6E7D20247B696E7374616E63652E6F7074696F6E732E657870616E6449636F6E7D600A202020202020290A2020202020202E61646443';
wwv_flow_imp.g_varchar2_table(132) := '6C617373280A202020202020202069636F6E0A202020202020293B0A0A20207D0A0A0A20202F2A0A20202A2054726967676572206F6E6520726567696F6E2D6C6576656C206368616E6765206576656E742E0A20202A0A20202A20555345523A0A20202A';
wwv_flow_imp.g_varchar2_table(133) := '2020204F6E652063757272656E7420636F6E74726F6C2D627265616B206865616465722049442E0A20202A0A20202A20455850414E445F414C4C202F20434F4C4C415053455F414C4C202F2052455345543A0A20202A202020416C6C206368616E676564';
wwv_flow_imp.g_varchar2_table(134) := '2063757272656E7420636F6E74726F6C2D627265616B206865616465722049447320696E206F6E65206576656E742E0A20202A2F0A202066756E6374696F6E20747269676765724368616E67654576656E74280A20202020696E7374616E63652C0A2020';
wwv_flow_imp.g_varchar2_table(135) := '20206865616465724964732C0A202020206973457870616E6465642C0A20202020736F757263650A202029207B0A0A20202020636F6E7374206576656E7444617461203D207B0A202020202020726567696F6E49643A0A2020202020202020696E737461';
wwv_flow_imp.g_varchar2_table(136) := '6E63652E726567696F6E49642C0A0A2020202020206865616465724964733A0A20202020202020206865616465724964732C0A0A202020202020657870616E6465643A0A20202020202020206973457870616E6465642C0A0A202020202020736F757263';
wwv_flow_imp.g_varchar2_table(137) := '653A0A2020202020202020736F757263650A202020207D3B0A0A20202020617065782E64656275672E696E666F280A202020202020696E7374616E63652E706C7567696E4E616D652C0A2020202020202254726967676572696E67206576656E743A222C';
wwv_flow_imp.g_varchar2_table(138) := '0A2020202020204348414E47455F4556454E542C0A202020202020224576656E7420446174613A222C0A2020202020206576656E74446174610A20202020293B0A0A20202020617065782E6576656E742E74726967676572280A202020202020696E7374';
wwv_flow_imp.g_varchar2_table(139) := '616E63652E726567696F6E242C0A2020202020204348414E47455F4556454E542C0A2020202020206576656E74446174610A20202020293B0A0A20207D0A0A0A20202F2A0A2020202A20536574206F6E6520636F6E74726F6C2D627265616B2067726F75';
wwv_flow_imp.g_varchar2_table(140) := '7020746F20746865207265717565737465642073746174652E0A2020202A0A2020202A2070657273697374537461746520757064617465732074686520696E2D6D656D6F72792072656D656D62657265642073746174652E0A2020202A0A2020202A2053';
wwv_flow_imp.g_varchar2_table(141) := '746F72616765206973207772697474656E206279207468652063616C6C657220736F20746861742062756C6B206F7065726174696F6E730A2020202A206F6E6C79206E65656420746F207772697465206F6E63652E0A2020202A0A2020202A2042756C6B';
wwv_flow_imp.g_varchar2_table(142) := '206F7065726174696F6E732070617373206E756C6C20666F72206576656E74536F7572636520616E6420656D6974206F6E650A2020202A20616767726567617465206576656E7420616674657220616C6C2067726F7570732068617665206265656E2070';
wwv_flow_imp.g_varchar2_table(143) := '726F6365737365642E0A2020202A2F0A202066756E6374696F6E2073657447726F7570457870616E646564280A20202020696E7374616E63652C0A20202020686561646572242C0A202020206973457870616E6465642C0A202020207065727369737453';
wwv_flow_imp.g_varchar2_table(144) := '746174652C0A202020206576656E74536F757263650A202029207B0A0A20202020636F6E737420627574746F6E24203D0A202020202020686561646572242E66696E64280A2020202020202020425554544F4E5F53454C4543544F520A20202020202029';
wwv_flow_imp.g_varchar2_table(145) := '2E666972737428293B0A0A20202020636F6E73742070726576696F7573457870616E646564203D0A202020202020627574746F6E242E61747472280A202020202020202022617269612D657870616E646564220A20202020202029203D3D3D2022747275';
wwv_flow_imp.g_varchar2_table(146) := '65223B0A0A20202020636F6E73742067726F75704B6579203D0A20202020202067657447726F75704B6579280A2020202020202020686561646572240A202020202020293B0A0A20202020636F6E7374206865616465724964203D0A2020202020206865';
wwv_flow_imp.g_varchar2_table(147) := '61646572242E61747472280A2020202020202020226964220A202020202020293B0A0A20202020736574427574746F6E5374617465280A202020202020696E7374616E63652C0A202020202020627574746F6E242C0A2020202020206973457870616E64';
wwv_flow_imp.g_varchar2_table(148) := '65640A20202020293B0A0A2020202067657447726F7570526F77732868656164657224290A2020202020202E746F67676C65280A20202020202020206973457870616E6465640A202020202020293B0A0A0A202020202F2A0A20202020202A2055706461';
wwv_flow_imp.g_varchar2_table(149) := '74652072656D656D62657265642073746174652E0A20202020202A2F0A20202020696620280A2020202020207065727369737453746174652026260A202020202020696E7374616E63652E737461746553746F726167652026260A20202020202067726F';
wwv_flow_imp.g_varchar2_table(150) := '75704B65790A2020202029207B0A0A202020202020696E7374616E63652E73746F72656453746174650A20202020202020202E7374617465735B67726F75704B65795D203D0A202020202020202020206973457870616E6465643B0A0A202020207D0A0A';
wwv_flow_imp.g_varchar2_table(151) := '20202020636F6E7374206368616E676564203D0A20202020202070726576696F7573457870616E64656420213D3D0A2020202020206973457870616E6465643B0A0A20202020696620280A2020202020206368616E6765642026260A2020202020206576';
wwv_flow_imp.g_varchar2_table(152) := '656E74536F757263650A2020202029207B0A0A202020202020747269676765724368616E67654576656E74280A2020202020202020696E7374616E63652C0A202020202020202068656164657249640A202020202020202020203F205B68656164657249';
wwv_flow_imp.g_varchar2_table(153) := '645D0A202020202020202020203A205B5D2C0A20202020202020206973457870616E6465642C0A20202020202020206576656E74536F757263650A202020202020293B0A0A202020207D0A0A2020202072657475726E206368616E6765643B0A0A20207D';
wwv_flow_imp.g_varchar2_table(154) := '0A0A0A20202F2A0A2020202A2052657475726E20616C6C2063757272656E7420636F6E74726F6C2D627265616B206865616465727320666F72206F6E6520726567696F6E2E0A2020202A2F0A202066756E6374696F6E20676574427265616B4865616465';
wwv_flow_imp.g_varchar2_table(155) := '727328696E7374616E636529207B0A0A2020202072657475726E20696E7374616E63652E726567696F6E240A2020202020202E66696E64280A2020202020202020434F4E54524F4C5F425245414B5F53454C4543544F520A202020202020293B0A0A2020';
wwv_flow_imp.g_varchar2_table(156) := '7D0A0A0A20202F2A0A2020202A20496E697469616C697A6520616C6C2063757272656E7420636F6E74726F6C2D627265616B2067726F7570732E0A2020202A2F0A202066756E6374696F6E20696E697469616C697A6547726F75707328696E7374616E63';
wwv_flow_imp.g_varchar2_table(157) := '6529207B0A0A20202020636F6E7374206865616465727324203D0A202020202020676574427265616B48656164657273280A2020202020202020696E7374616E63650A202020202020293B0A0A20202020696620282168656164657273242E6C656E6774';
wwv_flow_imp.g_varchar2_table(158) := '6829207B0A0A202020202020617065782E64656275672E696E666F280A2020202020202020696E7374616E63652E706C7567696E4E616D652C0A2020202020202020224E6F20636F6E74726F6C2D627265616B2067726F75707320666F756E6420696E20';
wwv_flow_imp.g_varchar2_table(159) := '726567696F6E3A222C0A2020202020202020696E7374616E63652E726567696F6E49640A202020202020293B0A0A20202020202072657475726E3B0A0A202020207D0A0A2020202068656164657273240A2020202020202E656163682866756E6374696F';
wwv_flow_imp.g_varchar2_table(160) := '6E2867726F7570496E64657829207B0A0A2020202020202020636F6E73742068656164657224203D0A20202020202020202020242874686973293B0A0A2020202020202020636F6E73742067726F75704B6579203D0A2020202020202020202067657447';
wwv_flow_imp.g_varchar2_table(161) := '726F75704B6579280A202020202020202020202020686561646572240A20202020202020202020293B0A0A20202020202020206C6574206973457870616E646564203D0A20202020202020202020696E7374616E63652E6F7074696F6E730A2020202020';
wwv_flow_imp.g_varchar2_table(162) := '202020202020202E696E697469616C6C79457870616E6465643B0A0A0A20202020202020202F2A0A20202020202020202A2052656D656D62657265642073746174652074616B657320707265636564656E63652E0A20202020202020202A2F0A20202020';
wwv_flow_imp.g_varchar2_table(163) := '20202020696620280A20202020202020202020696E7374616E63652E737461746553746F726167652026260A2020202020202020202067726F75704B65792026260A202020202020202020204F626A6563742E70726F746F747970650A20202020202020';
wwv_flow_imp.g_varchar2_table(164) := '20202020202E6861734F776E50726F70657274792E63616C6C280A2020202020202020202020202020696E7374616E63652E73746F72656453746174652E7374617465732C0A202020202020202020202020202067726F75704B65790A20202020202020';
wwv_flow_imp.g_varchar2_table(165) := '2020202020290A202020202020202029207B0A0A202020202020202020206973457870616E646564203D0A202020202020202020202020696E7374616E63652E73746F72656453746174650A20202020202020202020202020202E7374617465735B6772';
wwv_flow_imp.g_varchar2_table(166) := '6F75704B65795D3B0A0A20202020202020207D0A0A2020202020202020656E73757265427574746F6E280A20202020202020202020696E7374616E63652C0A20202020202020202020686561646572242C0A2020202020202020202067726F7570496E64';
wwv_flow_imp.g_varchar2_table(167) := '65780A2020202020202020293B0A0A0A20202020202020202F2A0A20202020202020202A20496E697469616C697A6174696F6E2F726573746F726174696F6E20646F6573206E6F743A0A20202020202020202A0A20202020202020202A202D2063726561';
wwv_flow_imp.g_varchar2_table(168) := '74652072656D656D626572656420737461746520656E74726965730A20202020202020202A202D2066697265206368616E6765206576656E74730A20202020202020202A2F0A202020202020202073657447726F7570457870616E646564280A20202020';
wwv_flow_imp.g_varchar2_table(169) := '202020202020696E7374616E63652C0A20202020202020202020686561646572242C0A202020202020202020206973457870616E6465642C0A2020202020202020202066616C73652C0A202020202020202020206E756C6C0A2020202020202020293B0A';
wwv_flow_imp.g_varchar2_table(170) := '0A2020202020207D293B0A0A20207D0A0A0A20202F2A0A2020202A20417474616368207468652064656C65676174656420636C69636B2068616E646C65722E0A2020202A2F0A202066756E6374696F6E20617474616368436C69636B48616E646C657228';
wwv_flow_imp.g_varchar2_table(171) := '696E7374616E636529207B0A0A20202020696E7374616E63652E726567696F6E240A2020202020202E6F6666280A2020202020202020425554544F4E5F4556454E545F48414E444C45520A202020202020290A2020202020202E6F6E280A202020202020';
wwv_flow_imp.g_varchar2_table(172) := '2020425554544F4E5F4556454E545F48414E444C45522C0A2020202020202020425554544F4E5F53454C4543544F522C0A202020202020202066756E6374696F6E2829207B0A0A20202020202020202020636F6E737420627574746F6E24203D0A202020';
wwv_flow_imp.g_varchar2_table(173) := '202020202020202020242874686973293B0A0A20202020202020202020636F6E73742068656164657224203D0A202020202020202020202020627574746F6E242E636C6F73657374280A2020202020202020202020202020434F4E54524F4C5F42524541';
wwv_flow_imp.g_varchar2_table(174) := '4B5F53454C4543544F520A202020202020202020202020293B0A0A20202020202020202020636F6E7374206973457870616E646564203D0A202020202020202020202020627574746F6E242E61747472280A202020202020202020202020202022617269';
wwv_flow_imp.g_varchar2_table(175) := '612D657870616E646564220A20202020202020202020202029203D3D3D202274727565223B0A0A202020202020202020202F2A0A20202020202020202020202A205573657220696E746572616374696F6E206368616E676573206F6E652067726F757020';
wwv_flow_imp.g_varchar2_table(176) := '616E64207468657265666F72650A20202020202020202020202A20656D697473206F6E652055534552206368616E6765206576656E742E0A20202020202020202020202A2F0A2020202020202020202073657447726F7570457870616E646564280A2020';
wwv_flow_imp.g_varchar2_table(177) := '20202020202020202020696E7374616E63652C0A202020202020202020202020686561646572242C0A202020202020202020202020216973457870616E6465642C0A202020202020202020202020747275652C0A20202020202020202020202022555345';
wwv_flow_imp.g_varchar2_table(178) := '52220A20202020202020202020293B0A0A20202020202020202020736176655374617465280A202020202020202020202020696E7374616E63650A20202020202020202020293B0A0A20202020202020207D0A202020202020293B0A0A20207D0A0A0A20';
wwv_flow_imp.g_varchar2_table(179) := '202F2A0A2020202A2052657475726E2074686520696E697469616C697A656420696E7374616E636520666F722065786163746C79206F6E6520726567696F6E2E0A2020202A0A2020202A205075626C696320415049206D6574686F647320757365207468';
wwv_flow_imp.g_varchar2_table(180) := '69732068656C7065722E0A2020202A2F0A202066756E6374696F6E20676574496E7374616E6365280A20202020726567696F6E2C0A20202020706C7567696E4E616D650A202029207B0A0A20202020636F6E73742064656275674E616D65203D0A202020';
wwv_flow_imp.g_varchar2_table(181) := '202020706C7567696E4E616D65207C7C0A20202020202044454641554C545F504C5547494E5F4E414D453B0A0A20202020636F6E737420726567696F6E24203D0A2020202020207265736F6C7665526567696F6E280A2020202020202020726567696F6E';
wwv_flow_imp.g_varchar2_table(182) := '2C0A202020202020202064656275674E616D650A202020202020293B0A0A202020206966202821726567696F6E242E6C656E67746829207B0A0A202020202020617065782E64656275672E6572726F72280A202020202020202064656275674E616D652C';
wwv_flow_imp.g_varchar2_table(183) := '0A2020202020202020225075626C6963204150492063616C6C2072657175697265732065786163746C79206F6E6520726567696F6E2E222C0A2020202020202020726567696F6E0A202020202020293B0A0A20202020202072657475726E206E756C6C3B';
wwv_flow_imp.g_varchar2_table(184) := '0A0A202020207D0A0A20202020636F6E737420696E7374616E6365203D0A202020202020696E7374616E6365732E676574280A2020202020202020726567696F6E245B305D0A202020202020293B0A0A202020206966202821696E7374616E636529207B';
wwv_flow_imp.g_varchar2_table(185) := '0A0A202020202020617065782E64656275672E7761726E280A202020202020202064656275674E616D652C0A202020202020202022526567696F6E20686173206E6F74206265656E20696E697469616C697A65642E222C0A202020202020202072656769';
wwv_flow_imp.g_varchar2_table(186) := '6F6E245B305D0A202020202020293B0A0A20202020202072657475726E206E756C6C3B0A0A202020207D0A0A2020202072657475726E20696E7374616E63653B0A0A20207D0A0A20202F2A0A2020202A20496E697469616C697A65206F6E6520496E7465';
wwv_flow_imp.g_varchar2_table(187) := '72616374697665205265706F727420726567696F6E2E0A2020202A0A2020202A20506C75672D696E2073657474696E67732061726520616C7265616479206E6F726D616C697A656420616E642064656661756C7465642062790A2020202A207468652041';
wwv_flow_imp.g_varchar2_table(188) := '50455820706C75672D696E20646566696E6974696F6E20616E642072656E6465722070726F6365647572652E0A2020202A0A2020202A2041207065722D726567696F6E20636F70792069732075736564206265636175736520616E20656D707479204578';
wwv_flow_imp.g_varchar2_table(189) := '70616E642049636F6E2069730A2020202A207265736F6C7665642066726F6D207468652063757272656E7420726567696F6E2773207465787420646972656374696F6E2E0A2020202A2F0A202066756E6374696F6E20696E6974496E7374616E6365280A';
wwv_flow_imp.g_varchar2_table(190) := '20202020726567696F6E2C0A202020206F7074696F6E732C0A20202020706C7567696E4E616D650A202029207B0A0A20202020636F6E737420726567696F6E24203D0A2020202020202428726567696F6E292E666972737428293B0A0A20202020696620';
wwv_flow_imp.g_varchar2_table(191) := '2821726567696F6E242E6C656E67746829207B0A0A202020202020617065782E64656275672E6572726F72280A2020202020202020706C7567696E4E616D652C0A202020202020202022556E61626C6520746F20696E697469616C697A6520726567696F';
wwv_flow_imp.g_varchar2_table(192) := '6E2E222C0A2020202020202020726567696F6E0A202020202020293B0A0A20202020202072657475726E2066616C73653B0A0A202020207D0A0A0A20202020636F6E737420696E7374616E63654F7074696F6E73203D0A202020202020242E657874656E';
wwv_flow_imp.g_varchar2_table(193) := '64280A20202020202020207B7D2C0A20202020202020206F7074696F6E730A202020202020293B0A0A0A202020202F2A0A202020202A205768656E20457870616E642049636F6E20697320656D7074792C206175746F6D61746963616C6C792073656C65';
wwv_flow_imp.g_varchar2_table(194) := '63740A202020202A2074686520646972656374696F6E616C2069636F6E206261736564206F6E3A0A202020202A0A202020202A202D20427574746F6E20506F736974696F6E0A202020202A202D204C5452202F2052544C20646972656374696F6E0A2020';
wwv_flow_imp.g_varchar2_table(195) := '20202A2F0A202020206966202821696E7374616E63654F7074696F6E732E657870616E6449636F6E29207B0A0A202020202020696E7374616E63654F7074696F6E732E657870616E6449636F6E203D0A202020202020202067657444656661756C744578';
wwv_flow_imp.g_varchar2_table(196) := '70616E6449636F6E280A20202020202020202020726567696F6E242C0A20202020202020202020696E7374616E63654F7074696F6E732E627574746F6E506F736974696F6E0A2020202020202020293B0A0A202020207D0A0A0A20202020636F6E737420';
wwv_flow_imp.g_varchar2_table(197) := '726567696F6E4964203D0A202020202020726567696F6E242E617474722822696422293B0A0A0A20202020636F6E737420696E7374616E6365203D207B0A0A202020202020726567696F6E243A0A2020202020202020726567696F6E242C0A0A20202020';
wwv_flow_imp.g_varchar2_table(198) := '2020726567696F6E49643A0A2020202020202020726567696F6E49642C0A0A202020202020706C7567696E4E616D653A0A2020202020202020706C7567696E4E616D652C0A0A2020202020206F7074696F6E733A0A2020202020202020696E7374616E63';
wwv_flow_imp.g_varchar2_table(199) := '654F7074696F6E732C0A0A202020202020737461746553746F726167653A0A2020202020202020676574537461746553746F72616765280A20202020202020202020726567696F6E49642C0A20202020202020202020696E7374616E63654F7074696F6E';
wwv_flow_imp.g_varchar2_table(200) := '732E72656D656D62657253746174652C0A20202020202020202020706C7567696E4E616D650A2020202020202020292C0A0A20202020202073746F72656453746174653A0A20202020202020206E756C6C0A0A202020207D3B0A0A0A202020206C6F6164';
wwv_flow_imp.g_varchar2_table(201) := '5374617465280A202020202020696E7374616E63650A20202020293B0A0A0A20202020696E7374616E6365732E736574280A202020202020726567696F6E245B305D2C0A202020202020696E7374616E63650A20202020293B0A0A0A2020202061747461';
wwv_flow_imp.g_varchar2_table(202) := '6368436C69636B48616E646C6572280A202020202020696E7374616E63650A20202020293B0A0A0A20202020696E697469616C697A6547726F757073280A202020202020696E7374616E63650A20202020293B0A0A0A20202020617065782E6465627567';
wwv_flow_imp.g_varchar2_table(203) := '2E696E666F280A202020202020706C7567696E4E616D652C0A20202020202022496E697469616C697A656420726567696F6E3A222C0A202020202020726567696F6E49640A20202020293B0A0A0A2020202072657475726E20747275653B0A0A20207D0A';
wwv_flow_imp.g_varchar2_table(204) := '0A0A20202F2A0A2020202A20496E697469616C697A65206F6E65206F72206D6F7265206D61746368696E6720496E746572616374697665205265706F727420726567696F6E732E0A2020202A0A2020202A205468697320616C6C6F777320612044796E61';
wwv_flow_imp.g_varchar2_table(205) := '6D696320416374696F6E207573696E672061206A51756572792073656C6563746F7220746F207461726765740A2020202A206D756C7469706C65204952732E0A2020202A0A2020202A2045616368206D61746368656420726567696F6E20697320737469';
wwv_flow_imp.g_varchar2_table(206) := '6C6C20616E20696E646570656E64656E7420706C75672D696E20696E7374616E63652E0A2020202A2F0A202066756E6374696F6E20696E6974280A20202020726567696F6E2C0A202020206F7074696F6E732C0A20202020706C7567696E4E616D650A20';
wwv_flow_imp.g_varchar2_table(207) := '2029207B0A0A20202020636F6E73742064656275674E616D65203D0A202020202020706C7567696E4E616D65207C7C0A20202020202044454641554C545F504C5547494E5F4E414D453B0A0A20202020636F6E737420726567696F6E7324203D0A202020';
wwv_flow_imp.g_varchar2_table(208) := '2020207265736F6C7665526567696F6E73280A2020202020202020726567696F6E0A202020202020293B0A0A202020206966202821726567696F6E73242E6C656E67746829207B0A0A202020202020617065782E64656275672E6572726F72280A202020';
wwv_flow_imp.g_varchar2_table(209) := '202020202064656275674E616D652C0A202020202020202022496E697469616C697A6174696F6E2074617267657420646964206E6F74207265736F6C766520746F20616E7920726567696F6E732E222C0A2020202020202020726567696F6E0A20202020';
wwv_flow_imp.g_varchar2_table(210) := '2020293B0A0A20202020202072657475726E2066616C73653B0A0A202020207D0A0A0A20202020617065782E64656275672E696E666F280A20202020202064656275674E616D652C0A20202020202022496E697469616C697A696E6720726567696F6E73';
wwv_flow_imp.g_varchar2_table(211) := '3A222C0A202020202020726567696F6E73242E6C656E6774680A20202020293B0A0A0A202020206C657420696E697469616C697A6564203D0A20202020202066616C73653B0A0A0A20202020726567696F6E73240A2020202020202E656163682866756E';
wwv_flow_imp.g_varchar2_table(212) := '6374696F6E2829207B0A0A2020202020202020696620280A20202020202020202020696E6974496E7374616E6365280A202020202020202020202020746869732C0A2020202020202020202020206F7074696F6E732C0A20202020202020202020202064';
wwv_flow_imp.g_varchar2_table(213) := '656275674E616D650A20202020202020202020290A202020202020202029207B0A0A20202020202020202020696E697469616C697A6564203D0A202020202020202020202020747275653B0A0A20202020202020207D0A0A2020202020207D293B0A0A0A';
wwv_flow_imp.g_varchar2_table(214) := '2020202072657475726E20696E697469616C697A65643B0A0A20207D0A0A0A20202F2A0A2020202A204170706C79206F6E6520737461746520746F20616C6C20636F6E74726F6C2D627265616B2067726F75707320696E2065786163746C790A2020202A';
wwv_flow_imp.g_varchar2_table(215) := '206F6E6520696E697469616C697A656420726567696F6E2E0A2020202A0A2020202A204F6E6C79206F6E65206972636F6E74726F6C627265616B6368616E6765206576656E7420697320656D6974746564206166746572207468650A2020202A206F7065';
wwv_flow_imp.g_varchar2_table(216) := '726174696F6E2C207265676172646C657373206F6620686F77206D616E792067726F757073206368616E6765642E0A2020202A2F0A202066756E6374696F6E20736574416C6C457870616E646564280A20202020726567696F6E2C0A2020202069734578';
wwv_flow_imp.g_varchar2_table(217) := '70616E6465642C0A20202020736F757263652C0A20202020706C7567696E4E616D650A202029207B0A0A20202020636F6E737420696E7374616E6365203D0A202020202020676574496E7374616E6365280A2020202020202020726567696F6E2C0A2020';
wwv_flow_imp.g_varchar2_table(218) := '202020202020706C7567696E4E616D650A202020202020293B0A0A202020206966202821696E7374616E636529207B0A20202020202072657475726E2066616C73653B0A202020207D0A0A0A20202020636F6E7374206368616E67656448656164657249';
wwv_flow_imp.g_varchar2_table(219) := '6473203D0A2020202020205B5D3B0A0A202020206C6574206368616E676564416E79203D0A20202020202066616C73653B0A0A0A20202020676574427265616B48656164657273280A202020202020696E7374616E63650A20202020290A202020202020';
wwv_flow_imp.g_varchar2_table(220) := '2E656163682866756E6374696F6E2867726F7570496E64657829207B0A0A2020202020202020636F6E73742068656164657224203D0A20202020202020202020242874686973293B0A0A0A20202020202020202F2A0A2020202020202020202A204E6F72';
wwv_flow_imp.g_varchar2_table(221) := '6D616C6C7920616C72656164792070726573656E742C2062757420656E737572652074686520627574746F6E206578697374730A2020202020202020202A20696E206361736520746865204150492069732063616C6C656420616674657220444F4D2063';
wwv_flow_imp.g_varchar2_table(222) := '68616E6765732E0A2020202020202020202A2F0A2020202020202020656E73757265427574746F6E280A20202020202020202020696E7374616E63652C0A20202020202020202020686561646572242C0A2020202020202020202067726F7570496E6465';
wwv_flow_imp.g_varchar2_table(223) := '780A2020202020202020293B0A0A0A2020202020202020636F6E7374206368616E676564203D0A2020202020202020202073657447726F7570457870616E646564280A202020202020202020202020696E7374616E63652C0A2020202020202020202020';
wwv_flow_imp.g_varchar2_table(224) := '20686561646572242C0A2020202020202020202020206973457870616E6465642C0A202020202020202020202020747275652C0A2020202020202020202020206E756C6C0A20202020202020202020293B0A0A2020202020202020696620286368616E67';
wwv_flow_imp.g_varchar2_table(225) := '656429207B0A0A202020202020202020206368616E676564416E79203D0A202020202020202020202020747275653B0A0A20202020202020202020636F6E7374206865616465724964203D0A202020202020202020202020686561646572242E61747472';
wwv_flow_imp.g_varchar2_table(226) := '280A2020202020202020202020202020226964220A202020202020202020202020293B0A0A2020202020202020202069662028686561646572496429207B0A0A2020202020202020202020206368616E6765644865616465724964732E70757368280A20';
wwv_flow_imp.g_varchar2_table(227) := '2020202020202020202020202068656164657249640A202020202020202020202020293B0A0A202020202020202020207D0A0A20202020202020207D0A0A2020202020207D293B0A0A0A202020202F2A0A20202020202A205065727369737420616C6C20';
wwv_flow_imp.g_varchar2_table(228) := '6368616E676564207374617465732077697468206F6E652073746F726167652077726974652E0A20202020202A2F0A20202020736176655374617465280A202020202020696E7374616E63650A20202020293B0A0A0A202020202F2A0A20202020202A20';
wwv_flow_imp.g_varchar2_table(229) := '456D6974206F6E6520616767726567617465206368616E6765206576656E742E0A20202020202A2F0A20202020696620286368616E676564416E7929207B0A0A202020202020747269676765724368616E67654576656E74280A2020202020202020696E';
wwv_flow_imp.g_varchar2_table(230) := '7374616E63652C0A20202020202020206368616E6765644865616465724964732C0A20202020202020206973457870616E6465642C0A2020202020202020736F757263650A202020202020293B0A0A202020207D0A0A0A2020202072657475726E207472';
wwv_flow_imp.g_varchar2_table(231) := '75653B0A0A20207D0A0A0A20202F2A0A2020202A20457870616E6420657665727920636F6E74726F6C2D627265616B2067726F757020696E206F6E6520726567696F6E2E0A2020202A2F0A202066756E6374696F6E20657870616E64416C6C280A202020';
wwv_flow_imp.g_varchar2_table(232) := '20726567696F6E2C0A20202020706C7567696E4E616D650A202029207B0A0A2020202072657475726E20736574416C6C457870616E646564280A202020202020726567696F6E2C0A202020202020747275652C0A20202020202022455850414E445F414C';
wwv_flow_imp.g_varchar2_table(233) := '4C222C0A202020202020706C7567696E4E616D650A20202020293B0A0A20207D0A0A0A20202F2A0A2020202A20436F6C6C6170736520657665727920636F6E74726F6C2D627265616B2067726F757020696E206F6E6520726567696F6E2E0A2020202A2F';
wwv_flow_imp.g_varchar2_table(234) := '0A202066756E6374696F6E20636F6C6C61707365416C6C280A20202020726567696F6E2C0A20202020706C7567696E4E616D650A202029207B0A0A2020202072657475726E20736574416C6C457870616E646564280A202020202020726567696F6E2C0A';
wwv_flow_imp.g_varchar2_table(235) := '20202020202066616C73652C0A20202020202022434F4C4C415053455F414C4C222C0A202020202020706C7567696E4E616D650A20202020293B0A0A20207D0A0A0A20202F2A0A2020202A20436C6561722072656D656D62657265642073746174652066';
wwv_flow_imp.g_varchar2_table(236) := '6F72206F6E6520726567696F6E20616E6420726573746F72650A2020202A2074686520636F6E6669677572656420496E697469616C6C7920457870616E6465642076616C75652E0A2020202A0A2020202A20426F74682073657373696F6E20616E642070';
wwv_flow_imp.g_varchar2_table(237) := '657273697374656E742062726F777365722073746174652061726520636C65617265642E0A2020202A0A2020202A204F6E65205245534554206576656E7420697320656D6974746564206966206F6E65206F72206D6F72652063757272656E742067726F';
wwv_flow_imp.g_varchar2_table(238) := '7570730A2020202A2061637475616C6C79206368616E67652073746174652E0A2020202A2F0A202066756E6374696F6E2072657365745374617465280A20202020726567696F6E2C0A20202020706C7567696E4E616D650A202029207B0A0A2020202063';
wwv_flow_imp.g_varchar2_table(239) := '6F6E737420696E7374616E6365203D0A202020202020676574496E7374616E6365280A2020202020202020726567696F6E2C0A2020202020202020706C7567696E4E616D650A202020202020293B0A0A202020206966202821696E7374616E636529207B';
wwv_flow_imp.g_varchar2_table(240) := '0A20202020202072657475726E2066616C73653B0A202020207D0A0A0A20202020636C65617253746F7265645374617465280A202020202020696E7374616E63652E726567696F6E49640A20202020293B0A0A0A20202020696E7374616E63652E73746F';
wwv_flow_imp.g_varchar2_table(241) := '7265645374617465203D0A20202020202063726561746553746F7265645374617465280A2020202020202020696E7374616E63650A202020202020293B0A0A0A20202020636F6E7374206368616E676564486561646572496473203D0A2020202020205B';
wwv_flow_imp.g_varchar2_table(242) := '5D3B0A0A202020206C6574206368616E676564416E79203D0A20202020202066616C73653B0A0A0A20202020676574427265616B48656164657273280A202020202020696E7374616E63650A20202020290A2020202020202E656163682866756E637469';
wwv_flow_imp.g_varchar2_table(243) := '6F6E2867726F7570496E64657829207B0A0A2020202020202020636F6E73742068656164657224203D0A20202020202020202020242874686973293B0A0A2020202020202020656E73757265427574746F6E280A20202020202020202020696E7374616E';
wwv_flow_imp.g_varchar2_table(244) := '63652C0A20202020202020202020686561646572242C0A2020202020202020202067726F7570496E6465780A2020202020202020293B0A0A0A2020202020202020636F6E7374206368616E676564203D0A2020202020202020202073657447726F757045';
wwv_flow_imp.g_varchar2_table(245) := '7870616E646564280A202020202020202020202020696E7374616E63652C0A202020202020202020202020686561646572242C0A202020202020202020202020696E7374616E63652E6F7074696F6E732E696E697469616C6C79457870616E6465642C0A';
wwv_flow_imp.g_varchar2_table(246) := '20202020202020202020202066616C73652C0A2020202020202020202020206E756C6C0A20202020202020202020293B0A0A0A2020202020202020696620286368616E67656429207B0A0A202020202020202020206368616E676564416E79203D0A2020';
wwv_flow_imp.g_varchar2_table(247) := '20202020202020202020747275653B0A0A20202020202020202020636F6E7374206865616465724964203D0A202020202020202020202020686561646572242E61747472280A2020202020202020202020202020226964220A2020202020202020202020';
wwv_flow_imp.g_varchar2_table(248) := '20293B0A0A2020202020202020202069662028686561646572496429207B0A0A2020202020202020202020206368616E6765644865616465724964732E70757368280A202020202020202020202020202068656164657249640A20202020202020202020';
wwv_flow_imp.g_varchar2_table(249) := '2020293B0A0A202020202020202020207D0A0A20202020202020207D0A0A2020202020207D293B0A0A0A202020202F2A0A20202020202A2049662072656D656D626572696E6720697320656E61626C65642C2072656372656174652073746F7261676520';
wwv_flow_imp.g_varchar2_table(250) := '776974683A0A20202020202A0A20202020202A202D2063757272656E742073746F726167652076657273696F6E0A20202020202A202D2063757272656E7420496E697469616C6C7920457870616E6465642073657474696E670A20202020202A202D206E';
wwv_flow_imp.g_varchar2_table(251) := '6F207065722D67726F7570206F76657272696465730A20202020202A2F0A20202020736176655374617465280A202020202020696E7374616E63650A20202020293B0A0A0A202020202F2A0A20202020202A20456D6974206F6E65206167677265676174';
wwv_flow_imp.g_varchar2_table(252) := '65205245534554206576656E742E0A20202020202A2F0A20202020696620286368616E676564416E7929207B0A0A202020202020747269676765724368616E67654576656E74280A2020202020202020696E7374616E63652C0A20202020202020206368';
wwv_flow_imp.g_varchar2_table(253) := '616E6765644865616465724964732C0A2020202020202020696E7374616E63652E6F7074696F6E732E696E697469616C6C79457870616E6465642C0A2020202020202020225245534554220A202020202020293B0A0A202020207D0A0A0A202020207265';
wwv_flow_imp.g_varchar2_table(254) := '7475726E20747275653B0A0A20207D0A0A0A20202F2A0A2020202A205075626C6963204150492E0A2020202A0A2020202A20696E697428293A0A2020202A2020204D617920696E697469616C697A65206F6E65206F72206D6F7265206D61746368656420';
wwv_flow_imp.g_varchar2_table(255) := '726567696F6E732E0A2020202A0A2020202A20657870616E64416C6C28293A0A2020202A20636F6C6C61707365416C6C28293A0A2020202A207265736574537461746528293A0A2020202A202020496E74656E74696F6E616C6C79206F70657261746520';
wwv_flow_imp.g_varchar2_table(256) := '6F6E2065786163746C79206F6E6520726567696F6E2E0A2020202A2F0A2020706C7567696E2E69722E636F6E74726F6C427265616B546F67676C6572203D207B0A0A20202020696E69743A0A202020202020696E69742C0A0A20202020657870616E6441';
wwv_flow_imp.g_varchar2_table(257) := '6C6C3A0A202020202020657870616E64416C6C2C0A0A20202020636F6C6C61707365416C6C3A0A202020202020636F6C6C61707365416C6C2C0A0A20202020726573657453746174653A0A202020202020726573657453746174650A0A20207D3B0A0A0A';
wwv_flow_imp.g_varchar2_table(258) := '20202F2A0A20202A205468652044796E616D696320416374696F6E2073686F756C64206E6F726D616C6C79206265206372656174656420776974683A0A20202A0A20202A2020204576656E743A20416674657220526566726573680A20202A0A20202A20';
wwv_flow_imp.g_varchar2_table(259) := '4120526567696F6E2073656C656374696F6E206E6F726D616C6C7920737570706C696573206F6E652074726967676572696E672049522E0A20202A0A20202A2041206A51756572792053656C6563746F722063616E20737570706C79206F6E65206F7220';
wwv_flow_imp.g_varchar2_table(260) := '6D6F7265206D61746368696E67204952733B0A20202A20696E6974282920747265617473206561636820617320616E20696E646570656E64656E7420706C75672D696E20696E7374616E63652E0A20202A0A20202A204E6F20416666656374656420456C';
wwv_flow_imp.g_varchar2_table(261) := '656D656E747320636F6E66696775726174696F6E20697320726571756972656420626563617573650A20202A2074686520706C75672D696E2075736573206461436F6E6669672E74726967676572696E67456C656D656E742E0A20202A2F0A202077696E';
wwv_flow_imp.g_varchar2_table(262) := '646F772E6972436F6E74726F6C427265616B546F67676C6572496E6974203D20280A2020202073657474696E67732C0A202020206461436F6E6669670A202029203D3E207B0A0A20202020636F6E737420706C7567696E4E616D65203D0A202020202020';
wwv_flow_imp.g_varchar2_table(263) := '676574506C7567696E4E616D65280A20202020202020206461436F6E6669670A202020202020293B0A0A20202020706C7567696E2E69720A2020202020202E636F6E74726F6C427265616B546F67676C65720A2020202020202E696E6974280A20202020';
wwv_flow_imp.g_varchar2_table(264) := '202020206461436F6E6669672E74726967676572696E67456C656D656E742C0A202020202020202073657474696E67732C0A2020202020202020706C7567696E4E616D650A202020202020293B0A0A20207D3B0A0A0A20202F2A0A20202A2044796E616D';
wwv_flow_imp.g_varchar2_table(265) := '696320416374696F6E20656E74727920706F696E7420666F72206465636C6172617469766520636F6E74726F6C2D627265616B20616374696F6E732E0A20202A0A20202A20496E74656E64656420666F7220757365207769746820616E204F7261636C65';
wwv_flow_imp.g_varchar2_table(266) := '204150455820427574746F6E205472696767657220416374696F6E2E0A20202A0A20202A2054686520627574746F6E206973207468652074726967676572696E6720656C656D656E742C207768696C65207468652074617267657420496E746572616374';
wwv_flow_imp.g_varchar2_table(267) := '6976650A20202A205265706F727420697320737570706C696564207468726F756768207468652044796E616D696320416374696F6E20416666656374656420456C656D656E74732E0A20202A0A20202A20537570706F7274656420616374696F6E733A0A';
wwv_flow_imp.g_varchar2_table(268) := '20202A0A20202A202020455850414E445F414C4C0A20202A202020434F4C4C415053455F414C4C0A20202A20202052455345545F53544154450A20202A0A20202A2054686520616666656374656420726567696F6E206D75737420616C72656164792068';
wwv_flow_imp.g_varchar2_table(269) := '617665206265656E20696E697469616C697A6564206279207468650A20202A20495220436F6E74726F6C20427265616B20546F67676C657220706C75672D696E2E0A20202A2F0A202077696E646F772E6972436F6E74726F6C427265616B546F67676C65';
wwv_flow_imp.g_varchar2_table(270) := '72416374696F6E203D20280A2020202073657474696E67732C0A202020206461436F6E6669670A202029203D3E207B0A0A20202020636F6E737420706C7567696E4E616D65203D0A202020202020676574506C7567696E4E616D65280A20202020202020';
wwv_flow_imp.g_varchar2_table(271) := '206461436F6E6669670A202020202020293B0A0A20202020636F6E737420617069203D0A202020202020706C7567696E2E69720A20202020202020202E636F6E74726F6C427265616B546F67676C65723B0A0A20202020636F6E737420726567696F6E24';
wwv_flow_imp.g_varchar2_table(272) := '203D0A20202020202024286461436F6E6669672E6166666563746564456C656D656E7473293B0A0A0A202020206966202821726567696F6E242E6C656E67746829207B0A0A202020202020617065782E64656275672E6572726F72280A20202020202020';
wwv_flow_imp.g_varchar2_table(273) := '20706C7567696E4E616D652C0A202020202020202022427574746F6E20416374696F6E20726571756972657320616E20616666656374656420496E746572616374697665205265706F727420726567696F6E2E220A202020202020293B0A0A2020202020';
wwv_flow_imp.g_varchar2_table(274) := '2072657475726E2066616C73653B0A0A202020207D0A0A0A2020202069662028726567696F6E242E6C656E67746820213D3D203129207B0A0A202020202020617065782E64656275672E6572726F72280A2020202020202020706C7567696E4E616D652C';
wwv_flow_imp.g_varchar2_table(275) := '0A202020202020202022427574746F6E20416374696F6E2072657175697265732065786163746C79206F6E6520616666656374656420726567696F6E2E204D6174636865643A222C0A2020202020202020726567696F6E242E6C656E6774680A20202020';
wwv_flow_imp.g_varchar2_table(276) := '2020293B0A0A20202020202072657475726E2066616C73653B0A0A202020207D0A0A0A20202020617065782E64656275672E696E666F280A202020202020706C7567696E4E616D652C0A20202020202022457865637574696E6720427574746F6E204163';
wwv_flow_imp.g_varchar2_table(277) := '74696F6E3A222C0A20202020202073657474696E67732E616374696F6E2C0A202020202020726567696F6E245B305D0A20202020293B0A0A0A20202020737769746368202873657474696E67732E616374696F6E29207B0A0A2020202020206361736520';
wwv_flow_imp.g_varchar2_table(278) := '22455850414E445F414C4C223A0A0A202020202020202072657475726E206170692E657870616E64416C6C280A20202020202020202020726567696F6E242C0A20202020202020202020706C7567696E4E616D650A2020202020202020293B0A0A0A2020';
wwv_flow_imp.g_varchar2_table(279) := '20202020636173652022434F4C4C415053455F414C4C223A0A0A202020202020202072657475726E206170692E636F6C6C61707365416C6C280A20202020202020202020726567696F6E242C0A20202020202020202020706C7567696E4E616D650A2020';
wwv_flow_imp.g_varchar2_table(280) := '202020202020293B0A0A0A20202020202063617365202252455345545F5354415445223A0A0A202020202020202072657475726E206170692E72657365745374617465280A20202020202020202020726567696F6E242C0A20202020202020202020706C';
wwv_flow_imp.g_varchar2_table(281) := '7567696E4E616D650A2020202020202020293B0A0A0A20202020202064656661756C743A0A0A2020202020202020617065782E64656275672E7761726E280A20202020202020202020706C7567696E4E616D652C0A2020202020202020202022556E7375';
wwv_flow_imp.g_varchar2_table(282) := '70706F7274656420427574746F6E20416374696F6E3A222C0A2020202020202020202073657474696E67732E616374696F6E0A2020202020202020293B0A0A202020202020202072657475726E2066616C73653B0A0A202020207D0A0A20207D3B0A0A7D';
wwv_flow_imp.g_varchar2_table(283) := '2928617065782E6A51756572792C2066695F6A617269735F706C7567696E293B0A';
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
wwv_flow_imp.g_varchar2_table(1) := '7661722066695F6A617269735F706C7567696E3D66695F6A617269735F706C7567696E7C7C7B7D3B2166756E6374696F6E28742C65297B652E69723D652E69727C7C7B7D3B636F6E7374206E3D6E6577205765616B4D61702C723D22495220436F6E7472';
wwv_flow_imp.g_varchar2_table(2) := '6F6C20427265616B20546F67676C6572222C6F3D2266695F6A617269735F706C7567696E2E6972436F6E74726F6C427265616B546F67676C6572222C693D227374617465222C613D2274682E612D4952522D6865616465722D2D67726F7570222C733D22';
wwv_flow_imp.g_varchar2_table(3) := '2E69722D636F6E74726F6C2D627265616B2D62746E222C633D222E69722D636F6E74726F6C2D627265616B2D69636F6E222C6C3D22636C69636B2E636F6E74726F6C427265616B546F67676C65222C753D226972636F6E74726F6C627265616B6368616E';
wwv_flow_imp.g_varchar2_table(4) := '6765223B66756E6374696F6E20672874297B72657475726E20742626742E616374696F6E2626742E616374696F6E2E616374696F6E7C7C727D66756E6374696F6E20642865297B69662822737472696E67223D3D747970656F662065297B636F6E737420';
wwv_flow_imp.g_varchar2_table(5) := '6E3D646F63756D656E742E676574456C656D656E74427949642865293B72657475726E2074286E3F6E3A65297D72657475726E20742865297D66756E6374696F6E207028742C652C6E297B696628224E4F223D3D3D652972657475726E206E756C6C3B69';
wwv_flow_imp.g_varchar2_table(6) := '662821742972657475726E20617065782E64656275672E7761726E286E2C2252656D656D62657220537461746520697320656E61626C65642C206275742074686520726567696F6E20686173206E6F2049442E22292C6E756C6C3B636F6E737420723D7B';
wwv_flow_imp.g_varchar2_table(7) := '7072656669783A6F2C75736541707049643A21302C7573655061676549643A21302C726567696F6E49643A747D3B72657475726E2253455353494F4E223D3D3D653F617065782E73746F726167652E67657453636F70656453657373696F6E53746F7261';
wwv_flow_imp.g_varchar2_table(8) := '67652872293A2250455253495354454E54223D3D3D653F617065782E73746F726167652E67657453636F7065644C6F63616C53746F726167652872293A28617065782E64656275672E7761726E286E2C22556E737570706F727465642052656D656D6265';
wwv_flow_imp.g_varchar2_table(9) := '722053746174652076616C75653A222C65292C6E756C6C297D66756E6374696F6E20662874297B72657475726E7B76657273696F6E3A322C696E697469616C6C79457870616E6465643A742E6F7074696F6E732E696E697469616C6C79457870616E6465';
wwv_flow_imp.g_varchar2_table(10) := '642C7374617465733A7B7D7D7D66756E6374696F6E20682874297B742E737461746553746F726167652626742E737461746553746F726167652E7365744974656D28692C4A534F4E2E737472696E6769667928742E73746F726564537461746529297D66';
wwv_flow_imp.g_varchar2_table(11) := '756E6374696F6E20782874297B696628742E73746F72656453746174653D662874292C21742E737461746553746F726167652972657475726E3B636F6E737420653D742E737461746553746F726167652E6765744974656D2869293B69662865297B7472';
wwv_flow_imp.g_varchar2_table(12) := '797B636F6E7374206E3D4A534F4E2E70617273652865293B69662866756E6374696F6E28742C65297B72657475726E20426F6F6C65616E28652626323D3D3D652E76657273696F6E2626652E696E697469616C6C79457870616E6465643D3D3D742E6F70';
wwv_flow_imp.g_varchar2_table(13) := '74696F6E732E696E697469616C6C79457870616E6465642626652E7374617465732626226F626A656374223D3D747970656F6620652E73746174657326262141727261792E6973417272617928652E73746174657329297D28742C6E292972657475726E';
wwv_flow_imp.g_varchar2_table(14) := '20766F696428742E73746F72656453746174653D6E297D63617463687B7D742E73746F72656453746174653D662874292C682874297D656C736520682874297D66756E6374696F6E20622874297B72657475726E20742E636C6F73657374282274722229';
wwv_flow_imp.g_varchar2_table(15) := '2E6E657874556E74696C286074723A68617328247B617D2960297D66756E6374696F6E20532874297B636F6E737420653D742E636C6F6E6528293B652E66696E642873292E72656D6F766528293B636F6E7374206E3D652E7465787428292E7265706C61';
wwv_flow_imp.g_varchar2_table(16) := '6365282F5C732B2F672C222022292E7472696D28293B72657475726E206E3F66756E6374696F6E2874297B6C657420653D323136363133363236313B666F72286C6574206E3D303B6E3C742E6C656E6774683B6E2B3D3129655E3D742E63686172436F64';
wwv_flow_imp.g_varchar2_table(17) := '654174286E292C653D4D6174682E696D756C28652C3136373737363139293B72657475726E28653E3E3E30292E746F537472696E67283136297D286E293A22227D66756E6374696F6E20492874297B72657475726E20537472696E672874292E7265706C';
wwv_flow_imp.g_varchar2_table(18) := '616365282F5B5E412D5A612D7A302D395F2D5D2F672C225F22297D66756E6374696F6E206D28652C6E2C72297B636F6E7374206F3D66756E6374696F6E2865297B6C6574206E3D652E6368696C6472656E28222E69722D636F6E74726F6C2D627265616B';
wwv_flow_imp.g_varchar2_table(19) := '2D68656164657222292E666972737428293B6966286E2E6C656E6774682972657475726E206E3B636F6E737420723D652E6368696C6472656E2873292E666972737428292E64657461636828292C6F3D7428223C7370616E3E222C7B636C6173733A2269';
wwv_flow_imp.g_varchar2_table(20) := '722D636F6E74726F6C2D627265616B2D74657874227D293B72657475726E206F2E617070656E6428652E636F6E74656E74732829292C6E3D7428223C7370616E3E222C7B636C6173733A2269722D636F6E74726F6C2D627265616B2D686561646572227D';
wwv_flow_imp.g_varchar2_table(21) := '292C6E2E617070656E64286F292C722E6C656E67746826266E2E617070656E642872292C652E617070656E64286E292C6E7D286E293B6C657420693D6F2E6368696C6472656E2873292E666972737428293B692E6C656E6774687C7C28693D7428223C62';
wwv_flow_imp.g_varchar2_table(22) := '7574746F6E3E222C7B747970653A22627574746F6E227D29293B6C657420613D692E6368696C6472656E2863293B612E6C656E6774687C7C28613D7428223C7370616E3E222C7B22617269612D68696464656E223A2274727565222C636C6173733A2274';
wwv_flow_imp.g_varchar2_table(23) := '2D49636F6E2066612069722D636F6E74726F6C2D627265616B2D69636F6E227D292C692E617070656E64286129292C692E617474722822636C617373222C60247B652E6F7074696F6E732E627574746F6E437373436C61737365737D2069722D636F6E74';
wwv_flow_imp.g_varchar2_table(24) := '726F6C2D627265616B2D62746E602E7472696D2829292C6F2E746F67676C65436C617373282269722D636F6E74726F6C2D627265616B2D6865616465722D2D7374617274222C225354415254223D3D3D652E6F7074696F6E732E627574746F6E506F7369';
wwv_flow_imp.g_varchar2_table(25) := '74696F6E292E746F67676C65436C617373282269722D636F6E74726F6C2D627265616B2D6865616465722D2D656E64222C22454E44223D3D3D652E6F7074696F6E732E627574746F6E506F736974696F6E292C22454E44223D3D3D652E6F7074696F6E73';
wwv_flow_imp.g_varchar2_table(26) := '2E627574746F6E506F736974696F6E3F6F2E617070656E642869293A6F2E70726570656E642869293B636F6E7374206C3D66756E6374696F6E28652C6E2C72297B636F6E7374206F3D62286E292C693D5B5D2C613D6E2E617474722822696422292C733D';
wwv_flow_imp.g_varchar2_table(27) := '4928652E726567696F6E49647C7C22697222292C633D4928617C7C6067726F75705F247B722B317D60293B72657475726E206F2E656163682866756E6374696F6E2865297B636F6E7374206E3D742874686973293B6C657420723D6E2E61747472282269';
wwv_flow_imp.g_varchar2_table(28) := '6422293B6966282172297B636F6E737420743D60247B737D5F63625F247B637D5F726F775F247B652B317D603B723D743B6C6574206F3D323B666F72283B646F63756D656E742E676574456C656D656E74427949642872292626646F63756D656E742E67';
wwv_flow_imp.g_varchar2_table(29) := '6574456C656D656E7442794964287229213D3D746869733B29723D60247B747D5F247B6F7D602C6F2B3D313B6E2E6174747228226964222C72297D692E707573682872297D292C697D28652C6E2C72293B72657475726E206C2E6C656E6774683F692E61';
wwv_flow_imp.g_varchar2_table(30) := '7474722822617269612D636F6E74726F6C73222C6C2E6A6F696E2822202229293A692E72656D6F7665417474722822617269612D636F6E74726F6C7322292C697D66756E6374696F6E204528742C652C6E2C72297B636F6E7374206F3D7B726567696F6E';
wwv_flow_imp.g_varchar2_table(31) := '49643A742E726567696F6E49642C6865616465724964733A652C657870616E6465643A6E2C736F757263653A727D3B617065782E64656275672E696E666F28742E706C7567696E4E616D652C2254726967676572696E67206576656E743A222C752C2245';
wwv_flow_imp.g_varchar2_table(32) := '76656E7420446174613A222C6F292C617065782E6576656E742E7472696767657228742E726567696F6E242C752C6F297D66756E6374696F6E204128742C652C6E2C722C6F297B636F6E737420693D652E66696E642873292E666972737428292C613D22';
wwv_flow_imp.g_varchar2_table(33) := '74727565223D3D3D692E617474722822617269612D657870616E64656422292C6C3D532865292C753D652E617474722822696422293B2166756E6374696F6E28742C652C6E297B636F6E737420723D6E3F742E6F7074696F6E732E636F6C6C6170736554';
wwv_flow_imp.g_varchar2_table(34) := '69746C653A742E6F7074696F6E732E657870616E645469746C652C6F3D6E3F742E6F7074696F6E732E636F6C6C6170736549636F6E3A742E6F7074696F6E732E657870616E6449636F6E3B652E61747472287B7469746C653A722C22617269612D6C6162';
wwv_flow_imp.g_varchar2_table(35) := '656C223A722C22617269612D657870616E646564223A6E2E746F537472696E6728297D292C652E6368696C6472656E2863292E72656D6F7665436C6173732860247B742E6F7074696F6E732E636F6C6C6170736549636F6E7D20247B742E6F7074696F6E';
wwv_flow_imp.g_varchar2_table(36) := '732E657870616E6449636F6E7D60292E616464436C617373286F297D28742C692C6E292C622865292E746F67676C65286E292C722626742E737461746553746F7261676526266C262628742E73746F72656453746174652E7374617465735B6C5D3D6E29';
wwv_flow_imp.g_varchar2_table(37) := '3B636F6E737420673D61213D3D6E3B72657475726E206726266F26264528742C753F5B755D3A5B5D2C6E2C6F292C677D66756E6374696F6E20792874297B72657475726E20742E726567696F6E242E66696E642861297D66756E6374696F6E206B28652C';
wwv_flow_imp.g_varchar2_table(38) := '6F297B636F6E737420693D6F7C7C722C613D66756E6374696F6E28652C6E297B636F6E7374206F3D642865293B72657475726E206F2E6C656E6774683E312626617065782E64656275672E7761726E286E7C7C722C224578706563746564206F6E652072';
wwv_flow_imp.g_varchar2_table(39) := '6567696F6E20627574206D756C7469706C6520726567696F6E73206D6174636865643A222C6F2E6C656E677468292C313D3D3D6F2E6C656E6774683F6F3A7428297D28652C69293B69662821612E6C656E6774682972657475726E20617065782E646562';
wwv_flow_imp.g_varchar2_table(40) := '75672E6572726F7228692C225075626C6963204150492063616C6C2072657175697265732065786163746C79206F6E6520726567696F6E2E222C65292C6E756C6C3B636F6E737420733D6E2E67657428615B305D293B72657475726E20737C7C28617065';
wwv_flow_imp.g_varchar2_table(41) := '782E64656275672E7761726E28692C22526567696F6E20686173206E6F74206265656E20696E697469616C697A65642E222C615B305D292C6E756C6C297D66756E6374696F6E205F28652C722C6F297B636F6E737420693D742865292E66697273742829';
wwv_flow_imp.g_varchar2_table(42) := '3B69662821692E6C656E6774682972657475726E20617065782E64656275672E6572726F72286F2C22556E61626C6520746F20696E697469616C697A6520726567696F6E2E222C65292C21313B636F6E737420633D742E657874656E64287B7D2C72293B';
wwv_flow_imp.g_varchar2_table(43) := '632E657870616E6449636F6E7C7C28632E657870616E6449636F6E3D66756E6374696F6E28742C65297B636F6E7374206E3D2272746C223D3D3D742E6373732822646972656374696F6E22293B72657475726E22454E44223D3D3D653F6E3F2266612D63';
wwv_flow_imp.g_varchar2_table(44) := '686576726F6E2D7269676874223A2266612D63686576726F6E2D6C656674223A6E3F2266612D63686576726F6E2D6C656674223A2266612D63686576726F6E2D7269676874227D28692C632E627574746F6E506F736974696F6E29293B636F6E73742075';
wwv_flow_imp.g_varchar2_table(45) := '3D692E617474722822696422292C673D7B726567696F6E243A692C726567696F6E49643A752C706C7567696E4E616D653A6F2C6F7074696F6E733A632C737461746553746F726167653A7028752C632E72656D656D62657253746174652C6F292C73746F';
wwv_flow_imp.g_varchar2_table(46) := '72656453746174653A6E756C6C7D3B72657475726E20782867292C6E2E73657428695B305D2C67292C66756E6374696F6E2865297B652E726567696F6E242E6F6666286C292E6F6E286C2C732C66756E6374696F6E28297B636F6E7374206E3D74287468';
wwv_flow_imp.g_varchar2_table(47) := '6973292C723D6E2E636C6F736573742861292C6F3D2274727565223D3D3D6E2E617474722822617269612D657870616E64656422293B4128652C722C216F2C21302C225553455222292C682865297D297D2867292C66756E6374696F6E2865297B636F6E';
wwv_flow_imp.g_varchar2_table(48) := '7374206E3D792865293B6E2E6C656E6774683F6E2E656163682866756E6374696F6E286E297B636F6E737420723D742874686973292C6F3D532872293B6C657420693D652E6F7074696F6E732E696E697469616C6C79457870616E6465643B652E737461';
wwv_flow_imp.g_varchar2_table(49) := '746553746F7261676526266F26264F626A6563742E70726F746F747970652E6861734F776E50726F70657274792E63616C6C28652E73746F72656453746174652E7374617465732C6F29262628693D652E73746F72656453746174652E7374617465735B';
wwv_flow_imp.g_varchar2_table(50) := '6F5D292C6D28652C722C6E292C4128652C722C692C21312C6E756C6C297D293A617065782E64656275672E696E666F28652E706C7567696E4E616D652C224E6F20636F6E74726F6C2D627265616B2067726F75707320666F756E6420696E20726567696F';
wwv_flow_imp.g_varchar2_table(51) := '6E3A222C652E726567696F6E4964297D2867292C617065782E64656275672E696E666F286F2C22496E697469616C697A656420726567696F6E3A222C75292C21307D66756E6374696F6E207628652C6E2C722C6F297B636F6E737420693D6B28652C6F29';
wwv_flow_imp.g_varchar2_table(52) := '3B69662821692972657475726E21313B636F6E737420613D5B5D3B6C657420733D21313B72657475726E20792869292E656163682866756E6374696F6E2865297B636F6E737420723D742874686973293B6D28692C722C65293B6966284128692C722C6E';
wwv_flow_imp.g_varchar2_table(53) := '2C21302C6E756C6C29297B733D21303B636F6E737420743D722E617474722822696422293B742626612E707573682874297D7D292C682869292C7326264528692C612C6E2C72292C21307D652E69722E636F6E74726F6C427265616B546F67676C65723D';
wwv_flow_imp.g_varchar2_table(54) := '7B696E69743A66756E6374696F6E28742C652C6E297B636F6E7374206F3D6E7C7C722C693D642874293B69662821692E6C656E6774682972657475726E20617065782E64656275672E6572726F72286F2C22496E697469616C697A6174696F6E20746172';
wwv_flow_imp.g_varchar2_table(55) := '67657420646964206E6F74207265736F6C766520746F20616E7920726567696F6E732E222C74292C21313B617065782E64656275672E696E666F286F2C22496E697469616C697A696E6720726567696F6E733A222C692E6C656E677468293B6C65742061';
wwv_flow_imp.g_varchar2_table(56) := '3D21313B72657475726E20692E656163682866756E6374696F6E28297B5F28746869732C652C6F29262628613D2130297D292C617D2C657870616E64416C6C3A66756E6374696F6E28742C65297B72657475726E207628742C21302C22455850414E445F';
wwv_flow_imp.g_varchar2_table(57) := '414C4C222C65297D2C636F6C6C61707365416C6C3A66756E6374696F6E28742C65297B72657475726E207628742C21312C22434F4C4C415053455F414C4C222C65297D2C726573657453746174653A66756E6374696F6E28652C6E297B636F6E73742072';
wwv_flow_imp.g_varchar2_table(58) := '3D6B28652C6E293B69662821722972657475726E21313B2166756E6374696F6E2874297B69662821742972657475726E3B636F6E737420653D7B7072656669783A6F2C75736541707049643A21302C7573655061676549643A21302C726567696F6E4964';
wwv_flow_imp.g_varchar2_table(59) := '3A747D3B617065782E73746F726167652E67657453636F70656453657373696F6E53746F726167652865292E72656D6F76654974656D2869292C617065782E73746F726167652E67657453636F7065644C6F63616C53746F726167652865292E72656D6F';
wwv_flow_imp.g_varchar2_table(60) := '76654974656D2869297D28722E726567696F6E4964292C722E73746F72656453746174653D662872293B636F6E737420613D5B5D3B6C657420733D21313B72657475726E20792872292E656163682866756E6374696F6E2865297B636F6E7374206E3D74';
wwv_flow_imp.g_varchar2_table(61) := '2874686973293B6D28722C6E2C65293B6966284128722C6E2C722E6F7074696F6E732E696E697469616C6C79457870616E6465642C21312C6E756C6C29297B733D21303B636F6E737420743D6E2E617474722822696422293B742626612E707573682874';
wwv_flow_imp.g_varchar2_table(62) := '297D7D292C682872292C7326264528722C612C722E6F7074696F6E732E696E697469616C6C79457870616E6465642C22524553455422292C21307D7D2C77696E646F772E6972436F6E74726F6C427265616B546F67676C6572496E69743D28742C6E293D';
wwv_flow_imp.g_varchar2_table(63) := '3E7B636F6E737420723D67286E293B652E69722E636F6E74726F6C427265616B546F67676C65722E696E6974286E2E74726967676572696E67456C656D656E742C742C72297D2C77696E646F772E6972436F6E74726F6C427265616B546F67676C657241';
wwv_flow_imp.g_varchar2_table(64) := '6374696F6E3D286E2C72293D3E7B636F6E7374206F3D672872292C693D652E69722E636F6E74726F6C427265616B546F67676C65722C613D7428722E6166666563746564456C656D656E7473293B69662821612E6C656E6774682972657475726E206170';
wwv_flow_imp.g_varchar2_table(65) := '65782E64656275672E6572726F72286F2C22427574746F6E20416374696F6E20726571756972657320616E20616666656374656420496E746572616374697665205265706F727420726567696F6E2E22292C21313B69662831213D3D612E6C656E677468';
wwv_flow_imp.g_varchar2_table(66) := '2972657475726E20617065782E64656275672E6572726F72286F2C22427574746F6E20416374696F6E2072657175697265732065786163746C79206F6E6520616666656374656420726567696F6E2E204D6174636865643A222C612E6C656E677468292C';
wwv_flow_imp.g_varchar2_table(67) := '21313B73776974636828617065782E64656275672E696E666F286F2C22457865637574696E6720427574746F6E20416374696F6E3A222C6E2E616374696F6E2C615B305D292C6E2E616374696F6E297B6361736522455850414E445F414C4C223A726574';
wwv_flow_imp.g_varchar2_table(68) := '75726E20692E657870616E64416C6C28612C6F293B6361736522434F4C4C415053455F414C4C223A72657475726E20692E636F6C6C61707365416C6C28612C6F293B636173652252455345545F5354415445223A72657475726E20692E72657365745374';
wwv_flow_imp.g_varchar2_table(69) := '61746528612C6F293B64656661756C743A72657475726E20617065782E64656275672E7761726E286F2C22556E737570706F7274656420427574746F6E20416374696F6E3A222C6E2E616374696F6E292C21317D7D7D28617065782E6A51756572792C66';
wwv_flow_imp.g_varchar2_table(70) := '695F6A617269735F706C7567696E293B';
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
