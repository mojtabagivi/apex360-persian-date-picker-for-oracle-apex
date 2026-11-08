prompt --application/set_environment
set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- Oracle APEX export file (APEX 22.1+ compatible build)
--
-- This file is a backward-compatible variant of the APEX 26 plugin export.
-- Adjusted so it can be imported into Oracle APEX 22.X / 23.x / 24.x
-- and 26.x instances.
--
-- Adjustments made vs. the original APEX 26 export:
--   * p_version_yyyy_mm_dd lowered from '2026.03.30' to '2022.04.12'
--   * p_release             lowered from '24.1.0'    to '22.1.0'
--   * Removed p_apexlang_name parameters (not present in APEX 22.1)
--   * Removed p_static_id     parameters from plugin attributes
--   * Removed p_version_scn   parameter from the plugin definition
--
-- You should run this script using a SQL client connected to the database as
-- the owner (parsing schema) of the application or as a database user with
-- the APEX_ADMINISTRATOR_ROLE role.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
wwv_flow_imp.import_begin (
 p_version_yyyy_mm_dd=>'2022.04.12'
,p_release=>'22.1.0'
,p_default_workspace_id=>3600412333796893
,p_default_application_id=>102
,p_default_id_offset=>0
,p_default_owner=>'APEX360'
);
end;
/
 
prompt APPLICATION 102 - persian date picker (APEX 22.1+ compatible)
--
-- Application Export:
--   Application:     102
--   Name:            persian date picker
--   Original Build:  Oracle APEX 26 (export dated 2026.03.30)
--   Compatible With: Oracle APEX 22.1, 22.2, 23.x, 24.x and 26.x
--   Export Type:     Component Export
--   Manifest
--     PLUGIN: 438448083865680986
--   Manifest End
--   Version:         22.1.0
--   Instance ID:     2200103291828121
--

begin
  -- replace components
  wwv_flow_imp.g_mode := 'REPLACE';
end;
/
prompt --application/shared_components/plugins/item_type/ir_apex360_datetimepicker
begin
wwv_flow_imp_shared.create_plugin(
 p_id=>wwv_flow_imp.id(438448083865680986)
,p_plugin_type=>'ITEM TYPE'
,p_name=>'IR.APEX360.DATETIMEPICKER'
,p_display_name=>'APEX360 Persian Jalali DateTimePicker'
,p_supported_component_types=>'APEX_APPLICATION_PAGE_ITEMS:APEX_APPL_PAGE_IG_COLUMNS'
,p_javascript_file_urls=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#PLUGIN_FILES#jalalidatepicker.js',
''))
,p_css_file_urls=>'#PLUGIN_FILES#jalalidatepicker.css'
,p_plsql_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'-- Persian Datepicker for Oracle APEX',
'-- Author: Mojtaba Haji Aligholi Givi',
'-- Website: https://apex360.ir',
'-- Copyright (c) 2026. All rights reserved.',
'',
'procedure RENDER_JDP(',
'    p_item   in apex_plugin.t_item,',
'    p_plugin in apex_plugin.t_plugin,',
'    p_param  in apex_plugin.t_item_render_param,',
'    p_result in out nocopy apex_plugin.t_item_render_result',
') IS',
'    r_item01 varchar2(4000) := p_item.attribute_01;',
'    r_item02 varchar2(4000) := p_item.attribute_02;',
'    r_item03 varchar2(4000) := p_item.attribute_03;',
'    r_item04 varchar2(4000) := p_item.attribute_04;',
'    r_item05 varchar2(4000) := p_item.attribute_05;',
'    r_item06 varchar2(4000) := p_item.attribute_06;',
'    r_item07 varchar2(4000) := p_item.attribute_07;',
'    r_item08 varchar2(4000) := p_item.attribute_08;',
'    r_item09 varchar2(4000) := p_item.attribute_09;',
'    r_item10 varchar2(4000) := p_item.attribute_10;',
'    r_item11 varchar2(4000) := p_item.attribute_11;',
'    r_item12 varchar2(4000) := p_item.attribute_12;',
'    r_item13 varchar2(4000) := p_item.attribute_13;',
'    r_item14 varchar2(4000) := p_item.attribute_14;',
'    r_item15 varchar2(4000) := p_item.attribute_15;',
'',
'    r_app01 varchar2(4000) := p_plugin.attribute_01;',
'    r_app02 varchar2(4000) := p_plugin.attribute_02;',
'    r_app03 varchar2(4000) := p_plugin.attribute_03;',
'    r_app04 varchar2(4000) := p_plugin.attribute_04;',
'    r_app05 varchar2(4000) := p_plugin.attribute_05;',
'    r_app06 varchar2(4000) := p_plugin.attribute_06;',
'    r_app07 varchar2(4000) := p_plugin.attribute_07;',
'    r_app08 varchar2(4000) := p_plugin.attribute_08;',
'    r_app09 varchar2(4000) := p_plugin.attribute_09;',
'    r_app10 varchar2(4000) := p_plugin.attribute_10;',
'    r_app11 varchar2(4000) := p_plugin.attribute_11;',
'    r_app12 varchar2(4000) := p_plugin.attribute_12;   -- calendar color',
'    r_app13 varchar2(4000) := p_plugin.attribute_13;   -- theme mode',
'',
'    v_show_time           varchar2(1);',
'    v_show_seconds        varchar2(1);',
'    v_show_calendar_icon  varchar2(1);',
'    v_show_today_btn      varchar2(1);  ',
'    v_show_empty_btn      varchar2(1);',
'    v_min_date            varchar2(10);',
'    v_min_date_item       varchar2(255);',
'    v_min_date_static     varchar2(50);',
'    v_min_date_val        varchar2(50);',
'    v_max_date            varchar2(10);',
'    v_max_date_item       varchar2(255);',
'    v_max_date_static     varchar2(50);',
'    v_max_date_val        varchar2(50);',
'    v_min_time            varchar2(8);',
'    v_min_time_item       varchar2(255);',
'    v_min_time_static     varchar2(50);',
'    v_min_time_val        varchar2(50);',
'    v_max_time            varchar2(8);',
'    v_max_time_item       varchar2(255);',
'    v_max_time_static     varchar2(50);',
'    v_max_time_val        varchar2(50);',
'',
'    v_persian_digits   varchar2(50);',
'    v_date_sep         varchar2(20);',
'    v_time_sep         varchar2(20);',
'    v_between_sep      varchar2(20);',
'    v_use_dropdown_for_year varchar2(1);',
'    v_position         varchar2(10);',
'    v_hour_inc         varchar2(20);',
'    v_minute_inc       varchar2(20);',
'    v_color            varchar2(20);',
'    v_theme            varchar2(10);',
'',
'    v_mode          varchar2(1);            -- D = date, T = date+HH:MI, S = date+HH:MI:SS',
'    v_raw           varchar2(4000) := p_param.value;',
'    v_y   varchar2(10);  v_mo  varchar2(10);  v_d  varchar2(10);',
'    v_h   varchar2(10) := ''0'';  v_mi varchar2(10) := ''0'';  v_s varchar2(10) := ''0'';',
'    v_canon         varchar2(30)  := '''';            -- always YYYY/MM/DD HH24:MI:SS',
'    v_orig_time     varchar2(8)   := ''00:00:00'';',
'    v_display       varchar2(100) := '''';',
'    v_disp_id       varchar2(300) := p_item.name || ''_DISPLAY'';',
'',
'    v_dmy           boolean := false;               -- numeric short date order of the session (DMY / MDY)',
'    v_probe         varchar2(100);',
'    v_n1 varchar2(20); v_n2 varchar2(20); v_n3 varchar2(20);',
'    v_data_attrs    varchar2(4000) := '''';',
'    v_icon_html     varchar2(4000) := '''';',
'    v_html          varchar2(32767);',
'',
'    function get_part(p_str in varchar2, p_idx in pls_integer) return varchar2 is',
'    begin',
'        if p_str is null then return null; end if;',
'        return regexp_substr(p_str || ''|'', ''(.*?)\|'', 1, p_idx, null, 1);',
'    end get_part;',
'',
'    function yn(p_val in varchar2, p_default in varchar2) return varchar2 is',
'    begin',
'        if p_val is null then return p_default; end if;',
'        if trim(p_val) is null then return p_default; end if;',
'        if upper(trim(substr(p_val,1,5))) in (''N'',''NO'',''FALSE'',''0'',''OFF'') then',
'            return ''N'';',
'        end if;',
'        return ''Y'';',
'    end yn;',
'',
'    function yn_to_js(p_val in varchar2) return varchar2 is',
'    begin',
'        if p_val = ''Y'' then return ''true''; else return ''false''; end if;',
'    end yn_to_js;',
'',
'    function js_str(p_val in varchar2) return varchar2 is',
'    begin',
'        if p_val is null then return ''null''; end if;',
'        return ''"'' || replace(replace(replace(p_val, ''\'', ''\\''), ''"'', ''\"''), chr(10), ''\n'') || ''"'';',
'    end js_str;',
'BEGIN',
'    -- ---------- component attributes ----------',
'    v_show_time          := yn(r_item01, ''N'');',
'    v_show_seconds       := yn(r_item02, ''N'');',
'    v_show_calendar_icon := yn(r_item03, ''Y'');',
'    v_min_date        := nvl(r_item04, ''none'');',
'    v_min_date_item   := trim(r_item05);',
'    v_min_date_static := trim(r_item06);',
'    v_max_date        := nvl(r_item07, ''none'');',
'    v_max_date_item   := trim(r_item08);',
'    v_max_date_static := trim(r_item09);',
'    v_min_time        := nvl(r_item10, ''none'');',
'    v_min_time_item   := trim(r_item11);',
'    v_min_time_static := trim(r_item12);',
'    v_max_time        := nvl(r_item13, ''none'');',
'    v_max_time_item   := trim(r_item14);',
'    v_max_time_static := trim(r_item15);',
'',
'    -- ---------- application attributes ----------',
'    v_persian_digits := yn_to_js(yn(r_app01, ''Y''));',
'    v_date_sep    := coalesce(nullif(trim(r_app02), ''''), ''/'');',
'    v_time_sep    := coalesce(nullif(trim(r_app03), ''''), '':'');',
'    v_between_sep := coalesce(nullif(r_app04, ''''), '' '');',
'    v_show_today_btn:=yn(r_app05, ''Y''); ',
'    v_show_empty_btn:=yn(r_app06, ''Y''); ',
'    v_use_dropdown_for_year := yn(get_part(r_app08, 1), ''Y'');',
'    v_position    := lower(substr(coalesce(nullif(trim(r_app09), ''''), ''left''), 1, 10));',
'    v_hour_inc    := coalesce(nullif(trim(r_app10), ''''), ''1'');',
'    v_minute_inc  := coalesce(nullif(trim(r_app11), ''''), ''1'');',
'    v_color       := trim(r_app12);',
'    if v_color is null or not regexp_like(v_color, ''^#([0-9A-Fa-f]{3,4}|[0-9A-Fa-f]{6}|[0-9A-Fa-f]{8})$'') then',
'        v_color := null;',
'    end if;',
'    v_theme       := lower(coalesce(trim(r_app13), ''auto''));',
'    if v_theme not in (''auto'', ''light'', ''dark'') then v_theme := ''auto''; end if;',
'',
'    -- ---------- mode ----------',
'    if v_show_time = ''Y'' then',
'        if v_show_seconds = ''Y'' then v_mode := ''S''; else v_mode := ''T''; end if;',
'    else',
'        v_mode := ''D'';',
'    end if;',
'',
'    -- ---------- parse incoming value ----------',
'    -- APEX hands over the value formatted with the application date format',
'    -- (e.g. DS => 8/13/1405). Detect year position and day/month order.',
'    begin',
'        v_probe := to_char(date ''2001-03-24'', ''DS'',',
'                           ''NLS_CALENDAR=GREGORIAN NLS_DATE_LANGUAGE=ENGLISH'');',
'        if regexp_substr(v_probe, ''\d+'', 1, 1) = ''24'' then v_dmy := true; end if;',
'    exception when others then',
'        v_dmy := false;',
'    end;',
'',
'    if v_raw is not null then',
'        v_raw := translate(v_raw, unistr(''\06F0\06F1\06F2\06F3\06F4\06F5\06F6\06F7\06F8\06F9''), ''0123456789'');',
'        v_n1 := regexp_substr(v_raw, ''\d+'', 1, 1);',
'        v_n2 := regexp_substr(v_raw, ''\d+'', 1, 2);',
'        v_n3 := regexp_substr(v_raw, ''\d+'', 1, 3);',
'        v_h  := nvl(regexp_substr(v_raw, ''\d+'', 1, 4), ''0'');',
'        v_mi := nvl(regexp_substr(v_raw, ''\d+'', 1, 5), ''0'');',
'        v_s  := nvl(regexp_substr(v_raw, ''\d+'', 1, 6), ''0'');',
'        if v_n3 is not null then',
'            if length(v_n1) >= 3 then',
'                v_y := v_n1; v_mo := v_n2; v_d := v_n3;',
'            else',
'                if length(v_n3) >= 3 then',
'                    v_y := v_n3;',
'                else',
'                    v_y := to_char(case when to_number(v_n3) >= 70 then 1300 else 1400 end + to_number(v_n3));',
'                end if;',
'                if v_dmy then v_d := v_n1; v_mo := v_n2;',
'                else          v_mo := v_n1; v_d := v_n2;',
'                end if;',
'            end if;',
'        end if;',
'    end if;',
'',
'    if v_y is not null and v_mo is not null and v_d is not null then',
'        v_orig_time := lpad(v_h,2,''0'') || '':'' || lpad(v_mi,2,''0'') || '':'' || lpad(v_s,2,''0'');',
'        v_canon     := v_y || ''/'' || lpad(v_mo,2,''0'') || ''/'' || lpad(v_d,2,''0'') || '' '' || v_orig_time;',
'',
'        v_display := v_y || v_date_sep || lpad(v_mo,2,''0'') || v_date_sep || lpad(v_d,2,''0'');',
'        if v_mode in (''T'',''S'') then',
'            v_display := v_display || v_between_sep || lpad(v_h,2,''0'') || v_time_sep || lpad(v_mi,2,''0'');',
'            if v_mode = ''S'' then',
'                v_display := v_display || v_time_sep || lpad(v_s,2,''0'');',
'            end if;',
'        end if;',
'    end if;',
'',
'    -- ---------- read only ----------',
'    if p_param.is_readonly then',
'        apex_plugin_util.print_display_only(',
'            p_item_name        => p_item.name,',
'            p_display_value    => v_display,',
'            p_show_line_breaks => false,',
'            p_escape           => true,',
'            p_attributes       => p_item.element_attributes',
'        );',
'        return;',
'    end if;',
'',
'    -- ---------- global startWatch (once per page) ----------',
'    apex_javascript.add_inline_code(',
'        p_code =>',
'            ''$(function(){ jalaliDatepicker.startWatch({'' ||',
'            ''hasSecond:"attr",minDate:"attr",maxDate:"attr",minTime:"attr",maxTime:"attr",'' ||',
'            ''date:true,time:true,'' ||',
'            ''showTodayBtn:''||yn_to_js(v_show_today_btn)||'',''||',
'            ''showEmptyBtn:''||yn_to_js(v_show_empty_btn)||'',''||',
'            ''showSelectTimeBtnAlways:true,''||',
'            ''confirmButton:true,''||',
'            ''persianDigits:'' || v_persian_digits || '','' ||',
'            ''separatorChars:{date:'' || js_str(v_date_sep) ||',
'                '',between:'' || js_str(v_between_sep) ||',
'                '',time:'' || js_str(v_time_sep) || ''},'' ||',
'            ''useDropdownYears:'' || yn_to_js(v_use_dropdown_for_year) || '','' ||',
'            ''position:'' || js_str(v_position) || '','' ||',
'            ''primaryColor:'' || js_str(v_color) || '','' ||',
'            ''themeMode:'' || js_str(v_theme) || '','' ||',
'            ''minuteIncrement:'' || v_minute_inc || '','' ||',
'            ''hourIncrement:'' || v_hour_inc ||',
'            ''}); });'',',
'        p_key => ''JDP_GLOBAL_INIT''',
'    );',
'',
'    -- ---------- per item data attributes ----------',
'    if v_mode = ''D'' then',
'        v_data_attrs := v_data_attrs || '' data-jdp-only-date'';',
'    end if;',
'    if v_mode = ''S'' then',
'        v_data_attrs := v_data_attrs || '' data-jdp-has-second="true"'';',
'    else',
'        v_data_attrs := v_data_attrs || '' data-jdp-has-second="false"'';',
'    end if;',
'    v_data_attrs := v_data_attrs || '' data-jdp-orig-time="'' || v_orig_time || ''"'';',
'    v_data_attrs := v_data_attrs || '' data-jdp-date-order="'' || case when v_dmy then ''DMY'' else ''MDY'' end || ''"'';',
'',
'    -- ---------- min / max ----------',
'    if v_min_date = ''static'' then',
'        v_min_date_val := v_min_date_static;',
'    elsif v_min_date = ''item'' then',
'        v_min_date_val := replace(replace(substr(apex_util.get_session_state(v_min_date_item),1,10),''-'',''/''),''.'',''/'');',
'    end if;',
'    if v_max_date = ''static'' then',
'        v_max_date_val := v_max_date_static;',
'    elsif v_max_date = ''item'' then',
'        v_max_date_val := replace(replace(substr(apex_util.get_session_state(v_max_date_item),1,10),''-'',''/''),''.'',''/'');',
'    end if;',
'    if v_min_time = ''static'' then',
'        v_min_time_val := v_min_time_static;',
'    elsif v_min_time = ''item'' then',
'        v_min_time_val := substr(apex_util.get_session_state(v_min_time_item),1,8);',
'    end if;',
'    if v_max_time = ''static'' then',
'        v_max_time_val := v_max_time_static;',
'    elsif v_max_time = ''item'' then',
'        v_max_time_val := substr(apex_util.get_session_state(v_max_time_item),1,8);',
'    end if;',
'',
'    if v_min_date_val is not null then v_data_attrs := v_data_attrs || '' data-jdp-min-date="'' || wwv_flow_escape.html(v_min_date_val) || ''"''; end if;',
'    if v_max_date_val is not null then v_data_attrs := v_data_attrs || '' data-jdp-max-date="'' || wwv_flow_escape.html(v_max_date_val) || ''"''; end if;',
'    if v_mode <> ''D'' then',
'        if v_min_time_val is not null then v_data_attrs := v_data_attrs || '' data-jdp-min-time="'' || wwv_flow_escape.html(v_min_time_val) || ''"''; end if;',
'        if v_max_time_val is not null then v_data_attrs := v_data_attrs || '' data-jdp-max-time="'' || wwv_flow_escape.html(v_max_time_val) || ''"''; end if;',
'    end if;',
'',
'    -- ---------- icon (click is handled globally by the JS library) ----------',
'    if v_show_calendar_icon = ''Y'' then',
'        v_icon_html := ''<button aria-haspopup="dialog" aria-label="Select Date" class="a-Button a-Button--calendar jdp-trigger" tabindex="-1" title="Select Date" type="button"><span class="a-Icon icon-calendar"></span></button>'';',
'    end if;',
'',
'    -- ---------- HTML: hidden (real item) + visible (picker) ----------',
'    v_html :=',
'           ''<input type="hidden" data-jdp-hidden id="'' || p_item.name || ''"''',
'        || '' name="'' || apex_plugin.get_input_name_for_page_item(p_is_multi_value => false) || ''"''',
'        || '' value="'' || wwv_flow_escape.html(v_canon) || ''">''',
'        || ''<input data-jdp type="text"'' || v_data_attrs',
'        || '' id="'' || v_disp_id || ''"''',
'        || '' class="text_field apex-item-text jalili-date"''',
'        || '' autocomplete="off"''',
'   ',
'        || '' aria-labelledby="'' || p_item.name || ''_LABEL"''',
'        || case when p_item.placeholder is not null',
'                then '' placeholder="'' || wwv_flow_escape.html(p_item.placeholder) || ''"'' end',
'        || '' size="'' || nvl(to_char(p_item.element_width), ''30'') || ''"''',
'        || '' maxlength="40"''',
'        || '' '' || p_item.element_attributes',
'        || '' value="'' || wwv_flow_escape.html(v_display) || ''">''',
'        || v_icon_html;',
'    sys.htp.p(v_html);',
'',
'    p_result.is_navigable     := true;',
'    p_result.navigable_dom_id := v_disp_id;',
'END;'))
,p_api_version=>2
,p_render_function=>'RENDER_JDP'
,p_standard_attributes=>'VISIBLE:FORM_ELEMENT:SESSION_STATE:READONLY:ESCAPE_OUTPUT:SOURCE:FORMAT_MASK_DATE:ELEMENT:WIDTH:ELEMENT_OPTION:PLACEHOLDER'
,p_substitute_attributes=>true
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'Persian (Jalali) Datepicker for Oracle APEX',
'Design & Development: Mojtaba Haji Aligholi Givi',
'This plugin has been designed and developed to provide Persian (Jalali) date selection capability in Oracle APEX applications.',
'Custom Plugin Design & Development Orders:',
unistr('\D83C\DF10 https://apex360.ir'),
unistr('\2709\FE0F info@apex360.ir'),
'Contact the Developer:',
'LinkedIn: https://www.linkedin.com/in/mojtaba-aligholi',
'GitHub: https://github.com/mojtabagivi',
'Email: mojtaba.givi@gmail.com',
'Phone: 09123241271',
unistr('Copyright \00A9 2026 Mojtaba Haji Aligholi Givi. All rights reserved.'),
'All intellectual and material rights of this plugin belong to its designer and developer. Any redistribution, reproduction, or use outside the terms of the license requires permission from the copyright owner.'))
,p_version_identifier=>'2.9'
,p_about_url=>'https://Apex360.ir'
,p_files_version=>2461349235246
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(438448083865681086)
,p_plugin_id=>wwv_flow_imp.id(438448083865680986)
,p_attribute_scope=>'APPLICATION'
,p_attribute_sequence=>1
,p_display_sequence=>10
,p_prompt=>'Persian Digits'
,p_attribute_type=>'CHECKBOX'
,p_is_required=>false
,p_default_value=>'Y'
,p_is_translatable=>false
,p_help_text=>'Show Persian (Farsi) digits instead of English digits in the picker and input value.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(438448083865681184)
,p_plugin_id=>wwv_flow_imp.id(438448083865680986)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>1
,p_display_sequence=>91
,p_prompt=>'Show Time'
,p_attribute_type=>'CHECKBOX'
,p_is_required=>true
,p_default_value=>'N'
,p_is_translatable=>false
,p_help_text=>'When Yes it shows date and time together'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(438448083865681087)
,p_plugin_id=>wwv_flow_imp.id(438448083865680986)
,p_attribute_scope=>'APPLICATION'
,p_attribute_sequence=>2
,p_display_sequence=>20
,p_prompt=>'Date Separator'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_default_value=>'/'
,p_display_length=>15
,p_max_length=>5
,p_is_translatable=>false
,p_help_text=>'Character(s) separating year, month, day. Default: /  ->  1404/01/15'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(438448083865681185)
,p_plugin_id=>wwv_flow_imp.id(438448083865680986)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>2
,p_display_sequence=>92
,p_prompt=>'Show Seconds In Time'
,p_attribute_type=>'CHECKBOX'
,p_is_required=>false
,p_default_value=>'N'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(438448083865681184)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'Y'
,p_help_text=>'When Yes, time includes seconds (HH:MI:SS). Default No => HH:MI. Only applies when time is shown.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(438448083865681088)
,p_plugin_id=>wwv_flow_imp.id(438448083865680986)
,p_attribute_scope=>'APPLICATION'
,p_attribute_sequence=>3
,p_display_sequence=>30
,p_prompt=>'Time Separator'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_default_value=>':'
,p_max_length=>5
,p_display_length=>15
,p_is_translatable=>false
,p_help_text=>'Character(s) separating hour, minute, second. Default: :  ->  14:30'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(438448083865681186)
,p_plugin_id=>wwv_flow_imp.id(438448083865680986)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>3
,p_display_sequence=>30
,p_prompt=>'Show Calendar Icon'
,p_attribute_type=>'CHECKBOX'
,p_is_required=>false
,p_default_value=>'Y'
,p_is_translatable=>false
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(438448083865681089)
,p_plugin_id=>wwv_flow_imp.id(438448083865680986)
,p_attribute_scope=>'APPLICATION'
,p_attribute_sequence=>4
,p_display_sequence=>40
,p_prompt=>'Between Separator (Date & Time)'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_default_value=>' '
,p_max_length=>5
,p_display_length=>15
,p_is_translatable=>false
,p_help_text=>'Character(s) between date and time parts. Default: space  ->  1404/01/15 14:30'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(438448083865681187)
,p_plugin_id=>wwv_flow_imp.id(438448083865680986)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>4
,p_display_sequence=>40
,p_prompt=>'Min Date'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'none'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
,p_help_text=>'Minimum selectable Persian date, e.g. 1404/01/01. Item = read from a page item at runtime. Static = a fixed date value.'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(15438448083865681187)
,p_plugin_attribute_id=>wwv_flow_imp.id(438448083865681187)
,p_display_sequence=>20
,p_display_value=>'Item'
,p_return_value=>'item'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(15438448083865681188)
,p_plugin_attribute_id=>wwv_flow_imp.id(438448083865681187)
,p_display_sequence=>10
,p_display_value=>'None'
,p_return_value=>'none'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(15438448083865681189)
,p_plugin_attribute_id=>wwv_flow_imp.id(438448083865681187)
,p_display_sequence=>30
,p_display_value=>'Static'
,p_return_value=>'static'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(438448083865681090)
,p_plugin_id=>wwv_flow_imp.id(438448083865680986)
,p_attribute_scope=>'APPLICATION'
,p_attribute_sequence=>5
,p_display_sequence=>50
,p_prompt=>'Show Today Button'
,p_attribute_type=>'CHECKBOX'
,p_is_required=>false
,p_default_value=>'Y'
,p_is_translatable=>false
,p_help_text=>'Show the "Today" button in the picker footer.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(438448083865681188)
,p_plugin_id=>wwv_flow_imp.id(438448083865680986)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>5
,p_display_sequence=>50
,p_prompt=>'Min Date Item'
,p_attribute_type=>'PAGE ITEM'
,p_is_required=>true
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(438448083865681187)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'item'
,p_help_text=>'The item that determines the minimum allowed value. This must be a page item that is either on the current, or global page.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(438448083865681091)
,p_plugin_id=>wwv_flow_imp.id(438448083865680986)
,p_attribute_scope=>'APPLICATION'
,p_attribute_sequence=>6
,p_display_sequence=>60
,p_prompt=>'Show Empty Button'
,p_attribute_type=>'CHECKBOX'
,p_is_required=>false
,p_default_value=>'Y'
,p_is_translatable=>false
,p_help_text=>'Show the "Empty" button to clear the input value.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(438448083865681189)
,p_plugin_id=>wwv_flow_imp.id(438448083865680986)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>6
,p_display_sequence=>60
,p_prompt=>'Min Date Static'
,p_attribute_type=>'TEXT'
,p_is_required=>true
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(438448083865681187)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'static'
,p_help_text=>'Earliest date in Return Format, e.g. 1400/01/01. Applies to calendar and manual input. You may also use a page item substitution (e.g. &P1_DATE.) to supply the value dynamically.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(438448083865681092)
,p_plugin_id=>wwv_flow_imp.id(438448083865680986)
,p_attribute_scope=>'APPLICATION'
,p_attribute_sequence=>7
,p_display_sequence=>70
,p_prompt=>'Show Close Button'
,p_attribute_type=>'CHECKBOX'
,p_is_required=>false
,p_default_value=>'Y'
,p_is_translatable=>false
,p_help_text=>'Show the "Close" button. On mobile it shows by default.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(438448083865681104)
,p_plugin_id=>wwv_flow_imp.id(438448083865680986)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>7
,p_display_sequence=>70
,p_prompt=>'Max Date'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'none'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
,p_help_text=>'Maximum selectable Persian date, e.g. 1404/12/29. Can also be a CSS selector or "today".'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(438448083865681105)
,p_plugin_attribute_id=>wwv_flow_imp.id(438448083865681104)
,p_display_sequence=>20
,p_display_value=>'Item'
,p_return_value=>'item'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(438448083865681106)
,p_plugin_attribute_id=>wwv_flow_imp.id(438448083865681104)
,p_display_sequence=>10
,p_display_value=>'None'
,p_return_value=>'none'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(438448083865681107)
,p_plugin_attribute_id=>wwv_flow_imp.id(438448083865681104)
,p_display_sequence=>30
,p_display_value=>'Static'
,p_return_value=>'static'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(438448083865681094)
,p_plugin_id=>wwv_flow_imp.id(438448083865680986)
,p_attribute_scope=>'APPLICATION'
,p_attribute_sequence=>8
,p_display_sequence=>80
,p_prompt=>'Use Dropdown for Years'
,p_attribute_type=>'CHECKBOX'
,p_is_required=>false
,p_default_value=>'Y'
,p_is_translatable=>false
,p_help_text=>'When Yes, useDropdownYears . when No, changeMonthRotateYear.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(438448083865681108)
,p_plugin_id=>wwv_flow_imp.id(438448083865680986)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>8
,p_display_sequence=>80
,p_prompt=>'Max Date Item'
,p_attribute_type=>'PAGE ITEM'
,p_is_required=>true
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(438448083865681104)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'item'
,p_help_text=>'The item that determines the maximum allowed value. This must be a page item that is either on the current, or global page.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(438448083865681095)
,p_plugin_id=>wwv_flow_imp.id(438448083865680986)
,p_attribute_scope=>'APPLICATION'
,p_attribute_sequence=>9
,p_display_sequence=>90
,p_prompt=>'Calender Position'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>false
,p_default_value=>'left'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(438448083865681098)
,p_plugin_attribute_id=>wwv_flow_imp.id(438448083865681095)
,p_display_sequence=>30
,p_display_value=>'Center'
,p_return_value=>'center'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(438448083865681096)
,p_plugin_attribute_id=>wwv_flow_imp.id(438448083865681095)
,p_display_sequence=>10
,p_display_value=>'Left'
,p_return_value=>'left'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(438448083865681097)
,p_plugin_attribute_id=>wwv_flow_imp.id(438448083865681095)
,p_display_sequence=>20
,p_display_value=>'Right'
,p_return_value=>'right'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(438448083865681109)
,p_plugin_id=>wwv_flow_imp.id(438448083865680986)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>9
,p_display_sequence=>90
,p_prompt=>'Max Date Static'
,p_attribute_type=>'TEXT'
,p_is_required=>true
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(438448083865681104)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'static'
,p_help_text=>'Latest date in Return Format, e.g. 1410/12/29. Applies to calendar and manual input. You may also use a page item substitution (e.g. &P1_DATE.) to supply the value dynamically.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(438448083865681101)
,p_plugin_id=>wwv_flow_imp.id(438448083865680986)
,p_attribute_scope=>'APPLICATION'
,p_attribute_sequence=>10
,p_display_sequence=>100
,p_prompt=>'Time Increments (hour)'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_default_value=>'1'
,p_max_length=>20
,p_display_length=>15
,p_is_translatable=>false
,p_help_text=>'hourIncrement. Default: 1'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(438448083865681194)
,p_plugin_id=>wwv_flow_imp.id(438448083865680986)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>10
,p_display_sequence=>100
,p_prompt=>'Min Time'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'none'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(438448083865681184)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'Y'
,p_lov_type=>'STATIC'
,p_help_text=>'Minimum selectable time, e.g. 08:00 or 08:00:00. Can also be a CSS selector to another input.'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(438448083865681108)
,p_plugin_attribute_id=>wwv_flow_imp.id(438448083865681194)
,p_display_sequence=>20
,p_display_value=>'Item'
,p_return_value=>'item'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(438448083865681109)
,p_plugin_attribute_id=>wwv_flow_imp.id(438448083865681194)
,p_display_sequence=>10
,p_display_value=>'None'
,p_return_value=>'none'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(438448083865681110)
,p_plugin_attribute_id=>wwv_flow_imp.id(438448083865681194)
,p_display_sequence=>30
,p_display_value=>'Static'
,p_return_value=>'static'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(438448083865681102)
,p_plugin_id=>wwv_flow_imp.id(438448083865680986)
,p_attribute_scope=>'APPLICATION'
,p_attribute_sequence=>11
,p_display_sequence=>110
,p_prompt=>'Time Increments (minute)'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_default_value=>'1'
,p_max_length=>20
,p_display_length=>15
,p_is_translatable=>false
,p_help_text=>' minuteIncrement. Default: 1'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(438448083865681111)
,p_plugin_id=>wwv_flow_imp.id(438448083865680986)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>11
,p_display_sequence=>110
,p_prompt=>'Min Time Item'
,p_attribute_type=>'PAGE ITEM'
,p_is_required=>true
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(438448083865681194)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'item'
,p_help_text=>'The item that determines the maximum allowed value. This must be a page item that is either on the current, or global page.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(438448083865681257)
,p_plugin_id=>wwv_flow_imp.id(438448083865680986)
,p_attribute_scope=>'APPLICATION'
,p_attribute_sequence=>12
,p_display_sequence=>120
,p_prompt=>'Calendar Color'
,p_attribute_type=>'COLOR'
,p_is_required=>false
,p_is_translatable=>false
,p_examples=>'#f03636 <--red  |  #dc36f0 <-- purple  |  #36f054 <-- green  |  #e5f036 <-- yellow'
,p_help_text=>'Main color of the calendar (selected day, Confirm button, today highlight). Leave empty to use the Universal Theme primary color.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(438448083865681112)
,p_plugin_id=>wwv_flow_imp.id(438448083865680986)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>12
,p_display_sequence=>120
,p_prompt=>'Min Time Static'
,p_attribute_type=>'TEXT'
,p_is_required=>true
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(438448083865681194)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'static'
,p_help_text=>'Latest date in Return Format, e.g. 1410/12/29. Applies to calendar and manual input. You may also use a page item substitution (e.g. &P1_DATE.) to supply the value dynamically.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(438448083865681258)
,p_plugin_id=>wwv_flow_imp.id(438448083865680986)
,p_attribute_scope=>'APPLICATION'
,p_attribute_sequence=>13
,p_display_sequence=>130
,p_prompt=>'Theme Mode'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>false
,p_default_value=>'auto'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
,p_help_text=>'Auto: dark when the page background is dark. Light / Dark: force the calendar appearance.'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(438448083865681259)
,p_plugin_attribute_id=>wwv_flow_imp.id(438448083865681258)
,p_display_sequence=>10
,p_display_value=>'Auto'
,p_return_value=>'auto'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(438448083865681261)
,p_plugin_attribute_id=>wwv_flow_imp.id(438448083865681258)
,p_display_sequence=>30
,p_display_value=>'Dark'
,p_return_value=>'dark'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(438448083865681260)
,p_plugin_attribute_id=>wwv_flow_imp.id(438448083865681258)
,p_display_sequence=>20
,p_display_value=>'Light'
,p_return_value=>'light'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(438448083865681195)
,p_plugin_id=>wwv_flow_imp.id(438448083865680986)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>13
,p_display_sequence=>130
,p_prompt=>'Max Time'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'none'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(438448083865681184)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'Y'
,p_lov_type=>'STATIC'
,p_help_text=>'Maximum selectable time, e.g. 18:00 or 18:00:00. Can also be a CSS selector to another input.'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(438448083865681113)
,p_plugin_attribute_id=>wwv_flow_imp.id(438448083865681195)
,p_display_sequence=>20
,p_display_value=>'Item'
,p_return_value=>'item'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(438448083865681114)
,p_plugin_attribute_id=>wwv_flow_imp.id(438448083865681195)
,p_display_sequence=>10
,p_display_value=>'None'
,p_return_value=>'none'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(438448083865681115)
,p_plugin_attribute_id=>wwv_flow_imp.id(438448083865681195)
,p_display_sequence=>30
,p_display_value=>'Static'
,p_return_value=>'static'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(438448083865681114)
,p_plugin_id=>wwv_flow_imp.id(438448083865680986)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>14
,p_display_sequence=>140
,p_prompt=>'Max Time Item'
,p_attribute_type=>'PAGE ITEM'
,p_is_required=>true
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(438448083865681195)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'item'
,p_help_text=>'The item that determines the maximum allowed value. This must be a page item that is either on the current, or global page.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(438448083865681115)
,p_plugin_id=>wwv_flow_imp.id(438448083865680986)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>15
,p_display_sequence=>150
,p_prompt=>'Max Time Static'
,p_attribute_type=>'TEXT'
,p_is_required=>true
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(438448083865681195)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'static'
,p_help_text=>'Latest date in Return Format, e.g. 1410/12/29. Applies to calendar and manual input. You may also use a page item substitution (e.g. &P1_DATE.) to supply the value dynamically.'
);
end;
/
begin
wwv_flow_imp.g_varchar2_table := wwv_flow_imp.empty_varchar2_table;
wwv_flow_imp.g_varchar2_table(1) := '2F2A210A202A205065727369616E20446174657069636B657220666F72204F7261636C6520415045580A202A20417574686F723A204D6F6A746162612048616A6920416C6967686F6C6920476976690A202A20576562736974653A2068747470733A2F2F';
wwv_flow_imp.g_varchar2_table(2) := '617065783336302E69720A202A20436F707972696768742028632920323032362E20416C6C207269676874732072657365727665642E0A202A2F0A2E6A616C696C692D646174657B0A20202020646972656374696F6E3A206C74723B0A20202020746578';
wwv_flow_imp.g_varchar2_table(3) := '742D616C69676E3A2072696768743B0A20202020756E69636F64652D626964693A20706C61696E746578743B0A7D0A6A64702D6F7665726C6179207B0A202077696474683A20303B0A20206865696768743A20303B0A7D0A406D65646961206F6E6C7920';
wwv_flow_imp.g_varchar2_table(4) := '73637265656E20616E6420286D61782D77696474683A20343831707829207B0A20206A64702D6F7665726C6179207B0A20202020706F736974696F6E3A2066697865643B0A2020202077696474683A20313030253B0A202020206865696768743A203130';
wwv_flow_imp.g_varchar2_table(5) := '30253B0A20202020746F703A20303B0A202020206C6566743A20303B0A202020206261636B67726F756E642D636F6C6F723A20726762612831352C2032332C2034322C20302E3335293B0A20202020646973706C61793A206E6F6E653B0A20207D0A7D0A';
wwv_flow_imp.g_varchar2_table(6) := '0A6A64702D636F6E7461696E6572207B0A20202D2D6A64702D6461792D73697A653A20333270783B0A20202D2D6A64702D7072696D6172793A20766172282D2D75742D70616C657474652D7072696D6172792C2023326636666564293B0A20202D2D6A64';
wwv_flow_imp.g_varchar2_table(7) := '702D736F66742D6D69783A203132253B0A20202D2D6A64702D7072696D6172792D736F66743A20636F6C6F722D6D697828696E20737267622C20766172282D2D6A64702D7072696D6172792920766172282D2D6A64702D736F66742D6D6978292C207661';
wwv_flow_imp.g_varchar2_table(8) := '72282D2D6A64702D626729293B0A20202D2D6A64702D7072696D6172792D696E6B3A20236666663B0A20202D2D6A64702D62673A20236666663B0A20202D2D6A64702D696E6B3A20233166323933373B0A20202D2D6A64702D6D757465643A2023386139';
wwv_flow_imp.g_varchar2_table(9) := '3461363B0A20202D2D6A64702D6C696E653A20236536653966303B0A20202D2D6A64702D686F7665723A20236631663466393B0A20202D2D6A64702D7265643A20236535343834643B0A2020706F736974696F6E3A206162736F6C7574653B0A20207769';
wwv_flow_imp.g_varchar2_table(10) := '6474683A2063616C6328766172282D2D6A64702D6461792D73697A6529202A2037202B2032347078293B0A20206D696E2D77696474683A2063616C6328766172282D2D6A64702D6461792D73697A6529202A2037202B2032347078293B0A20206D61782D';
wwv_flow_imp.g_varchar2_table(11) := '77696474683A2063616C6328766172282D2D6A64702D6461792D73697A6529202A2037202B2032347078293B0A202070616464696E673A20387078203132707820313070783B0A2020636F6C6F722D736368656D653A206C696768743B0A20206261636B';
wwv_flow_imp.g_varchar2_table(12) := '67726F756E643A20766172282D2D6A64702D6267293B0A2020636F6C6F723A20766172282D2D6A64702D696E6B293B0A2020646972656374696F6E3A2072746C3B0A2020646973706C61793A206E6F6E653B0A2020666F6E742D73697A653A2031322E35';
wwv_flow_imp.g_varchar2_table(13) := '70783B0A20206C696E652D6865696768743A20312E343B0A2020626F726465723A2031707820736F6C696420766172282D2D6A64702D6C696E65293B0A2020626F726465722D7261646975733A20313470783B0A2020626F782D736861646F773A203020';
wwv_flow_imp.g_varchar2_table(14) := '31327078203332707820726762612831352C2032332C2034322C20302E3136292C2030203270782036707820726762612831352C2032332C2034322C20302E3038293B0A20206F766572666C6F773A2068696464656E3B0A2020746F7563682D61637469';
wwv_flow_imp.g_varchar2_table(15) := '6F6E3A206D616E6970756C6174696F6E3B0A2020757365722D73656C6563743A206E6F6E653B0A20202D7765626B69742D757365722D73656C6563743A206E6F6E653B0A2020616E696D6174696F6E3A206A64704F70656E416E696D6174696F6E203136';
wwv_flow_imp.g_varchar2_table(16) := '306D7320656173652D6F75743B0A7D0A406D65646961206F6E6C792073637265656E20616E6420286D61782D77696474683A20343831707829207B0A20206A64702D636F6E7461696E6572207B0A2020202077696474683A20313030253B0A202020206D';
wwv_flow_imp.g_varchar2_table(17) := '61782D77696474683A20313030253B0A202020206D696E2D77696474683A2032363070783B0A202020206C6566743A203530252021696D706F7274616E743B0A20202020626F74746F6D3A20302021696D706F7274616E743B0A20202020746F703A2075';
wwv_flow_imp.g_varchar2_table(18) := '6E7365742021696D706F7274616E743B0A202020207472616E73666F726D3A207472616E736C61746558282D353025292021696D706F7274616E743B0A20202020626F726465722D7261646975733A20313670782031367078203020303B0A2020202061';
wwv_flow_imp.g_varchar2_table(19) := '6E696D6174696F6E3A206A64704F70656E416E696D6174696F6E4D6F62696C65203230306D7320656173652D6F75743B0A20207D0A7D0A6A64702D636F6E7461696E65725B646174612D6A64702D7468656D653D226461726B225D207B0A20202D2D6A64';
wwv_flow_imp.g_varchar2_table(20) := '702D62673A20233166323433303B0A20202D2D6A64702D696E6B3A20236537656266333B0A20202D2D6A64702D6D757465643A20233865393861633B0A20202D2D6A64702D6C696E653A20233334336335303B0A20202D2D6A64702D686F7665723A2023';
wwv_flow_imp.g_varchar2_table(21) := '3262333234333B0A20202D2D6A64702D7265643A20236666376238303B0A20202D2D6A64702D736F66742D6D69783A203236253B0A2020636F6C6F722D736368656D653A206461726B3B0A2020626F782D736861646F773A203020313270782033327078';
wwv_flow_imp.g_varchar2_table(22) := '207267626128302C20302C20302C20302E3535292C20302032707820367078207267626128302C20302C20302C20302E34293B0A7D0A6A64702D636F6E7461696E6572206F7074696F6E207B0A20206261636B67726F756E643A20766172282D2D6A6470';
wwv_flow_imp.g_varchar2_table(23) := '2D6267293B0A2020636F6C6F723A20766172282D2D6A64702D696E6B293B0A7D0A6A64702D636F6E7461696E65722C0A6A64702D636F6E7461696E6572202A2C0A6A64702D636F6E7461696E6572202A3A3A61667465722C0A6A64702D636F6E7461696E';
wwv_flow_imp.g_varchar2_table(24) := '6572202A3A3A6265666F7265207B0A2020626F782D73697A696E673A20626F726465722D626F783B0A7D0A0A2F2A202D2D2D2D206865616465723A206D6F6E7468202F2079656172207374657070657273202D2D2D2D202A2F0A6A64702D636F6E746169';
wwv_flow_imp.g_varchar2_table(25) := '6E6572202E6A64702D6D6F6E7468732C0A6A64702D636F6E7461696E6572202E6A64702D7965617273207B0A2020646973706C61793A20696E6C696E652D666C65783B0A2020616C69676E2D6974656D733A2063656E7465723B0A202076657274696361';
wwv_flow_imp.g_varchar2_table(26) := '6C2D616C69676E3A206D6964646C653B0A20206865696768743A20323670783B0A20206D617267696E3A20303B0A2020666F6E742D73697A653A20313370783B0A2020666F6E742D7765696768743A203630303B0A2020636F6C6F723A20766172282D2D';
wwv_flow_imp.g_varchar2_table(27) := '6A64702D696E6B293B0A202066696C6C3A20766172282D2D6A64702D696E6B293B0A7D0A6A64702D636F6E7461696E6572202E6A64702D6D6F6E746873207B0A202077696474683A203536253B0A7D0A6A64702D636F6E7461696E6572202E6A64702D79';
wwv_flow_imp.g_varchar2_table(28) := '65617273207B0A202077696474683A203434253B0A7D0A6A64702D636F6E7461696E6572202E6A64702D69636F6E2D706C75732C0A6A64702D636F6E7461696E6572202E6A64702D69636F6E2D6D696E7573207B0A2020666C65783A206E6F6E653B0A20';
wwv_flow_imp.g_varchar2_table(29) := '20646973706C61793A20696E6C696E652D666C65783B0A2020616C69676E2D6974656D733A2063656E7465723B0A20206A7573746966792D636F6E74656E743A2063656E7465723B0A202077696474683A20323270783B0A20206865696768743A203232';
wwv_flow_imp.g_varchar2_table(30) := '70783B0A2020637572736F723A20706F696E7465723B0A2020626F726465723A206E6F6E653B0A2020626F726465722D7261646975733A203530253B0A20206261636B67726F756E643A207472616E73706172656E743B0A2020636F6C6F723A20766172';
wwv_flow_imp.g_varchar2_table(31) := '282D2D6A64702D6D75746564293B0A202066696C6C3A20766172282D2D6A64702D6D75746564293B0A2020746578742D6465636F726174696F6E3A206E6F6E653B0A20207472616E736974696F6E3A206261636B67726F756E6420302E3132732C20636F';
wwv_flow_imp.g_varchar2_table(32) := '6C6F7220302E3132733B0A7D0A6A64702D636F6E7461696E6572202E6A64702D69636F6E2D706C7573207376672C0A6A64702D636F6E7461696E6572202E6A64702D69636F6E2D6D696E757320737667207B0A202077696474683A20313470783B0A2020';
wwv_flow_imp.g_varchar2_table(33) := '6865696768743A20313470783B0A202070616464696E673A20303B0A2020766572746963616C2D616C69676E3A206D6964646C653B0A7D0A6A64702D636F6E7461696E6572202E6A64702D69636F6E2D706C75733A686F7665722C0A6A64702D636F6E74';
wwv_flow_imp.g_varchar2_table(34) := '61696E6572202E6A64702D69636F6E2D6D696E75733A686F766572207B0A20206261636B67726F756E643A20766172282D2D6A64702D686F766572293B0A2020636F6C6F723A20766172282D2D6A64702D696E6B293B0A202066696C6C3A20766172282D';
wwv_flow_imp.g_varchar2_table(35) := '2D6A64702D696E6B293B0A7D0A6A64702D636F6E7461696E6572202E6A64702D69636F6E2D706C75732E6E6F742D696E2D72616E67652C0A6A64702D636F6E7461696E6572202E6A64702D69636F6E2D6D696E75732E6E6F742D696E2D72616E6765207B';
wwv_flow_imp.g_varchar2_table(36) := '0A2020637572736F723A206E6F742D616C6C6F7765643B0A20206F7061636974793A20302E333B0A2020706F696E7465722D6576656E74733A206E6F6E653B0A7D0A6A64702D636F6E7461696E6572202E6A64702D796561722C0A6A64702D636F6E7461';
wwv_flow_imp.g_varchar2_table(37) := '696E6572202E6A64702D6D6F6E74682C0A6A64702D636F6E7461696E6572202E6A64702D74696D65207B0A2020666C65783A20312031206175746F3B0A20206D696E2D77696474683A20303B0A7D0A6A64702D636F6E7461696E6572202E6A64702D7965';
wwv_flow_imp.g_varchar2_table(38) := '617220696E7075742C0A6A64702D636F6E7461696E6572202E6A64702D796561722073656C6563742C0A6A64702D636F6E7461696E6572202E6A64702D6D6F6E746820696E7075742C0A6A64702D636F6E7461696E6572202E6A64702D6D6F6E74682073';
wwv_flow_imp.g_varchar2_table(39) := '656C6563742C0A6A64702D636F6E7461696E6572202E6A64702D74696D652073656C656374207B0A202077696474683A20313030253B0A20206865696768743A20323470783B0A20206D617267696E3A20303B0A202070616464696E673A203020327078';
wwv_flow_imp.g_varchar2_table(40) := '3B0A2020626F726465723A206E6F6E653B0A2020626F726465722D7261646975733A203870783B0A20206261636B67726F756E643A207472616E73706172656E743B0A2020636F6C6F723A20696E68657269743B0A2020666F6E743A20696E6865726974';
wwv_flow_imp.g_varchar2_table(41) := '3B0A2020666F6E742D7765696768743A203630303B0A2020746578742D616C69676E3A2063656E7465723B0A2020746578742D616C69676E2D6C6173743A2063656E7465723B0A2020637572736F723A20706F696E7465723B0A20206F75746C696E653A';
wwv_flow_imp.g_varchar2_table(42) := '206E6F6E653B0A20202D7765626B69742D617070656172616E63653A206E6F6E653B0A20202D6D6F7A2D617070656172616E63653A20746578746669656C643B0A2020617070656172616E63653A206E6F6E653B0A2020626F782D736861646F773A206E';
wwv_flow_imp.g_varchar2_table(43) := '6F6E653B0A7D0A6A64702D636F6E7461696E6572202E6A64702D7965617220696E707574207B0A2020637572736F723A20746578743B0A7D0A6A64702D636F6E7461696E6572202E6A64702D7965617220696E7075743A3A2D7765626B69742D6F757465';
wwv_flow_imp.g_varchar2_table(44) := '722D7370696E2D627574746F6E2C0A6A64702D636F6E7461696E6572202E6A64702D7965617220696E7075743A3A2D7765626B69742D696E6E65722D7370696E2D627574746F6E207B0A20202D7765626B69742D617070656172616E63653A206E6F6E65';
wwv_flow_imp.g_varchar2_table(45) := '3B0A20206D617267696E3A20303B0A7D0A6A64702D636F6E7461696E6572202E6A64702D796561722073656C6563743A686F7665722C0A6A64702D636F6E7461696E6572202E6A64702D6D6F6E74682073656C6563743A686F7665722C0A6A64702D636F';
wwv_flow_imp.g_varchar2_table(46) := '6E7461696E6572202E6A64702D7965617220696E7075743A686F7665722C0A6A64702D636F6E7461696E6572202E6A64702D796561722073656C6563743A666F6375732C0A6A64702D636F6E7461696E6572202E6A64702D6D6F6E74682073656C656374';
wwv_flow_imp.g_varchar2_table(47) := '3A666F6375732C0A6A64702D636F6E7461696E6572202E6A64702D7965617220696E7075743A666F637573207B0A20206261636B67726F756E643A20766172282D2D6A64702D686F766572293B0A7D0A6A64702D636F6E7461696E6572206F7074696F6E';
wwv_flow_imp.g_varchar2_table(48) := '207B0A2020666F6E742D73697A653A2031322E3570783B0A2020666F6E742D7765696768743A203430303B0A7D0A0A2F2A202D2D2D2D207765656B64617920686561646572202D2D2D2D202A2F0A6A64702D636F6E7461696E6572202E6A64702D646179';
wwv_flow_imp.g_varchar2_table(49) := '732D686561646572207B0A2020646973706C61793A20666C65783B0A202077696474683A20313030253B0A20206D617267696E2D746F703A203370783B0A202070616464696E673A20303B0A2020626F726465722D626F74746F6D3A2031707820736F6C';
wwv_flow_imp.g_varchar2_table(50) := '696420766172282D2D6A64702D6C696E65293B0A7D0A6A64702D636F6E7461696E6572202E6A64702D64617973207B0A2020646973706C61793A20666C65783B0A2020666C65782D777261703A20777261703B0A202077696474683A20313030253B0A20';
wwv_flow_imp.g_varchar2_table(51) := '206D617267696E2D746F703A203370783B0A202070616464696E673A20303B0A20206F75746C696E653A20303B0A7D0A6A64702D636F6E7461696E6572202E6A64702D6461792C0A6A64702D636F6E7461696E6572202E6A64702D6461792D6E616D6520';
wwv_flow_imp.g_varchar2_table(52) := '7B0A2020666C65783A203020302031342E32383537313433253B0A202077696474683A2031342E32383537313433253B0A20206865696768743A20323570783B0A20206C696E652D6865696768743A20323570783B0A20206D617267696E3A20303B0A20';
wwv_flow_imp.g_varchar2_table(53) := '20646973706C61793A20696E6C696E652D626C6F636B3B0A2020706F736974696F6E3A2072656C61746976653B0A2020746578742D616C69676E3A2063656E7465723B0A20206261636B67726F756E643A206E6F6E653B0A2020626F726465723A206E6F';
wwv_flow_imp.g_varchar2_table(54) := '6E653B0A2020636F6C6F723A20766172282D2D6A64702D696E6B293B0A2020666F6E742D7765696768743A203430303B0A7D0A6A64702D636F6E7461696E6572202E6A64702D6461792D6E616D65207B0A20206865696768743A20313970783B0A20206C';
wwv_flow_imp.g_varchar2_table(55) := '696E652D6865696768743A20313970783B0A20206D617267696E3A20302030203270783B0A2020666F6E742D73697A653A20313170783B0A2020666F6E742D7765696768743A203630303B0A2020636F6C6F723A20766172282D2D6A64702D6D75746564';
wwv_flow_imp.g_varchar2_table(56) := '293B0A2020637572736F723A2064656661756C743B0A7D0A6A64702D636F6E7461696E6572202E6A64702D6461792D6E616D652E6C6173742D7765656B2C0A6A64702D636F6E7461696E6572202E6A64702D6461792E6C6173742D7765656B2C0A6A6470';
wwv_flow_imp.g_varchar2_table(57) := '2D636F6E7461696E6572202E6A64702D6461792E686F6C696461792D6461792C0A6A64702D636F6E7461696E6572202E6A64702D6461792E686F6C6C792D6461792C0A6A64702D636F6E7461696E6572202E6A64702D6461792D6E616D652E686F6C6964';
wwv_flow_imp.g_varchar2_table(58) := '61792D646179207B0A2020636F6C6F723A20766172282D2D6A64702D726564293B0A7D0A6A64702D636F6E7461696E6572202E6A64702D6461792E6E6F742D696E2D6D6F6E7468207B0A20206F7061636974793A20302E33353B0A7D0A6A64702D636F6E';
wwv_flow_imp.g_varchar2_table(59) := '7461696E6572202E6A64702D6461792E64697361626C65642D646179207B0A20206F7061636974793A20302E323B0A2020637572736F723A206E6F742D616C6C6F7765643B0A7D0A6A64702D636F6E7461696E6572202E6A64702D6461793A6E6F74282E';
wwv_flow_imp.g_varchar2_table(60) := '64697361626C65642D64617929207B0A2020637572736F723A20706F696E7465723B0A2020626F726465722D7261646975733A203970783B0A20207472616E736974696F6E3A206261636B67726F756E6420302E31732C20636F6C6F7220302E31733B0A';
wwv_flow_imp.g_varchar2_table(61) := '7D0A6A64702D636F6E7461696E6572202E6A64702D6461793A6E6F74282E64697361626C65642D646179293A686F766572207B0A20206261636B67726F756E643A20766172282D2D6A64702D686F766572293B0A7D0A6A64702D636F6E7461696E657220';
wwv_flow_imp.g_varchar2_table(62) := '2E6A64702D6461792E746F646179207B0A20206261636B67726F756E643A20766172282D2D6A64702D7072696D6172792D736F6674293B0A2020636F6C6F723A20766172282D2D6A64702D7072696D617279293B0A2020666F6E742D7765696768743A20';
wwv_flow_imp.g_varchar2_table(63) := '3730303B0A7D0A6A64702D636F6E7461696E6572202E6A64702D6461792E73656C6563746564207B0A20206261636B67726F756E643A20766172282D2D6A64702D7072696D617279292021696D706F7274616E743B0A2020636F6C6F723A20766172282D';
wwv_flow_imp.g_varchar2_table(64) := '2D6A64702D7072696D6172792D696E6B292021696D706F7274616E743B0A2020666F6E742D7765696768743A203730303B0A20206F7061636974793A20312021696D706F7274616E743B0A2020626F782D736861646F773A203020327078203670782063';
wwv_flow_imp.g_varchar2_table(65) := '6F6C6F722D6D697828696E20737267622C20766172282D2D6A64702D7072696D61727929203430252C207472616E73706172656E74293B0A7D0A6A64702D636F6E7461696E6572202E6A64702D6461792E696E2D72616E6765207B0A20206261636B6772';
wwv_flow_imp.g_varchar2_table(66) := '6F756E643A20766172282D2D6A64702D7072696D6172792D736F6674293B0A2020626F726465722D7261646975733A20303B0A7D0A0A2F2A202D2D2D2D2074696D65202D2D2D2D202A2F0A6A64702D636F6E7461696E6572202E6A64702D74696D652D63';
wwv_flow_imp.g_varchar2_table(67) := '6F6E7461696E6572207B0A2020646973706C61793A20666C65783B0A2020616C69676E2D6974656D733A2063656E7465723B0A20206A7573746966792D636F6E74656E743A2063656E7465723B0A20206761703A203870783B0A20206D617267696E2D74';
wwv_flow_imp.g_varchar2_table(68) := '6F703A203570783B0A202070616464696E673A20367078203020303B0A2020626F726465722D746F703A2031707820736F6C696420766172282D2D6A64702D6C696E65293B0A7D0A6A64702D636F6E7461696E6572202E6A64702D74696D652D636F6E74';
wwv_flow_imp.g_varchar2_table(69) := '61696E6572202E6A64702D74696D65207B0A2020666C65783A2031203120303B0A2020706F736974696F6E3A2072656C61746976653B0A20206D617267696E3A20303B0A7D0A6A64702D636F6E7461696E6572202E6A64702D74696D652D636F6E746169';
wwv_flow_imp.g_varchar2_table(70) := '6E6572202E6A64702D74696D652073656C656374207B0A20206865696768743A20323670783B0A20206261636B67726F756E643A20766172282D2D6A64702D686F766572293B0A2020626F726465722D7261646975733A203870783B0A2020666F6E742D';
wwv_flow_imp.g_varchar2_table(71) := '7765696768743A203630303B0A2020666F6E742D73697A653A20313370783B0A7D0A6A64702D636F6E7461696E6572202E6A64702D74696D652D636F6E7461696E6572202E6A64702D74696D652073656C6563743A686F7665722C0A6A64702D636F6E74';
wwv_flow_imp.g_varchar2_table(72) := '61696E6572202E6A64702D74696D652D636F6E7461696E6572202E6A64702D74696D652073656C6563743A666F637573207B0A20206261636B67726F756E643A20766172282D2D6A64702D7072696D6172792D736F6674293B0A2020636F6C6F723A2076';
wwv_flow_imp.g_varchar2_table(73) := '6172282D2D6A64702D7072696D617279293B0A7D0A6A64702D636F6E7461696E6572202E6A64702D74696D652D636F6E7461696E6572202E6A64702D74696D653A3A6166746572207B0A2020636F6E74656E743A20223A223B0A2020706F736974696F6E';
wwv_flow_imp.g_varchar2_table(74) := '3A206162736F6C7574653B0A20206C6566743A202D3470783B0A2020746F703A203530253B0A20207472616E73666F726D3A207472616E736C617465282D3530252C202D353525293B0A2020666F6E742D7765696768743A203730303B0A2020636F6C6F';
wwv_flow_imp.g_varchar2_table(75) := '723A20766172282D2D6A64702D6D75746564293B0A7D0A6A64702D636F6E7461696E6572202E6A64702D74696D652D636F6E7461696E6572202E6A64702D74696D653A6C6173742D6368696C643A3A6166746572207B0A2020646973706C61793A206E6F';
wwv_flow_imp.g_varchar2_table(76) := '6E653B0A7D0A6A64702D636F6E7461696E6572202E6A64702D74696D652D636F6E7461696E65722E6A64702D6F6E6C792D74696D65202E6A64702D74696D652073656C656374207B0A20206865696768743A20333870783B0A2020666F6E742D73697A65';
wwv_flow_imp.g_varchar2_table(77) := '3A20313670783B0A7D0A0A2F2A202D2D2D2D20666F6F746572202D2D2D2D202A2F0A6A64702D636F6E7461696E6572202E6A64702D666F6F746572207B0A2020646973706C61793A20666C65783B0A2020616C69676E2D6974656D733A2063656E746572';
wwv_flow_imp.g_varchar2_table(78) := '3B0A20206761703A203670783B0A202077696474683A20313030253B0A20206D617267696E2D746F703A203870783B0A202070616464696E673A20303B0A20206F75746C696E653A20303B0A7D0A6A64702D636F6E7461696E6572202E6A64702D62746E';
wwv_flow_imp.g_varchar2_table(79) := '2D636F6E6669726D2C0A6A64702D636F6E7461696E6572202E6A64702D62746E2D746F6461792C0A6A64702D636F6E7461696E6572202E6A64702D62746E2D656D7074792C0A6A64702D636F6E7461696E6572202E6A64702D62746E2D636C6F7365207B';
wwv_flow_imp.g_varchar2_table(80) := '0A2020646973706C61793A20696E6C696E652D626C6F636B3B0A202070616464696E673A203020313270783B0A20206865696768743A20323670783B0A20206C696E652D6865696768743A20323670783B0A2020626F726465722D7261646975733A2038';
wwv_flow_imp.g_varchar2_table(81) := '70783B0A2020666F6E742D73697A653A20313270783B0A2020666F6E742D7765696768743A203630303B0A2020746578742D616C69676E3A2063656E7465723B0A202077686974652D73706163653A206E6F777261703B0A2020637572736F723A20706F';
wwv_flow_imp.g_varchar2_table(82) := '696E7465723B0A20207472616E736974696F6E3A2066696C74657220302E3132732C206261636B67726F756E6420302E3132733B0A7D0A6A64702D636F6E7461696E6572202E6A64702D62746E2D636F6E6669726D207B0A2020666C65783A2031203120';
wwv_flow_imp.g_varchar2_table(83) := '6175746F3B0A20206261636B67726F756E643A20766172282D2D6A64702D7072696D617279293B0A2020636F6C6F723A20766172282D2D6A64702D7072696D6172792D696E6B293B0A2020626F782D736861646F773A2030203270782036707820636F6C';
wwv_flow_imp.g_varchar2_table(84) := '6F722D6D697828696E20737267622C20766172282D2D6A64702D7072696D61727929203335252C207472616E73706172656E74293B0A7D0A6A64702D636F6E7461696E6572202E6A64702D62746E2D636F6E6669726D3A686F766572207B0A202066696C';
wwv_flow_imp.g_varchar2_table(85) := '7465723A206272696768746E65737328312E3038293B0A7D0A6A64702D636F6E7461696E6572202E6A64702D62746E2D746F646179207B0A20206261636B67726F756E643A20766172282D2D6A64702D7072696D6172792D736F6674293B0A2020636F6C';
wwv_flow_imp.g_varchar2_table(86) := '6F723A20766172282D2D6A64702D7072696D617279293B0A7D0A6A64702D636F6E7461696E6572202E6A64702D62746E2D746F6461793A686F766572207B0A202066696C7465723A206272696768746E65737328302E3936293B0A7D0A6A64702D636F6E';
wwv_flow_imp.g_varchar2_table(87) := '7461696E6572202E6A64702D62746E2D656D7074792C0A6A64702D636F6E7461696E6572202E6A64702D62746E2D636C6F7365207B0A20206261636B67726F756E643A207472616E73706172656E743B0A2020636F6C6F723A20766172282D2D6A64702D';
wwv_flow_imp.g_varchar2_table(88) := '6D75746564293B0A202070616464696E673A2030203870783B0A7D0A6A64702D636F6E7461696E6572202E6A64702D62746E2D656D7074793A686F7665722C0A6A64702D636F6E7461696E6572202E6A64702D62746E2D636C6F73653A686F766572207B';
wwv_flow_imp.g_varchar2_table(89) := '0A20206261636B67726F756E643A20766172282D2D6A64702D686F766572293B0A2020636F6C6F723A20766172282D2D6A64702D726564293B0A7D0A6A64702D636F6E7461696E6572202E6A64702D62746E2D746F6461792E64697361626C65642D6274';
wwv_flow_imp.g_varchar2_table(90) := '6E2C0A6A64702D636F6E7461696E6572202E6A64702D62746E2D656D7074792E64697361626C65642D62746E2C0A6A64702D636F6E7461696E6572202E6A64702D62746E2D636C6F73652E64697361626C65642D62746E207B0A20206F7061636974793A';
wwv_flow_imp.g_varchar2_table(91) := '20302E33353B0A2020637572736F723A206E6F742D616C6C6F7765643B0A7D0A406D65646961206F6E6C792073637265656E20616E6420286D61782D77696474683A20343831707829207B0A20206A64702D636F6E7461696E6572202E6A64702D62746E';
wwv_flow_imp.g_varchar2_table(92) := '2D636F6E6669726D2C0A20206A64702D636F6E7461696E6572202E6A64702D62746E2D746F6461792C0A20206A64702D636F6E7461696E6572202E6A64702D62746E2D656D7074792C0A20206A64702D636F6E7461696E6572202E6A64702D62746E2D63';
wwv_flow_imp.g_varchar2_table(93) := '6C6F7365207B0A202020206865696768743A20333670783B0A202020206C696E652D6865696768743A20333670783B0A20202020666F6E742D73697A653A20313470783B0A20207D0A7D0A0A406B65796672616D6573206A64704F70656E416E696D6174';
wwv_flow_imp.g_varchar2_table(94) := '696F6E207B0A202066726F6D207B0A202020206F7061636974793A20303B0A202020207472616E73666F726D3A207472616E736C61746559282D347078293B0A20207D0A2020746F207B0A202020206F7061636974793A20313B0A202020207472616E73';
wwv_flow_imp.g_varchar2_table(95) := '666F726D3A207472616E736C617465592830293B0A20207D0A7D0A406B65796672616D6573206A64704F70656E416E696D6174696F6E4D6F62696C65207B0A202066726F6D207B0A202020206D617267696E2D626F74746F6D3A202D3230253B0A202020';
wwv_flow_imp.g_varchar2_table(96) := '206F7061636974793A20303B0A20207D0A2020746F207B0A202020206D617267696E2D626F74746F6D3A20303B0A202020206F7061636974793A20313B0A20207D0A7D0A';
null;
end;
/
begin
wwv_flow_imp_shared.create_plugin_file(
 p_id=>wwv_flow_imp.id(438448083865681287)
,p_plugin_id=>wwv_flow_imp.id(438448083865680986)
,p_file_name=>'jalalidatepicker.css'
,p_mime_type=>'text/css'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_imp.varchar2_to_blob(wwv_flow_imp.g_varchar2_table)
);
end;
/
begin
wwv_flow_imp.g_varchar2_table := wwv_flow_imp.empty_varchar2_table;
wwv_flow_imp.g_varchar2_table(1) := '2F2A2A0A202A205065727369616E20446174657069636B657220666F72204F7261636C6520415045580A202A20417574686F723A204D6F6A746162612048616A6920416C6967686F6C6920476976690A202A20576562736974653A2068747470733A2F2F';
wwv_flow_imp.g_varchar2_table(2) := '617065783336302E69720A202A20436F707972696768742028632920323032362E20416C6C207269676874732072657365727665642E0A202A2F0A2866756E6374696F6E20285F77696E646F77246E6176696761746F7229207B0A202022757365207374';
wwv_flow_imp.g_varchar2_table(3) := '72696374223B0A0A2020766172206973556E646566696E6564203D2066756E6374696F6E206973556E646566696E65642876616C756529207B0A2020202072657475726E20747970656F662076616C7565203D3D3D2022756E646566696E6564223B0A20';
wwv_flow_imp.g_varchar2_table(4) := '207D3B0A202076617220697346756E6374696F6E203D2066756E6374696F6E20697346756E6374696F6E2876616C756529207B0A2020202072657475726E20747970656F662076616C7565203D3D3D202266756E6374696F6E223B0A20207D3B0A202076';
wwv_flow_imp.g_varchar2_table(5) := '6172206973537472696E67203D2066756E6374696F6E206973537472696E672876616C756529207B0A2020202072657475726E20747970656F662076616C7565203D3D3D2022737472696E67223B0A20207D3B0A20207661722069734F626A656374203D';
wwv_flow_imp.g_varchar2_table(6) := '2066756E6374696F6E2069734F626A6563742876616C756529207B0A2020202072657475726E2076616C756520213D3D206E756C6C20262620747970656F662076616C7565203D3D3D20226F626A656374223B0A20207D3B0A202076617220636C6F6E65';
wwv_flow_imp.g_varchar2_table(7) := '203D2066756E6374696F6E20636C6F6E652876616C756529207B0A2020202072657475726E204A534F4E2E7061727365284A534F4E2E737472696E676966792876616C756529293B0A20207D3B0A20207661722069734E6F744F626A6563744F72497345';
wwv_flow_imp.g_varchar2_table(8) := '6D7074794F626A656374203D2066756E6374696F6E2069734E6F744F626A6563744F724973456D7074794F626A656374286F626A29207B0A20202020696620282169734F626A656374286F626A2929207B0A20202020202072657475726E20747275653B';
wwv_flow_imp.g_varchar2_table(9) := '0A202020207D0A20202020747279207B0A20202020202072657475726E204A534F4E2E737472696E67696679286F626A29203D3D3D20227B7D223B0A202020207D20636174636820286529207B0A20202020202072657475726E2066616C73653B0A2020';
wwv_flow_imp.g_varchar2_table(10) := '20207D0A20207D3B0A2020766172205F657874656E64203D2066756E6374696F6E20657874656E64287461726765742C20736F7572636529207B0A20202020666F722028766172206B657920696E20736F7572636529207B0A2020202020206966202873';
wwv_flow_imp.g_varchar2_table(11) := '6F757263652E6861734F776E50726F7065727479286B65792929207B0A202020202020202076617220736F7572636556616C7565203D20736F757263655B6B65795D3B0A20202020202020207661722074617267657456616C7565203D20746172676574';
wwv_flow_imp.g_varchar2_table(12) := '5B6B65795D3B0A202020202020202069662028736F7572636556616C756520262620747970656F6620736F7572636556616C7565203D3D3D20226F626A65637422202626202141727261792E6973417272617928736F7572636556616C75652929207B0A';
wwv_flow_imp.g_varchar2_table(13) := '202020202020202020207461726765745B6B65795D203D205F657874656E642874617267657456616C756520262620747970656F662074617267657456616C7565203D3D3D20226F626A65637422203F2074617267657456616C7565203A207B7D2C2073';
wwv_flow_imp.g_varchar2_table(14) := '6F7572636556616C7565293B0A20202020202020207D20656C7365207B0A202020202020202020207461726765745B6B65795D203D20736F7572636556616C75653B0A20202020202020207D0A2020202020207D0A202020207D0A202020207265747572';
wwv_flow_imp.g_varchar2_table(15) := '6E207461726765743B0A20207D3B0A2020766172206D6F64203D2066756E6374696F6E206D6F6428612C206229207B0A2020202072657475726E2077696E646F772E4D6174682E6162732861202D2062202A2077696E646F772E4D6174682E666C6F6F72';
wwv_flow_imp.g_varchar2_table(16) := '2861202F206229293B0A20207D3B0A2020766172206164644C656164696E675A65726F203D2066756E6374696F6E206164644C656164696E675A65726F2876616C75652C206C656E67746829207B0A20202020696620286C656E677468203D3D3D20766F';
wwv_flow_imp.g_varchar2_table(17) := '6964203029207B0A2020202020206C656E677468203D20323B0A202020207D0A20202020696620286973556E646566696E65642876616C75652929207B0A20202020202072657475726E2076616C75653B0A202020207D0A202020207661722073747220';
wwv_flow_imp.g_varchar2_table(18) := '3D20537472696E67284D6174682E6162732876616C756529293B0A202020207661722069203D207374722E6C656E6774683B0A2020202076617220726573756C74203D2022223B0A202020206966202876616C7565203C203029207B0A20202020202072';
wwv_flow_imp.g_varchar2_table(19) := '6573756C74202B3D20222D223B0A202020207D0A202020207768696C65202869203C206C656E67746829207B0A20202020202069202B3D20313B0A202020202020726573756C74202B3D202230223B0A202020207D0A2020202072657475726E20726573';
wwv_flow_imp.g_varchar2_table(20) := '756C74202B207374723B0A20207D3B0A20207661722069734C65617059656172203D2066756E6374696F6E2069734C65617059656172286A7929207B0A2020202066756E6374696F6E2064697628612C206229207B0A20202020202072657475726E207E';
wwv_flow_imp.g_varchar2_table(21) := '7E2861202F2062293B0A202020207D0A2020202076617220627265616B73203D205B2D36312C20392C2033382C203139392C203432362C203638362C203735362C203831382C20313131312C20313138312C20313231302C20313633352C20323036302C';
wwv_flow_imp.g_varchar2_table(22) := '20323039372C20323139322C20323236322C20323332342C20323339342C20323435362C20333137385D3B0A2020202076617220626C203D20627265616B732E6C656E6774683B0A20202020766172206A756D70203D20303B0A20202020766172206A70';
wwv_flow_imp.g_varchar2_table(23) := '203D20627265616B735B305D3B0A20202020766172206C6561703B0A20202020666F7220287661722069203D20313B2069203C20626C3B2069202B3D203129207B0A202020202020766172206A6D203D20627265616B735B695D3B0A2020202020206A75';
wwv_flow_imp.g_varchar2_table(24) := '6D70203D206A6D202D206A703B0A202020202020696620286A79203C206A6D2920627265616B3B0A2020202020206A70203D206A6D3B0A202020207D0A20202020766172206E203D206A79202D206A703B0A20202020696620286A756D70202D206E203C';
wwv_flow_imp.g_varchar2_table(25) := '203629206E203D206E202D206A756D70202B20646976286A756D70202B20342C20333329202A2033333B0A202020206C656170203D206D6F64286D6F64286E202B20312C20333329202D20312C2034293B0A20202020696620286C656170203D3D3D202D';
wwv_flow_imp.g_varchar2_table(26) := '3129206C656170203D20343B0A2020202072657475726E206C656170203D3D3D20303B0A20207D3B0A202076617220746F4A616C616C69203D2066756E6374696F6E20746F4A616C616C692867792C20676D2C20676429207B0A20202020766172206A79';
wwv_flow_imp.g_varchar2_table(27) := '3B0A2020202076617220646179733B0A202020207661722067646D203D205B302C2033312C2035392C2039302C203132302C203135312C203138312C203231322C203234332C203237332C203330342C203333345D3B0A20202020696620286779203E20';
wwv_flow_imp.g_varchar2_table(28) := '3136303029207B0A2020202020206A79203D203937393B0A2020202020206779202D3D20313630303B0A202020207D20656C7365207B0A2020202020206A79203D20303B0A2020202020206779202D3D203632313B0A202020207D0A2020202076617220';
wwv_flow_imp.g_varchar2_table(29) := '677932203D20676D203E2032203F206779202B2031203A2067793B0A2020202064617973203D20333635202A206779202B204D6174682E666C6F6F722828677932202B203329202F203429202D204D6174682E666C6F6F722828677932202B2039392920';
wwv_flow_imp.g_varchar2_table(30) := '2F2031303029202B204D6174682E666C6F6F722828677932202B2033393929202F2034303029202D203830202B206764202B2067646D5B676D202D20315D3B0A202020206A79202B3D203333202A204D6174682E666C6F6F722864617973202F20313230';
wwv_flow_imp.g_varchar2_table(31) := '3533293B0A202020206461797320253D2031323035333B0A202020206A79202B3D2034202A204D6174682E666C6F6F722864617973202F2031343631293B0A202020206461797320253D20313436313B0A202020206966202864617973203E2033363529';
wwv_flow_imp.g_varchar2_table(32) := '207B0A2020202020206A79202B3D204D6174682E666C6F6F72282864617973202D203129202F20333635293B0A20202020202064617973203D202864617973202D2031292025203336353B0A202020207D0A20202020766172206A6D203D206461797320';
wwv_flow_imp.g_varchar2_table(33) := '3C20313836203F2031202B204D6174682E666C6F6F722864617973202F20333129203A2037202B204D6174682E666C6F6F72282864617973202D2031383629202F203330293B0A20202020766172206A64203D2031202B202864617973203C2031383620';
wwv_flow_imp.g_varchar2_table(34) := '3F20646179732025203331203A202864617973202D20313836292025203330293B0A2020202072657475726E207B0A202020202020796561723A206A792C0A2020202020206D6F6E74683A206A6D2C0A2020202020206461793A206A640A202020207D3B';
wwv_flow_imp.g_varchar2_table(35) := '0A20207D3B0A2020766172206A616C616C69546F646179203D2066756E6374696F6E206A616C616C69546F6461792829207B0A202020207661722064617465203D202F2A20405F5F505552455F5F202A2F6E6577204461746528293B0A20202020766172';
wwv_flow_imp.g_varchar2_table(36) := '206779203D20646174652E67657446756C6C5965617228293B0A2020202076617220676D203D20646174652E6765744D6F6E74682829202B20313B0A20202020766172206764203D20646174652E6765744461746528293B0A2020202072657475726E20';
wwv_flow_imp.g_varchar2_table(37) := '746F4A616C616C692867792C20676D2C206764293B0A20207D3B0A2020766172206765745765656B446179203D2066756E6374696F6E206765745765656B44617928796561722C206D6F6E74682C2064617929207B0A2020202076617220676574446179';
wwv_flow_imp.g_varchar2_table(38) := '73203D2066756E6374696F6E2067657444617973285F6D6F6E74682C205F64617929207B0A202020202020696620285F6D6F6E7468203C2038292072657475726E20285F6D6F6E7468202D203129202A203331202B205F6461793B0A2020202020207265';
wwv_flow_imp.g_varchar2_table(39) := '7475726E2036202A203331202B20285F6D6F6E7468202D203729202A203330202B205F6461793B0A202020207D3B0A20202020766172206765744469666644617973203D2066756E6374696F6E2067657444696666446179732879656172312C206D6F6E';
wwv_flow_imp.g_varchar2_table(40) := '7468312C20646179312C2079656172322C206D6F6E7468322C206461793229207B0A202020202020766172206469666644617973203D2067657444617973286D6F6E7468322C206461793229202D2067657444617973286D6F6E7468312C206461793129';
wwv_flow_imp.g_varchar2_table(41) := '3B0A202020202020766172207931203D207965617231203C207965617232203F207965617231203A2079656172323B0A202020202020766172207932203D207965617231203C207965617232203F207965617232203A2079656172313B0A202020202020';
wwv_flow_imp.g_varchar2_table(42) := '666F7220287661722079203D2079313B2079203C2079323B20792B2B29207B0A20202020202020206966202869734C6561705965617228792929206469666644617973202B3D207965617231203C207965617232203F20333636203A202D3336363B656C';
wwv_flow_imp.g_varchar2_table(43) := '7365206469666644617973202B3D207965617231203C207965617232203F20333635203A202D3336353B0A2020202020207D0A20202020202072657475726E2064696666446179733B0A202020207D3B0A2020202072657475726E206D6F642867657444';
wwv_flow_imp.g_varchar2_table(44) := '6966664461797328313339322C20332C2032352C20796561722C206D6F6E74682C20646179292C2037293B0A20207D3B0A20207661722067657444617973496E4D6F6E7468203D2066756E6374696F6E2067657444617973496E4D6F6E74682879656172';
wwv_flow_imp.g_varchar2_table(45) := '2C206D6F6E746829207B0A2020202072657475726E205B302C2033312C2033312C2033312C2033312C2033312C2033312C2033302C2033302C2033302C2033302C2033302C2069734C65617059656172287965617229203F203330203A2032395D5B6D6F';
wwv_flow_imp.g_varchar2_table(46) := '6E74685D3B0A20207D3B0A202076617220746F477265676F7269616E203D2066756E6374696F6E20746F477265676F7269616E286A792C206A6D2C206A6429207B0A20202020766172206779203D206A79203C3D20393739203F20363231203A20313630';
wwv_flow_imp.g_varchar2_table(47) := '303B0A202020206A79202D3D206A79203C3D20393739203F2030203A203937393B0A202020207661722064617973203D20333635202A206A79202B204D6174682E666C6F6F72286A79202F20333329202A2038202B204D6174682E666C6F6F7228286A79';
wwv_flow_imp.g_varchar2_table(48) := '2025203333202B203329202F203429202B203738202B206A64202B20286A6D203C2037203F20286A6D202D203129202A203331203A20286A6D202D203729202A203330202B20313836293B0A202020206779202B3D20343030202A204D6174682E666C6F';
wwv_flow_imp.g_varchar2_table(49) := '6F722864617973202F20313436303937293B0A202020206461797320253D203134363039373B0A202020206966202864617973203E20333635323429207B0A2020202020206779202B3D20313030202A204D6174682E666C6F6F72282D2D64617973202F';
wwv_flow_imp.g_varchar2_table(50) := '203336353234293B0A2020202020206461797320253D2033363532343B0A2020202020206966202864617973203E3D203336352920646179732B2B3B0A202020207D0A202020206779202B3D2034202A204D6174682E666C6F6F722864617973202F2031';
wwv_flow_imp.g_varchar2_table(51) := '343631293B0A202020206461797320253D20313436313B0A202020206966202864617973203E2033363529207B0A2020202020206779202B3D204D6174682E666C6F6F72282864617973202D203129202F20333635293B0A20202020202064617973203D';
wwv_flow_imp.g_varchar2_table(52) := '202864617973202D2031292025203336353B0A202020207D0A20202020766172206764203D2064617973202B20313B0A202020207661722073616C5F61203D205B302C2033312C20677920252034203D3D3D203020262620677920252031303020213D3D';
wwv_flow_imp.g_varchar2_table(53) := '2030207C7C206779202520343030203D3D3D2030203F203239203A2032382C2033312C2033302C2033312C2033302C2033312C2033312C2033302C2033312C2033302C2033315D3B0A2020202076617220676D3B0A20202020666F722028676D203D2030';
wwv_flow_imp.g_varchar2_table(54) := '3B20676D203C2031333B20676D2B2B29207B0A2020202020207661722076203D2073616C5F615B676D5D3B0A202020202020696620286764203C3D20762920627265616B3B0A2020202020206764202D3D20763B0A202020207D0A202020207265747572';
wwv_flow_imp.g_varchar2_table(55) := '6E207B0A202020202020796561723A2067792C0A2020202020206D6F6E74683A20676D2C0A2020202020206461793A2067640A202020207D3B0A20207D3B0A202076617220676574446174654E756D626572203D2066756E6374696F6E20676574446174';
wwv_flow_imp.g_varchar2_table(56) := '654E756D626572286461746529207B0A2020202072657475726E20646174652E79656172202A20316534202B20646174652E6D6F6E7468202A20313030202B20646174652E6461793B0A20207D3B0A202076617220697356616C696459656172203D2066';
wwv_flow_imp.g_varchar2_table(57) := '756E6374696F6E20697356616C696459656172287965617229207B0A2020202072657475726E202169734E614E2879656172292026262079656172203E3D203165332026262079656172203C3D20313939393B0A20207D3B0A202076617220697356616C';
wwv_flow_imp.g_varchar2_table(58) := '69644D6F6E7468203D2066756E6374696F6E20697356616C69644D6F6E7468286D6F6E746829207B0A2020202072657475726E202169734E614E286D6F6E746829202626206D6F6E7468203E3D2031202626206D6F6E7468203C3D2031323B0A20207D3B';
wwv_flow_imp.g_varchar2_table(59) := '0A2020766172206573636170655265676578203D2066756E6374696F6E2065736361706552656765782876616C756529207B0A2020202072657475726E2076616C75652E7265706C616365282F5B2E2A2B3F5E247B7D28297C5B5C5D5C5C5D2F672C2022';
wwv_flow_imp.g_varchar2_table(60) := '5C5C242622293B0A20207D3B0A20207661722067657444617465537472696E674C656E677468203D2066756E6374696F6E2067657444617465537472696E674C656E677468286A647029207B0A2020202072657475726E2038202B206A64702E6F707469';
wwv_flow_imp.g_varchar2_table(61) := '6F6E732E736570617261746F7243686172732E646174652E6C656E677468202A20323B0A20207D3B0A20207661722068617356616C6964506172744C656E67746873203D2066756E6374696F6E2068617356616C6964506172744C656E67746873287061';
wwv_flow_imp.g_varchar2_table(62) := '7274732C206C656E6774687329207B0A202020206966202870617274732E6C656E67746820213D3D206C656E677468732E6C656E677468292072657475726E2066616C73653B0A20202020666F7220287661722069203D20303B2069203C207061727473';
wwv_flow_imp.g_varchar2_table(63) := '2E6C656E6774683B20692B2B29207B0A2020202020206966202870617274735B695D2E6C656E67746820213D3D206C656E677468735B695D292072657475726E2066616C73653B0A202020207D0A2020202072657475726E20747275653B0A20207D3B0A';
wwv_flow_imp.g_varchar2_table(64) := '20207661722067657446616C6C6261636B44617465203D2066756E6374696F6E2067657446616C6C6261636B44617465286A647029207B0A20202020696620286A64702E5F696E697444617465292072657475726E206A64702E5F696E6974446174653B';
wwv_flow_imp.g_varchar2_table(65) := '0A20202020696620286A64702E6F7074696F6E732E696E69744461746520262620747970656F66206A64702E6F7074696F6E732E696E697444617465203D3D3D20226F626A65637422292072657475726E206A64702E6F7074696F6E732E696E69744461';
wwv_flow_imp.g_varchar2_table(66) := '74653B0A2020202072657475726E206A64702E746F6461793B0A20207D3B0A20207661722067657446616C6C6261636B54696D65203D2066756E6374696F6E2067657446616C6C6261636B54696D65286A647029207B0A20202020696620286A64702E5F';
wwv_flow_imp.g_varchar2_table(67) := '696E697454696D65292072657475726E206A64702E5F696E697454696D653B0A20202020696620286A64702E6F7074696F6E732E696E697454696D6520262620747970656F66206A64702E6F7074696F6E732E696E697454696D65203D3D3D20226F626A';
wwv_flow_imp.g_varchar2_table(68) := '65637422292072657475726E206A64702E6F7074696F6E732E696E697454696D653B0A2020202072657475726E207B0A202020202020686F75723A20302C0A2020202020206D696E7574653A20302C0A2020202020207365636F6E643A20300A20202020';
wwv_flow_imp.g_varchar2_table(69) := '7D3B0A20207D3B0A2020766172206E6F726D616C697A654D696E4D617844617465203D2066756E6374696F6E206E6F726D616C697A654D696E4D617844617465286A64702C20646174654F626A2C207570646174654F626A29207B0A2020202076617220';
wwv_flow_imp.g_varchar2_table(70) := '5F646174654F626A203D205F657874656E6428646174654F626A207C7C207B7D2C207570646174654F626A207C7C207B7D293B0A202020207661722066616C6C6261636B44617465203D2067657446616C6C6261636B44617465286A6470293B0A202020';
wwv_flow_imp.g_varchar2_table(71) := '20766172206D617844617465203D206A64702E6F7074696F6E732E6D6178446174653B0A20202020766172206D696E44617465203D206A64702E6F7074696F6E732E6D696E446174653B0A202020207661722079656172203D20697356616C6964596561';
wwv_flow_imp.g_varchar2_table(72) := '72285F646174654F626A2E7965617229203F205F646174654F626A2E79656172203A2066616C6C6261636B446174652E796561723B0A20202020766172206D6F6E7468203D20697356616C69644D6F6E7468285F646174654F626A2E6D6F6E746829203F';
wwv_flow_imp.g_varchar2_table(73) := '205F646174654F626A2E6D6F6E7468203A2066616C6C6261636B446174652E6D6F6E74683B0A2020202076617220646179203D202169734E614E285F646174654F626A2E64617929202626205F646174654F626A2E646179203E3D2031203F205F646174';
wwv_flow_imp.g_varchar2_table(74) := '654F626A2E646179203A2066616C6C6261636B446174652E6461793B0A202020207661722064617973496E4D6F6E7468203D2067657444617973496E4D6F6E746828796561722C206D6F6E7468293B0A2020202069662028646179203E2064617973496E';
wwv_flow_imp.g_varchar2_table(75) := '4D6F6E746829207B0A202020202020646179203D2064617973496E4D6F6E74683B0A202020207D0A20202020766172206E6F726D616C697A656444617465203D207B0A202020202020796561723A20796561722C0A2020202020206D6F6E74683A206D6F';
wwv_flow_imp.g_varchar2_table(76) := '6E74682C0A2020202020206461793A206461790A202020207D3B0A20202020696620286D696E4461746520262620676574446174654E756D626572286E6F726D616C697A65644461746529203C20676574446174654E756D626572286D696E4461746529';
wwv_flow_imp.g_varchar2_table(77) := '292072657475726E206D696E446174653B0A20202020696620286D61784461746520262620676574446174654E756D626572286E6F726D616C697A65644461746529203E20676574446174654E756D626572286D61784461746529292072657475726E20';
wwv_flow_imp.g_varchar2_table(78) := '6D6178446174653B0A2020202072657475726E206E6F726D616C697A6564446174653B0A20207D3B0A2020766172206E6F726D616C697A654D696E4D617854696D65203D2066756E6374696F6E206E6F726D616C697A654D696E4D617854696D65286A64';
wwv_flow_imp.g_varchar2_table(79) := '702C2074696D654F626A2C207570646174654F626A29207B0A20202020766172205F74696D654F626A203D205F657874656E642874696D654F626A207C7C207B7D2C207570646174654F626A207C7C207B7D293B0A2020202076617220696E697454696D';
wwv_flow_imp.g_varchar2_table(80) := '65203D2067657446616C6C6261636B54696D65286A6470293B0A20202020766172206D617854696D65203D206A64702E6F7074696F6E732E6D617854696D653B0A20202020766172206D696E54696D65203D206A64702E6F7074696F6E732E6D696E5469';
wwv_flow_imp.g_varchar2_table(81) := '6D653B0A2020202076617220686F7572203D205F74696D654F626A2E686F75723B0A20202020766172206D696E757465203D205F74696D654F626A2E6D696E7574653B0A20202020766172207365636F6E64203D205F74696D654F626A2E7365636F6E64';
wwv_flow_imp.g_varchar2_table(82) := '3B0A202020206966202869734E614E28686F757229207C7C20686F7572203C2030207C7C20686F7572203E20323329207B0A202020202020686F7572203D20696E697454696D652E686F75723B0A202020207D20656C7365207B0A202020202020696620';
wwv_flow_imp.g_varchar2_table(83) := '286D696E54696D6520262620686F7572203C206D696E54696D652E686F757229207B0A2020202020202020686F7572203D206D696E54696D652E686F75723B0A2020202020207D20656C736520696620286D617854696D6520262620686F7572203E206D';
wwv_flow_imp.g_varchar2_table(84) := '617854696D652E686F757229207B0A2020202020202020686F7572203D206D617854696D652E686F75723B0A2020202020207D0A202020207D0A202020206966202869734E614E286D696E75746529207C7C206D696E757465203C2030207C7C206D696E';
wwv_flow_imp.g_varchar2_table(85) := '757465203E20353929207B0A2020202020206D696E757465203D20696E697454696D652E6D696E7574653B0A202020207D20656C7365207B0A202020202020696620286D696E54696D6520262620686F7572203C3D206D696E54696D652E686F75722026';
wwv_flow_imp.g_varchar2_table(86) := '26206D696E757465203C206D696E54696D652E6D696E75746529207B0A20202020202020206D696E757465203D206D696E54696D652E6D696E7574653B0A2020202020207D20656C736520696620286D617854696D6520262620686F7572203E3D206D61';
wwv_flow_imp.g_varchar2_table(87) := '7854696D652E686F7572202626206D696E757465203E206D617854696D652E6D696E75746529207B0A20202020202020206D696E757465203D206D617854696D652E6D696E7574653B0A2020202020207D0A202020207D0A202020206966202869734E61';
wwv_flow_imp.g_varchar2_table(88) := '4E287365636F6E6429207C7C207365636F6E64203C2030207C7C207365636F6E64203E20353929207B0A2020202020207365636F6E64203D20696E697454696D652E7365636F6E643B0A202020207D20656C7365207B0A202020202020696620286D696E';
wwv_flow_imp.g_varchar2_table(89) := '54696D6520262620686F7572203C3D206D696E54696D652E686F7572202626206D696E757465203C3D206D696E54696D652E6D696E757465202626207365636F6E64203C206D696E54696D652E7365636F6E6429207B0A20202020202020207365636F6E';
wwv_flow_imp.g_varchar2_table(90) := '64203D206D696E54696D652E7365636F6E643B0A2020202020207D20656C736520696620286D617854696D6520262620686F7572203E3D206D617854696D652E686F7572202626206D696E757465203E3D206D617854696D652E6D696E75746520262620';
wwv_flow_imp.g_varchar2_table(91) := '7365636F6E64203E206D617854696D652E7365636F6E6429207B0A20202020202020207365636F6E64203D206D617854696D652E7365636F6E643B0A2020202020207D0A202020207D0A2020202072657475726E207B0A202020202020686F75723A2068';
wwv_flow_imp.g_varchar2_table(92) := '6F75722C0A2020202020206D696E7574653A206D696E7574652C0A2020202020207365636F6E643A207365636F6E640A202020207D3B0A20207D3B0A20207661722067657456616C69645965617273203D2066756E6374696F6E2067657456616C696459';
wwv_flow_imp.g_varchar2_table(93) := '65617273286A647029207B0A20202020766172205F6A6470246F7074696F6E73246D696E446174652C205F6A6470246F7074696F6E73246D6178446174653B0A2020202066756E6374696F6E20726E642876616C29207B0A20202020202072657475726E';
wwv_flow_imp.g_varchar2_table(94) := '204D6174682E726F756E642876616C202F2031303029202A203130303B0A202020207D0A2020202076617220696E697459656172203D206A64702E696E6974446174652E796561723B0A20202020766172206D696E203D2028285F6A6470246F7074696F';
wwv_flow_imp.g_varchar2_table(95) := '6E73246D696E44617465203D206A64702E6F7074696F6E732E6D696E4461746529203D3D206E756C6C203F20766F69642030203A205F6A6470246F7074696F6E73246D696E446174652E7965617229207C7C20726E6428696E697459656172202D203230';
wwv_flow_imp.g_varchar2_table(96) := '30293B0A20202020766172206D6178203D2028285F6A6470246F7074696F6E73246D617844617465203D206A64702E6F7074696F6E732E6D61784461746529203D3D206E756C6C203F20766F69642030203A205F6A6470246F7074696F6E73246D617844';
wwv_flow_imp.g_varchar2_table(97) := '6174652E7965617229207C7C20726E6428696E697459656172202B20323030293B0A2020202072657475726E207B0A2020202020206D696E3A206D696E2C0A2020202020206D61783A206D61780A202020207D3B0A20207D3B0A20207661722067657456';
wwv_flow_imp.g_varchar2_table(98) := '616C69644D6F6E746873203D2066756E6374696F6E2067657456616C69644D6F6E746873286A647029207B0A2020202076617220696E697459656172203D206A64702E696E6974446174652E796561723B0A20202020766172206D696E44617465203D20';
wwv_flow_imp.g_varchar2_table(99) := '6A64702E6F7074696F6E732E6D696E446174653B0A20202020766172206D617844617465203D206A64702E6F7074696F6E732E6D6178446174653B0A20202020766172206D6F6E746873203D205B5D3B0A20202020766172207374617274203D20313B0A';
wwv_flow_imp.g_varchar2_table(100) := '202020207661722066696E697368203D2031323B0A2020202069662028696E697459656172203D3D3D20286D696E44617465203D3D206E756C6C203F20766F69642030203A206D696E446174652E796561722929207B0A2020202020207374617274203D';
wwv_flow_imp.g_varchar2_table(101) := '206D696E446174652E6D6F6E74683B0A20202020202069662028696E697459656172203D3D3D20286D617844617465203D3D206E756C6C203F20766F69642030203A206D6178446174652E796561722929207B0A202020202020202066696E697368203D';
wwv_flow_imp.g_varchar2_table(102) := '206D6178446174652E6D6F6E74683B0A2020202020207D0A202020207D20656C73652069662028696E697459656172203D3D3D20286D617844617465203D3D206E756C6C203F20766F69642030203A206D6178446174652E796561722929207B0A202020';
wwv_flow_imp.g_varchar2_table(103) := '2020207374617274203D20313B0A20202020202066696E697368203D206D6178446174652E6D6F6E74683B0A202020207D0A20202020666F7220287661722069203D2073746172743B2069203C3D2066696E6973683B20692B2B29207B0A202020202020';
wwv_flow_imp.g_varchar2_table(104) := '6D6F6E7468732E707573682869293B0A202020207D0A2020202072657475726E206D6F6E7468733B0A20207D3B0A202076617220697356616C696444617465203D2066756E6374696F6E20697356616C696444617465286A64702C20796561722C206D6F';
wwv_flow_imp.g_varchar2_table(105) := '6E74682C2064617929207B0A202020207661722064617465203D20676574446174654E756D626572287B0A202020202020796561723A20796561722C0A2020202020206D6F6E74683A206D6F6E74682C0A2020202020206461793A206461790A20202020';
wwv_flow_imp.g_varchar2_table(106) := '7D293B0A20202020766172206D6178446174654E756D626572203D20646174653B0A20202020766172206D696E446174654E756D626572203D20646174653B0A20202020766172206D617844617465203D206A64702E6F7074696F6E732E6D6178446174';
wwv_flow_imp.g_varchar2_table(107) := '653B0A20202020766172206D696E44617465203D206A64702E6F7074696F6E732E6D696E446174653B0A20202020696620282169734E6F744F626A6563744F724973456D7074794F626A656374286D696E446174652929207B0A2020202020206D696E44';
wwv_flow_imp.g_varchar2_table(108) := '6174654E756D626572203D20676574446174654E756D626572286D696E44617465293B0A202020207D0A20202020696620282169734E6F744F626A6563744F724973456D7074794F626A656374286D6178446174652929207B0A2020202020206D617844';
wwv_flow_imp.g_varchar2_table(109) := '6174654E756D626572203D20676574446174654E756D626572286D617844617465293B0A202020207D0A2020202072657475726E2064617465203C3D206D6178446174654E756D6265722026262064617465203E3D206D696E446174654E756D6265723B';
wwv_flow_imp.g_varchar2_table(110) := '0A20207D3B0A202076617220697356616C696444617465546F646179203D2066756E6374696F6E20697356616C696444617465546F646179286A647029207B0A2020202072657475726E20697356616C696444617465286A64702C206A64702E746F6461';
wwv_flow_imp.g_varchar2_table(111) := '792E796561722C206A64702E746F6461792E6D6F6E74682C206A64702E746F6461792E646179293B0A20207D3B0A202076617220697356616C696456616C7565537472696E67203D2066756E6374696F6E20697356616C696456616C7565537472696E67';
wwv_flow_imp.g_varchar2_table(112) := '286A64702C2073747229207B0A20202020696620282173747229207B0A20202020202072657475726E2066616C73653B0A202020207D0A20202020766172207365704F7074203D206A64702E6F7074696F6E732E736570617261746F7243686172733B0A';
wwv_flow_imp.g_varchar2_table(113) := '202020207661722064617465536570617261746F72203D206573636170655265676578287365704F70742E64617465293B0A202020207661722074696D65536570617261746F72203D206573636170655265676578287365704F70742E74696D65293B0A';
wwv_flow_imp.g_varchar2_table(114) := '20202020766172206265747765656E536570617261746F72203D206573636170655265676578287365704F70742E6265747765656E293B0A2020202076617220646174655061747465726E203D206A64702E6F7074696F6E732E64617465203F20225C5C';
wwv_flow_imp.g_varchar2_table(115) := '647B347D22202B2064617465536570617261746F72202B20225C5C647B327D22202B2064617465536570617261746F72202B20225C5C647B327D22203A2022223B0A202020207661722074696D655061747465726E203D206A64702E6F7074696F6E732E';
wwv_flow_imp.g_varchar2_table(116) := '74696D65203F20225C5C647B327D22202B2074696D65536570617261746F72202B20225C5C647B327D22202B20286A64702E6F7074696F6E732E6861735365636F6E64203F2074696D65536570617261746F72202B20225C5C647B327D22203A20222229';
wwv_flow_imp.g_varchar2_table(117) := '203A2022223B0A20202020766172207265676578203D206E65772052656745787028225E22202B20646174655061747465726E202B2028646174655061747465726E2026262074696D655061747465726E203F206265747765656E536570617261746F72';
wwv_flow_imp.g_varchar2_table(118) := '203A20222229202B2074696D655061747465726E202B20222422293B0A2020202072657475726E2072656765782E7465737428737472293B0A20207D3B0A20207661722067657444617465506172747346726F6D537472696E67203D2066756E6374696F';
wwv_flow_imp.g_varchar2_table(119) := '6E2067657444617465506172747346726F6D537472696E67286A64702C2073747229207B0A2020202069662028216A64702E6F7074696F6E732E64617465292072657475726E205B5D3B0A2020202072657475726E207374722E73756273747228302C20';
wwv_flow_imp.g_varchar2_table(120) := '67657444617465537472696E674C656E677468286A647029292E73706C6974286A64702E6F7074696F6E732E736570617261746F7243686172732E64617465293B0A20207D3B0A20207661722067657454696D65506172747346726F6D537472696E6720';
wwv_flow_imp.g_varchar2_table(121) := '3D2066756E6374696F6E2067657454696D65506172747346726F6D537472696E67286A64702C2073747229207B0A20202020766172207365704F7074203D206A64702E6F7074696F6E732E736570617261746F7243686172733B0A20202020696620286A';
wwv_flow_imp.g_varchar2_table(122) := '64702E6F7074696F6E732E6461746529207B0A2020202020207661722074696D655374617274203D2067657444617465537472696E674C656E677468286A647029202B207365704F70742E6265747765656E2E6C656E6774683B0A202020202020726574';
wwv_flow_imp.g_varchar2_table(123) := '75726E206A64702E6F7074696F6E732E74696D65202626207374722E6C656E677468203E2074696D655374617274203F207374722E7375627374722874696D655374617274292E73706C6974287365704F70742E74696D6529203A205B5D3B0A20202020';
wwv_flow_imp.g_varchar2_table(124) := '7D0A2020202072657475726E207374722E73706C6974287365704F70742E74696D65293B0A20207D3B0A202076617220697356616C696454696D655061727473203D2066756E6374696F6E20697356616C696454696D6550617274732870617274732C20';
wwv_flow_imp.g_varchar2_table(125) := '6861735365636F6E6429207B0A2020202072657475726E2068617356616C6964506172744C656E677468732870617274732C206861735365636F6E64203F205B322C20322C20325D203A205B322C20325D293B0A20207D3B0A2020766172206765745661';
wwv_flow_imp.g_varchar2_table(126) := '6C75654F626A65637446726F6D537472696E67203D2066756E6374696F6E2067657456616C75654F626A65637446726F6D537472696E67286A64702C2073747229207B0A202020207661722064617465203D2067657444617465506172747346726F6D53';
wwv_flow_imp.g_varchar2_table(127) := '7472696E67286A64702C20737472293B0A202020207661722074696D65203D2067657454696D65506172747346726F6D537472696E67286A64702C20737472293B0A2020202072657475726E207B0A202020202020796561723A207061727365496E7428';
wwv_flow_imp.g_varchar2_table(128) := '646174655B305D2C203130292C0A2020202020206D6F6E74683A207061727365496E7428646174655B315D2C203130292C0A2020202020206461793A207061727365496E7428646174655B325D2C203130292C0A202020202020686F75723A2070617273';
wwv_flow_imp.g_varchar2_table(129) := '65496E742874696D655B305D2C20313029207C7C20302C0A2020202020206D696E7574653A207061727365496E742874696D655B315D2C20313029207C7C20302C0A2020202020207365636F6E643A207061727365496E742874696D655B325D2C203130';
wwv_flow_imp.g_varchar2_table(130) := '29207C7C20300A202020207D3B0A20207D3B0A2020766172206765744461746556616C7565537472696E6746726F6D56616C75654F626A65637457697468536570203D2066756E6374696F6E206765744461746556616C7565537472696E6746726F6D56';
wwv_flow_imp.g_varchar2_table(131) := '616C75654F626A65637457697468536570286A64702C206F626A2C20666F7254617267657429207B0A20202020766172206F7074203D206A64702E6F7074696F6E733B0A2020202076617220736570617261746F724368617273203D206F70742E736570';
wwv_flow_imp.g_varchar2_table(132) := '617261746F7243686172733B0A202020207661722064617465203D20666F72546172676574203F20736570617261746F7243686172732E74617267657444617465203A20736570617261746F7243686172732E646174653B0A202020207661722074696D';
wwv_flow_imp.g_varchar2_table(133) := '65203D20666F72546172676574203F20736570617261746F7243686172732E74617267657454696D65203A20736570617261746F7243686172732E74696D653B0A20202020766172206265747765656E203D20666F72546172676574203F207365706172';
wwv_flow_imp.g_varchar2_table(134) := '61746F7243686172732E7461726765744265747765656E203A20736570617261746F7243686172732E6265747765656E3B0A202020207661722064617465537472203D206F70742E64617465203F202222202B206F626A2E79656172202B206461746520';
wwv_flow_imp.g_varchar2_table(135) := '2B206164644C656164696E675A65726F286F626A2E6D6F6E746829202B2064617465202B206164644C656164696E675A65726F286F626A2E64617929203A2022223B0A202020207661722074696D65537472203D206F70742E74696D65203F202222202B';
wwv_flow_imp.g_varchar2_table(136) := '206164644C656164696E675A65726F286F626A2E686F757229202B2074696D65202B206164644C656164696E675A65726F286F626A2E6D696E75746529202B20286F70742E6861735365636F6E64203F2074696D65202B206164644C656164696E675A65';
wwv_flow_imp.g_varchar2_table(137) := '726F286F626A2E7365636F6E6429203A20222229203A2022223B0A20202020766172206265747765656E537472203D20646174655374722026262074696D65537472203F206265747765656E203A2022223B0A2020202072657475726E20646174655374';
wwv_flow_imp.g_varchar2_table(138) := '72202B206265747765656E537472202B2074696D655374723B0A20207D3B0A202076617220676574446174654F6E6C7956616C7565537472696E6757697468536570203D2066756E6374696F6E20676574446174654F6E6C7956616C7565537472696E67';
wwv_flow_imp.g_varchar2_table(139) := '57697468536570286A64702C206F626A2C20666F7254617267657429207B0A202020207661722064617465536570617261746F72203D20666F72546172676574203F206A64702E6F7074696F6E732E736570617261746F7243686172732E746172676574';
wwv_flow_imp.g_varchar2_table(140) := '44617465203A206A64702E6F7074696F6E732E736570617261746F7243686172732E646174653B0A2020202072657475726E202222202B206F626A2E79656172202B2064617465536570617261746F72202B206164644C656164696E675A65726F286F62';
wwv_flow_imp.g_varchar2_table(141) := '6A2E6D6F6E746829202B2064617465536570617261746F72202B206164644C656164696E675A65726F286F626A2E646179293B0A20207D3B0A20207661722067657456616C7565537472696E6746726F6D56616C75654F626A656374203D2066756E6374';
wwv_flow_imp.g_varchar2_table(142) := '696F6E2067657456616C7565537472696E6746726F6D56616C75654F626A656374286A64702C206F626A29207B0A2020202072657475726E206765744461746556616C7565537472696E6746726F6D56616C75654F626A65637457697468536570286A64';
wwv_flow_imp.g_varchar2_table(143) := '702C206F626A293B0A20207D3B0A20207661722061726553616D654461746573203D2066756E6374696F6E2061726553616D654461746573286669727374446174652C207365636F6E644461746529207B0A2020202072657475726E2067657444617465';
wwv_flow_imp.g_varchar2_table(144) := '4E756D6265722866697273744461746529203D3D3D20676574446174654E756D626572287365636F6E6444617465293B0A20207D3B0A202076617220736F72744461746573203D2066756E6374696F6E20736F7274446174657328646174657329207B0A';
wwv_flow_imp.g_varchar2_table(145) := '2020202072657475726E2064617465732E736C69636528292E736F72742866756E6374696F6E20286669727374446174652C207365636F6E644461746529207B0A202020202020766172206669727374446174654E756D626572203D2067657444617465';
wwv_flow_imp.g_varchar2_table(146) := '4E756D62657228666972737444617465293B0A202020202020766172207365636F6E64446174654E756D626572203D20676574446174654E756D626572287365636F6E6444617465293B0A202020202020696620286669727374446174654E756D626572';
wwv_flow_imp.g_varchar2_table(147) := '203C207365636F6E64446174654E756D626572292072657475726E202D313B0A202020202020696620286669727374446174654E756D626572203E207365636F6E64446174654E756D626572292072657475726E20313B0A20202020202072657475726E';
wwv_flow_imp.g_varchar2_table(148) := '20303B0A202020207D293B0A20207D3B0A202076617220697344617465496E52616E6765203D2066756E6374696F6E20697344617465496E52616E676528646174652C207374617274446174652C20656E644461746529207B0A20202020766172206461';
wwv_flow_imp.g_varchar2_table(149) := '74654E756D626572203D20676574446174654E756D6265722864617465293B0A2020202076617220736F727465644461746573203D20736F72744461746573285B7374617274446174652C20656E64446174655D293B0A2020202072657475726E206461';
wwv_flow_imp.g_varchar2_table(150) := '74654E756D626572203E20676574446174654E756D62657228736F7274656444617465735B305D2920262620646174654E756D626572203C20676574446174654E756D62657228736F7274656444617465735B315D293B0A20207D3B0A20207661722067';
wwv_flow_imp.g_varchar2_table(151) := '65744461746553656C656374696F6E56616C7565537472696E67203D2066756E6374696F6E206765744461746553656C656374696F6E56616C7565537472696E67286A64702C2073656C656374656444617465732C20666F7254617267657429207B0A20';
wwv_flow_imp.g_varchar2_table(152) := '202020696620282173656C656374656444617465732E6C656E677468292072657475726E2022223B0A20202020766172206D6F6465203D206A64702E6F7074696F6E732E6D6F6465207C7C202273696E676C65223B0A2020202076617220646174657320';
wwv_flow_imp.g_varchar2_table(153) := '3D206D6F6465203D3D3D202272616E676522203F20736F727444617465732873656C65637465644461746573292E736C69636528302C203229203A2073656C656374656444617465733B0A2020202076617220736570617261746F72203D206D6F646520';
wwv_flow_imp.g_varchar2_table(154) := '3D3D3D202272616E676522203F206A64702E6F7074696F6E732E72616E6765536570617261746F72203A206A64702E6F7074696F6E732E6D756C7469706C65536570617261746F723B0A2020202072657475726E2064617465732E6D61702866756E6374';
wwv_flow_imp.g_varchar2_table(155) := '696F6E20286461746529207B0A20202020202072657475726E20676574446174654F6E6C7956616C7565537472696E6757697468536570286A64702C20646174652C20666F72546172676574293B0A202020207D292E6A6F696E28736570617261746F72';
wwv_flow_imp.g_varchar2_table(156) := '293B0A20207D3B0A20207661722067657453656C6563746564446174657346726F6D537472696E67203D2066756E6374696F6E2067657453656C6563746564446174657346726F6D537472696E67286A64702C2076616C756529207B0A20202020766172';
wwv_flow_imp.g_varchar2_table(157) := '206D6F6465203D206A64702E6F7074696F6E732E6D6F6465207C7C202273696E676C65223B0A20202020696620282176616C7565207C7C206D6F6465203D3D3D202273696E676C6522292072657475726E205B5D3B0A2020202076617220736570617261';
wwv_flow_imp.g_varchar2_table(158) := '746F72203D206D6F6465203D3D3D202272616E676522203F206A64702E6F7074696F6E732E72616E6765536570617261746F72203A206A64702E6F7074696F6E732E6D756C7469706C65536570617261746F723B0A202020207661722064617465506172';
wwv_flow_imp.g_varchar2_table(159) := '7473203D2076616C75652E73706C697428736570617261746F72293B0A202020207661722073656C65637465644461746573203D205B5D3B0A20202020666F7220287661722069203D20303B2069203C206461746550617274732E6C656E6774683B2069';
wwv_flow_imp.g_varchar2_table(160) := '2B2B29207B0A202020202020766172206461746556616C7565203D206461746550617274735B695D2E7472696D28293B0A20202020202069662028697356616C696444617465537472696E67286A64702C206461746556616C75652929207B0A20202020';
wwv_flow_imp.g_varchar2_table(161) := '2020202076617220646174654F626A656374203D2067657456616C75654F626A65637446726F6D537472696E67286A64702C206461746556616C7565293B0A202020202020202073656C656374656444617465732E70757368287B0A2020202020202020';
wwv_flow_imp.g_varchar2_table(162) := '2020796561723A20646174654F626A6563742E796561722C0A202020202020202020206D6F6E74683A20646174654F626A6563742E6D6F6E74682C0A202020202020202020206461793A20646174654F626A6563742E6461790A20202020202020207D29';
wwv_flow_imp.g_varchar2_table(163) := '3B0A2020202020207D0A202020207D0A2020202072657475726E206D6F6465203D3D3D202272616E676522203F20736F727444617465732873656C65637465644461746573292E736C69636528302C203229203A2073656C656374656444617465733B0A';
wwv_flow_imp.g_varchar2_table(164) := '20207D3B0A202076617220697356616C696444617465537472696E67203D2066756E6374696F6E20697356616C696444617465537472696E67286A64702C2073747229207B0A20202020696620282173747229207B0A20202020202072657475726E2066';
wwv_flow_imp.g_varchar2_table(165) := '616C73653B0A202020207D0A2020202072657475726E2068617356616C6964506172744C656E677468732867657444617465506172747346726F6D537472696E67286A64702C20737472292C205B342C20322C20325D293B0A20207D3B0A202076617220';
wwv_flow_imp.g_varchar2_table(166) := '697356616C696454696D65537472696E67203D2066756E6374696F6E20697356616C696454696D65537472696E67286A64702C2073747229207B0A20202020696620282173747229207B0A20202020202072657475726E2066616C73653B0A202020207D';
wwv_flow_imp.g_varchar2_table(167) := '0A2020202072657475726E20697356616C696454696D6550617274732867657454696D65506172747346726F6D537472696E67286A64702C20737472292C206A64702E6F7074696F6E732E6861735365636F6E64293B0A20207D3B0A2020766172206765';
wwv_flow_imp.g_varchar2_table(168) := '74436F6E76657274656456616C7565203D2066756E6374696F6E20676574436F6E76657274656456616C7565286A647029207B0A20202020766172205F6A647024696E7075743B0A202020207661722076616C7565203D20285F6A647024696E70757420';
wwv_flow_imp.g_varchar2_table(169) := '3D206A64702E696E70757429203D3D206E756C6C203F20766F69642030203A205F6A647024696E7075742E76616C75653B0A20202020696620282176616C756529207B0A20202020202072657475726E2022223B0A202020207D0A20202020696620286A';
wwv_flow_imp.g_varchar2_table(170) := '64702E6F7074696F6E732E74617267657456616C75655479706529207B0A20202020202069662028286A64702E6F7074696F6E732E6D6F6465207C7C202273696E676C65222920213D3D202273696E676C652229207B0A20202020202020207661722073';
wwv_flow_imp.g_varchar2_table(171) := '656C65637465644461746573203D2067657453656C6563746564446174657346726F6D537472696E67286A64702C2076616C7565293B0A2020202020202020696620286A64702E6F7074696F6E732E74617267657456616C756554797065203D3D3D2022';
wwv_flow_imp.g_varchar2_table(172) := '677265676F7269616E2229207B0A2020202020202020202076617220677265676F7269616E4461746573203D2073656C656374656444617465732E6D61702866756E6374696F6E20286461746529207B0A20202020202020202020202072657475726E20';
wwv_flow_imp.g_varchar2_table(173) := '5F657874656E6428646174652C20746F477265676F7269616E28646174652E796561722C20646174652E6D6F6E74682C20646174652E64617929293B0A202020202020202020207D293B0A2020202020202020202072657475726E206765744461746553';
wwv_flow_imp.g_varchar2_table(174) := '656C656374696F6E56616C7565537472696E67286A64702C20677265676F7269616E44617465732C2074727565293B0A20202020202020207D0A202020202020202072657475726E2076616C75653B0A2020202020207D0A202020202020766172206E6F';
wwv_flow_imp.g_varchar2_table(175) := '726D616C56616C7565203D2067657456616C75654F626A65637446726F6D537472696E67286A64702C2076616C7565293B0A202020202020696620286A64702E6F7074696F6E732E74617267657456616C756554797065203D3D3D2022677265676F7269';
wwv_flow_imp.g_varchar2_table(176) := '616E2229207B0A202020202020202076617220677265676F7269616E56616C7565203D20746F477265676F7269616E286E6F726D616C56616C75652E796561722C206E6F726D616C56616C75652E6D6F6E74682C206E6F726D616C56616C75652E646179';
wwv_flow_imp.g_varchar2_table(177) := '293B0A202020202020202072657475726E206765744461746556616C7565537472696E6746726F6D56616C75654F626A65637457697468536570286A64702C205F657874656E64286E6F726D616C56616C75652C20677265676F7269616E56616C756529';
wwv_flow_imp.g_varchar2_table(178) := '2C2074727565293B0A2020202020207D0A202020207D0A2020202072657475726E2076616C75653B0A20207D3B0A0A20202F2A203D3D3D3D3D20546F702D77696E646F7720686F7374696E67202872656E646572207069636B65722061626F7665206D6F';
wwv_flow_imp.g_varchar2_table(179) := '64616C20696672616D657329203D3D3D3D3D202A2F0A2020766172204A44505F4353535F4E414D45203D20226A616C616C69646174657069636B65722E637373223B0A202076617220676574486F737457696E646F77203D2066756E6374696F6E206765';
wwv_flow_imp.g_varchar2_table(180) := '74486F737457696E646F772829207B0A20202020747279207B0A2020202020206966202877696E646F772E746F702026262077696E646F772E746F7020213D3D2077696E646F772026262077696E646F772E746F702E646F63756D656E74202626207769';
wwv_flow_imp.g_varchar2_table(181) := '6E646F772E746F702E646F63756D656E742E626F647929207B0A202020202020202072657475726E2077696E646F772E746F703B0A2020202020207D0A202020207D20636174636820286529207B7D0A2020202072657475726E2077696E646F773B0A20';
wwv_flow_imp.g_varchar2_table(182) := '207D3B0A2020766172206973486F737465644F6E546F70203D2066756E6374696F6E206973486F737465644F6E546F702829207B0A2020202072657475726E20676574486F737457696E646F77282920213D3D2077696E646F773B0A20207D3B0A202076';
wwv_flow_imp.g_varchar2_table(183) := '617220656E73757265486F7374437373203D2066756E6374696F6E20656E73757265486F737443737328686F737457696E29207B0A2020202069662028686F737457696E203D3D3D2077696E646F77292072657475726E3B0A2020202076617220686F73';
wwv_flow_imp.g_varchar2_table(184) := '74446F63203D20686F737457696E2E646F63756D656E743B0A2020202069662028686F7374446F632E676574456C656D656E744279496428226A64702D686F73742D6373732229292072657475726E3B0A20202020766172206C696E6B203D20646F6375';
wwv_flow_imp.g_varchar2_table(185) := '6D656E742E717565727953656C6563746F7228276C696E6B5B687265662A3D2227202B204A44505F4353535F4E414D45202B2027225D27293B0A20202020696620286C696E6B29207B0A20202020202076617220636C6F6E65203D20686F7374446F632E';
wwv_flow_imp.g_varchar2_table(186) := '637265617465456C656D656E7428226C696E6B22293B0A202020202020636C6F6E652E6964203D20226A64702D686F73742D637373223B0A202020202020636C6F6E652E72656C203D20227374796C657368656574223B0A202020202020636C6F6E652E';
wwv_flow_imp.g_varchar2_table(187) := '68726566203D206C696E6B2E687265663B0A202020202020686F7374446F632E686561642E617070656E644368696C6428636C6F6E65293B0A20202020202072657475726E3B0A202020207D0A2020202076617220637373203D2022223B0A2020202066';
wwv_flow_imp.g_varchar2_table(188) := '6F7220287661722069203D20303B2069203C20646F63756D656E742E7374796C655368656574732E6C656E6774683B20692B2B29207B0A202020202020747279207B0A20202020202020207661722072756C6573203D20646F63756D656E742E7374796C';
wwv_flow_imp.g_varchar2_table(189) := '655368656574735B695D2E63737352756C6573207C7C205B5D3B0A2020202020202020666F722028766172206A203D20303B206A203C2072756C65732E6C656E6774683B206A2B2B29207B0A202020202020202020206966202872756C65735B6A5D2E63';
wwv_flow_imp.g_varchar2_table(190) := '7373546578742E696E6465784F6628226A64702D2229203E202D312920637373202B3D2072756C65735B6A5D2E63737354657874202B20225C6E223B0A20202020202020207D0A2020202020207D20636174636820286529207B7D0A202020207D0A2020';
wwv_flow_imp.g_varchar2_table(191) := '20206966202863737329207B0A202020202020766172207374203D20686F7374446F632E637265617465456C656D656E7428227374796C6522293B0A20202020202073742E6964203D20226A64702D686F73742D637373223B0A20202020202073742E74';
wwv_flow_imp.g_varchar2_table(192) := '657874436F6E74656E74203D206373733B0A202020202020686F7374446F632E686561642E617070656E644368696C64287374293B0A202020207D0A20207D3B0A2020766172206765744672616D654F6666736574203D2066756E6374696F6E20676574';
wwv_flow_imp.g_varchar2_table(193) := '4672616D654F66667365742829207B0A202020207661722078203D20302C2079203D20302C2077203D2077696E646F773B0A20202020747279207B0A2020202020207768696C6520287720213D3D20772E746F7020262620772E6672616D65456C656D65';
wwv_flow_imp.g_varchar2_table(194) := '6E7429207B0A20202020202020207661722072203D20772E6672616D65456C656D656E742E676574426F756E64696E67436C69656E745265637428293B0A2020202020202020766172206373203D20772E706172656E742E676574436F6D707574656453';
wwv_flow_imp.g_varchar2_table(195) := '74796C6528772E6672616D65456C656D656E74293B0A202020202020202078202B3D20722E6C656674202B20287061727365466C6F61742863732E626F726465724C656674576964746829207C7C203029202B20287061727365466C6F61742863732E70';
wwv_flow_imp.g_varchar2_table(196) := '616464696E674C65667429207C7C2030293B0A202020202020202079202B3D20722E746F70202B20287061727365466C6F61742863732E626F72646572546F70576964746829207C7C203029202B20287061727365466C6F61742863732E70616464696E';
wwv_flow_imp.g_varchar2_table(197) := '67546F7029207C7C2030293B0A202020202020202077203D20772E706172656E743B0A2020202020207D0A202020207D20636174636820286529207B7D0A2020202072657475726E207B20783A20782C20793A2079207D3B0A20207D3B0A202076617220';
wwv_flow_imp.g_varchar2_table(198) := '676574486F7374506172656E74203D2066756E6374696F6E20676574486F7374506172656E7428636F6E7461696E657229207B0A2020202069662028636F6E7461696E657220262620636F6E7461696E657220213D3D2022626F64792220262620636F6E';
wwv_flow_imp.g_varchar2_table(199) := '7461696E657220213D3D20646F63756D656E742E626F647929207B0A20202020202072657475726E20636F6E7461696E65723B0A202020207D0A2020202076617220686F737457696E203D20676574486F737457696E646F7728293B0A20202020656E73';
wwv_flow_imp.g_varchar2_table(200) := '757265486F737443737328686F737457696E293B0A2020202072657475726E20686F737457696E2E646F63756D656E742E626F64793B0A20207D3B0A0A202076617220686F73745374617465203D207B2077696E3A206E756C6C2C206672616D653A206E';
wwv_flow_imp.g_varchar2_table(201) := '756C6C2C2074696D65723A206E756C6C207D3B0A202076617220646574616368486F7374203D2066756E6374696F6E20646574616368486F73742829207B0A20202020766172206877203D20686F737453746174652E77696E3B0A202020206966202821';
wwv_flow_imp.g_varchar2_table(202) := '6877292072657475726E3B0A20202020747279207B0A20202020202068772E646F63756D656E742E72656D6F76654576656E744C697374656E65722822636C69636B222C206F6E486F7374436C69636B43616C6C6261636B2C2074727565293B0A202020';
wwv_flow_imp.g_varchar2_table(203) := '20202068772E646F63756D656E742E72656D6F76654576656E744C697374656E6572284556454E545F4B4559444F574E5F5354522C2068616E646C654573634B6579293B0A20202020202068772E72656D6F76654576656E744C697374656E6572282272';
wwv_flow_imp.g_varchar2_table(204) := '6573697A65222C206F6E526573697A6548616E646C6572293B0A20202020202069662028686F737453746174652E74696D6572292068772E636C656172496E74657276616C28686F737453746174652E74696D6572293B0A202020207D20636174636820';
wwv_flow_imp.g_varchar2_table(205) := '286529207B7D0A20202020686F737453746174652E77696E203D206E756C6C3B0A20202020686F737453746174652E6672616D65203D206E756C6C3B0A20202020686F737453746174652E74696D6572203D206E756C6C3B0A20207D3B0A202076617220';
wwv_flow_imp.g_varchar2_table(206) := '617474616368486F7374203D2066756E6374696F6E20617474616368486F73742829207B0A202020207661722063203D206A616C616C69446174657069636B65722E5F6470436F6E7461696E65723B0A20202020696620282163207C7C20632E6F776E65';
wwv_flow_imp.g_varchar2_table(207) := '72446F63756D656E74203D3D3D20646F63756D656E74292072657475726E3B0A20202020646574616368486F737428293B0A20202020766172206877203D20676574486F737457696E646F7728293B0A20202020747279207B0A20202020202068772E64';
wwv_flow_imp.g_varchar2_table(208) := '6F63756D656E742E6164644576656E744C697374656E65722822636C69636B222C206F6E486F7374436C69636B43616C6C6261636B2C2074727565293B0A20202020202068772E646F63756D656E742E6164644576656E744C697374656E657228455645';
wwv_flow_imp.g_varchar2_table(209) := '4E545F4B4559444F574E5F5354522C2068616E646C654573634B6579293B0A20202020202068772E6164644576656E744C697374656E65722822726573697A65222C206F6E526573697A6548616E646C6572293B0A202020202020686F73745374617465';
wwv_flow_imp.g_varchar2_table(210) := '2E77696E203D2068773B0A202020202020686F737453746174652E6672616D65203D2077696E646F772E6672616D65456C656D656E743B0A202020202020686F737453746174652E74696D6572203D2068772E736574496E74657276616C2866756E6374';
wwv_flow_imp.g_varchar2_table(211) := '696F6E202829207B0A2020202020202020766172206665203D20686F737453746174652E6672616D652C20676F6E65203D20747275653B0A2020202020202020747279207B0A20202020202020202020676F6E65203D20216665207C7C202166652E6973';
wwv_flow_imp.g_varchar2_table(212) := '436F6E6E6563746564207C7C2066652E676574436C69656E74526563747328292E6C656E677468203D3D3D20303B0A20202020202020207D20636174636820286529207B7D0A202020202020202069662028676F6E652920636C65616E7570486F737465';
wwv_flow_imp.g_varchar2_table(213) := '6428293B0A2020202020207D2C20323030293B0A202020207D20636174636820286529207B7D0A2020202077696E646F772E72656D6F76654576656E744C697374656E657228227061676568696465222C20636C65616E7570486F73746564293B0A2020';
wwv_flow_imp.g_varchar2_table(214) := '202077696E646F772E6164644576656E744C697374656E657228227061676568696465222C20636C65616E7570486F73746564293B0A20207D3B0A202076617220636C65616E7570486F73746564203D2066756E6374696F6E20636C65616E7570486F73';
wwv_flow_imp.g_varchar2_table(215) := '7465642829207B0A20202020766172206A6470203D206A616C616C69446174657069636B65723B0A2020202069662028216A6470292072657475726E3B0A20202020747279207B20646574616368486F737428293B207D20636174636820286529207B7D';
wwv_flow_imp.g_varchar2_table(216) := '0A20202020747279207B206A64702E72657665727450656E64696E6728293B207D20636174636820286529207B7D0A20202020747279207B206A64702E697353686F77203D2066616C73653B207D20636174636820286529207B7D0A2020202074727920';
wwv_flow_imp.g_varchar2_table(217) := '7B0A202020202020696620286A64702E5F6470436F6E7461696E6572202626206A64702E5F6470436F6E7461696E65722E706172656E744E6F646529206A64702E5F6470436F6E7461696E65722E706172656E744E6F64652E72656D6F76654368696C64';
wwv_flow_imp.g_varchar2_table(218) := '286A64702E5F6470436F6E7461696E6572293B0A202020202020696620286A64702E6F7665726C6179456C656D656E74202626206A64702E6F7665726C6179456C656D656E742E706172656E744E6F646529206A64702E6F7665726C6179456C656D656E';
wwv_flow_imp.g_varchar2_table(219) := '742E706172656E744E6F64652E72656D6F76654368696C64286A64702E6F7665726C6179456C656D656E74293B0A202020207D20636174636820286529207B7D0A20207D3B0A2020766172204E414D455350414345203D20226A6470223B0A2020766172';
wwv_flow_imp.g_varchar2_table(220) := '204449565F4E414D455350414345203D20226469762E22202B204E414D4553504143453B0A202076617220434F4E5441494E45525F454C454D454E545F5155455259203D204E414D455350414345202B20222D636F6E7461696E6572223B0A2020766172';
wwv_flow_imp.g_varchar2_table(221) := '204F5645524C41595F454C454D454E545F5155455259203D204E414D455350414345202B20222D6F7665726C6179223B0A20207661722059454152535F454C454D454E545F5155455259203D204449565F4E414D455350414345202B20222D7965617273';
wwv_flow_imp.g_varchar2_table(222) := '223B0A202076617220594541525F454C454D454E545F5155455259203D204449565F4E414D455350414345202B20222D79656172223B0A2020766172204D4F4E5448535F454C454D454E545F5155455259203D204449565F4E414D455350414345202B20';
wwv_flow_imp.g_varchar2_table(223) := '222D6D6F6E746873223B0A2020766172204D4F4E54485F454C454D454E545F5155455259203D204449565F4E414D455350414345202B20222D6D6F6E7468223B0A202076617220444159535F454C454D454E545F5155455259203D204449565F4E414D45';
wwv_flow_imp.g_varchar2_table(224) := '5350414345202B20222D64617973223B0A202076617220444159535F4845414445525F454C454D454E545F5155455259203D204449565F4E414D455350414345202B20222D646179732D686561646572223B0A2020766172204441595F454C454D454E54';
wwv_flow_imp.g_varchar2_table(225) := '5F5155455259203D204449565F4E414D455350414345202B20222D646179223B0A2020766172204441595F4E4F545F494E5F4D4F4E54485F454C454D454E545F5155455259203D204449565F4E414D455350414345202B20222D6461792E6E6F742D696E';
wwv_flow_imp.g_varchar2_table(226) := '2D6D6F6E7468223B0A2020766172204441595F44495341424C45445F454C454D454E545F5155455259203D204449565F4E414D455350414345202B20222D6461792E64697361626C65642D646179223B0A2020766172204441595F44495341424C45445F';
wwv_flow_imp.g_varchar2_table(227) := '4E4F545F494E5F4D4F4E54485F454C454D454E545F5155455259203D204441595F4E4F545F494E5F4D4F4E54485F454C454D454E545F5155455259202B20222E64697361626C65642D646179223B0A2020766172204441595F4E414D455F454C454D454E';
wwv_flow_imp.g_varchar2_table(228) := '545F5155455259203D204449565F4E414D455350414345202B20222D6461792D6E616D65223B0A202076617220504C55535F49434F4E5F454C454D454E545F5155455259203D204449565F4E414D455350414345202B20222D69636F6E2D706C7573223B';
wwv_flow_imp.g_varchar2_table(229) := '0A2020766172204D494E55535F49434F4E5F454C454D454E545F5155455259203D204449565F4E414D455350414345202B20222D69636F6E2D6D696E7573223B0A202076617220464F4F5445525F454C454D454E545F5155455259203D204449565F4E41';
wwv_flow_imp.g_varchar2_table(230) := '4D455350414345202B20222D666F6F746572223B0A202076617220544F4441595F425554544F4E5F454C454D454E545F5155455259203D204449565F4E414D455350414345202B20222D62746E2D746F646179223B0A202076617220454D5054595F4255';
wwv_flow_imp.g_varchar2_table(231) := '54544F4E5F454C454D454E545F5155455259203D204449565F4E414D455350414345202B20222D62746E2D656D707479223B0A202076617220434C4F53455F425554544F4E5F454C454D454E545F5155455259203D204449565F4E414D45535041434520';
wwv_flow_imp.g_varchar2_table(232) := '2B20222D62746E2D636C6F7365223B0A202076617220434F4E4649524D5F425554544F4E5F454C454D454E545F5155455259203D204449565F4E414D455350414345202B20222D62746E2D636F6E6669726D223B0A202076617220464F4F5445525F5449';
wwv_flow_imp.g_varchar2_table(233) := '4D455F454C454D454E545F5155455259203D204449565F4E414D455350414345202B20222D74696D652D636F6E7461696E6572223B0A20207661722054494D455F44524F50444F574E5F504152454E545F454C454D454E545F5155455259203D20444956';
wwv_flow_imp.g_varchar2_table(234) := '5F4E414D455350414345202B20222D74696D65223B0A20207661722053454C45435445445F434C4153535F4E414D45203D202273656C6563746564223B0A202076617220544F4441595F434C4153535F4E414D45203D2022746F646179223B0A20207661';
wwv_flow_imp.g_varchar2_table(235) := '72204C4153545F5745454B5F434C4153535F4E414D45203D20226C6173742D7765656B223B0A20207661722044495341424C455F434C4153535F4E414D45203D20226E6F742D696E2D72616E6765223B0A202076617220484F4C494441595F434C415353';
wwv_flow_imp.g_varchar2_table(236) := '5F4E414D45203D2022686F6C696461792D646179223B0A20207661722052414E47455F53544152545F434C4153535F4E414D45203D202272616E67652D7374617274223B0A20207661722052414E47455F454E445F434C4153535F4E414D45203D202272';
wwv_flow_imp.g_varchar2_table(237) := '616E67652D656E64223B0A202076617220494E5F52414E47455F434C4153535F4E414D45203D2022696E2D72616E6765223B0A2020766172204556454E545F4348414E47455F494E5055545F535452203D204E414D455350414345202B20223A6368616E';
wwv_flow_imp.g_varchar2_table(238) := '6765223B0A2020766172204556454E545F4348414E47455F4D4F4E54485F44524F50444F574E5F535452203D20226368616E6765223B0A2020766172204556454E545F4348414E47455F54494D455F44524F50444F574E5F535452203D204556454E545F';
wwv_flow_imp.g_varchar2_table(239) := '4348414E47455F4D4F4E54485F44524F50444F574E5F5354523B0A2020766172204556454E545F4348414E47455F594541525F494E5055545F535452203D20226B65797570206368616E6765223B0A2020766172204556454E545F434C49434B5F535452';
wwv_flow_imp.g_varchar2_table(240) := '203D2022636C69636B223B0A2020766172204556454E545F464F4355535F535452203D2022666F637573696E223B0A2020766172204556454E545F4B4559444F574E5F535452203D20226B6579646F776E223B0A2020766172204D494E5F4D41585F544F';
wwv_flow_imp.g_varchar2_table(241) := '4441595F53455454494E47203D2022746F646179223B0A2020766172204F5054494F4E5F415454525F53455454494E47203D202261747472223B0A202076617220444154415F4A4450203D2022646174612D6A64702D223B0A202076617220494E49545F';
wwv_flow_imp.g_varchar2_table(242) := '444154455F415454525F4E414D45203D20444154415F4A4450202B2022696E69742D64617465223B0A2020766172204D41585F444154455F415454525F4E414D45203D20444154415F4A4450202B20226D61782D64617465223B0A2020766172204D494E';
wwv_flow_imp.g_varchar2_table(243) := '5F444154455F415454525F4E414D45203D20444154415F4A4450202B20226D696E2D64617465223B0A2020766172204D41585F54494D455F415454525F4E414D45203D20444154415F4A4450202B20226D61782D74696D65223B0A2020766172204D494E';
wwv_flow_imp.g_varchar2_table(244) := '5F54494D455F415454525F4E414D45203D20444154415F4A4450202B20226D696E2D74696D65223B0A2020766172205441524745545F56414C55455F494E5055545F415454525F4E414D45203D20444154415F4A4450202B20227461726765742D76616C';
wwv_flow_imp.g_varchar2_table(245) := '75652D696E707574223B0A2020766172205441524745545F56414C55455F545950455F415454525F4E414D45203D20444154415F4A4450202B20227461726765742D76616C75652D74797065223B0A2020766172204D4F44455F415454525F4E414D4520';
wwv_flow_imp.g_varchar2_table(246) := '3D20444154415F4A4450202B20226D6F6465223B0A2020766172204841535F5345434F4E445F415454525F4E414D45203D20444154415F4A4450202B20226861732D7365636F6E64223B0A2020766172204F4E4C595F444154455F415454525F53455454';
wwv_flow_imp.g_varchar2_table(247) := '494E475F4D41585F415454525F4E414D45203D20444154415F4A4450202B20226F6E6C792D64617465223B0A2020766172204F4E4C595F54494D455F415454525F53455454494E475F4D41585F415454525F4E414D45203D20444154415F4A4450202B20';
wwv_flow_imp.g_varchar2_table(248) := '226F6E6C792D74696D65223B0A20207661722044454641554C545F44415953203D205B22D8B4222C2022DB8C222C2022D8AF222C2022D8B3222C2022DA86222C2022D9BE222C2022D8AC225D3B0A20207661722044454641554C545F4D4F4E544853203D';
wwv_flow_imp.g_varchar2_table(249) := '205B22D981D8B1D988D8B1D8AFDB8CD986222C2022D8A7D8B1D8AFDB8CD8A8D987D8B4D8AA222C2022D8AED8B1D8AFD8A7D8AF222C2022D8AADB8CD8B1222C2022D985D8B1D8AFD8A7D8AF222C2022D8B4D987D8B1DB8CD988D8B1222C2022D985D987D8';
wwv_flow_imp.g_varchar2_table(250) := 'B1222C2022D8A2D8A8D8A7D986222C2022D8A2D8B0D8B1222C2022D8AFDB8C222C2022D8A8D987D985D986222C2022D8A7D8B3D981D986D8AF225D3B0A20207661722044454641554C545F534550415241544F525F4348415253203D207B0A2020202064';
wwv_flow_imp.g_varchar2_table(251) := '6174653A20222F222C0A202020206265747765656E3A202220222C0A2020202074696D653A20223A222C0A20202020746172676574446174653A20222D222C0A202020207461726765744265747765656E3A202220222C0A202020207461726765745469';
wwv_flow_imp.g_varchar2_table(252) := '6D653A20223A220A20207D3B0A202076617220544F4441595F444154455F4F5054494F4E5F4E414D4553203D205B22696E697444617465222C20226D696E44617465222C20226D617844617465225D3B0A202076617220415454525F4F5054494F4E5F4E';
wwv_flow_imp.g_varchar2_table(253) := '414D4553203D207B0A20202020696E6974446174653A20494E49545F444154455F415454525F4E414D452C0A202020206D696E446174653A204D494E5F444154455F415454525F4E414D452C0A202020206D6178446174653A204D41585F444154455F41';
wwv_flow_imp.g_varchar2_table(254) := '5454525F4E414D452C0A202020206D696E54696D653A204D494E5F54494D455F415454525F4E414D452C0A202020206D617854696D653A204D41585F54494D455F415454525F4E414D452C0A2020202074617267657456616C7565496E7075743A205441';
wwv_flow_imp.g_varchar2_table(255) := '524745545F56414C55455F494E5055545F415454525F4E414D452C0A2020202074617267657456616C7565547970653A205441524745545F56414C55455F545950455F415454525F4E414D452C0A202020206D6F64653A204D4F44455F415454525F4E41';
wwv_flow_imp.g_varchar2_table(256) := '4D452C0A202020206861735365636F6E643A204841535F5345434F4E445F415454525F4E414D450A20207D3B0A20207661722054494D455F415454525F4F5054494F4E5F4E414D4553203D205B226D696E54696D65222C20226D617854696D65225D3B0A';
wwv_flow_imp.g_varchar2_table(257) := '20207661722053454C454354494F4E5F4D4F44455F4E414D4553203D205B2273696E676C65222C202272616E6765222C20226D756C7469706C65225D3B0A20207661722044454641554C545F52414E47455F534550415241544F52203D2022202D20223B';
wwv_flow_imp.g_varchar2_table(258) := '0A20207661722044454641554C545F4D554C5449504C455F534550415241544F52203D20222C20223B0A20207661722044454641554C545F504C55535F48544D4C203D20273C7376672076696577426F783D2230203020313032342031303234223E3C67';
wwv_flow_imp.g_varchar2_table(259) := '3E3C7061746820643D224D38313020353534682D32353676323536682D3834762D323536682D323536762D383468323536762D32353668383476323536683235367638347A223E3C2F706174683E3C2F673E3C2F7376673E273B0A202076617220444546';
wwv_flow_imp.g_varchar2_table(260) := '41554C545F4D494E55535F48544D4C203D20273C7376672076696577426F783D2230203020313032342031303234223E3C673E3C7061746820643D224D38313020353534682D353936762D3834683539367638347A223E3C2F706174683E3C2F673E3C2F';
wwv_flow_imp.g_varchar2_table(261) := '7376673E273B0A2020766172205354594C455F5649534942494C4954595F56495349424C45203D202276697369626C65223B0A2020766172205354594C455F5649534942494C4954595F48494444454E203D202268696464656E223B0A20207661722053';
wwv_flow_imp.g_varchar2_table(262) := '54594C455F444953504C41595F424C4F434B203D2022626C6F636B223B0A2020766172205354594C455F444953504C41595F48494444454E203D20226E6F6E65223B0A2020766172205354594C455F504F534954494F4E5F4649584544203D2022666978';
wwv_flow_imp.g_varchar2_table(263) := '6564223B0A2020766172205F6765745363726F6C6C506172656E74203D2066756E6374696F6E206765745363726F6C6C506172656E74286E6F646529207B0A20202020696620285B2268746D6C222C2022626F6479222C202223646F63756D656E74225D';
wwv_flow_imp.g_varchar2_table(264) := '2E696E6465784F6628286E6F64652E6E6F64654E616D65207C7C202222292E746F4C6F77657243617365282929203E3D203029207B0A20202020202072657475726E2077696E646F773B0A202020207D0A20202020696620286E6F646520696E7374616E';
wwv_flow_imp.g_varchar2_table(265) := '63656F662048544D4C456C656D656E7429207B0A202020202020766172205F77696E646F7724676574436F6D70757465645374203D2077696E646F772E676574436F6D70757465645374796C65286E6F6465292C0A20202020202020206F766572666C6F';
wwv_flow_imp.g_varchar2_table(266) := '77203D205F77696E646F7724676574436F6D707574656453742E6F766572666C6F772C0A20202020202020206F766572666C6F7758203D205F77696E646F7724676574436F6D707574656453742E6F766572666C6F77582C0A20202020202020206F7665';
wwv_flow_imp.g_varchar2_table(267) := '72666C6F7759203D205F77696E646F7724676574436F6D707574656453742E6F766572666C6F77593B0A202020202020696620282F6175746F7C7363726F6C6C7C6F7665726C61792F2E74657374286F766572666C6F77202B206F766572666C6F775920';
wwv_flow_imp.g_varchar2_table(268) := '2B206F766572666C6F77582929207B0A202020202020202072657475726E206E6F64653B0A2020202020207D0A202020207D0A2020202072657475726E205F6765745363726F6C6C506172656E74286E6F64652E706172656E744E6F6465293B0A20207D';
wwv_flow_imp.g_varchar2_table(269) := '3B0A2020766172206765744576656E74546172676574203D2066756E6374696F6E206765744576656E74546172676574286576656E7429207B0A20202020747279207B0A20202020202069662028697346756E6374696F6E286576656E742E636F6D706F';
wwv_flow_imp.g_varchar2_table(270) := '736564506174682929207B0A202020202020202072657475726E206576656E742E636F6D706F7365645061746828295B305D3B0A2020202020207D0A20202020202072657475726E206576656E742E7461726765743B0A202020207D2063617463682028';
wwv_flow_imp.g_varchar2_table(271) := '6572726F7229207B0A20202020202072657475726E206576656E742E7461726765743B0A202020207D0A20207D3B0A202076617220636F6E7461696E73446F6D203D2066756E6374696F6E20636F6E7461696E73446F6D28706172656E742C206576656E';
wwv_flow_imp.g_varchar2_table(272) := '7429207B0A202020207661722070617468203D206576656E742E70617468207C7C206576656E742E636F6D706F73656450617468202626206576656E742E636F6D706F736564506174682829207C7C2066616C73653B0A20202020696620282170617468';
wwv_flow_imp.g_varchar2_table(273) := '29207B0A20202020202072657475726E20706172656E742E6F7574657248544D4C2E696E6465784F66286576656E742E7461726765742E6F7574657248544D4C29203E202D313B0A202020207D0A2020202072657475726E20706174682E696E6465784F';
wwv_flow_imp.g_varchar2_table(274) := '6628706172656E742920213D3D202D313B0A20207D3B0A2020766172206372656174654576656E74203D2066756E6374696F6E206372656174654576656E74286E616D6529207B0A202020207661722065203D20646F63756D656E742E63726561746545';
wwv_flow_imp.g_varchar2_table(275) := '76656E7428224576656E7422293B0A20202020652E696E69744576656E74286E616D652C20747275652C2074727565293B0A2020202072657475726E20653B0A20207D3B0A202076617220747269676765724576656E74203D2066756E6374696F6E2074';
wwv_flow_imp.g_varchar2_table(276) := '7269676765724576656E7428656C6D2C206576656E7429207B0A202020206966202821656C6D292072657475726E3B0A20202020656C6D2E64697370617463684576656E74286372656174654576656E74286576656E7429293B0A202020207B0A202020';
wwv_flow_imp.g_varchar2_table(277) := '202020656C6D2E64697370617463684576656E74286372656174654576656E7428226368616E67652229293B0A202020202020656C6D2E64697370617463684576656E74286372656174654576656E742822696E7075742229293B0A202020207D0A2020';
wwv_flow_imp.g_varchar2_table(278) := '7D3B0A2020766172206164644C697374656E65724D756C7469203D2066756E6374696F6E206164644C697374656E65724D756C746928656C656D656E742C206576656E744E616D65732C206C697374656E657229207B0A20202020766172206576656E74';
wwv_flow_imp.g_varchar2_table(279) := '73203D206576656E744E616D65732E73706C697428222022293B0A20202020666F7220287661722069203D20302C20694C656E203D206576656E74732E6C656E6774683B2069203C20694C656E3B20692B2B29207B0A202020202020656C656D656E742E';
wwv_flow_imp.g_varchar2_table(280) := '6164644576656E744C697374656E6572286576656E74735B695D2C206C697374656E65722C2066616C7365293B0A202020207D0A20207D3B0A202076617220736574496E6E657248544D4C203D2066756E6374696F6E20736574496E6E657248544D4C28';
wwv_flow_imp.g_varchar2_table(281) := '656C656D656E742C2068746D6C29207B0A20202020656C656D656E742E696E6E657248544D4C203D2068746D6C3B0A20207D3B0A202076617220637265617465456C656D656E74203D2066756E6374696F6E20637265617465456C656D656E7428746167';
wwv_flow_imp.g_varchar2_table(282) := '2C20706172656E742C206576656E744E616D65732C206576656E742C20636F6E74656E742C20636F6E74656E744D6F646529207B0A2020202069662028636F6E74656E744D6F6465203D3D3D20766F6964203029207B0A202020202020636F6E74656E74';
wwv_flow_imp.g_varchar2_table(283) := '4D6F6465203D202274657874223B0A202020207D0A202020207661722073706C697473203D207461672E73706C697428222E22293B0A20202020746167203D2073706C6974732E73686966742829207C7C2022646976223B0A2020202076617220636C61';
wwv_flow_imp.g_varchar2_table(284) := '73734E616D65203D2073706C6974733B0A2020202076617220656C656D656E74203D2077696E646F772E646F63756D656E742E637265617465456C656D656E7428746167293B0A20202020696620286973537472696E6728706172656E742929207B0A20';
wwv_flow_imp.g_varchar2_table(285) := '202020202076617220706172656E74456C656D656E74203D2077696E646F772E646F63756D656E742E717565727953656C6563746F7228706172656E74293B0A2020202020206966202821706172656E74456C656D656E7429207B0A2020202020202020';
wwv_flow_imp.g_varchar2_table(286) := '7468726F77206E6577204572726F722822506172656E7420656C656D656E74206E6F7420666F756E643A2022202B20706172656E74293B0A2020202020207D0A202020202020706172656E74456C656D656E742E617070656E644368696C6428656C656D';
wwv_flow_imp.g_varchar2_table(287) := '656E74293B0A202020207D20656C7365207B0A202020202020706172656E742E617070656E644368696C6428656C656D656E74293B0A202020207D0A2020202069662028636C6173734E616D652E6C656E67746829207B0A202020202020656C656D656E';
wwv_flow_imp.g_varchar2_table(288) := '742E636C6173734E616D65203D20636C6173734E616D652E6A6F696E28222022293B0A202020207D0A20202020696620286576656E744E616D6573202626206576656E7429207B0A2020202020206164644C697374656E65724D756C746928656C656D65';
wwv_flow_imp.g_varchar2_table(289) := '6E742C206576656E744E616D65732C206576656E74293B0A202020207D0A2020202069662028216973556E646566696E656428636F6E74656E742929207B0A20202020202069662028636F6E74656E744D6F6465203D3D3D202268746D6C2229207B0A20';
wwv_flow_imp.g_varchar2_table(290) := '20202020202020736574496E6E657248544D4C28656C656D656E742C20636F6E74656E74293B0A2020202020207D20656C7365207B0A2020202020202020656C656D656E742E74657874436F6E74656E74203D20636F6E74656E743B0A2020202020207D';
wwv_flow_imp.g_varchar2_table(291) := '0A202020207D0A2020202072657475726E20656C656D656E743B0A20207D3B0A202076617220746F5065727369616E44696769747349664E6565646564203D2066756E6374696F6E20746F5065727369616E44696769747349664E656564656428646174';
wwv_flow_imp.g_varchar2_table(292) := '612C20636F6E7665727429207B0A2020202069662028636F6E76657274292072657475726E20646174612E746F537472696E6728292E7265706C616365282F5C642F672C2066756E6374696F6E20286429207B0A20202020202072657475726E2022DBB0';
wwv_flow_imp.g_varchar2_table(293) := 'DBB1DBB2DBB3DBB4DBB5DBB6DBB7DBB8DBB9225B7061727365496E7428642C203130295D3B0A202020207D293B0A2020202072657475726E20646174613B0A20207D3B0A20207661722067657441727261794E756D62657273537472696E67546F203D20';
wwv_flow_imp.g_varchar2_table(294) := '66756E6374696F6E2067657441727261794E756D62657273537472696E67546F286D696E2C206D61782C20696E6372656D656E7429207B0A20202020766172206974656D73203D205B5D3B0A202020206966202821696E6372656D656E74207C7C20696E';
wwv_flow_imp.g_varchar2_table(295) := '6372656D656E74203C3D203029207B0A202020202020696E6372656D656E74203D20313B0A202020207D0A20202020666F7220287661722069203D206D696E3B2069203C3D206D61783B2069202B3D20696E6372656D656E7429206974656D732E707573';
wwv_flow_imp.g_varchar2_table(296) := '68286164644C656164696E675A65726F286929293B0A2020202072657475726E206974656D733B0A20207D3B0A20207661722067657453656C656374656454696D6550617274203D2066756E6374696F6E2067657453656C656374656454696D65506172';
wwv_flow_imp.g_varchar2_table(297) := '74286576656E7429207B0A2020202072657475726E204E756D626572286576656E742E7461726765742E76616C7565293B0A20207D3B0A2020766172206765744D696E54696D65203D2066756E6374696F6E206765744D696E54696D65286A647029207B';
wwv_flow_imp.g_varchar2_table(298) := '0A2020202072657475726E205F657874656E64287B0A202020202020686F75723A20302C0A2020202020206D696E7574653A20302C0A2020202020207365636F6E643A20300A202020207D2C206A64702E6F7074696F6E732E6D696E54696D65207C7C20';
wwv_flow_imp.g_varchar2_table(299) := '7B7D293B0A20207D3B0A2020766172206765744D617854696D65203D2066756E6374696F6E206765744D617854696D65286A647029207B0A2020202072657475726E205F657874656E64287B0A202020202020686F75723A2032332C0A2020202020206D';
wwv_flow_imp.g_varchar2_table(300) := '696E7574653A2035392C0A2020202020207365636F6E643A2035390A202020207D2C206A64702E6F7074696F6E732E6D617854696D65207C7C207B7D293B0A20207D3B0A2020766172206765744D696E7574654974656D73203D2066756E6374696F6E20';
wwv_flow_imp.g_varchar2_table(301) := '6765744D696E7574654974656D73286A64702C206D696E54696D652C206D617854696D6529207B0A20202020696620286D696E54696D652E686F7572203D3D3D206D617854696D652E686F757229207B0A20202020202072657475726E20676574417272';
wwv_flow_imp.g_varchar2_table(302) := '61794E756D62657273537472696E67546F286D696E54696D652E6D696E7574652C206D617854696D652E6D696E7574652C206A64702E6F7074696F6E732E6D696E757465496E6372656D656E74293B0A202020207D0A20202020696620286A64702E696E';
wwv_flow_imp.g_varchar2_table(303) := '697454696D652E686F7572203D3D3D206D696E54696D652E686F757229207B0A20202020202072657475726E2067657441727261794E756D62657273537472696E67546F286D696E54696D652E6D696E7574652C2035392C206A64702E6F7074696F6E73';
wwv_flow_imp.g_varchar2_table(304) := '2E6D696E757465496E6372656D656E74293B0A202020207D0A20202020696620286A64702E696E697454696D652E686F7572203D3D3D206D617854696D652E686F757229207B0A20202020202072657475726E2067657441727261794E756D6265727353';
wwv_flow_imp.g_varchar2_table(305) := '7472696E67546F28302C206D617854696D652E6D696E7574652C206A64702E6F7074696F6E732E6D696E757465496E6372656D656E74293B0A202020207D0A2020202072657475726E2067657441727261794E756D62657273537472696E67546F28302C';
wwv_flow_imp.g_varchar2_table(306) := '2035392C206A64702E6F7074696F6E732E6D696E757465496E6372656D656E74293B0A20207D3B0A2020766172206765745365636F6E644974656D73203D2066756E6374696F6E206765745365636F6E644974656D73286A64702C206D696E54696D652C';
wwv_flow_imp.g_varchar2_table(307) := '206D617854696D6529207B0A20202020696620286D696E54696D652E686F7572203D3D3D206D617854696D652E686F7572202626206D696E54696D652E6D696E757465203D3D3D206D617854696D652E6D696E75746529207B0A20202020202072657475';
wwv_flow_imp.g_varchar2_table(308) := '726E2067657441727261794E756D62657273537472696E67546F286D696E54696D652E7365636F6E642C206D617854696D652E7365636F6E64293B0A202020207D0A20202020696620286A64702E696E697454696D652E686F7572203D3D3D206D696E54';
wwv_flow_imp.g_varchar2_table(309) := '696D652E686F7572202626206A64702E696E697454696D652E6D696E757465203D3D3D206D696E54696D652E6D696E75746529207B0A20202020202072657475726E2067657441727261794E756D62657273537472696E67546F286D696E54696D652E73';
wwv_flow_imp.g_varchar2_table(310) := '65636F6E642C203539293B0A202020207D0A20202020696620286A64702E696E697454696D652E686F7572203D3D3D206D617854696D652E686F7572202626206A64702E696E697454696D652E6D696E757465203D3D3D206D617854696D652E6D696E75';
wwv_flow_imp.g_varchar2_table(311) := '746529207B0A20202020202072657475726E2067657441727261794E756D62657273537472696E67546F28302C206D617854696D652E7365636F6E64293B0A202020207D0A2020202072657475726E2067657441727261794E756D62657273537472696E';
wwv_flow_imp.g_varchar2_table(312) := '67546F28302C203539293B0A20207D3B0A20207661722074696D6544726F70646F776E52656E646572203D2066756E6374696F6E2074696D6544726F70646F776E52656E646572286A64702C2074696D655069636B6572436F6E7461696E65722C207479';
wwv_flow_imp.g_varchar2_table(313) := '706529207B0A20202020766172206765744974656D466F7254797065203D2066756E6374696F6E206765744974656D466F72547970652829207B0A202020202020766172206D696E54696D65203D206765744D696E54696D65286A6470293B0A20202020';
wwv_flow_imp.g_varchar2_table(314) := '2020766172206D617854696D65203D206765744D617854696D65286A6470293B0A2020202020206966202874797065203D3D3D2022686F75722229207B0A202020202020202072657475726E2067657441727261794E756D62657273537472696E67546F';
wwv_flow_imp.g_varchar2_table(315) := '286D696E54696D652E686F75722C206D617854696D652E686F75722C206A64702E6F7074696F6E732E686F7572496E6372656D656E74293B0A2020202020207D0A2020202020206966202874797065203D3D3D20226D696E7574652229207B0A20202020';
wwv_flow_imp.g_varchar2_table(316) := '2020202072657475726E206765744D696E7574654974656D73286A64702C206D696E54696D652C206D617854696D65293B0A2020202020207D0A20202020202072657475726E206765745365636F6E644974656D73286A64702C206D696E54696D652C20';
wwv_flow_imp.g_varchar2_table(317) := '6D617854696D65293B0A202020207D3B0A2020202076617220636F6E7461696E6572203D20637265617465456C656D656E742854494D455F44524F50444F574E5F504152454E545F454C454D454E545F51554552592C2074696D655069636B6572436F6E';
wwv_flow_imp.g_varchar2_table(318) := '7461696E6572293B0A202020207661722064726F70646F776E436F6E7461696E6572203D20637265617465456C656D656E74282273656C656374222C20636F6E7461696E65722C204556454E545F4348414E47455F54494D455F44524F50444F574E5F53';
wwv_flow_imp.g_varchar2_table(319) := '54522C2066756E6374696F6E20286576656E7429207B0A202020202020766172205F6E6F726D616C697A654D696E4D617854696D653B0A2020202020206A64702E73657456616C7565286E6F726D616C697A654D696E4D617854696D65286A64702C206A';
wwv_flow_imp.g_varchar2_table(320) := '64702E696E697454696D652C20285F6E6F726D616C697A654D696E4D617854696D65203D207B7D2C205F6E6F726D616C697A654D696E4D617854696D655B747970655D203D2067657453656C656374656454696D6550617274286576656E74292C205F6E';
wwv_flow_imp.g_varchar2_table(321) := '6F726D616C697A654D696E4D617854696D652929293B0A202020207D293B0A2020202064726F70646F776E436F6E7461696E65722E746162496E646578203D202D313B0A20202020766172206974656D73203D206765744974656D466F72547970652829';
wwv_flow_imp.g_varchar2_table(322) := '3B0A20202020666F7220287661722069203D20303B2069203C206974656D732E6C656E6774683B20692B2B29207B0A2020202020207661722063757272656E744974656D203D206974656D735B695D3B0A202020202020766172206F7074696F6E456C65';
wwv_flow_imp.g_varchar2_table(323) := '6D656E74203D20637265617465456C656D656E7428226F7074696F6E222C2064726F70646F776E436F6E7461696E6572293B0A2020202020206F7074696F6E456C656D656E742E76616C7565203D2063757272656E744974656D2E746F537472696E6728';
wwv_flow_imp.g_varchar2_table(324) := '293B0A2020202020206F7074696F6E456C656D656E742E74657874203D20746F5065727369616E44696769747349664E65656465642863757272656E744974656D2C206A64702E6F7074696F6E732E7065727369616E446967697473292E746F53747269';
wwv_flow_imp.g_varchar2_table(325) := '6E6728293B0A2020202020206F7074696F6E456C656D656E742E73656C6563746564203D207061727365496E742863757272656E744974656D29203D3D3D204E756D626572286A64702E67657456616C75655B747970655D207C7C206A64702E696E6974';
wwv_flow_imp.g_varchar2_table(326) := '54696D655B747970655D293B0A202020207D0A20207D3B0A20207661722072656E64657254696D655069636B6572203D2066756E6374696F6E2072656E64657254696D655069636B6572286A647029207B0A2020202076617220656C656D656E74517565';
wwv_flow_imp.g_varchar2_table(327) := '7279203D20464F4F5445525F54494D455F454C454D454E545F5155455259202B20286A64702E6F7074696F6E732E74696D6520262620216A64702E6F7074696F6E732E64617465203F20222E6A64702D6F6E6C792D74696D6522203A202222293B0A2020';
wwv_flow_imp.g_varchar2_table(328) := '20207661722074696D655069636B6572436F6E7461696E6572203D20637265617465456C656D656E7428656C656D656E7451756572792C206A64702E6470436F6E7461696E6572293B0A20202020696620286A64702E6F7074696F6E732E686173536563';
wwv_flow_imp.g_varchar2_table(329) := '6F6E6429207B0A20202020202074696D6544726F70646F776E52656E646572286A64702C2074696D655069636B6572436F6E7461696E65722C20227365636F6E6422293B0A202020207D0A2020202074696D6544726F70646F776E52656E646572286A64';
wwv_flow_imp.g_varchar2_table(330) := '702C2074696D655069636B6572436F6E7461696E65722C20226D696E75746522293B0A2020202074696D6544726F70646F776E52656E646572286A64702C2074696D655069636B6572436F6E7461696E65722C2022686F757222293B0A20207D3B0A2020';
wwv_flow_imp.g_varchar2_table(331) := '766172206765744C6173745765656B436C61737349664E6563657373617279203D2066756E6374696F6E206765744C6173745765656B436C61737349664E6563657373617279286461794F665765656B29207B0A2020202072657475726E206461794F66';
wwv_flow_imp.g_varchar2_table(332) := '5765656B203D3D3D2036203F20222E22202B204C4153545F5745454B5F434C4153535F4E414D45202B20222E22202B20484F4C494441595F434C4153535F4E414D45203A2022223B0A20207D3B0A2020766172206765744461746546726F6D4461794F70';
wwv_flow_imp.g_varchar2_table(333) := '74696F6E73203D2066756E6374696F6E206765744461746546726F6D4461794F7074696F6E73286461794F7074696F6E7329207B0A2020202072657475726E207B0A202020202020796561723A206461794F7074696F6E732E796561722C0A2020202020';
wwv_flow_imp.g_varchar2_table(334) := '206D6F6E74683A206461794F7074696F6E732E6D6F6E74682C0A2020202020206461793A206461794F7074696F6E732E6461790A202020207D3B0A20207D3B0A20207661722067657453656C656374696F6E436C6173734E616D65203D2066756E637469';
wwv_flow_imp.g_varchar2_table(335) := '6F6E2067657453656C656374696F6E436C6173734E616D65286A64702C206461794F7074696F6E7329207B0A202020207661722064617944617465203D206765744461746546726F6D4461794F7074696F6E73286461794F7074696F6E73293B0A202020';
wwv_flow_imp.g_varchar2_table(336) := '20766172206D6F6465203D206A64702E6F7074696F6E732E6D6F6465207C7C202273696E676C65223B0A20202020696620286D6F6465203D3D3D202273696E676C652229207B0A20202020202072657475726E206A64702E696E70757456616C75652E64';
wwv_flow_imp.g_varchar2_table(337) := '6179203D3D3D206461794F7074696F6E732E646179202626206A64702E696E70757456616C75652E79656172203D3D3D206461794F7074696F6E732E79656172202626206A64702E696E70757456616C75652E6D6F6E7468203D3D3D206461794F707469';
wwv_flow_imp.g_varchar2_table(338) := '6F6E732E6D6F6E7468203F20222E22202B2053454C45435445445F434C4153535F4E414D45203A2022223B0A202020207D0A20202020696620286D6F6465203D3D3D20226D756C7469706C652229207B0A202020202020666F7220287661722069203D20';
wwv_flow_imp.g_varchar2_table(339) := '303B2069203C206A64702E73656C656374656444617465732E6C656E6774683B20692B2B29207B0A20202020202020206966202861726553616D65446174657328646179446174652C206A64702E73656C656374656444617465735B695D292920726574';
wwv_flow_imp.g_varchar2_table(340) := '75726E20222E22202B2053454C45435445445F434C4153535F4E414D453B0A2020202020207D0A20202020202072657475726E2022223B0A202020207D0A2020202069662028216A64702E73656C656374656444617465732E6C656E6774682920726574';
wwv_flow_imp.g_varchar2_table(341) := '75726E2022223B0A202020206966202861726553616D65446174657328646179446174652C206A64702E73656C656374656444617465735B305D29292072657475726E20222E22202B2053454C45435445445F434C4153535F4E414D45202B20222E2220';
wwv_flow_imp.g_varchar2_table(342) := '2B2052414E47455F53544152545F434C4153535F4E414D453B0A20202020696620286A64702E73656C656374656444617465732E6C656E677468203D3D3D20322026262061726553616D65446174657328646179446174652C206A64702E73656C656374';
wwv_flow_imp.g_varchar2_table(343) := '656444617465735B315D29292072657475726E20222E22202B2053454C45435445445F434C4153535F4E414D45202B20222E22202B2052414E47455F454E445F434C4153535F4E414D453B0A20202020696620286A64702E73656C656374656444617465';
wwv_flow_imp.g_varchar2_table(344) := '732E6C656E677468203D3D3D203220262620697344617465496E52616E676528646179446174652C206A64702E73656C656374656444617465735B305D2C206A64702E73656C656374656444617465735B315D29292072657475726E20222E22202B2049';
wwv_flow_imp.g_varchar2_table(345) := '4E5F52414E47455F434C4153535F4E414D453B0A2020202072657475726E2022223B0A20207D3B0A202076617220637265617465456C656D656E74506C75734D696E7573203D2066756E6374696F6E20637265617465456C656D656E74506C75734D696E';
wwv_flow_imp.g_varchar2_table(346) := '7573286A64702C20636F6E7461696E65722C206973596561722C206D6F646529207B0A20202020766172205F6A6470246F7074696F6E73246D617844617465322C205F6A6470246F7074696F6E73246D617844617465332C205F6A6470246F7074696F6E';
wwv_flow_imp.g_varchar2_table(347) := '73246D696E44617465322C205F6A6470246F7074696F6E73246D696E44617465333B0A20202020766172206973506C7573203D206D6F6465203D3D3D2022504C5553223B0A2020202076617220636C6173734E616D65203D2022223B0A20202020766172';
wwv_flow_imp.g_varchar2_table(348) := '20656C656D656E745175657279203D206973506C7573203F20504C55535F49434F4E5F454C454D454E545F5155455259203A204D494E55535F49434F4E5F454C454D454E545F51554552593B0A202020207661722069734D617859656172203D20697350';
wwv_flow_imp.g_varchar2_table(349) := '6C75732026262028285F6A6470246F7074696F6E73246D61784461746532203D206A64702E6F7074696F6E732E6D61784461746529203D3D206E756C6C203F20766F69642030203A205F6A6470246F7074696F6E73246D617844617465322E7965617229';
wwv_flow_imp.g_varchar2_table(350) := '203D3D3D206A64702E696E6974446174652E796561723B0A202020207661722069734D61784D6F6E7468203D206973506C75732026262028285F6A6470246F7074696F6E73246D61784461746533203D206A64702E6F7074696F6E732E6D617844617465';
wwv_flow_imp.g_varchar2_table(351) := '29203D3D206E756C6C203F20766F69642030203A205F6A6470246F7074696F6E73246D617844617465332E6D6F6E746829203D3D3D206A64702E696E6974446174652E6D6F6E74683B0A202020207661722069734D696E59656172203D20216973506C75';
wwv_flow_imp.g_varchar2_table(352) := '732026262028285F6A6470246F7074696F6E73246D696E4461746532203D206A64702E6F7074696F6E732E6D696E4461746529203D3D206E756C6C203F20766F69642030203A205F6A6470246F7074696F6E73246D696E44617465322E7965617229203D';
wwv_flow_imp.g_varchar2_table(353) := '3D3D206A64702E696E6974446174652E796561723B0A202020207661722069734D696E4D6F6E7468203D20216973506C75732026262028285F6A6470246F7074696F6E73246D696E4461746533203D206A64702E6F7074696F6E732E6D696E4461746529';
wwv_flow_imp.g_varchar2_table(354) := '203D3D206E756C6C203F20766F69642030203A205F6A6470246F7074696F6E73246D696E44617465332E6D6F6E746829203D3D3D206A64702E696E6974446174652E6D6F6E74683B0A202020207661722068746D6C203D206973506C7573203F206A6470';
wwv_flow_imp.g_varchar2_table(355) := '2E6F7074696F6E732E706C757348746D6C203A206A64702E6F7074696F6E732E6D696E757348746D6C3B0A20202020766172206576656E74203D2066756E6374696F6E206576656E742829207B0A2020202020206966202869735965617229207B0A2020';
wwv_flow_imp.g_varchar2_table(356) := '202020202020696620286973506C757329206A64702E696E6372656173655965617228293B656C7365206A64702E64656372656173655965617228293B0A2020202020207D20656C7365207B0A2020202020202020696620286973506C757329206A6470';
wwv_flow_imp.g_varchar2_table(357) := '2E696E6372656173654D6F6E746828293B656C7365206A64702E64656372656173654D6F6E746828293B0A2020202020207D0A202020207D3B0A202020206966202869735965617229207B0A2020202020206966202869734D617859656172207C7C2069';
wwv_flow_imp.g_varchar2_table(358) := '734D696E5965617229207B0A2020202020202020636C6173734E616D65203D2044495341424C455F434C4153535F4E414D453B0A2020202020207D0A202020207D20656C7365207B0A2020202020206966202869734D6178596561722026262069734D61';
wwv_flow_imp.g_varchar2_table(359) := '784D6F6E7468207C7C2069734D696E596561722026262069734D696E4D6F6E746829207B0A2020202020202020636C6173734E616D65203D2044495341424C455F434C4153535F4E414D453B0A2020202020207D0A202020207D0A202020206372656174';
wwv_flow_imp.g_varchar2_table(360) := '65456C656D656E7428656C656D656E745175657279202B20222E22202B20636C6173734E616D652C20636F6E7461696E65722C204556454E545F434C49434B5F5354522C206576656E742C2068746D6C2C202268746D6C22293B0A20207D3B0A20207661';
wwv_flow_imp.g_varchar2_table(361) := '7220637265617465456C656D656E74506C7573203D2066756E6374696F6E20637265617465456C656D656E74506C7573286A64702C20636F6E7461696E65722C2069735965617229207B0A20202020637265617465456C656D656E74506C75734D696E75';
wwv_flow_imp.g_varchar2_table(362) := '73286A64702C20636F6E7461696E65722C206973596561722C2022504C555322293B0A20207D3B0A202076617220637265617465456C656D656E744D696E7573203D2066756E6374696F6E20637265617465456C656D656E744D696E7573286A64702C20';
wwv_flow_imp.g_varchar2_table(363) := '636F6E7461696E65722C2069735965617229207B0A20202020637265617465456C656D656E74506C75734D696E7573286A64702C20636F6E7461696E65722C206973596561722C20224D494E555322293B0A20207D3B0A202076617220676574496E7075';
wwv_flow_imp.g_varchar2_table(364) := '7456616C7565203D2066756E6374696F6E20676574496E70757456616C7565286576656E7429207B0A2020202072657475726E206576656E742E7461726765742E76616C75653B0A20207D3B0A20207661722072656E64657259656172203D2066756E63';
wwv_flow_imp.g_varchar2_table(365) := '74696F6E2072656E64657259656172286A647029207B0A20202020766172205F6A6470246F7074696F6E732475736544726F70643B0A20202020766172207965617273436F6E7461696E6572203D20637265617465456C656D656E742859454152535F45';
wwv_flow_imp.g_varchar2_table(366) := '4C454D454E545F51554552592C206A64702E6470436F6E7461696E6572293B0A20202020637265617465456C656D656E74506C7573286A64702C207965617273436F6E7461696E65722C2074727565293B0A202020207661722079656172436F6E746169';
wwv_flow_imp.g_varchar2_table(367) := '6E6572203D20637265617465456C656D656E7428594541525F454C454D454E545F51554552592C207965617273436F6E7461696E6572293B0A20202020637265617465456C656D656E744D696E7573286A64702C207965617273436F6E7461696E65722C';
wwv_flow_imp.g_varchar2_table(368) := '2074727565293B0A202020207661722075736544726F70646F776E5965617273203D20285F6A6470246F7074696F6E732475736544726F7064203D206A64702E6F7074696F6E732E75736544726F70646F776E59656172732920213D206E756C6C203F20';
wwv_flow_imp.g_varchar2_table(369) := '5F6A6470246F7074696F6E732475736544726F7064203A206A64702E6F7074696F6E732E75736544726F70446F776E59656172733B0A202020207661722079656172496E7075745461674E616D65203D2075736544726F70646F776E5965617273203F20';
wwv_flow_imp.g_varchar2_table(370) := '2273656C65637422203A2022696E707574223B0A202020207661722079656172496E707574203D20637265617465456C656D656E742879656172496E7075745461674E616D652C2079656172436F6E7461696E65722C204556454E545F4348414E47455F';
wwv_flow_imp.g_varchar2_table(371) := '594541525F494E5055545F5354522C2066756E6374696F6E20286576656E7429207B0A2020202020207661722079656172203D204E756D62657228676574496E70757456616C7565286576656E7429293B0A2020202020206966202879656172203C2031';
wwv_flow_imp.g_varchar2_table(372) := '6533207C7C2079656172203E20326533292072657475726E3B0A2020202020206A64702E796561724368616E67652879656172293B0A202020207D293B0A202020206966202875736544726F70646F776E596561727329207B0A20202020202079656172';
wwv_flow_imp.g_varchar2_table(373) := '496E7075742E7365744174747269627574652822746162696E646578222C20222D3122293B0A2020202020207661722076616C69645965617273203D2067657456616C69645965617273286A6470293B0A202020202020666F7220287661722069203D20';
wwv_flow_imp.g_varchar2_table(374) := '76616C696459656172732E6D696E3B2069203C3D2076616C696459656172732E6D61783B20692B2B29207B0A2020202020202020766172206F7074696F6E456C656D656E74203D20637265617465456C656D656E7428226F7074696F6E222C2079656172';
wwv_flow_imp.g_varchar2_table(375) := '496E707574293B0A20202020202020206F7074696F6E456C656D656E742E76616C7565203D20692E746F537472696E6728293B0A20202020202020206F7074696F6E456C656D656E742E74657874203D20746F5065727369616E44696769747349664E65';
wwv_flow_imp.g_varchar2_table(376) := '6564656428692C206A64702E6F7074696F6E732E7065727369616E446967697473292E746F537472696E6728293B0A20202020202020206F7074696F6E456C656D656E742E73656C6563746564203D2069203D3D3D206A64702E696E6974446174652E79';
wwv_flow_imp.g_varchar2_table(377) := '6561723B0A2020202020207D0A202020207D20656C7365207B0A20202020202079656172496E7075742E746162496E646578203D202D313B0A20202020202079656172496E7075742E76616C7565203D206A64702E696E6974446174652E796561722E74';
wwv_flow_imp.g_varchar2_table(378) := '6F537472696E6728293B0A20202020202079656172496E7075742E74797065203D20226E756D626572223B0A202020207D0A20207D3B0A20207661722072656E6465724D6F6E746873203D2066756E6374696F6E2072656E6465724D6F6E746873286A64';
wwv_flow_imp.g_varchar2_table(379) := '7029207B0A20202020766172206D6F6E746873436F6E7461696E6572203D20637265617465456C656D656E74284D4F4E5448535F454C454D454E545F51554552592C206A64702E6470436F6E7461696E6572293B0A20202020637265617465456C656D65';
wwv_flow_imp.g_varchar2_table(380) := '6E74506C7573286A64702C206D6F6E746873436F6E7461696E65722C2066616C7365293B0A20202020766172206D6F6E7468436F6E7461696E6572203D20637265617465456C656D656E74284D4F4E54485F454C454D454E545F51554552592C206D6F6E';
wwv_flow_imp.g_varchar2_table(381) := '746873436F6E7461696E6572293B0A20202020637265617465456C656D656E744D696E7573286A64702C206D6F6E746873436F6E7461696E65722C2066616C7365293B0A20202020766172206D6F6E746844726F70646F776E436F6E7461696E6572203D';
wwv_flow_imp.g_varchar2_table(382) := '20637265617465456C656D656E74282273656C656374222C206D6F6E7468436F6E7461696E65722C204556454E545F4348414E47455F4D4F4E54485F44524F50444F574E5F5354522C2066756E6374696F6E20286576656E7429207B0A2020202020206A';
wwv_flow_imp.g_varchar2_table(383) := '64702E6D6F6E74684368616E6765284E756D62657228676574496E70757456616C7565286576656E742929293B0A202020207D293B0A202020206D6F6E746844726F70646F776E436F6E7461696E65722E746162496E646578203D202D313B0A20202020';
wwv_flow_imp.g_varchar2_table(384) := '766172206D6F6E746873203D2067657456616C69644D6F6E746873286A6470293B0A20202020766172206D6F6E7468734E616D65203D206A64702E6F7074696F6E732E6D6F6E7468733B0A20202020666F7220287661722069203D20303B2069203C206D';
wwv_flow_imp.g_varchar2_table(385) := '6F6E7468732E6C656E6774683B20692B2B29207B0A202020202020766172206F7074696F6E456C656D656E74203D20637265617465456C656D656E7428226F7074696F6E222C206D6F6E746844726F70646F776E436F6E7461696E6572293B0A20202020';
wwv_flow_imp.g_varchar2_table(386) := '20206F7074696F6E456C656D656E742E76616C7565203D206D6F6E7468735B695D2E746F537472696E6728293B0A2020202020206F7074696F6E456C656D656E742E74657874203D20746F5065727369616E44696769747349664E6565646564286D6F6E';
wwv_flow_imp.g_varchar2_table(387) := '7468734E616D655B6D6F6E7468735B695D202D20315D2C206A64702E6F7074696F6E732E7065727369616E446967697473292E746F537472696E6728293B0A2020202020206F7074696F6E456C656D656E742E73656C6563746564203D206D6F6E746873';
wwv_flow_imp.g_varchar2_table(388) := '5B695D203D3D3D206A64702E696E6974446174652E6D6F6E74683B0A202020207D0A20207D3B0A20207661722072656E64657244617973203D2066756E6374696F6E2072656E64657244617973286A647029207B0A202020207661722064617973486561';
wwv_flow_imp.g_varchar2_table(389) := '646572436F6E7461696E6572203D20637265617465456C656D656E7428444159535F4845414445525F454C454D454E545F51554552592C206A64702E6470436F6E7461696E6572293B0A202020207661722064617973436F6E7461696E6572203D206372';
wwv_flow_imp.g_varchar2_table(390) := '65617465456C656D656E7428444159535F454C454D454E545F51554552592C206A64702E6470436F6E7461696E6572293B0A20202020666F7220287661722069203D20303B2069203C20373B20692B2B29207B0A202020202020637265617465456C656D';
wwv_flow_imp.g_varchar2_table(391) := '656E74284441595F4E414D455F454C454D454E545F5155455259202B206765744C6173745765656B436C61737349664E65636573736172792869292C2064617973486561646572436F6E7461696E65722C20766F696420302C20766F696420302C20746F';
wwv_flow_imp.g_varchar2_table(392) := '5065727369616E44696769747349664E6565646564286A64702E6F7074696F6E732E646179735B695D2C206A64702E6F7074696F6E732E7065727369616E446967697473292E746F537472696E672829293B0A202020207D0A2020202076617220736574';
wwv_flow_imp.g_varchar2_table(393) := '44656661756C744F7074696F6E73203D2066756E6374696F6E2073657444656661756C744F7074696F6E73286F707429207B0A20202020202069662028216F70742E646179207C7C206F70742E696E4265666F72654D6F6E746829207B0A202020202020';
wwv_flow_imp.g_varchar2_table(394) := '20206F70742E646179203D20313B0A2020202020207D20656C7365207B0A20202020202020206F70742E646179202B3D20313B0A2020202020207D0A2020202020206F70742E696E4265666F72654D6F6E7468203D2066616C73653B0A2020202020206F';
wwv_flow_imp.g_varchar2_table(395) := '70742E696E41667465724D6F6E7468203D2066616C73653B0A2020202020206F70742E697356616C6964203D2066616C73653B0A2020202020206F70742E6973486F6C69646179203D2066616C73653B0A2020202020206F70742E6973486F6C6C794461';
wwv_flow_imp.g_varchar2_table(396) := '79203D2066616C73653B0A2020202020206F70742E636C6173734E616D65203D2022223B0A2020202020206F70742E79656172203D206A64702E696E6974446174652E796561723B0A2020202020206F70742E6D6F6E7468203D206A64702E696E697444';
wwv_flow_imp.g_varchar2_table(397) := '6174652E6D6F6E74683B0A2020202020206F70742E7765656B446179203D206765745765656B446179286F70742E796561722C206F70742E6D6F6E74682C206F70742E646179293B0A20202020202072657475726E206F70743B0A202020207D3B0A2020';
wwv_flow_imp.g_varchar2_table(398) := '2020766172206461794F7074696F6E73203D2073657444656661756C744F7074696F6E73287B7D293B0A202020207661722064617973496E4D6F6E7468203D2067657444617973496E4D6F6E7468286461794F7074696F6E732E796561722C206461794F';
wwv_flow_imp.g_varchar2_table(399) := '7074696F6E732E6D6F6E7468293B0A202020207661722073746172745765656B446179496E4D6F6E7468203D206461794F7074696F6E732E7765656B4461793B0A20202020766172206D617844617973496E43616C656E646172203D2037202A204D6174';
wwv_flow_imp.g_varchar2_table(400) := '682E6365696C282873746172745765656B446179496E4D6F6E7468202B2064617973496E4D6F6E746829202F203729202D20313B0A20202020766172206265666F72654D6F6E74684E756D626572203D206461794F7074696F6E732E6D6F6E7468203D3D';
wwv_flow_imp.g_varchar2_table(401) := '3D2031203F203132203A206461794F7074696F6E732E6D6F6E7468202D20313B0A202020207661722061667465724D6F6E74684E756D626572203D206461794F7074696F6E732E6D6F6E7468203D3D3D203132203F2031203A206461794F7074696F6E73';
wwv_flow_imp.g_varchar2_table(402) := '2E6D6F6E7468202B20313B0A20202020766172206265666F72654D6F6E7468596561724E756D626572203D206265666F72654D6F6E74684E756D626572203D3D3D203132203F206461794F7074696F6E732E79656172202D2031203A206461794F707469';
wwv_flow_imp.g_varchar2_table(403) := '6F6E732E796561723B0A202020207661722061667465724D6F6E7468596561724E756D626572203D2061667465724D6F6E74684E756D626572203D3D3D2031203F206461794F7074696F6E732E79656172202B2031203A206461794F7074696F6E732E79';
wwv_flow_imp.g_varchar2_table(404) := '6561723B0A20202020766172206265666F72654D6F6E746844617973203D206461794F7074696F6E732E6D6F6E7468203D3D3D2031203F2067657444617973496E4D6F6E7468286461794F7074696F6E732E79656172202D20312C206265666F72654D6F';
wwv_flow_imp.g_varchar2_table(405) := '6E74684E756D62657229203A2067657444617973496E4D6F6E7468286461794F7074696F6E732E796561722C206265666F72654D6F6E74684E756D626572293B0A20202020766172206265666F7265446179496E4D6F6E7468203D206265666F72654D6F';
wwv_flow_imp.g_varchar2_table(406) := '6E746844617973202D2073746172745765656B446179496E4D6F6E74683B0A20202020766172206166746572446179496E4D6F6E7468203D20303B0A20202020766172205F6C6F6F70203D2066756E6374696F6E205F6C6F6F702829207B0A2020202020';
wwv_flow_imp.g_varchar2_table(407) := '206461794F7074696F6E732E696E4265666F72654D6F6E7468203D206461794F7074696F6E732E646179203C3D2073746172745765656B446179496E4D6F6E7468202626205F69203C2073746172745765656B446179496E4D6F6E74683B0A2020202020';
wwv_flow_imp.g_varchar2_table(408) := '206461794F7074696F6E732E696E41667465724D6F6E7468203D205F69203E3D2064617973496E4D6F6E7468202B2073746172745765656B446179496E4D6F6E74683B0A202020202020696620286461794F7074696F6E732E696E4265666F72654D6F6E';
wwv_flow_imp.g_varchar2_table(409) := '7468207C7C206461794F7074696F6E732E696E41667465724D6F6E746829207B0A2020202020202020696620286461794F7074696F6E732E696E4265666F72654D6F6E746829207B0A202020202020202020206265666F7265446179496E4D6F6E74682B';
wwv_flow_imp.g_varchar2_table(410) := '2B3B0A202020202020202020206461794F7074696F6E732E646179203D206265666F7265446179496E4D6F6E74683B0A202020202020202020206461794F7074696F6E732E79656172203D206265666F72654D6F6E7468596561724E756D6265723B0A20';
wwv_flow_imp.g_varchar2_table(411) := '2020202020202020206461794F7074696F6E732E6D6F6E7468203D206265666F72654D6F6E74684E756D6265723B0A20202020202020207D20656C7365207B0A202020202020202020206166746572446179496E4D6F6E74682B2B3B0A20202020202020';
wwv_flow_imp.g_varchar2_table(412) := '2020206461794F7074696F6E732E646179203D206166746572446179496E4D6F6E74683B0A202020202020202020206461794F7074696F6E732E79656172203D2061667465724D6F6E7468596561724E756D6265723B0A20202020202020202020646179';
wwv_flow_imp.g_varchar2_table(413) := '4F7074696F6E732E6D6F6E7468203D2061667465724D6F6E74684E756D6265723B0A20202020202020207D0A20202020202020206461794F7074696F6E732E7765656B446179203D206765745765656B446179286461794F7074696F6E732E796561722C';
wwv_flow_imp.g_varchar2_table(414) := '206461794F7074696F6E732E6D6F6E74682C206461794F7074696F6E732E646179293B0A2020202020207D0A2020202020206461794F7074696F6E732E697356616C6964203D20697356616C696444617465286A64702C206461794F7074696F6E732E79';
wwv_flow_imp.g_varchar2_table(415) := '6561722C206461794F7074696F6E732E6D6F6E74682C206461794F7074696F6E732E646179293B0A2020202020206461794F7074696F6E732E636C6173734E616D65203D206765744C6173745765656B436C61737349664E656365737361727928676574';
wwv_flow_imp.g_varchar2_table(416) := '5765656B446179286461794F7074696F6E732E796561722C206461794F7074696F6E732E6D6F6E74682C206461794F7074696F6E732E64617929293B0A2020202020206461794F7074696F6E732E636C6173734E616D65202B3D2067657453656C656374';
wwv_flow_imp.g_varchar2_table(417) := '696F6E436C6173734E616D65286A64702C206461794F7074696F6E73293B0A202020202020696620286A64702E746F6461792E646179203D3D3D206461794F7074696F6E732E646179202626206A64702E746F6461792E79656172203D3D3D206461794F';
wwv_flow_imp.g_varchar2_table(418) := '7074696F6E732E79656172202626206A64702E746F6461792E6D6F6E7468203D3D3D206461794F7074696F6E732E6D6F6E746829207B0A20202020202020206461794F7074696F6E732E636C6173734E616D65202B3D20222E22202B20544F4441595F43';
wwv_flow_imp.g_varchar2_table(419) := '4C4153535F4E414D453B0A2020202020207D0A20202020202069662028697346756E6374696F6E286A64702E6F7074696F6E732E64617952656E646572696E672929207B0A20202020202020205F657874656E64286461794F7074696F6E732C206A6470';
wwv_flow_imp.g_varchar2_table(420) := '2E6F7074696F6E732E64617952656E646572696E67286461794F7074696F6E732C206A64702E696E70757429293B0A2020202020207D0A202020202020696620286461794F7074696F6E732E6973486F6C69646179207C7C206461794F7074696F6E732E';
wwv_flow_imp.g_varchar2_table(421) := '6973486F6C6C7944617929207B0A20202020202020206461794F7074696F6E732E636C6173734E616D65202B3D20222E22202B20484F4C494441595F434C4153535F4E414D453B0A2020202020207D0A202020202020766172207175657279203D206461';
wwv_flow_imp.g_varchar2_table(422) := '794F7074696F6E732E697356616C6964203F204441595F454C454D454E545F5155455259203A204441595F44495341424C45445F454C454D454E545F51554552593B0A202020202020696620286461794F7074696F6E732E696E4265666F72654D6F6E74';
wwv_flow_imp.g_varchar2_table(423) := '68207C7C206461794F7074696F6E732E696E41667465724D6F6E746829207B0A20202020202020207175657279203D204441595F4E4F545F494E5F4D4F4E54485F454C454D454E545F51554552593B0A202020202020202069662028216461794F707469';
wwv_flow_imp.g_varchar2_table(424) := '6F6E732E697356616C696429207B0A202020202020202020207175657279203D204441595F44495341424C45445F4E4F545F494E5F4D4F4E54485F454C454D454E545F51554552593B0A20202020202020207D0A2020202020207D0A2020202020207661';
wwv_flow_imp.g_varchar2_table(425) := '7220646179436F6E7461696E6572203D20637265617465456C656D656E74287175657279202B206461794F7074696F6E732E636C6173734E616D652C2064617973436F6E7461696E65722C20766F696420302C20766F696420302C20746F506572736961';
wwv_flow_imp.g_varchar2_table(426) := '6E44696769747349664E6565646564286461794F7074696F6E732E6461792C206A64702E6F7074696F6E732E7065727369616E446967697473292E746F537472696E672829293B0A202020202020646179436F6E7461696E65722E646179203D20646179';
wwv_flow_imp.g_varchar2_table(427) := '4F7074696F6E732E6461793B0A202020202020646179436F6E7461696E65722E6D6F6E7468203D206461794F7074696F6E732E6D6F6E74683B0A202020202020646179436F6E7461696E65722E79656172203D206461794F7074696F6E732E796561723B';
wwv_flow_imp.g_varchar2_table(428) := '0A202020202020696620286461794F7074696F6E732E697356616C696429207B0A2020202020202020646179436F6E7461696E65722E6164644576656E744C697374656E6572284556454E545F434C49434B5F5354522C2066756E6374696F6E20282920';
wwv_flow_imp.g_varchar2_table(429) := '7B0A202020202020202020206A64702E73657456616C7565287B0A202020202020202020202020796561723A20646179436F6E7461696E65722E796561722C0A2020202020202020202020206D6F6E74683A20646179436F6E7461696E65722E6D6F6E74';
wwv_flow_imp.g_varchar2_table(430) := '682C0A2020202020202020202020206461793A20646179436F6E7461696E65722E6461790A202020202020202020207D293B0A20202020202020207D293B0A2020202020207D0A20202020202073657444656661756C744F7074696F6E73286461794F70';
wwv_flow_imp.g_varchar2_table(431) := '74696F6E73293B0A202020207D3B0A20202020666F722028766172205F69203D20303B205F69203C3D206D617844617973496E43616C656E6461723B205F692B2B29207B0A2020202020205F6C6F6F7028293B0A202020207D0A20207D3B0A2020766172';
wwv_flow_imp.g_varchar2_table(432) := '2072656E646572446174655069636B6572203D2066756E6374696F6E2072656E646572446174655069636B6572286A647029207B0A2020202072656E64657259656172286A6470293B0A2020202072656E6465724D6F6E746873286A6470293B0A202020';
wwv_flow_imp.g_varchar2_table(433) := '2072656E64657244617973286A6470293B0A20207D3B0A20207661722072656E646572466F6F746572203D2066756E6374696F6E2072656E646572466F6F746572286A647029207B0A20202020766172205F6A647024696E707574323B0A202020207661';
wwv_flow_imp.g_varchar2_table(434) := '7220666F6F746572436F6E7461696E6572203D20637265617465456C656D656E7428464F4F5445525F454C454D454E545F51554552592C206A64702E6470436F6E7461696E65722C20766F696420302C20766F696420302C20766F69642030293B0A2020';
wwv_flow_imp.g_varchar2_table(435) := '20200A0A202020206966286A64702E6F7074696F6E732E74696D65297B0A20202020637265617465456C656D656E7428434F4E4649524D5F425554544F4E5F454C454D454E545F51554552592C20666F6F746572436F6E7461696E65722C204556454E54';
wwv_flow_imp.g_varchar2_table(436) := '5F434C49434B5F5354522C2066756E6374696F6E202829207B0A2020202020206A64702E636F6E6669726D56616C756528293B0A202020207D2C2022D8AAD8A7DB8CDB8CD8AF22293B0A202020207D0A0A0A20202020696620286A64702E6F7074696F6E';
wwv_flow_imp.g_varchar2_table(437) := '732E73686F77546F64617942746E202626206A64702E6F7074696F6E732E6461746529207B0A202020202020766172206973416374697665546F646179203D20697356616C696444617465546F646179286A6470293B0A20202020202076617220746F64';
wwv_flow_imp.g_varchar2_table(438) := '617942746E4C6162656C203D206A64702E6F7074696F6E732E74696D65203F2022D987D985E2808CD8A7DAA9D986D988D98622203A2022D8A7D985D8B1D988D8B2223B0A202020202020637265617465456C656D656E7428544F4441595F425554544F4E';
wwv_flow_imp.g_varchar2_table(439) := '5F454C454D454E545F5155455259202B20286973416374697665546F646179203F202222203A20222E64697361626C65642D62746E22292C20666F6F746572436F6E7461696E65722C204556454E545F434C49434B5F5354522C2066756E6374696F6E20';
wwv_flow_imp.g_varchar2_table(440) := '2829207B0A202020202020202069662028216973416374697665546F646179292072657475726E3B0A2020202020202020696620286A64702E6F7074696F6E732E74696D6529207B0A20202020202020202020766172206E6F7754203D20676574437572';
wwv_flow_imp.g_varchar2_table(441) := '72656E7454696D6528293B0A202020202020202020206A64702E73657456616C7565287B0A202020202020202020202020796561723A206A64702E746F6461792E796561722C0A2020202020202020202020206D6F6E74683A206A64702E746F6461792E';
wwv_flow_imp.g_varchar2_table(442) := '6D6F6E74682C0A2020202020202020202020206461793A206A64702E746F6461792E6461792C0A202020202020202020202020686F75723A206E6F77542E686F75722C0A2020202020202020202020206D696E7574653A206E6F77542E6D696E7574652C';
wwv_flow_imp.g_varchar2_table(443) := '0A2020202020202020202020207365636F6E643A206E6F77542E7365636F6E640A202020202020202020207D293B0A20202020202020207D20656C7365207B0A202020202020202020206A64702E73657456616C7565286A64702E746F646179293B0A20';
wwv_flow_imp.g_varchar2_table(444) := '202020202020207D0A2020202020207D2C20746F64617942746E4C6162656C293B0A202020207D0A2020202069662028216A64702E6F7074696F6E732E64617465202626206A64702E6F7074696F6E732E74696D6520262620282128285F6A647024696E';
wwv_flow_imp.g_varchar2_table(445) := '70757432203D206A64702E696E7075742920213D206E756C6C202626205F6A647024696E707574322E76616C756529207C7C2021216A64702E6F7074696F6E732E73686F7753656C65637454696D6542746E416C776179732929207B0A20202020202063';
wwv_flow_imp.g_varchar2_table(446) := '7265617465456C656D656E7428544F4441595F425554544F4E5F454C454D454E545F51554552592C20666F6F746572436F6E7461696E65722C204556454E545F434C49434B5F5354522C2066756E6374696F6E202829207B0A20202020202020206A6470';
wwv_flow_imp.g_varchar2_table(447) := '2E73657456616C7565286A64702E696E697454696D65293B0A20202020202020206A64702E6869646528293B0A2020202020207D2C2022D8A7D986D8AAD8AED8A7D8A822293B0A202020207D0A20202020696620286A64702E6F7074696F6E732E73686F';
wwv_flow_imp.g_varchar2_table(448) := '77456D70747942746E29207B0A202020202020637265617465456C656D656E7428454D5054595F425554544F4E5F454C454D454E545F51554552592C20666F6F746572436F6E7461696E65722C204556454E545F434C49434B5F5354522C2066756E6374';
wwv_flow_imp.g_varchar2_table(449) := '696F6E202829207B0A20202020202020206A64702E636C65616E56616C756528293B0A2020202020202020696620286A64702E6F7074696F6E732E6869646541667465724368616E676529206A64702E6869646528293B0A2020202020207D2C2022D8AE';
wwv_flow_imp.g_varchar2_table(450) := 'D8A7D984DB8C22293B0A202020207D0A20202020696620286A64702E6F7074696F6E732E73686F77436C6F736542746E2029207B0A202020202020637265617465456C656D656E7428434C4F53455F425554544F4E5F454C454D454E545F51554552592C';
wwv_flow_imp.g_varchar2_table(451) := '20666F6F746572436F6E7461696E65722C204556454E545F434C49434B5F5354522C2066756E6374696F6E202829207B0A20202020202020206A64702E6869646528293B0A2020202020207D2C2022D8A8D8B3D8AAD98622293B0A202020207D0A20207D';
wwv_flow_imp.g_varchar2_table(452) := '3B0A20202F2A203D3D3D3D3D205468656D652028636F6C6F72202B206C696768742F6461726B29203D3D3D3D3D202A2F0A2020766172204845585F434F4C4F525F5245203D202F5E23283F3A5B302D39612D665D7B337D7C5B302D39612D665D7B347D7C';
wwv_flow_imp.g_varchar2_table(453) := '5B302D39612D665D7B367D7C5B302D39612D665D7B387D29242F693B0A202076617220696E6B466F72436F6C6F72203D2066756E6374696F6E20696E6B466F72436F6C6F722868657829207B0A202020207661722068203D206865782E736C6963652831';
wwv_flow_imp.g_varchar2_table(454) := '293B0A2020202069662028682E6C656E677468203C3D2034292068203D20682E636861724174283029202B20682E636861724174283029202B20682E636861724174283129202B20682E636861724174283129202B20682E636861724174283229202B20';
wwv_flow_imp.g_varchar2_table(455) := '682E6368617241742832293B0A20202020766172206368203D205B7061727365496E7428682E73756273747228302C2032292C203136292C207061727365496E7428682E73756273747228322C2032292C203136292C207061727365496E7428682E7375';
wwv_flow_imp.g_varchar2_table(456) := '6273747228342C2032292C203136295D2E6D61702866756E6374696F6E20287629207B0A20202020202076203D2076202F203235353B0A20202020202072657475726E2076203C3D20302E3033393238203F2076202F2031322E3932203A204D6174682E';
wwv_flow_imp.g_varchar2_table(457) := '706F77282876202B20302E30353529202F20312E3035352C20322E34293B0A202020207D293B0A20202020766172206C756D203D20302E32313236202A2063685B305D202B20302E37313532202A2063685B315D202B20302E30373232202A2063685B32';
wwv_flow_imp.g_varchar2_table(458) := '5D3B0A2020202072657475726E206C756D203E20302E35203F20222331313138323722203A202223666666666666223B0A20207D3B0A202076617220646574656374506167655468656D65203D2066756E6374696F6E2064657465637450616765546865';
wwv_flow_imp.g_varchar2_table(459) := '6D6528696E70757429207B0A20202020747279207B0A20202020202076617220656C203D20696E7075742C2077696E203D20696E70757420262620696E7075742E6F776E6572446F63756D656E742E64656661756C7456696577207C7C2077696E646F77';
wwv_flow_imp.g_varchar2_table(460) := '3B0A2020202020207768696C652028656C20262620656C2E6E6F646554797065203D3D3D203129207B0A2020202020202020766172206D203D2077696E2E676574436F6D70757465645374796C6528656C292E6261636B67726F756E64436F6C6F722E6D';
wwv_flow_imp.g_varchar2_table(461) := '61746368282F726762613F5C28285B5E295D2B295C292F293B0A2020202020202020696620286D29207B0A20202020202020202020766172207061727473203D206D5B315D2E73706C6974282F5B5C732C5C2F5D2B2F292E66696C74657228426F6F6C65';
wwv_flow_imp.g_varchar2_table(462) := '616E292E6D6170287061727365466C6F6174293B0A2020202020202020202076617220616C706861203D2070617274732E6C656E677468203E2033203F2070617274735B335D203A20313B0A2020202020202020202069662028616C706861203E20302E';
wwv_flow_imp.g_varchar2_table(463) := '3529207B0A20202020202020202020202072657475726E2028302E323939202A2070617274735B305D202B20302E353837202A2070617274735B315D202B20302E313134202A2070617274735B325D29202F20323535203C20302E3435203F2022646172';
wwv_flow_imp.g_varchar2_table(464) := '6B22203A20226C69676874223B0A202020202020202020207D0A20202020202020207D0A2020202020202020656C203D20656C2E706172656E74456C656D656E743B0A2020202020207D0A202020207D20636174636820286529207B7D0A202020207472';
wwv_flow_imp.g_varchar2_table(465) := '79207B0A20202020202072657475726E2077696E646F772E6D617463684D656469612026262077696E646F772E6D617463684D65646961282228707265666572732D636F6C6F722D736368656D653A206461726B2922292E6D617463686573203F202264';
wwv_flow_imp.g_varchar2_table(466) := '61726B22203A20226C69676874223B0A202020207D20636174636820286529207B7D0A2020202072657475726E20226C69676874223B0A20207D3B0A2020766172206170706C795468656D65203D2066756E6374696F6E206170706C795468656D65286A';
wwv_flow_imp.g_varchar2_table(467) := '647029207B0A202020207661722063203D206A64702E5F6470436F6E7461696E65723B0A20202020696620282163292072657475726E3B0A20202020766172206D6F6465203D206A64702E6F7074696F6E732E7468656D654D6F64653B0A202020207661';
wwv_flow_imp.g_varchar2_table(468) := '72207468656D65203D206D6F6465203D3D3D20226461726B22207C7C206D6F6465203D3D3D20226C6967687422203F206D6F6465203A20646574656374506167655468656D65286A64702E696E707574293B0A20202020632E7365744174747269627574';
wwv_flow_imp.g_varchar2_table(469) := '652822646174612D6A64702D7468656D65222C207468656D65293B0A2020202076617220636F6C203D206A64702E6F7074696F6E732E7072696D617279436F6C6F723B0A2020202069662028636F6C202626204845585F434F4C4F525F52452E74657374';
wwv_flow_imp.g_varchar2_table(470) := '28636F6C2929207B0A202020202020632E7374796C652E73657450726F706572747928222D2D6A64702D7072696D617279222C20636F6C293B0A202020202020632E7374796C652E73657450726F706572747928222D2D6A64702D7072696D6172792D69';
wwv_flow_imp.g_varchar2_table(471) := '6E6B222C20696E6B466F72436F6C6F7228636F6C29293B0A202020207D20656C7365207B0A202020202020632E7374796C652E72656D6F766550726F706572747928222D2D6A64702D7072696D61727922293B0A202020202020632E7374796C652E7265';
wwv_flow_imp.g_varchar2_table(472) := '6D6F766550726F706572747928222D2D6A64702D7072696D6172792D696E6B22293B0A202020207D0A20207D3B0A20207661722072656E646572203D2066756E6374696F6E2072656E646572286A647029207B0A20202020736574496E6E657248544D4C';
wwv_flow_imp.g_varchar2_table(473) := '286A64702E6470436F6E7461696E65722C202222293B0A202020206170706C795468656D65286A6470293B0A20202020696620286A64702E6F7074696F6E732E6461746529207B0A20202020202072656E646572446174655069636B6572286A6470293B';
wwv_flow_imp.g_varchar2_table(474) := '0A202020207D0A20202020696620286A64702E6F7074696F6E732E74696D6529207B0A20202020202072656E64657254696D655069636B6572286A6470293B0A202020207D0A2020202072656E646572466F6F746572286A6470293B0A20207D3B0A2020';
wwv_flow_imp.g_varchar2_table(475) := '66756E6374696F6E20647261772829207B0A2020202072656E6465722874686973293B0A20207D0A20207661722069734D6F62696C65203D202F6970686F6E657C69706F647C616E64726F69647C69657C626C61636B62657272797C66656E6E65632F2E';
wwv_flow_imp.g_varchar2_table(476) := '7465737428285F77696E646F77246E6176696761746F72203D2077696E646F772E6E6176696761746F7229203D3D206E756C6C207C7C20285F77696E646F77246E6176696761746F72203D205F77696E646F77246E6176696761746F722E757365724167';
wwv_flow_imp.g_varchar2_table(477) := '656E7429203D3D206E756C6C203F20766F69642030203A205F77696E646F77246E6176696761746F722E746F4C6F776572436173652829293B0A20207661722067657454696D6556616C75654F626A65637446726F6D5061727473203D2066756E637469';
wwv_flow_imp.g_varchar2_table(478) := '6F6E2067657454696D6556616C75654F626A65637446726F6D50617274732870617274732C206861735365636F6E6429207B0A202020206966202821697356616C696454696D6550617274732870617274732C206861735365636F6E642929207B0A2020';
wwv_flow_imp.g_varchar2_table(479) := '2020202072657475726E206E756C6C3B0A202020207D0A2020202072657475726E207B0A202020202020686F75723A207061727365496E742870617274735B305D2C203130292C0A2020202020206D696E7574653A207061727365496E74287061727473';
wwv_flow_imp.g_varchar2_table(480) := '5B315D2C203130292C0A2020202020207365636F6E643A207061727365496E742870617274735B325D2C20313029207C7C20300A202020207D3B0A20207D3B0A20207661722067657454696D6556616C75654F626A65637446726F6D54696D654F6E6C79';
wwv_flow_imp.g_varchar2_table(481) := '537472696E67203D2066756E6374696F6E2067657454696D6556616C75654F626A65637446726F6D54696D654F6E6C79537472696E67286A64702C2074696D65537472696E6729207B0A2020202072657475726E2067657454696D6556616C75654F626A';
wwv_flow_imp.g_varchar2_table(482) := '65637446726F6D50617274732874696D65537472696E672E73706C6974286A64702E6F7074696F6E732E736570617261746F7243686172732E74696D65292C206A64702E6F7074696F6E732E6861735365636F6E64293B0A20207D3B0A2020766172206E';
wwv_flow_imp.g_varchar2_table(483) := '6F726D616C697A6553656C656374696F6E4D6F6465203D2066756E6374696F6E206E6F726D616C697A6553656C656374696F6E4D6F6465286D6F646529207B0A2020202072657475726E206D6F64652026262053454C454354494F4E5F4D4F44455F4E41';
wwv_flow_imp.g_varchar2_table(484) := '4D45532E696E6465784F66286D6F646529203E202D31203F206D6F6465203A202273696E676C65223B0A20207D3B0A2020766172206E6F726D616C697A65426F6F6C65616E41747472203D2066756E6374696F6E206E6F726D616C697A65426F6F6C6561';
wwv_flow_imp.g_varchar2_table(485) := '6E417474722876616C75652C2064656661756C7456616C756529207B0A202020206966202876616C7565203D3D3D206E756C6C207C7C2076616C7565203D3D3D20766F69642030207C7C2076616C7565203D3D3D202222292072657475726E2064656661';
wwv_flow_imp.g_varchar2_table(486) := '756C7456616C75653B0A2020202072657475726E2076616C756520213D3D202266616C7365223B0A20207D3B0A2020766172206E6F726D616C697A654F7074696F6E73203D2066756E6374696F6E206E6F726D616C697A654F7074696F6E732865787465';
wwv_flow_imp.g_varchar2_table(487) := '726E616C4F7074696F6E732C20696E7465726E616C4F7074696F6E732C206A647029207B0A202020207661722073657444656661756C7456616C7565203D2066756E6374696F6E2073657444656661756C7456616C75652870726F70657274794E616D65';
wwv_flow_imp.g_varchar2_table(488) := '2C2064656661756C7456616C756529207B0A202020202020766172205F7265663B0A2020202020207661722065787456616C7565203D2065787465726E616C4F7074696F6E735B70726F70657274794E616D655D3B0A20202020202076617220696E7456';
wwv_flow_imp.g_varchar2_table(489) := '616C7565203D20696E7465726E616C4F7074696F6E735B70726F70657274794E616D655D3B0A2020202020207661722065787465726E616C56616C7565203D20544F4441595F444154455F4F5054494F4E5F4E414D45532E696E6465784F662870726F70';
wwv_flow_imp.g_varchar2_table(490) := '657274794E616D6529203E202D312026262065787456616C7565203D3D3D204D494E5F4D41585F544F4441595F53455454494E47203F20696E7465726E616C4F7074696F6E732E746F646179203A2065787456616C75653B0A2020202020207661722064';
wwv_flow_imp.g_varchar2_table(491) := '657363726970746F72203D204F626A6563742E6765744F776E50726F706572747944657363726970746F7228696E7465726E616C4F7074696F6E732C2070726F70657274794E616D65293B0A2020202020206966202864657363726970746F7220213D20';
wwv_flow_imp.g_varchar2_table(492) := '6E756C6C2026262064657363726970746F722E676574202626202164657363726970746F722E73657429207B0A202020202020202064656C65746520696E7465726E616C4F7074696F6E735B70726F70657274794E616D655D3B0A2020202020207D0A20';
wwv_flow_imp.g_varchar2_table(493) := '2020202020696E7465726E616C4F7074696F6E735B70726F70657274794E616D655D203D20285F726566203D2065787465726E616C56616C756520213D206E756C6C203F2065787465726E616C56616C7565203A20696E7456616C75652920213D206E75';
wwv_flow_imp.g_varchar2_table(494) := '6C6C203F205F726566203A2064656661756C7456616C75653B0A202020207D3B0A2020202076617220676574446174654F7254696D6544656661756C7446726F6D41747472203D2066756E6374696F6E20676574446174654F7254696D6544656661756C';
wwv_flow_imp.g_varchar2_table(495) := '7446726F6D4174747228617474724E616D652C20697354696D6529207B0A202020202020766172205F6A647024696E707574333B0A202020202020766172206174747256616C203D20285F6A647024696E70757433203D206A64702E696E70757429203D';
wwv_flow_imp.g_varchar2_table(496) := '3D206E756C6C203F20766F69642030203A205F6A647024696E707574332E67657441747472696275746528617474724E616D65293B0A2020202020206966202821697354696D65202626206174747256616C203D3D3D204D494E5F4D41585F544F444159';
wwv_flow_imp.g_varchar2_table(497) := '5F53455454494E47292072657475726E20636C6F6E65286A64702E746F646179293B0A20202020202069662028216973537472696E67286174747256616C29292072657475726E207B7D3B0A202020202020747279207B0A202020202020202061747472';
wwv_flow_imp.g_varchar2_table(498) := '56616C203D20646F63756D656E742E717565727953656C6563746F72286174747256616C292E76616C75653B0A2020202020207D20636174636820285F756E7573656429207B7D0A20202020202069662028697354696D6529207B0A2020202020202020';
wwv_flow_imp.g_varchar2_table(499) := '69662028697356616C696454696D65537472696E67286A64702C206174747256616C29292072657475726E2067657456616C75654F626A65637446726F6D537472696E67286A64702C206174747256616C293B0A202020202020202072657475726E2067';
wwv_flow_imp.g_varchar2_table(500) := '657454696D6556616C75654F626A65637446726F6D54696D654F6E6C79537472696E67286A64702C206174747256616C29207C7C207B7D3B0A2020202020207D0A20202020202069662028697356616C696444617465537472696E67286A64702C206174';
wwv_flow_imp.g_varchar2_table(501) := '747256616C29292072657475726E2067657456616C75654F626A65637446726F6D537472696E67286A64702C206174747256616C293B0A20202020202072657475726E207B7D3B0A202020207D3B0A202020207661722067657441747472476574746572';
wwv_flow_imp.g_varchar2_table(502) := '203D2066756E6374696F6E20676574417474724765747465722870726F70657274794E616D6529207B0A2020202020206966202870726F70657274794E616D65203D3D3D202274617267657456616C7565496E70757422292072657475726E2066756E63';
wwv_flow_imp.g_varchar2_table(503) := '74696F6E202829207B0A2020202020202020766172205F6A647024696E707574343B0A202020202020202072657475726E20285F6A647024696E70757434203D206A64702E696E70757429203D3D206E756C6C203F20766F69642030203A205F6A647024';
wwv_flow_imp.g_varchar2_table(504) := '696E707574342E676574417474726962757465285441524745545F56414C55455F494E5055545F415454525F4E414D45293B0A2020202020207D3B0A2020202020206966202870726F70657274794E616D65203D3D3D202274617267657456616C756554';
wwv_flow_imp.g_varchar2_table(505) := '79706522292072657475726E2066756E6374696F6E202829207B0A2020202020202020766172205F6A647024696E707574353B0A202020202020202072657475726E20285F6A647024696E70757435203D206A64702E696E70757429203D3D206E756C6C';
wwv_flow_imp.g_varchar2_table(506) := '203F20766F69642030203A205F6A647024696E707574352E676574417474726962757465285441524745545F56414C55455F545950455F415454525F4E414D45293B0A2020202020207D3B0A2020202020206966202870726F70657274794E616D65203D';
wwv_flow_imp.g_varchar2_table(507) := '3D3D20226D6F646522292072657475726E2066756E6374696F6E202829207B0A2020202020202020766172205F6A647024696E707574363B0A202020202020202072657475726E206E6F726D616C697A6553656C656374696F6E4D6F646528285F6A6470';
wwv_flow_imp.g_varchar2_table(508) := '24696E70757436203D206A64702E696E70757429203D3D206E756C6C203F20766F69642030203A205F6A647024696E707574362E676574417474726962757465284D4F44455F415454525F4E414D4529293B0A2020202020207D3B0A2020202020206966';
wwv_flow_imp.g_varchar2_table(509) := '202870726F70657274794E616D65203D3D3D20226861735365636F6E6422292072657475726E2066756E6374696F6E202829207B0A2020202020202020766172205F6A647024696E707574373B0A202020202020202072657475726E206E6F726D616C69';
wwv_flow_imp.g_varchar2_table(510) := '7A65426F6F6C65616E4174747228285F6A647024696E70757437203D206A64702E696E70757429203D3D206E756C6C203F20766F69642030203A205F6A647024696E707574372E67657441747472696275746528415454525F4F5054494F4E5F4E414D45';
wwv_flow_imp.g_varchar2_table(511) := '532E6861735365636F6E64292C2074727565293B0A2020202020207D3B0A20202020202076617220617474724E616D65203D20415454525F4F5054494F4E5F4E414D45535B70726F70657274794E616D655D3B0A20202020202076617220697354696D65';
wwv_flow_imp.g_varchar2_table(512) := '203D2054494D455F415454525F4F5054494F4E5F4E414D45532E696E6465784F662870726F70657274794E616D6529203E202D313B0A20202020202072657475726E2066756E6374696F6E202829207B0A202020202020202072657475726E2067657444';
wwv_flow_imp.g_varchar2_table(513) := '6174654F7254696D6544656661756C7446726F6D4174747228617474724E616D652C20697354696D65293B0A2020202020207D3B0A202020207D3B0A2020202066756E6374696F6E20736574446566696E6550726F706572747946726F6D417474722870';
wwv_flow_imp.g_varchar2_table(514) := '726F70657274794E616D6529207B0A2020202020206966202865787465726E616C4F7074696F6E735B70726F70657274794E616D655D203D3D3D204F5054494F4E5F415454525F53455454494E47207C7C2070726F70657274794E616D65203D3D3D2022';
wwv_flow_imp.g_varchar2_table(515) := '6461746522207C7C2070726F70657274794E616D65203D3D3D202274696D652229207B0A20202020202020206966202870726F70657274794E616D6520213D3D202264617465222026262070726F70657274794E616D6520213D3D202274696D65222920';
wwv_flow_imp.g_varchar2_table(516) := '7B0A2020202020202020202064656C65746520696E7465726E616C4F7074696F6E735B70726F70657274794E616D655D3B0A20202020202020207D0A20202020202020207661722067657474657246756E63203D2066756E6374696F6E20676574746572';
wwv_flow_imp.g_varchar2_table(517) := '46756E632829207B0A2020202020202020202072657475726E207B7D3B0A20202020202020207D3B0A20202020202020206966202870726F70657274794E616D65203D3D3D2022646174652229207B0A20202020202020202020766172205F6578746572';
wwv_flow_imp.g_varchar2_table(518) := '6E616C4F7074696F6E7324646174653B0A20202020202020202020766172205F64617465203D20285F65787465726E616C4F7074696F6E732464617465203D2065787465726E616C4F7074696F6E732E646174652920213D206E756C6C203F205F657874';
wwv_flow_imp.g_varchar2_table(519) := '65726E616C4F7074696F6E732464617465203A20696E7465726E616C4F7074696F6E732E646174653B0A2020202020202020202064656C65746520696E7465726E616C4F7074696F6E735B70726F70657274794E616D655D3B0A20202020202020202020';
wwv_flow_imp.g_varchar2_table(520) := '67657474657246756E63203D2066756E6374696F6E2067657474657246756E632829207B0A202020202020202020202020766172205F6A647024696E707574382C205F6A647024696E707574393B0A20202020202020202020202072657475726E202128';
wwv_flow_imp.g_varchar2_table(521) := '285F6A647024696E70757438203D206A64702E696E7075742920213D206E756C6C202626205F6A647024696E707574382E686173417474726962757465284F4E4C595F54494D455F415454525F53455454494E475F4D41585F415454525F4E414D452929';
wwv_flow_imp.g_varchar2_table(522) := '20262620285F64617465207C7C2028285F6A647024696E70757439203D206A64702E696E70757429203D3D206E756C6C203F20766F69642030203A205F6A647024696E707574392E686173417474726962757465284F4E4C595F444154455F415454525F';
wwv_flow_imp.g_varchar2_table(523) := '53455454494E475F4D41585F415454525F4E414D452929293B0A202020202020202020207D3B0A20202020202020207D20656C7365206966202870726F70657274794E616D65203D3D3D202274696D652229207B0A20202020202020202020766172205F';
wwv_flow_imp.g_varchar2_table(524) := '65787465726E616C4F7074696F6E732474696D653B0A20202020202020202020766172205F74696D65203D20285F65787465726E616C4F7074696F6E732474696D65203D2065787465726E616C4F7074696F6E732E74696D652920213D206E756C6C203F';
wwv_flow_imp.g_varchar2_table(525) := '205F65787465726E616C4F7074696F6E732474696D65203A20696E7465726E616C4F7074696F6E732E74696D653B0A2020202020202020202064656C65746520696E7465726E616C4F7074696F6E735B70726F70657274794E616D655D3B0A2020202020';
wwv_flow_imp.g_varchar2_table(526) := '202020202067657474657246756E63203D2066756E6374696F6E2067657474657246756E632829207B0A202020202020202020202020766172205F6A647024696E707574302C205F6A647024696E707574313B0A20202020202020202020202072657475';
wwv_flow_imp.g_varchar2_table(527) := '726E202128285F6A647024696E70757430203D206A64702E696E7075742920213D206E756C6C202626205F6A647024696E707574302E686173417474726962757465284F4E4C595F444154455F415454525F53455454494E475F4D41585F415454525F4E';
wwv_flow_imp.g_varchar2_table(528) := '414D45292920262620285F74696D65207C7C2028285F6A647024696E70757431203D206A64702E696E70757429203D3D206E756C6C203F20766F69642030203A205F6A647024696E707574312E686173417474726962757465284F4E4C595F54494D455F';
wwv_flow_imp.g_varchar2_table(529) := '415454525F53455454494E475F4D41585F415454525F4E414D452929293B0A202020202020202020207D3B0A20202020202020207D20656C7365207B0A2020202020202020202067657474657246756E63203D2067657441747472476574746572287072';
wwv_flow_imp.g_varchar2_table(530) := '6F70657274794E616D65293B0A20202020202020207D0A202020202020202077696E646F772E4F626A6563742E646566696E6550726F706572747928696E7465726E616C4F7074696F6E732C2070726F70657274794E616D652C207B0A20202020202020';
wwv_flow_imp.g_varchar2_table(531) := '2020206765743A2067657474657246756E632C0A20202020202020202020656E756D657261626C653A20747275652C0A20202020202020202020636F6E666967757261626C653A20747275650A20202020202020207D293B0A2020202020207D20656C73';
wwv_flow_imp.g_varchar2_table(532) := '65207B0A2020202020202020766172205F74656D70203D20696E7465726E616C4F7074696F6E735B70726F70657274794E616D655D3B0A202020202020202064656C65746520696E7465726E616C4F7074696F6E735B70726F70657274794E616D655D3B';
wwv_flow_imp.g_varchar2_table(533) := '0A202020202020202073657444656661756C7456616C75652870726F70657274794E616D652C205F74656D70293B0A2020202020207D0A20202020202072657475726E20696E7465726E616C4F7074696F6E733B0A202020207D0A202020207365744465';
wwv_flow_imp.g_varchar2_table(534) := '6661756C7456616C75652822636F6E7461696E6572222C2022626F647922293B0A2020202073657444656661756C7456616C7565282273656C6563746F72222C2022696E7075745B646174612D6A64705D22293B0A2020202073657444656661756C7456';
wwv_flow_imp.g_varchar2_table(535) := '616C756528227A496E646578222C20313030303030293B0A2020202073657444656661756C7456616C756528226175746F53686F77222C2074727565293B0A2020202073657444656661756C7456616C756528226175746F48696465222C207472756529';
wwv_flow_imp.g_varchar2_table(536) := '3B0A2020202073657444656661756C7456616C756528226175746F526561644F6E6C79496E707574222C2069734D6F62696C65293B0A2020202073657444656661756C7456616C75652822746F705370616365222C2030293B0A20202020736574446566';
wwv_flow_imp.g_varchar2_table(537) := '61756C7456616C75652822626F74746F6D5370616365222C2030293B0A2020202073657444656661756C7456616C756528226F766572666C6F775370616365222C202D3130293B0A2020202073657444656661756C7456616C7565282268696465416674';
wwv_flow_imp.g_varchar2_table(538) := '65724368616E6765222C2074727565293B0A2020202073657444656661756C7456616C756528226869646541667465724368616E67655769746854696D65222C2066616C7365293B0A2020202073657444656661756C7456616C756528226368616E6765';
wwv_flow_imp.g_varchar2_table(539) := '4D6F6E7468526F7461746559656172222C2066616C7365293B0A2020202073657444656661756C7456616C7565282273686F77546F64617942746E222C2074727565293B0A2020202073657444656661756C7456616C7565282273686F77456D70747942';
wwv_flow_imp.g_varchar2_table(540) := '746E222C2074727565293B0A2020202073657444656661756C7456616C7565282273686F77436C6F736542746E222C2069734D6F62696C65293B0A2020202073657444656661756C7456616C75652822636F6E6669726D427574746F6E222C2074727565';
wwv_flow_imp.g_varchar2_table(541) := '293B0A2020202073657444656661756C7456616C756528227072696D617279436F6C6F72222C202222293B0A2020202073657444656661756C7456616C756528227468656D654D6F6465222C20226175746F22293B0A2020202073657444656661756C74';
wwv_flow_imp.g_varchar2_table(542) := '56616C7565282273686F7753656C65637454696D6542746E416C77617973222C2066616C7365293B0A2020202073657444656661756C7456616C756528226861735365636F6E64222C2074727565293B0A2020202073657444656661756C7456616C7565';
wwv_flow_imp.g_varchar2_table(543) := '282264617465222C2074727565293B0A2020202073657444656661756C7456616C7565282274696D65222C2066616C7365293B0A2020202073657444656661756C7456616C7565282264617973222C2044454641554C545F44415953293B0A2020202073';
wwv_flow_imp.g_varchar2_table(544) := '657444656661756C7456616C756528226D6F6E746873222C2044454641554C545F4D4F4E544853293B0A2020202073657444656661756C7456616C75652822736570617261746F724368617273222C2044454641554C545F534550415241544F525F4348';
wwv_flow_imp.g_varchar2_table(545) := '415253293B0A2020202073657444656661756C7456616C756528227065727369616E446967697473222C2066616C7365293B0A2020202073657444656661756C7456616C75652822706C757348746D6C222C2044454641554C545F504C55535F48544D4C';
wwv_flow_imp.g_varchar2_table(546) := '293B0A2020202073657444656661756C7456616C756528226D696E757348746D6C222C2044454641554C545F4D494E55535F48544D4C293B0A202020206966202865787465726E616C4F7074696F6E732E75736544726F70446F776E596561727320213D';
wwv_flow_imp.g_varchar2_table(547) := '3D20766F696420302026262065787465726E616C4F7074696F6E732E75736544726F70646F776E5965617273203D3D3D20766F6964203029207B0A202020202020696E7465726E616C4F7074696F6E732E75736544726F70646F776E5965617273203D20';
wwv_flow_imp.g_varchar2_table(548) := '65787465726E616C4F7074696F6E732E75736544726F70446F776E59656172733B0A202020207D0A2020202073657444656661756C7456616C7565282275736544726F70646F776E5965617273222C2074727565293B0A20202020696E7465726E616C4F';
wwv_flow_imp.g_varchar2_table(549) := '7074696F6E732E75736544726F70446F776E5965617273203D20696E7465726E616C4F7074696F6E732E75736544726F70646F776E59656172733B0A2020202073657444656661756C7456616C75652822746F646179222C206A616C616C69546F646179';
wwv_flow_imp.g_varchar2_table(550) := '2829293B0A2020202073657444656661756C7456616C75652822706F736974696F6E222C20226C65667422293B0A2020202073657444656661756C7456616C756528226D696E757465496E6372656D656E74222C2031293B0A2020202073657444656661';
wwv_flow_imp.g_varchar2_table(551) := '756C7456616C75652822686F7572496E6372656D656E74222C2031293B0A2020202073657444656661756C7456616C756528226D6F6465222C202273696E676C6522293B0A2020202073657444656661756C7456616C7565282272616E67655365706172';
wwv_flow_imp.g_varchar2_table(552) := '61746F72222C2044454641554C545F52414E47455F534550415241544F52293B0A2020202073657444656661756C7456616C756528226D756C7469706C65536570617261746F72222C2044454641554C545F4D554C5449504C455F534550415241544F52';
wwv_flow_imp.g_varchar2_table(553) := '293B0A2020202069662028697346756E6374696F6E2865787465726E616C4F7074696F6E732E64617952656E646572696E67292920696E7465726E616C4F7074696F6E732E64617952656E646572696E67203D2065787465726E616C4F7074696F6E732E';
wwv_flow_imp.g_varchar2_table(554) := '64617952656E646572696E673B0A202020206966202865787465726E616C4F7074696F6E732E696E697454696D652026262065787465726E616C4F7074696F6E732E696E697454696D6520213D3D204D494E5F4D41585F544F4441595F53455454494E47';
wwv_flow_imp.g_varchar2_table(555) := '2026262065787465726E616C4F7074696F6E732E696E697454696D6520213D3D204F5054494F4E5F415454525F53455454494E4729207B0A202020202020696E7465726E616C4F7074696F6E732E696E697454696D65203D2065787465726E616C4F7074';
wwv_flow_imp.g_varchar2_table(556) := '696F6E732E696E697454696D653B0A202020207D0A202020206966202865787465726E616C4F7074696F6E732E696E697444617465203D3D3D204D494E5F4D41585F544F4441595F53455454494E472920696E7465726E616C4F7074696F6E732E696E69';
wwv_flow_imp.g_varchar2_table(557) := '7444617465203D20696E7465726E616C4F7074696F6E732E746F6461793B0A202020206966202865787465726E616C4F7074696F6E732E6D696E44617465203D3D3D204D494E5F4D41585F544F4441595F53455454494E472920696E7465726E616C4F70';
wwv_flow_imp.g_varchar2_table(558) := '74696F6E732E6D696E44617465203D20696E7465726E616C4F7074696F6E732E746F6461793B0A202020206966202865787465726E616C4F7074696F6E732E6D617844617465203D3D3D204D494E5F4D41585F544F4441595F53455454494E472920696E';
wwv_flow_imp.g_varchar2_table(559) := '7465726E616C4F7074696F6E732E6D617844617465203D20696E7465726E616C4F7074696F6E732E746F6461793B0A20202020696E7465726E616C4F7074696F6E73203D20736574446566696E6550726F706572747946726F6D41747472282274696D65';
wwv_flow_imp.g_varchar2_table(560) := '22293B0A20202020696E7465726E616C4F7074696F6E73203D20736574446566696E6550726F706572747946726F6D4174747228226461746522293B0A20202020696E7465726E616C4F7074696F6E73203D20736574446566696E6550726F7065727479';
wwv_flow_imp.g_varchar2_table(561) := '46726F6D417474722822696E69744461746522293B0A20202020696E7465726E616C4F7074696F6E73203D20736574446566696E6550726F706572747946726F6D4174747228226D696E4461746522293B0A20202020696E7465726E616C4F7074696F6E';
wwv_flow_imp.g_varchar2_table(562) := '73203D20736574446566696E6550726F706572747946726F6D4174747228226D61784461746522293B0A20202020696E7465726E616C4F7074696F6E73203D20736574446566696E6550726F706572747946726F6D4174747228226D696E54696D652229';
wwv_flow_imp.g_varchar2_table(563) := '3B0A20202020696E7465726E616C4F7074696F6E73203D20736574446566696E6550726F706572747946726F6D4174747228226D617854696D6522293B0A20202020696E7465726E616C4F7074696F6E73203D20736574446566696E6550726F70657274';
wwv_flow_imp.g_varchar2_table(564) := '7946726F6D41747472282274617267657456616C7565496E70757422293B0A20202020696E7465726E616C4F7074696F6E73203D20736574446566696E6550726F706572747946726F6D41747472282274617267657456616C75655479706522293B0A20';
wwv_flow_imp.g_varchar2_table(565) := '202020696E7465726E616C4F7074696F6E73203D20736574446566696E6550726F706572747946726F6D4174747228226D6F646522293B0A20202020696E7465726E616C4F7074696F6E73203D20736574446566696E6550726F706572747946726F6D41';
wwv_flow_imp.g_varchar2_table(566) := '74747228226861735365636F6E6422293B0A2020202072657475726E20696E7465726E616C4F7074696F6E733B0A20207D3B0A2020766172204A616C616C69446174655069636B6572496E7465726E616C4F7074696F6E73203D202F2A235F5F50555245';
wwv_flow_imp.g_varchar2_table(567) := '5F5F2A2F66756E6374696F6E202829207B0A2020202066756E6374696F6E204A616C616C69446174655069636B6572496E7465726E616C4F7074696F6E732865787465726E616C4F7074696F6E732C206A647029207B0A202020202020746869732E636F';
wwv_flow_imp.g_varchar2_table(568) := '6E7461696E6572203D20766F696420303B0A202020202020746869732E73656C6563746F72203D20766F696420303B0A202020202020746869732E7A496E646578203D20766F696420303B0A202020202020746869732E6175746F53686F77203D20766F';
wwv_flow_imp.g_varchar2_table(569) := '696420303B0A202020202020746869732E6175746F48696465203D20766F696420303B0A202020202020746869732E6175746F526561644F6E6C79496E707574203D20766F696420303B0A202020202020746869732E746F705370616365203D20766F69';
wwv_flow_imp.g_varchar2_table(570) := '6420303B0A202020202020746869732E626F74746F6D5370616365203D20766F696420303B0A202020202020746869732E6F766572666C6F775370616365203D20766F696420303B0A202020202020746869732E6869646541667465724368616E676520';
wwv_flow_imp.g_varchar2_table(571) := '3D20766F696420303B0A202020202020746869732E6869646541667465724368616E67655769746854696D65203D20766F696420303B0A202020202020746869732E6368616E67654D6F6E7468526F7461746559656172203D20766F696420303B0A2020';
wwv_flow_imp.g_varchar2_table(572) := '20202020746869732E73686F77546F64617942746E203D20766F696420303B0A202020202020746869732E73686F77456D70747942746E203D20766F696420303B0A202020202020746869732E73686F77436C6F736542746E203D20766F696420303B0A';
wwv_flow_imp.g_varchar2_table(573) := '202020202020746869732E636F6E6669726D427574746F6E203D20766F696420303B0A202020202020746869732E7072696D617279436F6C6F72203D20766F696420303B0A202020202020746869732E7468656D654D6F6465203D20766F696420303B0A';
wwv_flow_imp.g_varchar2_table(574) := '202020202020746869732E73686F7753656C65637454696D6542746E416C77617973203D20766F696420303B0A202020202020746869732E64617952656E646572696E67203D20766F696420303B0A202020202020746869732E6D696E44617465203D20';
wwv_flow_imp.g_varchar2_table(575) := '766F696420303B0A202020202020746869732E6D617844617465203D20766F696420303B0A202020202020746869732E696E697444617465203D20766F696420303B0A202020202020746869732E6D696E54696D65203D20766F696420303B0A20202020';
wwv_flow_imp.g_varchar2_table(576) := '2020746869732E6D617854696D65203D20766F696420303B0A202020202020746869732E696E697454696D65203D20766F696420303B0A202020202020746869732E64617465203D20766F696420303B0A202020202020746869732E74696D65203D2076';
wwv_flow_imp.g_varchar2_table(577) := '6F696420303B0A202020202020746869732E746F646179203D20766F696420303B0A202020202020746869732E6861735365636F6E64203D20766F696420303B0A202020202020746869732E74617267657456616C7565496E707574203D20766F696420';
wwv_flow_imp.g_varchar2_table(578) := '303B0A202020202020746869732E74617267657456616C756554797065203D20766F696420303B0A202020202020746869732E64617973203D20766F696420303B0A202020202020746869732E6D6F6E746873203D20766F696420303B0A202020202020';
wwv_flow_imp.g_varchar2_table(579) := '746869732E736570617261746F724368617273203D20766F696420303B0A202020202020746869732E7065727369616E446967697473203D20766F696420303B0A202020202020746869732E706C757348746D6C203D20766F696420303B0A2020202020';
wwv_flow_imp.g_varchar2_table(580) := '20746869732E6D696E757348746D6C203D20766F696420303B0A202020202020746869732E75736544726F70646F776E5965617273203D20766F696420303B0A2020202020202F2A2A0A202020202020202A204064657072656361746564206368616E67';
wwv_flow_imp.g_varchar2_table(581) := '6520746F2075736544726F70646F776E59656172730A202020202020202A2F0A202020202020746869732E75736544726F70446F776E5965617273203D20766F696420303B0A202020202020746869732E706F736974696F6E203D20766F696420303B0A';
wwv_flow_imp.g_varchar2_table(582) := '202020202020746869732E6D696E757465496E6372656D656E74203D20766F696420303B0A202020202020746869732E686F7572496E6372656D656E74203D20766F696420303B0A202020202020746869732E6D6F6465203D20766F696420303B0A2020';
wwv_flow_imp.g_varchar2_table(583) := '20202020746869732E72616E6765536570617261746F72203D20766F696420303B0A202020202020746869732E6D756C7469706C65536570617261746F72203D20766F696420303B0A2020202020206E6F726D616C697A654F7074696F6E732865787465';
wwv_flow_imp.g_varchar2_table(584) := '726E616C4F7074696F6E73207C7C207B7D2C2069734E6F744F626A6563744F724973456D7074794F626A656374286A64702E6F7074696F6E7329203F2074686973203A206A64702E6F7074696F6E732C206A6470293B0A202020207D0A20202020766172';
wwv_flow_imp.g_varchar2_table(585) := '205F70726F746F203D204A616C616C69446174655069636B6572496E7465726E616C4F7074696F6E732E70726F746F747970653B0A202020205F70726F746F2E757064617465203D2066756E6374696F6E207570646174652865787465726E616C4F7074';
wwv_flow_imp.g_varchar2_table(586) := '696F6E732C206A647029207B0A2020202020206E6F726D616C697A654F7074696F6E732865787465726E616C4F7074696F6E73207C7C207B7D2C20746869732C206A6470293B0A202020207D3B0A2020202072657475726E204A616C616C694461746550';
wwv_flow_imp.g_varchar2_table(587) := '69636B6572496E7465726E616C4F7074696F6E733B0A20207D28293B0A2020766172206A616C616C69446174657069636B6572203D207B0A20202020696E69743A2066756E6374696F6E20696E6974286F7074696F6E7329207B0A202020202020746869';
wwv_flow_imp.g_varchar2_table(588) := '732E7570646174654F7074696F6E73286F7074696F6E73293B0A2020202020206164644576656E744C697374656E65724F6E526573697A6528293B0A2020202020206164644576656E744C697374656E65724F6E426F647928293B0A2020202020206164';
wwv_flow_imp.g_varchar2_table(589) := '644576656E744C697374656E65724F6E496E7075747328746869732E6F7074696F6E732E73656C6563746F72293B0A202020207D2C0A202020207570646174654F7074696F6E733A2066756E6374696F6E207570646174654F7074696F6E73286F707469';
wwv_flow_imp.g_varchar2_table(590) := '6F6E7329207B0A2020202020206966202869734E6F744F626A6563744F724973456D7074794F626A65637428746869732E6F7074696F6E732929207B0A2020202020202020746869732E6F7074696F6E73203D206E6577204A616C616C69446174655069';
wwv_flow_imp.g_varchar2_table(591) := '636B6572496E7465726E616C4F7074696F6E73286F7074696F6E732C2074686973293B0A2020202020207D20656C7365207B0A2020202020202020746869732E6F7074696F6E732E757064617465286F7074696F6E732C2074686973293B0A2020202020';
wwv_flow_imp.g_varchar2_table(592) := '207D0A2020202020206170706C795A496E64657828293B0A202020207D2C0A202020206F7074696F6E733A207B7D2C0A20202020696E7075743A206E756C6C2C0A2020202069735472616E736974696F6E696E673A2066616C73652C0A20202020676574';
wwv_flow_imp.g_varchar2_table(593) := '206470436F6E7461696E65722829207B0A2020202020206966202821746869732E5F6470436F6E7461696E6572207C7C2021746869732E5F6470436F6E7461696E65722E6973436F6E6E656374656429207B0A2020202020202020746869732E5F647043';
wwv_flow_imp.g_varchar2_table(594) := '6F6E7461696E6572203D20637265617465456C656D656E7428434F4E5441494E45525F454C454D454E545F51554552592C20676574486F7374506172656E7428746869732E6F7074696F6E732E636F6E7461696E657229293B0A20202020202020207468';
wwv_flow_imp.g_varchar2_table(595) := '69732E5F6470436F6E7461696E65722E7365744174747269627574652822746162696E646578222C20222D3122293B0A2020202020207D0A2020202020206966202821746869732E6F7665726C6179456C656D656E74207C7C2021746869732E6F766572';
wwv_flow_imp.g_varchar2_table(596) := '6C6179456C656D656E742E6973436F6E6E656374656429207B0A2020202020202020746869732E6F7665726C6179456C656D656E74203D20637265617465456C656D656E74284F5645524C41595F454C454D454E545F51554552592C20676574486F7374';
wwv_flow_imp.g_varchar2_table(597) := '506172656E7428746869732E6F7074696F6E732E636F6E7461696E657229293B0A2020202020207D0A2020202020206170706C795A496E64657828293B0A20202020202072657475726E20746869732E5F6470436F6E7461696E65723B0A202020207D2C';
wwv_flow_imp.g_varchar2_table(598) := '0A2020202067657420746F6461792829207B0A202020202020746869732E5F746F646179203D20746869732E5F746F646179207C7C20746869732E6F7074696F6E732E746F646179207C7C206A616C616C69546F64617928293B0A202020202020726574';
wwv_flow_imp.g_varchar2_table(599) := '75726E20746869732E5F746F6461793B0A202020207D2C0A2020202067657420696E70757456616C75652829207B0A202020202020766172205F7468697324696E7075743B0A20202020202076617220696E70757456616C7565203D2028285F74686973';
wwv_flow_imp.g_varchar2_table(600) := '24696E707574203D20746869732E696E70757429203D3D206E756C6C203F20766F69642030203A205F7468697324696E7075742E76616C756529207C7C2022223B0A20202020202069662028697356616C696456616C7565537472696E6728746869732C';
wwv_flow_imp.g_varchar2_table(601) := '20696E70757456616C75652929207B0A202020202020202072657475726E2067657456616C75654F626A65637446726F6D537472696E6728746869732C20696E70757456616C7565293B0A2020202020207D0A20202020202069662028697356616C6964';
wwv_flow_imp.g_varchar2_table(602) := '44617465537472696E6728746869732C20696E70757456616C75652929207B0A202020202020202072657475726E2067657456616C75654F626A65637446726F6D537472696E6728746869732C20696E70757456616C7565293B0A2020202020207D0A20';
wwv_flow_imp.g_varchar2_table(603) := '202020202072657475726E207B7D3B0A202020207D2C0A2020202067657420696E6974446174652829207B0A20202020202069662028746869732E6F7074696F6E732E696E69744461746529207B0A202020202020202072657475726E20746869732E6F';
wwv_flow_imp.g_varchar2_table(604) := '7074696F6E732E696E6974446174653B0A2020202020207D0A20202020202069662028746869732E5F696E69744461746529207B0A202020202020202072657475726E20746869732E5F696E6974446174653B0A2020202020207D0A2020202020207468';
wwv_flow_imp.g_varchar2_table(605) := '69732E5F696E697444617465203D206E6F726D616C697A654D696E4D61784461746528746869732C20676574496E697469616C44617465287468697329293B0A20202020202072657475726E20746869732E5F696E6974446174653B0A202020207D2C0A';
wwv_flow_imp.g_varchar2_table(606) := '2020202067657420696E697454696D652829207B0A20202020202069662028746869732E5F696E697454696D6529207B0A202020202020202072657475726E20746869732E5F696E697454696D653B0A2020202020207D0A202020202020746869732E5F';
wwv_flow_imp.g_varchar2_table(607) := '696E697454696D65203D206E6F726D616C697A654D696E4D617854696D6528746869732C20676574496E697469616C54696D65287468697329293B0A20202020202072657475726E20746869732E5F696E697454696D653B0A202020207D2C0A20202020';
wwv_flow_imp.g_varchar2_table(608) := '5F647261773A20647261772C0A2020202073686F773A2066756E6374696F6E2073686F7728696E70757429207B0A202020202020766172205F74686973203D20746869733B0A202020202020746869732E72657665727450656E64696E6728293B0A2020';
wwv_flow_imp.g_varchar2_table(609) := '20202020726573657443757272656E74496E70757453746174652874686973293B0A202020202020746869732E696E707574203D20696E7075743B0A202020202020746869732E5F636F6D6D6974746564203D20696E7075742E76616C75653B0A202020';
wwv_flow_imp.g_varchar2_table(610) := '202020746869732E5F70656E64696E67203D2066616C73653B0A20202020202073657453656C6563746564446174657346726F6D496E7075742874686973293B0A202020202020746869732E5F6472617728293B0A202020202020736574526561644F6E';
wwv_flow_imp.g_varchar2_table(611) := '6C7928696E7075742C20746869732E6F7074696F6E73293B0A202020202020746869732E69735472616E736974696F6E696E67203D20747275653B0A2020202020207365745069636B65725669736962696C69747928746869732C2074727565293B0A20';
wwv_flow_imp.g_varchar2_table(612) := '202020202073657454696D656F75742866756E6374696F6E202829207B0A20202020202020207365745069636B65725669736962696C697479285F746869732C2074727565293B0A20202020202020205F746869732E697353686F77203D20747275653B';
wwv_flow_imp.g_varchar2_table(613) := '0A20202020202020205F746869732E69735472616E736974696F6E696E67203D2066616C73653B0A2020202020207D2C20333030293B0A202020202020746869732E736574506F736974696F6E28293B0A2020202020207365745363726F6C6C4F6E5061';
wwv_flow_imp.g_varchar2_table(614) := '72656E7428696E707574293B0A202020202020646F63756D656E742E6164644576656E744C697374656E6572284556454E545F4B4559444F574E5F5354522C2068616E646C654573634B6579293B0A202020202020617474616368486F737428293B0A20';
wwv_flow_imp.g_varchar2_table(615) := '2020207D2C0A20202020686964653A2066756E6374696F6E20686964652829207B0A2020202020202F2F20636F6D6D69742070656E64696E672073656C656374696F6E207768656E20636C6F73696E672028636C69636B206F757473696465202F204573';
wwv_flow_imp.g_varchar2_table(616) := '632920E280942061637473206C696B6520436F6E6669726D0A20202020202069662028746869732E5F70656E64696E6729207B0A202020202020202076617220696E70203D20746869732E696E7075743B0A202020202020202069662028696E7029207B';
wwv_flow_imp.g_varchar2_table(617) := '0A20202020202020202020746869732E5F70656E64696E67203D2066616C73653B0A20202020202020202020746869732E5F636F6D6D6974746564203D20696E702E76616C75653B0A20202020202020202020747269676765724576656E7428696E702C';
wwv_flow_imp.g_varchar2_table(618) := '204556454E545F4348414E47455F494E5055545F535452293B0A20202020202020202020746869732E73657454617267657456616C756528293B0A20202020202020207D0A2020202020207D20656C7365207B0A2020202020202020746869732E726576';
wwv_flow_imp.g_varchar2_table(619) := '65727450656E64696E6728293B0A2020202020207D0A202020202020646574616368486F737428293B0A2020202020207365745069636B65725669736962696C69747928746869732C2066616C7365293B0A202020202020746869732E697353686F7720';
wwv_flow_imp.g_varchar2_table(620) := '3D2066616C73653B0A20202020202072656D6F76655363726F6C6C4F6E506172656E7428293B0A202020202020646F63756D656E742E72656D6F76654576656E744C697374656E6572284556454E545F4B4559444F574E5F5354522C2068616E646C6545';
wwv_flow_imp.g_varchar2_table(621) := '73634B6579293B0A202020207D2C0A20202020736574506F736974696F6E3A2066756E6374696F6E20736574506F736974696F6E2829207B0A2020202020206966202821746869732E696E707574207C7C20746869732E6470436F6E7461696E65722E73';
wwv_flow_imp.g_varchar2_table(622) := '74796C652E7669736962696C69747920213D3D205354594C455F5649534942494C4954595F56495349424C4529207B0A202020202020202072657475726E3B0A2020202020207D0A20202020202076617220686F73746564203D20746869732E5F647043';
wwv_flow_imp.g_varchar2_table(623) := '6F6E7461696E657220262620746869732E5F6470436F6E7461696E65722E6F776E6572446F63756D656E7420213D3D20646F63756D656E743B0A20202020202076617220686F737457696E203D20686F73746564203F20676574486F737457696E646F77';
wwv_flow_imp.g_varchar2_table(624) := '2829203A2077696E646F773B0A202020202020766172206F6666203D20686F73746564203F206765744672616D654F66667365742829203A207B20783A20302C20793A2030207D3B0A20202020202076617220696E707574426F756E6473203D20746869';
wwv_flow_imp.g_varchar2_table(625) := '732E696E7075742E676574426F756E64696E67436C69656E745265637428293B0A20202020202076617220696E707574486569676874203D20696E707574426F756E64732E6865696768743B0A202020202020766172206C656674203D20696E70757442';
wwv_flow_imp.g_varchar2_table(626) := '6F756E64732E6C656674202B206F66662E783B0A20202020202076617220746F70203D20696E707574426F756E64732E746F70202B206F66662E79202B20696E7075744865696768743B0A20202020202069662028746869732E6F7074696F6E732E746F';
wwv_flow_imp.g_varchar2_table(627) := '7053706163652920746F70202B3D20746869732E6F7074696F6E732E746F7053706163653B0A2020202020207661722077696E646F775769647468203D20686F737457696E2E646F63756D656E742E626F64792E6F666673657457696474683B0A202020';
wwv_flow_imp.g_varchar2_table(628) := '202020766172206470436F6E7461696E65725769647468203D20746869732E6470436F6E7461696E65722E6F666673657457696474683B0A202020202020766172206470436F6E7461696E6572486569676874203D20746869732E6470436F6E7461696E';
wwv_flow_imp.g_varchar2_table(629) := '65722E6F66667365744865696768743B0A20202020202076617220706F736974696F6E203D20746869732E6F7074696F6E732E706F736974696F6E3B0A20202020202069662028706F736974696F6E203D3D3D202272696768742229207B0A2020202020';
wwv_flow_imp.g_varchar2_table(630) := '2020206C656674203D206C656674202B20696E707574426F756E64732E7769647468202D206470436F6E7461696E657257696474683B0A2020202020202020696620286C656674202B206470436F6E7461696E65725769647468203E3D2077696E646F77';
wwv_flow_imp.g_varchar2_table(631) := '576964746829207B0A202020202020202020206C656674202D3D206C656674202B206470436F6E7461696E65725769647468202D202877696E646F775769647468202B2028746869732E6F7074696F6E732E6F766572666C6F775370616365207C7C2030';
wwv_flow_imp.g_varchar2_table(632) := '29293B0A20202020202020207D0A2020202020207D20656C73652069662028706F736974696F6E203D3D3D202263656E7465722229207B0A20202020202020206C656674203D206C656674202B20696E707574426F756E64732E7769647468202F203220';
wwv_flow_imp.g_varchar2_table(633) := '2D206470436F6E7461696E65725769647468202F20323B0A2020202020202020696620286C656674202B206470436F6E7461696E65725769647468203E3D2077696E646F77576964746829207B0A202020202020202020206C656674202D3D206C656674';
wwv_flow_imp.g_varchar2_table(634) := '202B206470436F6E7461696E65725769647468202D202877696E646F775769647468202B2028746869732E6F7074696F6E732E6F766572666C6F775370616365207C7C203029293B0A20202020202020207D0A2020202020207D0A202020202020696620';
wwv_flow_imp.g_varchar2_table(635) := '286C656674202B206470436F6E7461696E65725769647468203E3D2077696E646F77576964746829207B0A20202020202020206C656674202D3D206C656674202B206470436F6E7461696E65725769647468202D202877696E646F775769647468202B20';
wwv_flow_imp.g_varchar2_table(636) := '28746869732E6F7074696F6E732E6F766572666C6F775370616365207C7C203029293B0A2020202020207D0A202020202020696620286C656674203C203029207B0A20202020202020206C656674203D20303B0A2020202020207D0A2020202020206966';
wwv_flow_imp.g_varchar2_table(637) := '2028746F70202D20696E707574486569676874203E3D206470436F6E7461696E657248656967687420262620746F70202B206470436F6E7461696E6572486569676874203E3D20686F737457696E2E696E6E657248656967687429207B0A202020202020';
wwv_flow_imp.g_varchar2_table(638) := '2020746F70202D3D206470436F6E7461696E6572486569676874202B20696E707574486569676874202B2028746869732E6F7074696F6E732E626F74746F6D5370616365207C7C203029202B2028746869732E6F7074696F6E732E746F70537061636520';
wwv_flow_imp.g_varchar2_table(639) := '7C7C2030293B0A2020202020207D0A202020202020746869732E6470436F6E7461696E65722E7374796C652E706F736974696F6E203D205354594C455F504F534954494F4E5F46495845443B0A202020202020746869732E6470436F6E7461696E65722E';
wwv_flow_imp.g_varchar2_table(640) := '7374796C652E6C656674203D206C656674202B20227078223B0A202020202020746869732E6470436F6E7461696E65722E7374796C652E746F70203D20746F70202B20227078223B0A202020207D2C0A202020206765742067657456616C75652829207B';
wwv_flow_imp.g_varchar2_table(641) := '0A202020202020746869732E5F76616C7565203D20746869732E5F76616C7565207C7C20746869732E696E70757456616C7565207C7C207B7D3B0A20202020202072657475726E20746869732E5F76616C75653B0A202020207D2C0A2020202073657456';
wwv_flow_imp.g_varchar2_table(642) := '616C75653A2066756E6374696F6E2073657456616C7565286F626A56616C756529207B0A20202020202069662028746869732E6F7074696F6E732E646174652026262028746869732E6F7074696F6E732E6D6F6465207C7C202273696E676C6522292021';
wwv_flow_imp.g_varchar2_table(643) := '3D3D202273696E676C65222026262069734461746556616C7565286F626A56616C75652929207B0A20202020202020207365744461746553656C656374696F6E56616C756528746869732C206F626A56616C7565293B0A20202020202020207265747572';
wwv_flow_imp.g_varchar2_table(644) := '6E3B0A2020202020207D0A202020202020746869732E5F76616C7565203D205F657874656E64287B0A2020202020202020796561723A20746869732E746F6461792E796561722C0A20202020202020206D6F6E74683A20746869732E746F6461792E6D6F';
wwv_flow_imp.g_varchar2_table(645) := '6E74682C0A20202020202020206461793A20746869732E746F6461792E6461792C0A2020202020202020686F75723A20746869732E696E697454696D652E686F75722C0A20202020202020206D696E7574653A20746869732E696E697454696D652E6D69';
wwv_flow_imp.g_varchar2_table(646) := '6E7574652C0A20202020202020207365636F6E643A20746869732E696E697454696D652E7365636F6E640A2020202020207D2C205F657874656E6428746869732E5F76616C7565207C7C207B7D2C206F626A56616C756529293B0A202020202020746869';
wwv_flow_imp.g_varchar2_table(647) := '732E5F696E697454696D65203D206E756C6C3B0A20202020202076617220737461676564203D202121746869732E6F7074696F6E732E636F6E6669726D427574746F6E3B0A20202020202069662028746869732E696E70757429207B0A20202020202020';
wwv_flow_imp.g_varchar2_table(648) := '20746869732E696E7075742E76616C7565203D2067657456616C7565537472696E6746726F6D56616C75654F626A65637428746869732C20746869732E5F76616C7565293B0A20202020202020206966202873746167656429207B0A2020202020202020';
wwv_flow_imp.g_varchar2_table(649) := '2020746869732E5F70656E64696E67203D20747275653B0A20202020202020207D20656C7365207B0A20202020202020202020747269676765724576656E7428746869732E696E7075742C204556454E545F4348414E47455F494E5055545F535452293B';
wwv_flow_imp.g_varchar2_table(650) := '0A20202020202020207D0A2020202020207D0A20202020202069662028217374616765642920746869732E73657454617267657456616C756528293B0A2020202020206966202873746167656429207B0A2020202020202020746869732E5F6472617728';
wwv_flow_imp.g_varchar2_table(651) := '293B0A20202020202020202F2F20646174652D6F6E6C793A2073656C656374696E6720612064617920696D6D6564696174656C7920636F6E6669726D7320616E6420636C6F7365730A20202020202020206966202821746869732E6F7074696F6E732E74';
wwv_flow_imp.g_varchar2_table(652) := '696D6529207B0A20202020202020202020746869732E636F6E6669726D56616C756528293B0A2020202020202020202072657475726E3B0A20202020202020207D0A2020202020207D20656C73652069662028746869732E6F7074696F6E732E68696465';
wwv_flow_imp.g_varchar2_table(653) := '41667465724368616E6765202626202821746869732E6F7074696F6E732E74696D65207C7C20746869732E6F7074696F6E732E6869646541667465724368616E67655769746854696D652929207B0A2020202020202020746869732E6869646528293B0A';
wwv_flow_imp.g_varchar2_table(654) := '2020202020207D20656C7365207B0A2020202020202020746869732E5F6472617728293B0A2020202020207D0A202020207D2C0A20202020636F6E6669726D56616C75653A2066756E6374696F6E20636F6E6669726D56616C75652829207B0A20202020';
wwv_flow_imp.g_varchar2_table(655) := '202076617220696E70203D20746869732E696E7075743B0A20202020202069662028696E7020262620746869732E5F70656E64696E6729207B0A2020202020202020746869732E5F70656E64696E67203D2066616C73653B0A2020202020202020746869';
wwv_flow_imp.g_varchar2_table(656) := '732E5F636F6D6D6974746564203D20696E702E76616C75653B0A2020202020202020747269676765724576656E7428696E702C204556454E545F4348414E47455F494E5055545F535452293B0A2020202020202020746869732E73657454617267657456';
wwv_flow_imp.g_varchar2_table(657) := '616C756528293B0A2020202020207D0A202020202020746869732E6869646528293B0A202020207D2C0A2020202072657665727450656E64696E673A2066756E6374696F6E2072657665727450656E64696E672829207B0A202020202020696620287468';
wwv_flow_imp.g_varchar2_table(658) := '69732E5F70656E64696E6720262620746869732E696E70757429207B0A2020202020202020746869732E696E7075742E76616C7565203D20746869732E5F636F6D6D6974746564207C7C2022223B0A2020202020207D0A202020202020746869732E5F70';
wwv_flow_imp.g_varchar2_table(659) := '656E64696E67203D2066616C73653B0A202020207D2C0A20202020636C65616E56616C75653A2066756E6374696F6E20636C65616E56616C75652829207B0A202020202020746869732E5F70656E64696E67203D2066616C73653B0A2020202020207468';
wwv_flow_imp.g_varchar2_table(660) := '69732E5F636F6D6D6974746564203D2022223B0A202020202020746869732E73656C65637465644461746573203D205B5D3B0A20202020202069662028746869732E696E70757429207B0A2020202020202020746869732E696E7075742E76616C756520';
wwv_flow_imp.g_varchar2_table(661) := '3D2022223B0A2020202020202020747269676765724576656E7428746869732E696E7075742C204556454E545F4348414E47455F494E5055545F535452293B0A2020202020207D0A202020202020746869732E73657454617267657456616C756528293B';
wwv_flow_imp.g_varchar2_table(662) := '0A202020207D2C0A2020202073657454617267657456616C75653A2066756E6374696F6E2073657454617267657456616C75652829207B0A2020202020206966202821746869732E6F7074696F6E732E74617267657456616C7565496E70757429207265';
wwv_flow_imp.g_varchar2_table(663) := '7475726E3B0A20202020202076617220746172676574496E7075744C697374203D20746869732E6F7074696F6E732E74617267657456616C7565496E70757420696E7374616E63656F662048544D4C456C656D656E74203F205B746869732E6F7074696F';
wwv_flow_imp.g_varchar2_table(664) := '6E732E74617267657456616C7565496E7075745D203A20646F63756D656E742E717565727953656C6563746F72416C6C28746869732E6F7074696F6E732E74617267657456616C7565496E707574293B0A2020202020206966202821746172676574496E';
wwv_flow_imp.g_varchar2_table(665) := '7075744C697374207C7C2021746172676574496E7075744C6973742E6C656E677468292072657475726E3B0A202020202020666F7220287661722069203D20303B2069203C20746172676574496E7075744C6973742E6C656E6774683B20692B2B29207B';
wwv_flow_imp.g_varchar2_table(666) := '0A202020202020202076617220746172676574496E707574203D20746172676574496E7075744C6973745B695D3B0A2020202020202020746172676574496E7075742E76616C7565203D20676574436F6E76657274656456616C75652874686973293B0A';
wwv_flow_imp.g_varchar2_table(667) := '2020202020207D0A202020207D2C0A20202020696E6372656173654D6F6E74683A2066756E6374696F6E20696E6372656173654D6F6E74682829207B0A2020202020206966202821746869732E5F696E697444617465292072657475726E3B0A20202020';
wwv_flow_imp.g_varchar2_table(668) := '20207661722069734C6173744D6F6E7468203D20746869732E5F696E6974446174652E6D6F6E7468203D3D3D2031323B0A20202020202069662028746869732E6F7074696F6E732E6368616E67654D6F6E7468526F74617465596561722026262069734C';
wwv_flow_imp.g_varchar2_table(669) := '6173744D6F6E746829207B0A2020202020202020746869732E696E6372656173655965617228293B0A2020202020207D0A202020202020746869732E6D6F6E74684368616E67652869734C6173744D6F6E7468203F2031203A20746869732E5F696E6974';
wwv_flow_imp.g_varchar2_table(670) := '446174652E6D6F6E7468202B2031293B0A202020207D2C0A2020202064656372656173654D6F6E74683A2066756E6374696F6E2064656372656173654D6F6E74682829207B0A2020202020206966202821746869732E5F696E6974446174652920726574';
wwv_flow_imp.g_varchar2_table(671) := '75726E3B0A20202020202076617220697346697273744D6F6E7468203D20746869732E5F696E6974446174652E6D6F6E7468203D3D3D20313B0A20202020202069662028746869732E6F7074696F6E732E6368616E67654D6F6E7468526F746174655965';
wwv_flow_imp.g_varchar2_table(672) := '617220262620697346697273744D6F6E746829207B0A2020202020202020746869732E64656372656173655965617228293B0A2020202020207D0A202020202020746869732E6D6F6E74684368616E676528697346697273744D6F6E7468203F20313220';
wwv_flow_imp.g_varchar2_table(673) := '3A20746869732E5F696E6974446174652E6D6F6E7468202D2031293B0A202020207D2C0A202020206D6F6E74684368616E67653A2066756E6374696F6E206D6F6E74684368616E6765286D6F6E746829207B0A2020202020206966202821746869732E5F';
wwv_flow_imp.g_varchar2_table(674) := '696E697444617465292072657475726E3B0A202020202020746869732E5F696E697444617465203D206E6F726D616C697A654D696E4D61784461746528746869732C20746869732E5F696E6974446174652C207B0A20202020202020206D6F6E74683A20';
wwv_flow_imp.g_varchar2_table(675) := '6D6F6E74680A2020202020207D293B0A202020202020746869732E5F6472617728293B0A202020207D2C0A20202020696E637265617365596561723A2066756E6374696F6E20696E637265617365596561722829207B0A20202020202069662028217468';
wwv_flow_imp.g_varchar2_table(676) := '69732E5F696E697444617465292072657475726E3B0A202020202020746869732E796561724368616E676528746869732E5F696E6974446174652E79656172202B2031293B0A202020207D2C0A202020206465637265617365596561723A2066756E6374';
wwv_flow_imp.g_varchar2_table(677) := '696F6E206465637265617365596561722829207B0A2020202020206966202821746869732E5F696E697444617465292072657475726E3B0A202020202020746869732E796561724368616E676528746869732E5F696E6974446174652E79656172202D20';
wwv_flow_imp.g_varchar2_table(678) := '31293B0A202020207D2C0A20202020796561724368616E67653A2066756E6374696F6E20796561724368616E6765287965617229207B0A2020202020206966202821746869732E5F696E697444617465292072657475726E3B0A20202020202074686973';
wwv_flow_imp.g_varchar2_table(679) := '2E5F696E697444617465203D206E6F726D616C697A654D696E4D61784461746528746869732C20746869732E5F696E6974446174652C207B0A2020202020202020796561723A20796561720A2020202020207D293B0A202020202020746869732E5F6472';
wwv_flow_imp.g_varchar2_table(680) := '617728293B0A202020207D2C0A202020205F6470436F6E7461696E65723A20766F696420302C0A202020206F7665726C6179456C656D656E743A20766F696420302C0A202020205F7363726F6C6C506172656E743A20766F696420302C0A202020205F73';
wwv_flow_imp.g_varchar2_table(681) := '63726F6C6C48616E646C65723A20766F696420302C0A202020205F746F6461793A20766F696420302C0A202020205F696E6974446174653A206E756C6C2C0A202020205F696E697454696D653A206E756C6C2C0A202020205F76616C75653A206E756C6C';
wwv_flow_imp.g_varchar2_table(682) := '2C0A2020202073656C656374656444617465733A205B5D2C0A20202020697353686F773A2066616C73650A20207D3B0A202066756E6374696F6E2067657443757272656E7454696D652829207B0A202020207661722064617465203D202F2A20405F5F50';
wwv_flow_imp.g_varchar2_table(683) := '5552455F5F202A2F6E6577204461746528293B0A2020202072657475726E207B0A202020202020686F75723A20646174652E676574486F75727328292C0A2020202020206D696E7574653A20646174652E6765744D696E7574657328292C0A2020202020';
wwv_flow_imp.g_varchar2_table(684) := '207365636F6E643A20300A202020207D3B0A20207D0A202066756E6374696F6E20676574496E697469616C44617465286A647029207B0A20202020766172205F6A647024696E70757431303B0A2020202076617220696E70757456616C7565203D202828';
wwv_flow_imp.g_varchar2_table(685) := '5F6A647024696E7075743130203D206A64702E696E70757429203D3D206E756C6C203F20766F69642030203A205F6A647024696E70757431302E76616C756529207C7C2022223B0A202020206966202821696E70757456616C756529207B0A2020202020';
wwv_flow_imp.g_varchar2_table(686) := '2072657475726E206A64702E6F7074696F6E732E696E697444617465207C7C20636C6F6E65286A64702E746F646179293B0A202020207D0A2020202069662028697356616C696444617465537472696E67286A64702C20696E70757456616C7565292920';
wwv_flow_imp.g_varchar2_table(687) := '7B0A20202020202072657475726E2067657456616C75654F626A65637446726F6D537472696E67286A64702C20696E70757456616C7565293B0A202020207D0A2020202072657475726E20636C6F6E65286A64702E746F646179293B0A20207D0A202066';
wwv_flow_imp.g_varchar2_table(688) := '756E6374696F6E20676574496E697469616C54696D65286A647029207B0A20202020766172205F6A647024696E70757431313B0A202020207661722064656661756C74496E6974203D2067657443757272656E7454696D6528293B0A2020202076617220';
wwv_flow_imp.g_varchar2_table(689) := '696E697454696D65203D2028285F6A647024696E7075743131203D206A64702E696E70757429203D3D206E756C6C203F20766F69642030203A205F6A647024696E70757431312E76616C756529207C7C206A64702E6F7074696F6E732E696E697454696D';
wwv_flow_imp.g_varchar2_table(690) := '65207C7C2064656661756C74496E69743B0A2020202069662028216973537472696E6728696E697454696D652929207B0A20202020202072657475726E20696E697454696D653B0A202020207D0A2020202069662028697356616C696454696D65537472';
wwv_flow_imp.g_varchar2_table(691) := '696E67286A64702C20696E697454696D652929207B0A20202020202072657475726E2067657456616C75654F626A65637446726F6D537472696E67286A64702C20696E697454696D65293B0A202020207D0A2020202072657475726E2064656661756C74';
wwv_flow_imp.g_varchar2_table(692) := '496E69743B0A20207D0A202066756E6374696F6E20726573657443757272656E74496E7075745374617465286A647029207B0A202020206A64702E5F696E697444617465203D206E756C6C3B0A202020206A64702E5F696E697454696D65203D206E756C';
wwv_flow_imp.g_varchar2_table(693) := '6C3B0A202020206A64702E5F76616C7565203D206E756C6C3B0A202020206A64702E73656C65637465644461746573203D205B5D3B0A20207D0A202066756E6374696F6E2069734461746556616C75652876616C756529207B0A2020202072657475726E';
wwv_flow_imp.g_varchar2_table(694) := '20747970656F662076616C75652E79656172203D3D3D20226E756D6265722220262620747970656F662076616C75652E6D6F6E7468203D3D3D20226E756D6265722220262620747970656F662076616C75652E646179203D3D3D20226E756D626572223B';
wwv_flow_imp.g_varchar2_table(695) := '0A20207D0A202066756E6374696F6E2073657453656C6563746564446174657346726F6D496E707574286A647029207B0A20202020766172205F6A647024696E70757431323B0A2020202069662028286A64702E6F7074696F6E732E6D6F6465207C7C20';
wwv_flow_imp.g_varchar2_table(696) := '2273696E676C652229203D3D3D202273696E676C6522292072657475726E3B0A202020206A64702E73656C65637465644461746573203D2067657453656C6563746564446174657346726F6D537472696E67286A64702C2028285F6A647024696E707574';
wwv_flow_imp.g_varchar2_table(697) := '3132203D206A64702E696E70757429203D3D206E756C6C203F20766F69642030203A205F6A647024696E70757431322E76616C756529207C7C202222293B0A20207D0A202066756E6374696F6E207365744461746553656C656374696F6E56616C756528';
wwv_flow_imp.g_varchar2_table(698) := '6A64702C206461746529207B0A2020202069662028286A64702E6F7074696F6E732E6D6F6465207C7C202273696E676C652229203D3D3D202272616E67652229207B0A20202020202073657452616E67654461746553656C656374696F6E286A64702C20';
wwv_flow_imp.g_varchar2_table(699) := '64617465293B0A202020207D20656C7365207B0A2020202020207365744D756C7469706C654461746553656C656374696F6E286A64702C2064617465293B0A202020207D0A2020202077726974654461746553656C656374696F6E56616C7565286A6470';
wwv_flow_imp.g_varchar2_table(700) := '293B0A20207D0A202066756E6374696F6E2073657452616E67654461746553656C656374696F6E286A64702C206461746529207B0A2020202069662028216A64702E73656C656374656444617465732E6C656E677468207C7C206A64702E73656C656374';
wwv_flow_imp.g_varchar2_table(701) := '656444617465732E6C656E677468203D3D3D203229207B0A2020202020206A64702E73656C65637465644461746573203D205B646174655D3B0A20202020202072657475726E3B0A202020207D0A202020206A64702E73656C6563746564446174657320';
wwv_flow_imp.g_varchar2_table(702) := '3D20736F72744461746573285B6A64702E73656C656374656444617465735B305D2C20646174655D293B0A20207D0A202066756E6374696F6E207365744D756C7469706C654461746553656C656374696F6E286A64702C206461746529207B0A20202020';
wwv_flow_imp.g_varchar2_table(703) := '7661722073656C65637465644461746573203D205B5D3B0A202020207661722073686F756C6441646444617465203D20747275653B0A20202020666F7220287661722069203D20303B2069203C206A64702E73656C656374656444617465732E6C656E67';
wwv_flow_imp.g_varchar2_table(704) := '74683B20692B2B29207B0A2020202020206966202861726553616D654461746573286A64702E73656C656374656444617465735B695D2C20646174652929207B0A202020202020202073686F756C6441646444617465203D2066616C73653B0A20202020';
wwv_flow_imp.g_varchar2_table(705) := '20207D20656C7365207B0A202020202020202073656C656374656444617465732E70757368286A64702E73656C656374656444617465735B695D293B0A2020202020207D0A202020207D0A202020206966202873686F756C644164644461746529207B0A';
wwv_flow_imp.g_varchar2_table(706) := '20202020202073656C656374656444617465732E707573682864617465293B0A202020207D0A202020206A64702E73656C65637465644461746573203D20736F727444617465732873656C65637465644461746573293B0A20207D0A202066756E637469';
wwv_flow_imp.g_varchar2_table(707) := '6F6E2077726974654461746553656C656374696F6E56616C7565286A647029207B0A20202020696620286A64702E696E70757429207B0A2020202020206A64702E696E7075742E76616C7565203D206765744461746553656C656374696F6E56616C7565';
wwv_flow_imp.g_varchar2_table(708) := '537472696E67286A64702C206A64702E73656C65637465644461746573293B0A202020202020747269676765724576656E74286A64702E696E7075742C204556454E545F4348414E47455F494E5055545F535452293B0A202020207D0A202020206A6470';
wwv_flow_imp.g_varchar2_table(709) := '2E73657454617267657456616C756528293B0A2020202069662028286A64702E6F7074696F6E732E6D6F6465207C7C202273696E676C652229203D3D3D202272616E676522202626206A64702E73656C656374656444617465732E6C656E677468203D3D';
wwv_flow_imp.g_varchar2_table(710) := '3D2032202626206A64702E6F7074696F6E732E6869646541667465724368616E676529207B0A2020202020206A64702E6869646528293B0A202020207D20656C7365207B0A2020202020206A64702E5F6472617728293B0A202020207D0A20207D0A2020';
wwv_flow_imp.g_varchar2_table(711) := '66756E6374696F6E207365745069636B65725669736962696C697479286A64702C20697356697369626C6529207B0A202020206A64702E6470436F6E7461696E65722E7374796C652E7669736962696C697479203D20697356697369626C65203F205354';
wwv_flow_imp.g_varchar2_table(712) := '594C455F5649534942494C4954595F56495349424C45203A205354594C455F5649534942494C4954595F48494444454E3B0A202020206A64702E6470436F6E7461696E65722E7374796C652E646973706C6179203D20697356697369626C65203F205354';
wwv_flow_imp.g_varchar2_table(713) := '594C455F444953504C41595F424C4F434B203A205354594C455F444953504C41595F48494444454E3B0A20202020696620286A64702E6F7665726C6179456C656D656E7429207B0A2020202020206A64702E6F7665726C6179456C656D656E742E737479';
wwv_flow_imp.g_varchar2_table(714) := '6C652E646973706C6179203D20697356697369626C65203F205354594C455F444953504C41595F424C4F434B203A205354594C455F444953504C41595F48494444454E3B0A202020207D0A20207D0A202066756E6374696F6E206170706C795A496E6465';
wwv_flow_imp.g_varchar2_table(715) := '782829207B0A20202020766172205F6A616C616C69446174657069636B6572245F64702C205F6A616C616C69446174657069636B6572246F76653B0A20202020766172207A496E646578203D206A616C616C69446174657069636B65722E6F7074696F6E';
wwv_flow_imp.g_varchar2_table(716) := '732E7A496E6465783B0A2020202069662028747970656F66207A496E64657820213D3D20226E756D62657222292072657475726E3B0A2020202069662028285F6A616C616C69446174657069636B6572245F6470203D206A616C616C6944617465706963';
wwv_flow_imp.g_varchar2_table(717) := '6B65722E5F6470436F6E7461696E65722920213D206E756C6C202626205F6A616C616C69446174657069636B6572245F64702E6973436F6E6E656374656429207B0A2020202020206A616C616C69446174657069636B65722E5F6470436F6E7461696E65';
wwv_flow_imp.g_varchar2_table(718) := '722E7374796C652E7A496E646578203D20537472696E67287A496E646578293B0A202020207D0A2020202069662028285F6A616C616C69446174657069636B6572246F7665203D206A616C616C69446174657069636B65722E6F7665726C6179456C656D';
wwv_flow_imp.g_varchar2_table(719) := '656E742920213D206E756C6C202626205F6A616C616C69446174657069636B6572246F76652E6973436F6E6E656374656429207B0A2020202020206A616C616C69446174657069636B65722E6F7665726C6179456C656D656E742E7374796C652E7A496E';
wwv_flow_imp.g_varchar2_table(720) := '646578203D20537472696E67287A496E646578202D2031293B0A202020207D0A20207D0A202066756E6374696F6E206F6E5363726F6C6C48616E646C65722829207B0A202020206A616C616C69446174657069636B65722E736574506F736974696F6E28';
wwv_flow_imp.g_varchar2_table(721) := '293B0A20207D0A202066756E6374696F6E207365745363726F6C6C4F6E506172656E7428696E70757429207B0A2020202072656D6F76655363726F6C6C4F6E506172656E7428293B0A202020206A616C616C69446174657069636B65722E5F7363726F6C';
wwv_flow_imp.g_varchar2_table(722) := '6C506172656E74203D205F6765745363726F6C6C506172656E7428696E707574293B0A202020206A616C616C69446174657069636B65722E5F7363726F6C6C48616E646C6572203D206F6E5363726F6C6C48616E646C65723B0A202020206A616C616C69';
wwv_flow_imp.g_varchar2_table(723) := '446174657069636B65722E5F7363726F6C6C506172656E742E6164644576656E744C697374656E657228227363726F6C6C222C206A616C616C69446174657069636B65722E5F7363726F6C6C48616E646C65722C2066616C7365293B0A20207D0A202066';
wwv_flow_imp.g_varchar2_table(724) := '756E6374696F6E2072656D6F76655363726F6C6C4F6E506172656E742829207B0A2020202069662028216A616C616C69446174657069636B65722E5F7363726F6C6C506172656E74207C7C20216A616C616C69446174657069636B65722E5F7363726F6C';
wwv_flow_imp.g_varchar2_table(725) := '6C48616E646C6572292072657475726E3B0A202020206A616C616C69446174657069636B65722E5F7363726F6C6C506172656E742E72656D6F76654576656E744C697374656E657228227363726F6C6C222C206A616C616C69446174657069636B65722E';
wwv_flow_imp.g_varchar2_table(726) := '5F7363726F6C6C48616E646C6572293B0A202020206A616C616C69446174657069636B65722E5F7363726F6C6C506172656E74203D20766F696420303B0A202020206A616C616C69446174657069636B65722E5F7363726F6C6C48616E646C6572203D20';
wwv_flow_imp.g_varchar2_table(727) := '766F696420303B0A20207D0A202066756E6374696F6E20736574526561644F6E6C7928696E7075742C206F7074696F6E7329207B0A20202020696620286F7074696F6E732E6175746F526561644F6E6C79496E7075742026262021696E7075742E726561';
wwv_flow_imp.g_varchar2_table(728) := '644F6E6C7929207B0A202020202020696E7075742E7365744174747269627574652822726561646F6E6C79222C2022726561646F6E6C7922293B0A202020202020696E7075742E726561644F6E6C79203D20747275653B0A202020207D0A20207D0A2020';
wwv_flow_imp.g_varchar2_table(729) := '66756E6374696F6E206F6E526573697A6548616E646C65722829207B0A202020206A616C616C69446174657069636B65722E736574506F736974696F6E28293B0A20207D0A202066756E6374696F6E206164644576656E744C697374656E65724F6E5265';
wwv_flow_imp.g_varchar2_table(730) := '73697A652829207B0A20202020456C656D656E742E70726F746F747970652E6D617463686573203D20456C656D656E742E70726F746F747970652E6D617463686573207C7C20456C656D656E742E70726F746F747970652E6D61746368657353656C6563';
wwv_flow_imp.g_varchar2_table(731) := '746F72207C7C20456C656D656E742E70726F746F747970652E6D6F7A4D61746368657353656C6563746F72207C7C20456C656D656E742E70726F746F747970652E6D734D61746368657353656C6563746F72207C7C20456C656D656E742E70726F746F74';
wwv_flow_imp.g_varchar2_table(732) := '7970652E6F4D61746368657353656C6563746F72207C7C20456C656D656E742E70726F746F747970652E7765626B69744D61746368657353656C6563746F723B0A2020202077696E646F772E72656D6F76654576656E744C697374656E65722822726573';
wwv_flow_imp.g_varchar2_table(733) := '697A65222C206F6E526573697A6548616E646C6572293B0A2020202077696E646F772E6164644576656E744C697374656E65722822726573697A65222C206F6E526573697A6548616E646C6572293B0A20207D0A2020766172206F6E496E707574466F63';
wwv_flow_imp.g_varchar2_table(734) := '757343616C6C6261636B203D2066756E6374696F6E206F6E496E707574466F63757343616C6C6261636B286529207B0A2020202069662028216A616C616C69446174657069636B65722E6F7074696F6E732E6175746F53686F7729207B0A202020202020';
wwv_flow_imp.g_varchar2_table(735) := '72657475726E3B0A202020207D0A2020202069662028652E74617267657420262620652E7461726765742E6D617463686573286A616C616C69446174657069636B65722E6F7074696F6E732E73656C6563746F722929207B0A2020202020206A616C616C';
wwv_flow_imp.g_varchar2_table(736) := '69446174657069636B65722E73686F7728652E746172676574293B0A202020207D0A20207D3B0A202066756E6374696F6E206164644576656E744C697374656E65724F6E496E7075747328717565727953656C6563746F7229207B0A20202020646F6375';
wwv_flow_imp.g_varchar2_table(737) := '6D656E742E626F64792E72656D6F76654576656E744C697374656E6572284556454E545F464F4355535F5354522C206F6E496E707574466F63757343616C6C6261636B293B0A202020206966202821717565727953656C6563746F72292072657475726E';
wwv_flow_imp.g_varchar2_table(738) := '3B0A20202020646F63756D656E742E626F64792E6164644576656E744C697374656E6572284556454E545F464F4355535F5354522C206F6E496E707574466F63757343616C6C6261636B293B0A20207D0A20207661722066696E6454726967676572496E';
wwv_flow_imp.g_varchar2_table(739) := '707574203D2066756E6374696F6E2066696E6454726967676572496E707574287472696767657229207B0A2020202076617220686F6C646572203D20747269676765722E706172656E744E6F64653B0A20202020666F7220287661722069203D20303B20';
wwv_flow_imp.g_varchar2_table(740) := '686F6C6465722026262069203C20343B20692B2B2C20686F6C646572203D20686F6C6465722E706172656E744E6F646529207B0A20202020202076617220696E70203D20686F6C6465722E717565727953656C6563746F722822696E7075745B64617461';
wwv_flow_imp.g_varchar2_table(741) := '2D6A64705D22293B0A20202020202069662028696E70292072657475726E20696E703B0A202020207D0A2020202072657475726E206E756C6C3B0A20207D3B0A2020766172206F6E54726967676572436C69636B43617074757265203D2066756E637469';
wwv_flow_imp.g_varchar2_table(742) := '6F6E206F6E54726967676572436C69636B43617074757265286529207B0A2020202076617220746172676574203D206765744576656E745461726765742865293B0A202020207661722074726967676572203D2074617267657420262620746172676574';
wwv_flow_imp.g_varchar2_table(743) := '2E636C6F73657374203F207461726765742E636C6F7365737428222E6A64702D747269676765722229203A206E756C6C3B0A20202020696620282174726967676572292072657475726E3B0A2020202076617220696E70203D2066696E64547269676765';
wwv_flow_imp.g_varchar2_table(744) := '72496E7075742874726967676572293B0A202020206966202821696E70292072657475726E3B0A20202020652E70726576656E7444656661756C7428293B0A2020202069662028696E702E64697361626C6564207C7C20696E702E726561644F6E6C7920';
wwv_flow_imp.g_varchar2_table(745) := '262620216A616C616C69446174657069636B65722E6F7074696F6E732E6175746F526561644F6E6C79496E707574292072657475726E3B0A20202020696620286A616C616C69446174657069636B65722E697353686F77202626206A616C616C69446174';
wwv_flow_imp.g_varchar2_table(746) := '657069636B65722E696E707574203D3D3D20696E7029207B0A2020202020206A616C616C69446174657069636B65722E6869646528293B0A202020207D20656C7365207B0A2020202020206A616C616C69446174657069636B65722E73686F7728696E70';
wwv_flow_imp.g_varchar2_table(747) := '293B0A202020207D0A20207D3B0A2020766172206F6E486F7374436C69636B43616C6C6261636B203D2066756E6374696F6E206F6E486F7374436C69636B43616C6C6261636B286529207B0A2020202069662028216A616C616C69446174657069636B65';
wwv_flow_imp.g_varchar2_table(748) := '722E6F7074696F6E732E6175746F48696465207C7C20216A616C616C69446174657069636B65722E697353686F77292072657475726E3B0A202020207661722070617468203D20652E636F6D706F73656450617468203F20652E636F6D706F7365645061';
wwv_flow_imp.g_varchar2_table(749) := '74682829203A205B5D3B0A2020202069662028706174682E696E6465784F66286A616C616C69446174657069636B65722E5F6470436F6E7461696E657229203E202D31292072657475726E3B0A202020206A616C616C69446174657069636B65722E6869';
wwv_flow_imp.g_varchar2_table(750) := '646528293B0A20207D3B0A2020766172206F6E426F6479436C69636B43616C6C6261636B203D2066756E6374696F6E206F6E426F6479436C69636B43616C6C6261636B286529207B0A2020202076617220746774203D206765744576656E745461726765';
wwv_flow_imp.g_varchar2_table(751) := '742865293B0A2020202069662028746774202626207467742E636C6F73657374202626207467742E636C6F7365737428222E6A64702D747269676765722229292072657475726E3B0A2020202076617220636C69636B496E73696465446174655069636B';
wwv_flow_imp.g_varchar2_table(752) := '6572203D20636F6E7461696E73446F6D286A616C616C69446174657069636B65722E6470436F6E7461696E65722C2065293B0A2020202076617220636C69636B4F6E496E707574203D206765744576656E74546172676574286529203D3D3D206A616C61';
wwv_flow_imp.g_varchar2_table(753) := '6C69446174657069636B65722E696E7075743B0A2020202069662028216A616C616C69446174657069636B65722E6F7074696F6E732E6175746F48696465207C7C20216A616C616C69446174657069636B65722E697353686F77207C7C20636C69636B49';
wwv_flow_imp.g_varchar2_table(754) := '6E73696465446174655069636B6572207C7C20636C69636B4F6E496E70757429207B0A20202020202072657475726E3B0A202020207D0A202020206A616C616C69446174657069636B65722E6869646528293B0A20207D3B0A202066756E6374696F6E20';
wwv_flow_imp.g_varchar2_table(755) := '6164644576656E744C697374656E65724F6E426F64792829207B0A20202020646F63756D656E742E626F64792E72656D6F76654576656E744C697374656E65722822636C69636B222C206F6E426F6479436C69636B43616C6C6261636B293B0A20202020';
wwv_flow_imp.g_varchar2_table(756) := '646F63756D656E742E626F64792E6164644576656E744C697374656E65722822636C69636B222C206F6E426F6479436C69636B43616C6C6261636B293B0A20202020646F63756D656E742E72656D6F76654576656E744C697374656E65722822636C6963';
wwv_flow_imp.g_varchar2_table(757) := '6B222C206F6E54726967676572436C69636B436170747572652C2074727565293B0A20202020646F63756D656E742E6164644576656E744C697374656E65722822636C69636B222C206F6E54726967676572436C69636B436170747572652C2074727565';
wwv_flow_imp.g_varchar2_table(758) := '293B0A20207D0A202066756E6374696F6E2068616E646C654573634B6579286576656E7429207B0A20202020696620286576656E742E6B6579203D3D3D20224573636170652229207B0A20202020202069662028216A616C616C69446174657069636B65';
wwv_flow_imp.g_varchar2_table(759) := '722E69735472616E736974696F6E696E6729207B0A2020202020202020766172205F6A616C616C69446174657069636B657224696E703B0A2020202020202020285F6A616C616C69446174657069636B657224696E70203D206A616C616C694461746570';
wwv_flow_imp.g_varchar2_table(760) := '69636B65722E696E70757429203D3D206E756C6C207C7C205F6A616C616C69446174657069636B657224696E702E626C7572203D3D206E756C6C207C7C205F6A616C616C69446174657069636B657224696E702E626C757228293B0A2020202020202020';
wwv_flow_imp.g_varchar2_table(761) := '6A616C616C69446174657069636B65722E6869646528293B0A2020202020207D0A202020207D0A20207D0A0A20202F2A203D3D3D3D3D2048696464656E2063616E6F6E6963616C2076616C75652073796E63202B2070726F6772616D6D61746963204150';
wwv_flow_imp.g_varchar2_table(762) := '49203D3D3D3D3D202A2F0A2020766172206E6F726D446967697473203D2066756E6374696F6E206E6F726D4469676974732873747229207B0A2020202072657475726E20537472696E6728737472203D3D206E756C6C203F202222203A20737472292E72';
wwv_flow_imp.g_varchar2_table(763) := '65706C616365282F5BDBB02DDBB95D2F672C2066756E6374696F6E20286329207B0A20202020202072657475726E20632E63686172436F64654174283029202D203078303646303B0A202020207D292E7265706C616365282F5BD9A02DD9A95D2F672C20';
wwv_flow_imp.g_varchar2_table(764) := '66756E6374696F6E20286329207B0A20202020202072657475726E20632E63686172436F64654174283029202D203078303636303B0A202020207D293B0A20207D3B0A20207661722070616432203D2066756E6374696F6E2070616432287829207B0A20';
wwv_flow_imp.g_varchar2_table(765) := '20202078203D20537472696E67287061727365496E7428782C20313029207C7C2030293B0A2020202072657475726E20782E6C656E677468203C2032203F20223022202B2078203A20783B0A20207D3B0A2020766172206A64704D6F6465203D2066756E';
wwv_flow_imp.g_varchar2_table(766) := '6374696F6E206A64704D6F64652876697329207B0A20202020696620287669732E686173417474726962757465284F4E4C595F444154455F415454525F53455454494E475F4D41585F415454525F4E414D4529292072657475726E202244223B0A202020';
wwv_flow_imp.g_varchar2_table(767) := '2072657475726E207669732E676574417474726962757465284841535F5345434F4E445F415454525F4E414D4529203D3D3D20227472756522203F20225322203A202254223B0A20207D3B0A2020766172207061727365416E7956616C7565203D206675';
wwv_flow_imp.g_varchar2_table(768) := '6E6374696F6E207061727365416E7956616C7565287374722C2076697329207B0A20202020766172206E203D206E6F726D44696769747328737472292E6D61746368282F5C642B2F6729207C7C205B5D3B0A20202020696620286E2E6C656E677468203C';
wwv_flow_imp.g_varchar2_table(769) := '2033292072657475726E206E756C6C3B0A2020202076617220792C206D2C20643B0A20202020696620286E5B305D2E6C656E677468203E3D203329207B0A20202020202079203D206E5B305D3B206D203D206E5B315D3B2064203D206E5B325D3B0A2020';
wwv_flow_imp.g_varchar2_table(770) := '20207D20656C7365207B0A202020202020766172207979203D207061727365496E74286E5B325D2C20313029207C7C20303B0A20202020202079203D206E5B325D2E6C656E677468203E3D2033203F206E5B325D203A20537472696E6728287979203E3D';
wwv_flow_imp.g_varchar2_table(771) := '203730203F2031333030203A203134303029202B207979293B0A20202020202069662028766973202626207669732E676574417474726962757465202626207669732E6765744174747269627574652822646174612D6A64702D646174652D6F72646572';
wwv_flow_imp.g_varchar2_table(772) := '2229203D3D3D2022444D592229207B0A202020202020202064203D206E5B305D3B206D203D206E5B315D3B0A2020202020207D20656C7365207B0A20202020202020206D203D206E5B305D3B2064203D206E5B315D3B0A2020202020207D0A202020207D';
wwv_flow_imp.g_varchar2_table(773) := '0A2020202072657475726E207B20796561723A20792C206D6F6E74683A2070616432286D292C206461793A20706164322864292C20686F75723A2070616432286E5B335D292C206D696E7574653A2070616432286E5B345D292C207365636F6E643A2070';
wwv_flow_imp.g_varchar2_table(774) := '616432286E5B355D29207D3B0A20207D3B0A202076617220746F43616E6F6E6963616C203D2066756E6374696F6E20746F43616E6F6E6963616C286F29207B0A2020202072657475726E206F2E79656172202B20222F22202B206F2E6D6F6E7468202B20';
wwv_flow_imp.g_varchar2_table(775) := '222F22202B206F2E646179202B20222022202B206F2E686F7572202B20223A22202B206F2E6D696E757465202B20223A22202B206F2E7365636F6E643B0A20207D3B0A202076617220746F446973706C6179203D2066756E6374696F6E20746F44697370';
wwv_flow_imp.g_varchar2_table(776) := '6C6179287669732C206F29207B0A20202020766172206F707473203D206A616C616C69446174657069636B65722E6F7074696F6E73207C7C207B7D3B0A2020202076617220736570203D206F7074732E736570617261746F724368617273207C7C204445';
wwv_flow_imp.g_varchar2_table(777) := '4641554C545F534550415241544F525F43484152533B0A20202020766172206D6F6465203D206A64704D6F646528766973293B0A20202020766172206F7574203D206F2E79656172202B207365702E64617465202B206F2E6D6F6E7468202B207365702E';
wwv_flow_imp.g_varchar2_table(778) := '64617465202B206F2E6461793B0A20202020696620286D6F646520213D3D2022442229207B0A2020202020206F7574202B3D207365702E6265747765656E202B206F2E686F7572202B207365702E74696D65202B206F2E6D696E7574653B0A2020202020';
wwv_flow_imp.g_varchar2_table(779) := '20696620286D6F6465203D3D3D2022532229206F7574202B3D207365702E74696D65202B206F2E7365636F6E643B0A202020207D0A2020202072657475726E20746F5065727369616E44696769747349664E6565646564286F75742C2021216F7074732E';
wwv_flow_imp.g_varchar2_table(780) := '7065727369616E446967697473293B0A20207D3B0A20207661722066696E6448696464656E203D2066756E6374696F6E2066696E6448696464656E2876697329207B0A2020202076617220686F6C646572203D207669732E706172656E744E6F64653B0A';
wwv_flow_imp.g_varchar2_table(781) := '2020202072657475726E20686F6C646572203F20686F6C6465722E717565727953656C6563746F722822696E7075745B646174612D6A64702D68696464656E5D2229203A206E756C6C3B0A20207D3B0A2020766172206E617469766556616C7565203D20';
wwv_flow_imp.g_varchar2_table(782) := '4F626A6563742E6765744F776E50726F706572747944657363726970746F722848544D4C496E707574456C656D656E742E70726F746F747970652C202276616C756522293B0A2020766172206E6174697665536574203D2066756E6374696F6E206E6174';
wwv_flow_imp.g_varchar2_table(783) := '69766553657428656C2C207629207B0A202020206E617469766556616C75652E7365742E63616C6C28656C2C2076293B0A20207D3B0A202076617220666972654368616E6765203D2066756E6374696F6E20666972654368616E676528656C29207B0A20';
wwv_flow_imp.g_varchar2_table(784) := '2020206966202877696E646F772E6A5175657279292077696E646F772E6A517565727928656C292E7472696767657228226368616E676522293B656C736520747269676765724576656E7428656C2C20226368616E676522293B0A20207D3B0A20207661';
wwv_flow_imp.g_varchar2_table(785) := '7220726566726573684F70656E5069636B6572203D2066756E6374696F6E20726566726573684F70656E5069636B65722876697329207B0A20202020696620286A616C616C69446174657069636B65722E696E707574203D3D3D2076697329207B0A2020';
wwv_flow_imp.g_varchar2_table(786) := '20202020726573657443757272656E74496E7075745374617465286A616C616C69446174657069636B6572293B0A20202020202073657453656C6563746564446174657346726F6D496E707574286A616C616C69446174657069636B6572293B0A202020';
wwv_flow_imp.g_varchar2_table(787) := '202020696620286A616C616C69446174657069636B65722E697353686F7729206A616C616C69446174657069636B65722E5F6472617728293B0A202020207D0A20207D3B0A20202F2A2068696464656E20287265616C206974656D29202D3E2076697369';
wwv_flow_imp.g_varchar2_table(788) := '626C652028646973706C617929202A2F0A2020766172206170706C7948696464656E546F446973706C6179203D2066756E6374696F6E206170706C7948696464656E546F446973706C6179287669732C2068696429207B0A202020207661722072617720';
wwv_flow_imp.g_varchar2_table(789) := '3D206E617469766556616C75652E6765742E63616C6C28686964293B0A20202020766172206F203D20726177203F207061727365416E7956616C7565287261772C2076697329203A206E756C6C3B0A202020206966202872617720262620216F29207265';
wwv_flow_imp.g_varchar2_table(790) := '7475726E3B0A20202020696620286F29207B0A2020202020207669732E7365744174747269627574652822646174612D6A64702D6F7269672D74696D65222C206F2E686F7572202B20223A22202B206F2E6D696E757465202B20223A22202B206F2E7365';
wwv_flow_imp.g_varchar2_table(791) := '636F6E64293B0A2020202020207669732E76616C7565203D20746F446973706C6179287669732C206F293B0A2020202020207661722063616E6F6E203D20746F43616E6F6E6963616C286F293B0A2020202020206966202863616E6F6E20213D3D207261';
wwv_flow_imp.g_varchar2_table(792) := '7729206E6174697665536574286869642C2063616E6F6E293B0A202020207D20656C7365207B0A2020202020207669732E76616C7565203D2022223B0A202020207D0A20202020726566726573684F70656E5069636B657228766973293B0A20207D3B0A';
wwv_flow_imp.g_varchar2_table(793) := '20202F2A2076697369626C652028646973706C617929202D3E2068696464656E20287265616C206974656D29202A2F0A20207661722073796E6348696464656E203D2066756E6374696F6E2073796E6348696464656E2876697329207B0A202020207661';
wwv_flow_imp.g_varchar2_table(794) := '7220686964203D2066696E6448696464656E28766973293B0A202020206966202821686964292072657475726E3B0A20202020696620286A616C616C69446174657069636B65722E5F70656E64696E67202626206A616C616C69446174657069636B6572';
wwv_flow_imp.g_varchar2_table(795) := '2E696E707574203D3D3D20766973292072657475726E3B0A2020202076617220747874203D206E6F726D446967697473287669732E76616C7565292E7472696D28293B0A202020207661722076616C203D2022223B0A202020206966202874787429207B';
wwv_flow_imp.g_varchar2_table(796) := '0A202020202020766172206F203D207061727365416E7956616C7565287478742C20766973293B0A20202020202069662028216F292072657475726E3B0A202020202020766172206D6F6465203D206A64704D6F646528766973293B0A20202020202069';
wwv_flow_imp.g_varchar2_table(797) := '6620286D6F6465203D3D3D2022442229207B0A2020202020202020766172206F74203D20287669732E6765744174747269627574652822646174612D6A64702D6F7269672D74696D652229207C7C202230303A30303A303022292E73706C697428223A22';
wwv_flow_imp.g_varchar2_table(798) := '293B0A20202020202020206F2E686F7572203D2070616432286F745B305D293B206F2E6D696E757465203D2070616432286F745B315D293B206F2E7365636F6E64203D2070616432286F745B325D293B0A2020202020207D20656C736520696620286D6F';
wwv_flow_imp.g_varchar2_table(799) := '6465203D3D3D2022542229207B0A20202020202020206F2E7365636F6E64203D20223030223B0A2020202020207D0A20202020202076616C203D20746F43616E6F6E6963616C286F293B0A202020207D0A20202020696620286E617469766556616C7565';
wwv_flow_imp.g_varchar2_table(800) := '2E6765742E63616C6C286869642920213D3D2076616C29207B0A2020202020206E6174697665536574286869642C2076616C293B0A202020202020666972654368616E676528686964293B0A202020207D0A20207D3B0A2020766172206F6E5669734368';
wwv_flow_imp.g_varchar2_table(801) := '616E676553796E63203D2066756E6374696F6E206F6E5669734368616E676553796E63286529207B0A202020207661722074203D20652E7461726765743B0A20202020696620287420262620742E6D61746368657320262620742E6D6174636865732822';
wwv_flow_imp.g_varchar2_table(802) := '696E7075745B646174612D6A64705D2229292073796E6348696464656E2874293B0A20207D3B0A2020646F63756D656E742E6164644576656E744C697374656E657228226368616E6765222C206F6E5669734368616E676553796E632C2074727565293B';
wwv_flow_imp.g_varchar2_table(803) := '0A2020646F63756D656E742E6164644576656E744C697374656E65722822666F6375736F7574222C206F6E5669734368616E676553796E632C2074727565293B0A2020766172207365744974656D56616C7565203D2066756E6374696F6E207365744974';
wwv_flow_imp.g_varchar2_table(804) := '656D56616C7565287669732C2076616C75652C2073757070726573734368616E676529207B0A2020202076617220686964203D2066696E6448696464656E28766973293B0A202020206966202821686964292072657475726E3B0A202020202F2F20616C';
wwv_flow_imp.g_varchar2_table(805) := '6C6F7720736574206576656E206966207061727365206973207374726963740A202020202F2F206966202876616C756520262620217061727365416E7956616C75652876616C75652C2076697329292072657475726E3B0A20202020766172206265666F';
wwv_flow_imp.g_varchar2_table(806) := '7265203D206E617469766556616C75652E6765742E63616C6C28686964293B0A20202020696620286A616C616C69446174657069636B65722E5F70656E64696E67202626206A616C616C69446174657069636B65722E696E707574203D3D3D2076697329';
wwv_flow_imp.g_varchar2_table(807) := '207B0A2020202020206A616C616C69446174657069636B65722E5F70656E64696E67203D2066616C73653B0A202020207D0A202020206E6174697665536574286869642C2076616C7565207C7C202222293B0A202020206170706C7948696464656E546F';
wwv_flow_imp.g_varchar2_table(808) := '446973706C6179287669732C20686964293B0A20202020696620286A616C616C69446174657069636B65722E696E707574203D3D3D2076697329206A616C616C69446174657069636B65722E5F636F6D6D6974746564203D207669732E76616C75653B0A';
wwv_flow_imp.g_varchar2_table(809) := '20202020696620282173757070726573734368616E6765202626206E617469766556616C75652E6765742E63616C6C286869642920213D3D206265666F72652920666972654368616E676528686964293B0A20207D3B0A202077696E646F772E6A616C61';
wwv_flow_imp.g_varchar2_table(810) := '6C69446174657069636B6572203D207B0A20202020737461727457617463683A2066756E6374696F6E2073746172745761746368286F7074696F6E7329207B0A202020202020696620286F7074696F6E73203D3D3D20766F6964203029207B0A20202020';
wwv_flow_imp.g_varchar2_table(811) := '202020206F7074696F6E73203D207B7D3B0A2020202020207D0A20202020202076617220696E6974203D2066756E6374696F6E20696E69742829207B0A202020202020202072657475726E206A616C616C69446174657069636B65722E696E6974286F70';
wwv_flow_imp.g_varchar2_table(812) := '74696F6E73293B0A2020202020207D3B0A20202020202069662028646F63756D656E742E626F647929207B0A2020202020202020696E697428293B0A2020202020207D20656C7365207B0A2020202020202020646F63756D656E742E6164644576656E74';
wwv_flow_imp.g_varchar2_table(813) := '4C697374656E65722822444F4D436F6E74656E744C6F61646564222C20696E69742C207B0A202020202020202020206F6E63653A20747275650A20202020202020207D293B0A2020202020207D0A202020207D2C0A202020207365744974656D56616C75';
wwv_flow_imp.g_varchar2_table(814) := '653A2066756E6374696F6E20287669732C2076616C75652C20737570707265737329207B0A2020202020207365744974656D56616C7565287669732C2076616C75652C207375707072657373293B0A202020207D2C0A202020206765744974656D56616C';
wwv_flow_imp.g_varchar2_table(815) := '75653A2066756E6374696F6E202876697329207B0A20202020202076617220686964203D2066696E6448696464656E28766973293B0A20202020202072657475726E20686964203F206869642E76616C7565203A2022223B0A202020207D2C0A20202020';
wwv_flow_imp.g_varchar2_table(816) := '73686F773A2066756E6374696F6E2073686F7728696E70757429207B0A2020202020206A616C616C69446174657069636B65722E73686F7728696E707574293B0A202020207D2C0A20202020686964653A2066756E6374696F6E20686964652829207B0A';
wwv_flow_imp.g_varchar2_table(817) := '2020202020206A616C616C69446174657069636B65722E6869646528293B0A202020207D2C0A202020207570646174654F7074696F6E733A2066756E6374696F6E207570646174654F7074696F6E73286F7074696F6E7329207B0A2020202020206A616C';
wwv_flow_imp.g_varchar2_table(818) := '616C69446174657069636B65722E7570646174654F7074696F6E73286F7074696F6E73293B0A202020207D0A20207D3B0A0A20202F2A203D3D3D3D3D2042696E64696E672068696464656E206974656D73202B204150455820726567697374726174696F';
wwv_flow_imp.g_varchar2_table(819) := '6E203D3D3D3D3D202A2F0A20202866756E6374696F6E2062696E64696E67416E64526567697374726174696F6E2829207B0A202020207661722072656769737465724974656D203D2066756E6374696F6E2072656769737465724974656D286869642C20';
wwv_flow_imp.g_varchar2_table(820) := '76697329207B0A202020202020696620286869642E5F6A647052656769737465726564207C7C20216869642E6964292072657475726E3B0A202020202020696620282177696E646F772E61706578207C7C2021617065782E6974656D207C7C2021617065';
wwv_flow_imp.g_varchar2_table(821) := '782E6974656D2E637265617465292072657475726E3B0A202020202020696620286869642E636C6F73657374202626206869642E636C6F7365737428222E612D47562229292072657475726E3B0A2020202020206869642E5F6A64705265676973746572';
wwv_flow_imp.g_varchar2_table(822) := '6564203D20747275653B0A20202020202076617220747267203D2066756E6374696F6E202829207B0A202020202020202072657475726E2077696E646F772E6A517565727928766973292E636C6F7365737428222E742D466F726D2D6974656D57726170';
wwv_flow_imp.g_varchar2_table(823) := '7065722C2074642C202E612D47562D63656C6C22292E66696E6428222E6A64702D7472696767657222293B0A2020202020207D3B0A202020202020747279207B0A2020202020202020617065782E6974656D2E637265617465286869642E69642C207B0A';
wwv_flow_imp.g_varchar2_table(824) := '202020202020202020206974656D5F747970653A20224A414C414C495F444154455F5049434B4552222C0A202020202020202020206E756C6C56616C75653A2022222C0A2020202020202020202067657456616C75653A2066756E6374696F6E20282920';
wwv_flow_imp.g_varchar2_table(825) := '7B2072657475726E206869642E76616C75653B207D2C0A2020202020202020202073657456616C75653A2066756E6374696F6E20287056616C75652C2070446973706C617956616C75652C207053757070726573734368616E67654576656E7429207B0A';
wwv_flow_imp.g_varchar2_table(826) := '2020202020202020202020207365744974656D56616C7565287669732C207056616C75652C207053757070726573734368616E67654576656E74293B0A202020202020202020207D2C0A20202020202020202020736574466F637573546F3A2066756E63';
wwv_flow_imp.g_varchar2_table(827) := '74696F6E202829207B2072657475726E2077696E646F772E6A517565727928766973293B207D2C0A20202020202020202020656E61626C653A2066756E6374696F6E202829207B207669732E64697361626C6564203D2066616C73653B206869642E6469';
wwv_flow_imp.g_varchar2_table(828) := '7361626C6564203D2066616C73653B2074726728292E70726F70282264697361626C6564222C2066616C7365293B207D2C0A2020202020202020202064697361626C653A2066756E6374696F6E202829207B207669732E64697361626C6564203D207472';
wwv_flow_imp.g_varchar2_table(829) := '75653B206869642E64697361626C6564203D20747275653B2074726728292E70726F70282264697361626C6564222C2074727565293B207D2C0A20202020202020202020697344697361626C65643A2066756E6374696F6E202829207B2072657475726E';
wwv_flow_imp.g_varchar2_table(830) := '207669732E64697361626C65643B207D0A20202020202020207D293B0A2020202020207D20636174636820286529207B7D0A202020207D3B0A202020202F2A20416E7920777269746520746F2068696464656E2E76616C7565202844796E616D69632041';
wwv_flow_imp.g_varchar2_table(831) := '6374696F6E2C20247328292C206A5175657279202E76616C28292C20617065782067656E65726963206974656D290A20202020202020616C736F20726566726573686573207468652076697369626C6520696E7075742E202A2F0A202020207661722062';
wwv_flow_imp.g_varchar2_table(832) := '696E6448696464656E203D2066756E6374696F6E2062696E6448696464656E2868696429207B0A202020202020696620286869642E5F6A6470426F756E64292072657475726E3B0A20202020202076617220766973203D206869642E706172656E744E6F';
wwv_flow_imp.g_varchar2_table(833) := '6465203F206869642E706172656E744E6F64652E717565727953656C6563746F722822696E7075745B646174612D6A64705D2229203A206E756C6C3B0A2020202020206966202821766973292072657475726E3B0A2020202020206869642E5F6A647042';
wwv_flow_imp.g_varchar2_table(834) := '6F756E64203D20747275653B0A202020202020747279207B0A20202020202020204F626A6563742E646566696E6550726F7065727479286869642C202276616C7565222C207B0A20202020202020202020636F6E666967757261626C653A20747275652C';
wwv_flow_imp.g_varchar2_table(835) := '0A20202020202020202020656E756D657261626C653A20747275652C0A202020202020202020206765743A2066756E6374696F6E202829207B2072657475726E206E617469766556616C75652E6765742E63616C6C28686964293B207D2C0A2020202020';
wwv_flow_imp.g_varchar2_table(836) := '20202020207365743A2066756E6374696F6E20287629207B0A2020202020202020202020206E617469766556616C75652E7365742E63616C6C286869642C2076293B0A2020202020202020202020206170706C7948696464656E546F446973706C617928';
wwv_flow_imp.g_varchar2_table(837) := '7669732C20686964293B0A202020202020202020207D0A20202020202020207D293B0A2020202020207D20636174636820286529207B7D0A20202020202072656769737465724974656D286869642C20766973293B0A202020207D3B0A20202020766172';
wwv_flow_imp.g_varchar2_table(838) := '2062696E64416C6C496E203D2066756E6374696F6E2062696E64416C6C496E28726F6F7429207B0A202020202020747279207B0A20202020202020206966202821726F6F74207C7C2028726F6F742E6E6F64655479706520213D3D203120262620726F6F';
wwv_flow_imp.g_varchar2_table(839) := '742E6E6F64655479706520213D3D203929292072657475726E3B0A202020202020202069662028726F6F742E6D61746368657320262620726F6F742E6D6174636865732822696E7075745B646174612D6A64702D68696464656E5D2229292062696E6448';
wwv_flow_imp.g_varchar2_table(840) := '696464656E28726F6F74293B0A2020202020202020766172206C697374203D20726F6F742E717565727953656C6563746F72416C6C203F20726F6F742E717565727953656C6563746F72416C6C2822696E7075745B646174612D6A64702D68696464656E';
wwv_flow_imp.g_varchar2_table(841) := '5D2229203A205B5D3B0A2020202020202020666F7220287661722069203D20303B2069203C206C6973742E6C656E6774683B20692B2B292062696E6448696464656E286C6973745B695D293B0A2020202020207D20636174636820286529207B7D0A2020';
wwv_flow_imp.g_varchar2_table(842) := '20207D3B0A202020206966202877696E646F772E4D75746174696F6E4F6273657276657229207B0A2020202020206E6577204D75746174696F6E4F627365727665722866756E6374696F6E20286D75747329207B0A2020202020202020666F7220287661';
wwv_flow_imp.g_varchar2_table(843) := '722069203D20303B2069203C206D7574732E6C656E6774683B20692B2B29207B0A20202020202020202020766172206164646564203D206D7574735B695D2E61646465644E6F6465733B0A20202020202020202020666F722028766172206A203D20303B';
wwv_flow_imp.g_varchar2_table(844) := '206A203C2061646465642E6C656E6774683B206A2B2B292062696E64416C6C496E2861646465645B6A5D293B0A20202020202020207D0A2020202020207D292E6F62736572766528646F63756D656E742E646F63756D656E74456C656D656E742C207B20';
wwv_flow_imp.g_varchar2_table(845) := '6368696C644C6973743A20747275652C20737562747265653A2074727565207D293B0A202020207D0A2020202069662028646F63756D656E742E72656164795374617465203D3D3D20226C6F6164696E672229207B0A202020202020646F63756D656E74';
wwv_flow_imp.g_varchar2_table(846) := '2E6164644576656E744C697374656E65722822444F4D436F6E74656E744C6F61646564222C2066756E6374696F6E202829207B2062696E64416C6C496E28646F63756D656E74293B207D293B0A202020207D20656C7365207B0A20202020202062696E64';
wwv_flow_imp.g_varchar2_table(847) := '416C6C496E28646F63756D656E74293B0A202020207D0A202020206966202877696E646F772E6170657820262620617065782E6974656D20262620617065782E6974656D2E61646441747461636848616E646C657229207B0A202020202020617065782E';
wwv_flow_imp.g_varchar2_table(848) := '6974656D2E61646441747461636848616E646C65722866756E6374696F6E202863747829207B0A202020202020202069662028637478202626206374782E6C656E67746829207B20666F7220287661722069203D20303B2069203C206374782E6C656E67';
wwv_flow_imp.g_varchar2_table(849) := '74683B20692B2B292062696E64416C6C496E286374785B695D293B207D0A2020202020202020656C73652062696E64416C6C496E28646F63756D656E74293B0A2020202020207D293B0A202020207D0A20207D2928293B0A7D2928293B0A';
null;
end;
/
begin
wwv_flow_imp_shared.create_plugin_file(
 p_id=>wwv_flow_imp.id(438448083865681286)
,p_plugin_id=>wwv_flow_imp.id(438448083865680986)
,p_file_name=>'jalalidatepicker.js'
,p_mime_type=>'text/javascript'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_imp.varchar2_to_blob(wwv_flow_imp.g_varchar2_table)
);
end;
/
begin
wwv_flow_imp.g_varchar2_table := wwv_flow_imp.empty_varchar2_table;
wwv_flow_imp.g_varchar2_table(1) := '2F2A210A2A205065727369616E20446174657069636B657220666F72204F7261636C6520415045580A2A20417574686F723A204D6F6A746162612048616A6920416C6967686F6C6920476976690A2A20576562736974653A2068747470733A2F2F617065';
wwv_flow_imp.g_varchar2_table(2) := '783336302E69720A2A20436F707972696768742028632920323032362E20416C6C207269676874732072657365727665642E0A2A2F0A2E6A616C696C692D646174657B646972656374696F6E3A206C74723B746578742D616C69676E3A2072696768743B';
wwv_flow_imp.g_varchar2_table(3) := '756E69636F64652D626964693A20706C61696E746578743B7D6A64702D6F7665726C6179207B77696474683A20303B6865696768743A20303B7D406D65646961206F6E6C792073637265656E20616E6420286D61782D77696474683A2034383170782920';
wwv_flow_imp.g_varchar2_table(4) := '7B6A64702D6F7665726C6179207B706F736974696F6E3A2066697865643B77696474683A20313030253B6865696768743A20313030253B746F703A20303B6C6566743A20303B6261636B67726F756E642D636F6C6F723A20726762612831352C2032332C';
wwv_flow_imp.g_varchar2_table(5) := '2034322C20302E3335293B646973706C61793A206E6F6E653B7D7D6A64702D636F6E7461696E6572207B2D2D6A64702D6461792D73697A653A20333270783B2D2D6A64702D7072696D6172793A20766172282D2D75742D70616C657474652D7072696D61';
wwv_flow_imp.g_varchar2_table(6) := '72792C2023326636666564293B2D2D6A64702D736F66742D6D69783A203132253B2D2D6A64702D7072696D6172792D736F66743A20636F6C6F722D6D697828696E20737267622C20766172282D2D6A64702D7072696D6172792920766172282D2D6A6470';
wwv_flow_imp.g_varchar2_table(7) := '2D736F66742D6D6978292C20766172282D2D6A64702D626729293B2D2D6A64702D7072696D6172792D696E6B3A20236666663B2D2D6A64702D62673A20236666663B2D2D6A64702D696E6B3A20233166323933373B2D2D6A64702D6D757465643A202338';
wwv_flow_imp.g_varchar2_table(8) := '61393461363B2D2D6A64702D6C696E653A20236536653966303B2D2D6A64702D686F7665723A20236631663466393B2D2D6A64702D7265643A20236535343834643B706F736974696F6E3A206162736F6C7574653B77696474683A2063616C6328766172';
wwv_flow_imp.g_varchar2_table(9) := '282D2D6A64702D6461792D73697A6529202A2037202B2032347078293B6D696E2D77696474683A2063616C6328766172282D2D6A64702D6461792D73697A6529202A2037202B2032347078293B6D61782D77696474683A2063616C6328766172282D2D6A';
wwv_flow_imp.g_varchar2_table(10) := '64702D6461792D73697A6529202A2037202B2032347078293B70616464696E673A20387078203132707820313070783B636F6C6F722D736368656D653A206C696768743B6261636B67726F756E643A20766172282D2D6A64702D6267293B636F6C6F723A';
wwv_flow_imp.g_varchar2_table(11) := '20766172282D2D6A64702D696E6B293B646972656374696F6E3A2072746C3B646973706C61793A206E6F6E653B666F6E742D73697A653A2031322E3570783B6C696E652D6865696768743A20312E343B626F726465723A2031707820736F6C6964207661';
wwv_flow_imp.g_varchar2_table(12) := '72282D2D6A64702D6C696E65293B626F726465722D7261646975733A20313470783B626F782D736861646F773A20302031327078203332707820726762612831352C2032332C2034322C20302E3136292C2030203270782036707820726762612831352C';
wwv_flow_imp.g_varchar2_table(13) := '2032332C2034322C20302E3038293B6F766572666C6F773A2068696464656E3B746F7563682D616374696F6E3A206D616E6970756C6174696F6E3B757365722D73656C6563743A206E6F6E653B2D7765626B69742D757365722D73656C6563743A206E6F';
wwv_flow_imp.g_varchar2_table(14) := '6E653B616E696D6174696F6E3A206A64704F70656E416E696D6174696F6E203136306D7320656173652D6F75743B7D406D65646961206F6E6C792073637265656E20616E6420286D61782D77696474683A20343831707829207B6A64702D636F6E746169';
wwv_flow_imp.g_varchar2_table(15) := '6E6572207B77696474683A20313030253B6D61782D77696474683A20313030253B6D696E2D77696474683A2032363070783B6C6566743A203530252021696D706F7274616E743B626F74746F6D3A20302021696D706F7274616E743B746F703A20756E73';
wwv_flow_imp.g_varchar2_table(16) := '65742021696D706F7274616E743B7472616E73666F726D3A207472616E736C61746558282D353025292021696D706F7274616E743B626F726465722D7261646975733A20313670782031367078203020303B616E696D6174696F6E3A206A64704F70656E';
wwv_flow_imp.g_varchar2_table(17) := '416E696D6174696F6E4D6F62696C65203230306D7320656173652D6F75743B7D7D6A64702D636F6E7461696E65725B646174612D6A64702D7468656D653D226461726B225D207B2D2D6A64702D62673A20233166323433303B2D2D6A64702D696E6B3A20';
wwv_flow_imp.g_varchar2_table(18) := '236537656266333B2D2D6A64702D6D757465643A20233865393861633B2D2D6A64702D6C696E653A20233334336335303B2D2D6A64702D686F7665723A20233262333234333B2D2D6A64702D7265643A20236666376238303B2D2D6A64702D736F66742D';
wwv_flow_imp.g_varchar2_table(19) := '6D69783A203236253B636F6C6F722D736368656D653A206461726B3B626F782D736861646F773A203020313270782033327078207267626128302C20302C20302C20302E3535292C20302032707820367078207267626128302C20302C20302C20302E34';
wwv_flow_imp.g_varchar2_table(20) := '293B7D6A64702D636F6E7461696E6572206F7074696F6E207B6261636B67726F756E643A20766172282D2D6A64702D6267293B636F6C6F723A20766172282D2D6A64702D696E6B293B7D6A64702D636F6E7461696E65722C0A6A64702D636F6E7461696E';
wwv_flow_imp.g_varchar2_table(21) := '6572202A2C0A6A64702D636F6E7461696E6572202A3A3A61667465722C0A6A64702D636F6E7461696E6572202A3A3A6265666F7265207B626F782D73697A696E673A20626F726465722D626F783B7D6A64702D636F6E7461696E6572202E6A64702D6D6F';
wwv_flow_imp.g_varchar2_table(22) := '6E7468732C0A6A64702D636F6E7461696E6572202E6A64702D7965617273207B646973706C61793A20696E6C696E652D666C65783B616C69676E2D6974656D733A2063656E7465723B766572746963616C2D616C69676E3A206D6964646C653B68656967';
wwv_flow_imp.g_varchar2_table(23) := '68743A20323670783B6D617267696E3A20303B666F6E742D73697A653A20313370783B666F6E742D7765696768743A203630303B636F6C6F723A20766172282D2D6A64702D696E6B293B66696C6C3A20766172282D2D6A64702D696E6B293B7D6A64702D';
wwv_flow_imp.g_varchar2_table(24) := '636F6E7461696E6572202E6A64702D6D6F6E746873207B77696474683A203536253B7D6A64702D636F6E7461696E6572202E6A64702D7965617273207B77696474683A203434253B7D6A64702D636F6E7461696E6572202E6A64702D69636F6E2D706C75';
wwv_flow_imp.g_varchar2_table(25) := '732C0A6A64702D636F6E7461696E6572202E6A64702D69636F6E2D6D696E7573207B666C65783A206E6F6E653B646973706C61793A20696E6C696E652D666C65783B616C69676E2D6974656D733A2063656E7465723B6A7573746966792D636F6E74656E';
wwv_flow_imp.g_varchar2_table(26) := '743A2063656E7465723B77696474683A20323270783B6865696768743A20323270783B637572736F723A20706F696E7465723B626F726465723A206E6F6E653B626F726465722D7261646975733A203530253B6261636B67726F756E643A207472616E73';
wwv_flow_imp.g_varchar2_table(27) := '706172656E743B636F6C6F723A20766172282D2D6A64702D6D75746564293B66696C6C3A20766172282D2D6A64702D6D75746564293B746578742D6465636F726174696F6E3A206E6F6E653B7472616E736974696F6E3A206261636B67726F756E642030';
wwv_flow_imp.g_varchar2_table(28) := '2E3132732C20636F6C6F7220302E3132733B7D6A64702D636F6E7461696E6572202E6A64702D69636F6E2D706C7573207376672C0A6A64702D636F6E7461696E6572202E6A64702D69636F6E2D6D696E757320737667207B77696474683A20313470783B';
wwv_flow_imp.g_varchar2_table(29) := '6865696768743A20313470783B70616464696E673A20303B766572746963616C2D616C69676E3A206D6964646C653B7D6A64702D636F6E7461696E6572202E6A64702D69636F6E2D706C75733A686F7665722C0A6A64702D636F6E7461696E6572202E6A';
wwv_flow_imp.g_varchar2_table(30) := '64702D69636F6E2D6D696E75733A686F766572207B6261636B67726F756E643A20766172282D2D6A64702D686F766572293B636F6C6F723A20766172282D2D6A64702D696E6B293B66696C6C3A20766172282D2D6A64702D696E6B293B7D6A64702D636F';
wwv_flow_imp.g_varchar2_table(31) := '6E7461696E6572202E6A64702D69636F6E2D706C75732E6E6F742D696E2D72616E67652C0A6A64702D636F6E7461696E6572202E6A64702D69636F6E2D6D696E75732E6E6F742D696E2D72616E6765207B637572736F723A206E6F742D616C6C6F776564';
wwv_flow_imp.g_varchar2_table(32) := '3B6F7061636974793A20302E333B706F696E7465722D6576656E74733A206E6F6E653B7D6A64702D636F6E7461696E6572202E6A64702D796561722C0A6A64702D636F6E7461696E6572202E6A64702D6D6F6E74682C0A6A64702D636F6E7461696E6572';
wwv_flow_imp.g_varchar2_table(33) := '202E6A64702D74696D65207B666C65783A20312031206175746F3B6D696E2D77696474683A20303B7D6A64702D636F6E7461696E6572202E6A64702D7965617220696E7075742C0A6A64702D636F6E7461696E6572202E6A64702D796561722073656C65';
wwv_flow_imp.g_varchar2_table(34) := '63742C0A6A64702D636F6E7461696E6572202E6A64702D6D6F6E746820696E7075742C0A6A64702D636F6E7461696E6572202E6A64702D6D6F6E74682073656C6563742C0A6A64702D636F6E7461696E6572202E6A64702D74696D652073656C65637420';
wwv_flow_imp.g_varchar2_table(35) := '7B77696474683A20313030253B6865696768743A20323470783B6D617267696E3A20303B70616464696E673A2030203270783B626F726465723A206E6F6E653B626F726465722D7261646975733A203870783B6261636B67726F756E643A207472616E73';
wwv_flow_imp.g_varchar2_table(36) := '706172656E743B636F6C6F723A20696E68657269743B666F6E743A20696E68657269743B666F6E742D7765696768743A203630303B746578742D616C69676E3A2063656E7465723B746578742D616C69676E2D6C6173743A2063656E7465723B63757273';
wwv_flow_imp.g_varchar2_table(37) := '6F723A20706F696E7465723B6F75746C696E653A206E6F6E653B2D7765626B69742D617070656172616E63653A206E6F6E653B2D6D6F7A2D617070656172616E63653A20746578746669656C643B617070656172616E63653A206E6F6E653B626F782D73';
wwv_flow_imp.g_varchar2_table(38) := '6861646F773A206E6F6E653B7D6A64702D636F6E7461696E6572202E6A64702D7965617220696E707574207B637572736F723A20746578743B7D6A64702D636F6E7461696E6572202E6A64702D7965617220696E7075743A3A2D7765626B69742D6F7574';
wwv_flow_imp.g_varchar2_table(39) := '65722D7370696E2D627574746F6E2C0A6A64702D636F6E7461696E6572202E6A64702D7965617220696E7075743A3A2D7765626B69742D696E6E65722D7370696E2D627574746F6E207B2D7765626B69742D617070656172616E63653A206E6F6E653B6D';
wwv_flow_imp.g_varchar2_table(40) := '617267696E3A20303B7D6A64702D636F6E7461696E6572202E6A64702D796561722073656C6563743A686F7665722C0A6A64702D636F6E7461696E6572202E6A64702D6D6F6E74682073656C6563743A686F7665722C0A6A64702D636F6E7461696E6572';
wwv_flow_imp.g_varchar2_table(41) := '202E6A64702D7965617220696E7075743A686F7665722C0A6A64702D636F6E7461696E6572202E6A64702D796561722073656C6563743A666F6375732C0A6A64702D636F6E7461696E6572202E6A64702D6D6F6E74682073656C6563743A666F6375732C';
wwv_flow_imp.g_varchar2_table(42) := '0A6A64702D636F6E7461696E6572202E6A64702D7965617220696E7075743A666F637573207B6261636B67726F756E643A20766172282D2D6A64702D686F766572293B7D6A64702D636F6E7461696E6572206F7074696F6E207B666F6E742D73697A653A';
wwv_flow_imp.g_varchar2_table(43) := '2031322E3570783B666F6E742D7765696768743A203430303B7D6A64702D636F6E7461696E6572202E6A64702D646179732D686561646572207B646973706C61793A20666C65783B77696474683A20313030253B6D617267696E2D746F703A203370783B';
wwv_flow_imp.g_varchar2_table(44) := '70616464696E673A20303B626F726465722D626F74746F6D3A2031707820736F6C696420766172282D2D6A64702D6C696E65293B7D6A64702D636F6E7461696E6572202E6A64702D64617973207B646973706C61793A20666C65783B666C65782D777261';
wwv_flow_imp.g_varchar2_table(45) := '703A20777261703B77696474683A20313030253B6D617267696E2D746F703A203370783B70616464696E673A20303B6F75746C696E653A20303B7D6A64702D636F6E7461696E6572202E6A64702D6461792C0A6A64702D636F6E7461696E6572202E6A64';
wwv_flow_imp.g_varchar2_table(46) := '702D6461792D6E616D65207B666C65783A203020302031342E32383537313433253B77696474683A2031342E32383537313433253B6865696768743A20323570783B6C696E652D6865696768743A20323570783B6D617267696E3A20303B646973706C61';
wwv_flow_imp.g_varchar2_table(47) := '793A20696E6C696E652D626C6F636B3B706F736974696F6E3A2072656C61746976653B746578742D616C69676E3A2063656E7465723B6261636B67726F756E643A206E6F6E653B626F726465723A206E6F6E653B636F6C6F723A20766172282D2D6A6470';
wwv_flow_imp.g_varchar2_table(48) := '2D696E6B293B666F6E742D7765696768743A203430303B7D6A64702D636F6E7461696E6572202E6A64702D6461792D6E616D65207B6865696768743A20313970783B6C696E652D6865696768743A20313970783B6D617267696E3A20302030203270783B';
wwv_flow_imp.g_varchar2_table(49) := '666F6E742D73697A653A20313170783B666F6E742D7765696768743A203630303B636F6C6F723A20766172282D2D6A64702D6D75746564293B637572736F723A2064656661756C743B7D6A64702D636F6E7461696E6572202E6A64702D6461792D6E616D';
wwv_flow_imp.g_varchar2_table(50) := '652E6C6173742D7765656B2C0A6A64702D636F6E7461696E6572202E6A64702D6461792E6C6173742D7765656B2C0A6A64702D636F6E7461696E6572202E6A64702D6461792E686F6C696461792D6461792C0A6A64702D636F6E7461696E6572202E6A64';
wwv_flow_imp.g_varchar2_table(51) := '702D6461792E686F6C6C792D6461792C0A6A64702D636F6E7461696E6572202E6A64702D6461792D6E616D652E686F6C696461792D646179207B636F6C6F723A20766172282D2D6A64702D726564293B7D6A64702D636F6E7461696E6572202E6A64702D';
wwv_flow_imp.g_varchar2_table(52) := '6461792E6E6F742D696E2D6D6F6E7468207B6F7061636974793A20302E33353B7D6A64702D636F6E7461696E6572202E6A64702D6461792E64697361626C65642D646179207B6F7061636974793A20302E323B637572736F723A206E6F742D616C6C6F77';
wwv_flow_imp.g_varchar2_table(53) := '65643B7D6A64702D636F6E7461696E6572202E6A64702D6461793A6E6F74282E64697361626C65642D64617929207B637572736F723A20706F696E7465723B626F726465722D7261646975733A203970783B7472616E736974696F6E3A206261636B6772';
wwv_flow_imp.g_varchar2_table(54) := '6F756E6420302E31732C20636F6C6F7220302E31733B7D6A64702D636F6E7461696E6572202E6A64702D6461793A6E6F74282E64697361626C65642D646179293A686F766572207B6261636B67726F756E643A20766172282D2D6A64702D686F76657229';
wwv_flow_imp.g_varchar2_table(55) := '3B7D6A64702D636F6E7461696E6572202E6A64702D6461792E746F646179207B6261636B67726F756E643A20766172282D2D6A64702D7072696D6172792D736F6674293B636F6C6F723A20766172282D2D6A64702D7072696D617279293B666F6E742D77';
wwv_flow_imp.g_varchar2_table(56) := '65696768743A203730303B7D6A64702D636F6E7461696E6572202E6A64702D6461792E73656C6563746564207B6261636B67726F756E643A20766172282D2D6A64702D7072696D617279292021696D706F7274616E743B636F6C6F723A20766172282D2D';
wwv_flow_imp.g_varchar2_table(57) := '6A64702D7072696D6172792D696E6B292021696D706F7274616E743B666F6E742D7765696768743A203730303B6F7061636974793A20312021696D706F7274616E743B626F782D736861646F773A2030203270782036707820636F6C6F722D6D69782869';
wwv_flow_imp.g_varchar2_table(58) := '6E20737267622C20766172282D2D6A64702D7072696D61727929203430252C207472616E73706172656E74293B7D6A64702D636F6E7461696E6572202E6A64702D6461792E696E2D72616E6765207B6261636B67726F756E643A20766172282D2D6A6470';
wwv_flow_imp.g_varchar2_table(59) := '2D7072696D6172792D736F6674293B626F726465722D7261646975733A20303B7D6A64702D636F6E7461696E6572202E6A64702D74696D652D636F6E7461696E6572207B646973706C61793A20666C65783B616C69676E2D6974656D733A2063656E7465';
wwv_flow_imp.g_varchar2_table(60) := '723B6A7573746966792D636F6E74656E743A2063656E7465723B6761703A203870783B6D617267696E2D746F703A203570783B70616464696E673A20367078203020303B626F726465722D746F703A2031707820736F6C696420766172282D2D6A64702D';
wwv_flow_imp.g_varchar2_table(61) := '6C696E65293B7D6A64702D636F6E7461696E6572202E6A64702D74696D652D636F6E7461696E6572202E6A64702D74696D65207B666C65783A2031203120303B706F736974696F6E3A2072656C61746976653B6D617267696E3A20303B7D6A64702D636F';
wwv_flow_imp.g_varchar2_table(62) := '6E7461696E6572202E6A64702D74696D652D636F6E7461696E6572202E6A64702D74696D652073656C656374207B6865696768743A20323670783B6261636B67726F756E643A20766172282D2D6A64702D686F766572293B626F726465722D7261646975';
wwv_flow_imp.g_varchar2_table(63) := '733A203870783B666F6E742D7765696768743A203630303B666F6E742D73697A653A20313370783B7D6A64702D636F6E7461696E6572202E6A64702D74696D652D636F6E7461696E6572202E6A64702D74696D652073656C6563743A686F7665722C0A6A';
wwv_flow_imp.g_varchar2_table(64) := '64702D636F6E7461696E6572202E6A64702D74696D652D636F6E7461696E6572202E6A64702D74696D652073656C6563743A666F637573207B6261636B67726F756E643A20766172282D2D6A64702D7072696D6172792D736F6674293B636F6C6F723A20';
wwv_flow_imp.g_varchar2_table(65) := '766172282D2D6A64702D7072696D617279293B7D6A64702D636F6E7461696E6572202E6A64702D74696D652D636F6E7461696E6572202E6A64702D74696D653A3A6166746572207B636F6E74656E743A20223A223B706F736974696F6E3A206162736F6C';
wwv_flow_imp.g_varchar2_table(66) := '7574653B6C6566743A202D3470783B746F703A203530253B7472616E73666F726D3A207472616E736C617465282D3530252C202D353525293B666F6E742D7765696768743A203730303B636F6C6F723A20766172282D2D6A64702D6D75746564293B7D6A';
wwv_flow_imp.g_varchar2_table(67) := '64702D636F6E7461696E6572202E6A64702D74696D652D636F6E7461696E6572202E6A64702D74696D653A6C6173742D6368696C643A3A6166746572207B646973706C61793A206E6F6E653B7D6A64702D636F6E7461696E6572202E6A64702D74696D65';
wwv_flow_imp.g_varchar2_table(68) := '2D636F6E7461696E65722E6A64702D6F6E6C792D74696D65202E6A64702D74696D652073656C656374207B6865696768743A20333870783B666F6E742D73697A653A20313670783B7D6A64702D636F6E7461696E6572202E6A64702D666F6F746572207B';
wwv_flow_imp.g_varchar2_table(69) := '646973706C61793A20666C65783B616C69676E2D6974656D733A2063656E7465723B6761703A203670783B77696474683A20313030253B6D617267696E2D746F703A203870783B70616464696E673A20303B6F75746C696E653A20303B7D6A64702D636F';
wwv_flow_imp.g_varchar2_table(70) := '6E7461696E6572202E6A64702D62746E2D636F6E6669726D2C0A6A64702D636F6E7461696E6572202E6A64702D62746E2D746F6461792C0A6A64702D636F6E7461696E6572202E6A64702D62746E2D656D7074792C0A6A64702D636F6E7461696E657220';
wwv_flow_imp.g_varchar2_table(71) := '2E6A64702D62746E2D636C6F7365207B646973706C61793A20696E6C696E652D626C6F636B3B70616464696E673A203020313270783B6865696768743A20323670783B6C696E652D6865696768743A20323670783B626F726465722D7261646975733A20';
wwv_flow_imp.g_varchar2_table(72) := '3870783B666F6E742D73697A653A20313270783B666F6E742D7765696768743A203630303B746578742D616C69676E3A2063656E7465723B77686974652D73706163653A206E6F777261703B637572736F723A20706F696E7465723B7472616E73697469';
wwv_flow_imp.g_varchar2_table(73) := '6F6E3A2066696C74657220302E3132732C206261636B67726F756E6420302E3132733B7D6A64702D636F6E7461696E6572202E6A64702D62746E2D636F6E6669726D207B666C65783A20312031206175746F3B6261636B67726F756E643A20766172282D';
wwv_flow_imp.g_varchar2_table(74) := '2D6A64702D7072696D617279293B636F6C6F723A20766172282D2D6A64702D7072696D6172792D696E6B293B626F782D736861646F773A2030203270782036707820636F6C6F722D6D697828696E20737267622C20766172282D2D6A64702D7072696D61';
wwv_flow_imp.g_varchar2_table(75) := '727929203335252C207472616E73706172656E74293B7D6A64702D636F6E7461696E6572202E6A64702D62746E2D636F6E6669726D3A686F766572207B66696C7465723A206272696768746E65737328312E3038293B7D6A64702D636F6E7461696E6572';
wwv_flow_imp.g_varchar2_table(76) := '202E6A64702D62746E2D746F646179207B6261636B67726F756E643A20766172282D2D6A64702D7072696D6172792D736F6674293B636F6C6F723A20766172282D2D6A64702D7072696D617279293B7D6A64702D636F6E7461696E6572202E6A64702D62';
wwv_flow_imp.g_varchar2_table(77) := '746E2D746F6461793A686F766572207B66696C7465723A206272696768746E65737328302E3936293B7D6A64702D636F6E7461696E6572202E6A64702D62746E2D656D7074792C0A6A64702D636F6E7461696E6572202E6A64702D62746E2D636C6F7365';
wwv_flow_imp.g_varchar2_table(78) := '207B6261636B67726F756E643A207472616E73706172656E743B636F6C6F723A20766172282D2D6A64702D6D75746564293B70616464696E673A2030203870783B7D6A64702D636F6E7461696E6572202E6A64702D62746E2D656D7074793A686F766572';
wwv_flow_imp.g_varchar2_table(79) := '2C0A6A64702D636F6E7461696E6572202E6A64702D62746E2D636C6F73653A686F766572207B6261636B67726F756E643A20766172282D2D6A64702D686F766572293B636F6C6F723A20766172282D2D6A64702D726564293B7D6A64702D636F6E746169';
wwv_flow_imp.g_varchar2_table(80) := '6E6572202E6A64702D62746E2D746F6461792E64697361626C65642D62746E2C0A6A64702D636F6E7461696E6572202E6A64702D62746E2D656D7074792E64697361626C65642D62746E2C0A6A64702D636F6E7461696E6572202E6A64702D62746E2D63';
wwv_flow_imp.g_varchar2_table(81) := '6C6F73652E64697361626C65642D62746E207B6F7061636974793A20302E33353B637572736F723A206E6F742D616C6C6F7765643B7D406D65646961206F6E6C792073637265656E20616E6420286D61782D77696474683A20343831707829207B6A6470';
wwv_flow_imp.g_varchar2_table(82) := '2D636F6E7461696E6572202E6A64702D62746E2D636F6E6669726D2C0A6A64702D636F6E7461696E6572202E6A64702D62746E2D746F6461792C0A6A64702D636F6E7461696E6572202E6A64702D62746E2D656D7074792C0A6A64702D636F6E7461696E';
wwv_flow_imp.g_varchar2_table(83) := '6572202E6A64702D62746E2D636C6F7365207B6865696768743A20333670783B6C696E652D6865696768743A20333670783B666F6E742D73697A653A20313470783B7D7D406B65796672616D6573206A64704F70656E416E696D6174696F6E207B66726F';
wwv_flow_imp.g_varchar2_table(84) := '6D207B6F7061636974793A20303B7472616E73666F726D3A207472616E736C61746559282D347078293B7D746F207B6F7061636974793A20313B7472616E73666F726D3A207472616E736C617465592830293B7D7D406B65796672616D6573206A64704F';
wwv_flow_imp.g_varchar2_table(85) := '70656E416E696D6174696F6E4D6F62696C65207B66726F6D207B6D617267696E2D626F74746F6D3A202D3230253B6F7061636974793A20303B7D746F207B6D617267696E2D626F74746F6D3A20303B6F7061636974793A20313B7D7D';
null;
end;
/
begin
wwv_flow_imp_shared.create_plugin_file(
 p_id=>wwv_flow_imp.id(43233919721397221)
,p_plugin_id=>wwv_flow_imp.id(438448083865680986)
,p_file_name=>'jalalidatepicker.min.css'
,p_mime_type=>'text/css'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_imp.varchar2_to_blob(wwv_flow_imp.g_varchar2_table)
);
end;
/
begin
wwv_flow_imp.g_varchar2_table := wwv_flow_imp.empty_varchar2_table;
wwv_flow_imp.g_varchar2_table(1) := '2166756E6374696F6E2874297B2275736520737472696374223B76617220653D66756E6374696F6E2874297B72657475726E20766F696420303D3D3D747D2C6E3D66756E6374696F6E2874297B72657475726E2266756E6374696F6E223D3D747970656F';
wwv_flow_imp.g_varchar2_table(2) := '6620747D2C693D66756E6374696F6E2874297B72657475726E22737472696E67223D3D747970656F6620747D2C6F3D66756E6374696F6E2874297B72657475726E204A534F4E2E7061727365284A534F4E2E737472696E67696679287429297D2C723D66';
wwv_flow_imp.g_varchar2_table(3) := '756E6374696F6E2874297B6966286E756C6C3D3D3D28653D74297C7C226F626A65637422213D747970656F6620652972657475726E21303B76617220653B7472797B72657475726E227B7D223D3D3D4A534F4E2E737472696E676966792874297D636174';
wwv_flow_imp.g_varchar2_table(4) := '63682874297B72657475726E21317D7D2C613D66756E6374696F6E28742C65297B666F7228766172206E20696E206529696628652E6861734F776E50726F7065727479286E29297B76617220693D655B6E5D2C6F3D745B6E5D3B692626226F626A656374';
wwv_flow_imp.g_varchar2_table(5) := '223D3D747970656F66206926262141727261792E697341727261792869293F745B6E5D3D61286F2626226F626A656374223D3D747970656F66206F3F6F3A7B7D2C69293A745B6E5D3D697D72657475726E20747D2C733D66756E6374696F6E28742C6529';
wwv_flow_imp.g_varchar2_table(6) := '7B72657475726E2077696E646F772E4D6174682E61627328742D652A77696E646F772E4D6174682E666C6F6F7228742F6529297D2C753D66756E6374696F6E28742C6E297B696628766F696420303D3D3D6E2626286E3D32292C65287429297265747572';
wwv_flow_imp.g_varchar2_table(7) := '6E20743B76617220693D537472696E67284D6174682E616273287429292C6F3D692E6C656E6774682C723D22223B666F7228743C30262628722B3D222D22293B6F3C6E3B296F2B3D312C722B3D2230223B72657475726E20722B697D2C643D66756E6374';
wwv_flow_imp.g_varchar2_table(8) := '696F6E2874297B666F722876617220652C6E3D5B2D36312C392C33382C3139392C3432362C3638362C3735362C3831382C313131312C313138312C313231302C313633352C323036302C323039372C323139322C323236322C323332342C323339342C32';
wwv_flow_imp.g_varchar2_table(9) := '3435362C333137385D2C693D6E2E6C656E6774682C6F3D302C723D6E5B305D2C613D313B613C693B612B3D31297B76617220753D6E5B615D3B6966286F3D752D722C743C7529627265616B3B723D757D76617220643D742D723B72657475726E206F2D64';
wwv_flow_imp.g_varchar2_table(10) := '3C36262628643D642D6F2B33332A7E7E28286F2B34292F333329292C2D313D3D3D28653D73287328642B312C3333292D312C342929262628653D34292C303D3D3D657D2C6C3D66756E6374696F6E28297B76617220743D6E657720446174653B72657475';
wwv_flow_imp.g_varchar2_table(11) := '726E2066756E6374696F6E28742C652C6E297B76617220692C6F3B743E313630303F28693D3937392C742D3D31363030293A28693D302C742D3D363231293B76617220723D653E323F742B313A743B72657475726E206F3D3336352A742B4D6174682E66';
wwv_flow_imp.g_varchar2_table(12) := '6C6F6F722828722B33292F34292D4D6174682E666C6F6F722828722B3939292F313030292B4D6174682E666C6F6F722828722B333939292F343030292D38302B6E2B5B302C33312C35392C39302C3132302C3135312C3138312C3231322C3234332C3237';
wwv_flow_imp.g_varchar2_table(13) := '332C3330342C3333345D5B652D315D2C692B3D33332A4D6174682E666C6F6F72286F2F3132303533292C6F253D31323035332C692B3D342A4D6174682E666C6F6F72286F2F31343631292C286F253D31343631293E333635262628692B3D4D6174682E66';
wwv_flow_imp.g_varchar2_table(14) := '6C6F6F7228286F2D31292F333635292C6F3D286F2D312925333635292C7B796561723A692C6D6F6E74683A6F3C3138363F312B4D6174682E666C6F6F72286F2F3331293A372B4D6174682E666C6F6F7228286F2D313836292F3330292C6461793A312B28';
wwv_flow_imp.g_varchar2_table(15) := '6F3C3138363F6F2533313A286F2D31383629253330297D7D28742E67657446756C6C5965617228292C742E6765744D6F6E746828292B312C742E676574446174652829297D2C683D66756E6374696F6E28742C652C6E297B76617220693D66756E637469';
wwv_flow_imp.g_varchar2_table(16) := '6F6E28742C65297B72657475726E20743C383F33312A28742D31292B653A3138362B33302A28742D37292B657D3B72657475726E20732866756E6374696F6E28742C652C6E2C6F2C722C61297B666F722876617220733D6928722C61292D6928652C6E29';
wwv_flow_imp.g_varchar2_table(17) := '2C753D743C6F3F6F3A742C6C3D743C6F3F743A6F3B6C3C753B6C2B2B2964286C293F732B3D743C6F3F3336363A2D3336363A732B3D743C6F3F3336353A2D3336353B72657475726E20737D28313339322C332C32352C742C652C6E292C37297D2C633D66';
wwv_flow_imp.g_varchar2_table(18) := '756E6374696F6E28742C65297B72657475726E5B302C33312C33312C33312C33312C33312C33312C33302C33302C33302C33302C33302C642874293F33303A32395D5B655D7D2C703D66756E6374696F6E28742C652C6E297B76617220693D743C3D3937';
wwv_flow_imp.g_varchar2_table(19) := '393F3632313A313630302C6F3D3336352A28742D3D743C3D3937393F303A393739292B382A4D6174682E666C6F6F7228742F3333292B4D6174682E666C6F6F722828742533332B33292F34292B37382B6E2B28653C373F33312A28652D31293A33302A28';
wwv_flow_imp.g_varchar2_table(20) := '652D37292B313836293B692B3D3430302A4D6174682E666C6F6F72286F2F313436303937292C286F253D313436303937293E3336353234262628692B3D3130302A4D6174682E666C6F6F72282D2D6F2F3336353234292C286F253D3336353234293E3D33';
wwv_flow_imp.g_varchar2_table(21) := '363526266F2B2B292C692B3D342A4D6174682E666C6F6F72286F2F31343631292C286F253D31343631293E333635262628692B3D4D6174682E666C6F6F7228286F2D31292F333635292C6F3D286F2D312925333635293B76617220722C613D6F2B312C73';
wwv_flow_imp.g_varchar2_table(22) := '3D5B302C33312C6925343D3D3026266925313030213D307C7C69253430303D3D303F32393A32382C33312C33302C33312C33302C33312C33312C33302C33312C33302C33315D3B666F7228723D303B723C31333B722B2B297B76617220753D735B725D3B';
wwv_flow_imp.g_varchar2_table(23) := '696628613C3D7529627265616B3B612D3D757D72657475726E7B796561723A692C6D6F6E74683A722C6461793A617D7D2C6D3D66756E6374696F6E2874297B72657475726E203165342A742E796561722B3130302A742E6D6F6E74682B742E6461797D2C';
wwv_flow_imp.g_varchar2_table(24) := '663D66756E6374696F6E2874297B72657475726E20742E7265706C616365282F5B2E2A2B3F5E247B7D28297C5B5C5D5C5C5D2F672C225C5C242622297D2C763D66756E6374696F6E2874297B72657475726E20382B322A742E6F7074696F6E732E736570';
wwv_flow_imp.g_varchar2_table(25) := '617261746F7243686172732E646174652E6C656E6774687D2C793D66756E6374696F6E28742C65297B696628742E6C656E677468213D3D652E6C656E6774682972657475726E21313B666F7228766172206E3D303B6E3C742E6C656E6774683B6E2B2B29';
wwv_flow_imp.g_varchar2_table(26) := '696628745B6E5D2E6C656E677468213D3D655B6E5D2972657475726E21313B72657475726E21307D2C673D66756E6374696F6E28742C652C6E297B76617220693D6128657C7C7B7D2C6E7C7C7B7D292C6F3D66756E6374696F6E2874297B72657475726E';
wwv_flow_imp.g_varchar2_table(27) := '20742E5F696E6974446174653F742E5F696E6974446174653A742E6F7074696F6E732E696E6974446174652626226F626A656374223D3D747970656F6620742E6F7074696F6E732E696E6974446174653F742E6F7074696F6E732E696E6974446174653A';
wwv_flow_imp.g_varchar2_table(28) := '742E746F6461797D2874292C723D742E6F7074696F6E732E6D6178446174652C733D742E6F7074696F6E732E6D696E446174652C753D66756E6374696F6E2874297B72657475726E2169734E614E2874292626743E3D3165332626743C3D313939397D28';
wwv_flow_imp.g_varchar2_table(29) := '692E79656172293F692E796561723A6F2E796561722C643D66756E6374696F6E2874297B72657475726E2169734E614E2874292626743E3D312626743C3D31327D28692E6D6F6E7468293F692E6D6F6E74683A6F2E6D6F6E74682C6C3D2169734E614E28';
wwv_flow_imp.g_varchar2_table(30) := '692E646179292626692E6461793E3D313F692E6461793A6F2E6461792C683D6328752C64293B6C3E682626286C3D68293B76617220703D7B796561723A752C6D6F6E74683A642C6461793A6C7D3B72657475726E207326266D2870293C6D2873293F733A';
wwv_flow_imp.g_varchar2_table(31) := '7226266D2870293E6D2872293F723A707D2C773D66756E6374696F6E28742C652C6E297B76617220693D6128657C7C7B7D2C6E7C7C7B7D292C6F3D66756E6374696F6E2874297B72657475726E20742E5F696E697454696D653F742E5F696E697454696D';
wwv_flow_imp.g_varchar2_table(32) := '653A742E6F7074696F6E732E696E697454696D652626226F626A656374223D3D747970656F6620742E6F7074696F6E732E696E697454696D653F742E6F7074696F6E732E696E697454696D653A7B686F75723A302C6D696E7574653A302C7365636F6E64';
wwv_flow_imp.g_varchar2_table(33) := '3A307D7D2874292C723D742E6F7074696F6E732E6D617854696D652C733D742E6F7074696F6E732E6D696E54696D652C753D692E686F75722C643D692E6D696E7574652C6C3D692E7365636F6E643B72657475726E2069734E614E2875297C7C753C307C';
wwv_flow_imp.g_varchar2_table(34) := '7C753E32333F753D6F2E686F75723A732626753C732E686F75723F753D732E686F75723A722626753E722E686F7572262628753D722E686F7572292C69734E614E2864297C7C643C307C7C643E35393F643D6F2E6D696E7574653A732626753C3D732E68';
wwv_flow_imp.g_varchar2_table(35) := '6F75722626643C732E6D696E7574653F643D732E6D696E7574653A722626753E3D722E686F75722626643E722E6D696E757465262628643D722E6D696E757465292C69734E614E286C297C7C6C3C307C7C6C3E35393F6C3D6F2E7365636F6E643A732626';
wwv_flow_imp.g_varchar2_table(36) := '753C3D732E686F75722626643C3D732E6D696E75746526266C3C732E7365636F6E643F6C3D732E7365636F6E643A722626753E3D722E686F75722626643E3D722E6D696E75746526266C3E722E7365636F6E642626286C3D722E7365636F6E64292C7B68';
wwv_flow_imp.g_varchar2_table(37) := '6F75723A752C6D696E7574653A642C7365636F6E643A6C7D7D2C443D66756E6374696F6E28742C652C6E2C69297B766172206F3D6D287B796561723A652C6D6F6E74683A6E2C6461793A697D292C613D6F2C733D6F2C753D742E6F7074696F6E732E6D61';
wwv_flow_imp.g_varchar2_table(38) := '78446174652C643D742E6F7074696F6E732E6D696E446174653B72657475726E20722864297C7C28733D6D286429292C722875297C7C28613D6D287529292C6F3C3D6126266F3E3D737D2C623D66756E6374696F6E28742C65297B72657475726E20742E';
wwv_flow_imp.g_varchar2_table(39) := '6F7074696F6E732E646174653F652E73756273747228302C76287429292E73706C697428742E6F7074696F6E732E736570617261746F7243686172732E64617465293A5B5D7D2C5F3D66756E6374696F6E28742C65297B766172206E3D742E6F7074696F';
wwv_flow_imp.g_varchar2_table(40) := '6E732E736570617261746F7243686172733B696628742E6F7074696F6E732E64617465297B76617220693D762874292B6E2E6265747765656E2E6C656E6774683B72657475726E20742E6F7074696F6E732E74696D652626652E6C656E6774683E693F65';
wwv_flow_imp.g_varchar2_table(41) := '2E7375627374722869292E73706C6974286E2E74696D65293A5B5D7D72657475726E20652E73706C6974286E2E74696D65297D2C433D66756E6374696F6E28742C65297B72657475726E207928742C653F5B322C322C325D3A5B322C325D297D2C533D66';
wwv_flow_imp.g_varchar2_table(42) := '756E6374696F6E28742C65297B766172206E3D6228742C65292C693D5F28742C65293B72657475726E7B796561723A7061727365496E74286E5B305D2C3130292C6D6F6E74683A7061727365496E74286E5B315D2C3130292C6461793A7061727365496E';
wwv_flow_imp.g_varchar2_table(43) := '74286E5B325D2C3130292C686F75723A7061727365496E7428695B305D2C3130297C7C302C6D696E7574653A7061727365496E7428695B315D2C3130297C7C302C7365636F6E643A7061727365496E7428695B325D2C3130297C7C307D7D2C543D66756E';
wwv_flow_imp.g_varchar2_table(44) := '6374696F6E28742C652C6E297B76617220693D742E6F7074696F6E732C6F3D692E736570617261746F7243686172732C723D6E3F6F2E746172676574446174653A6F2E646174652C613D6E3F6F2E74617267657454696D653A6F2E74696D652C733D6E3F';
wwv_flow_imp.g_varchar2_table(45) := '6F2E7461726765744265747765656E3A6F2E6265747765656E2C643D692E646174653F22222B652E796561722B722B7528652E6D6F6E7468292B722B7528652E646179293A22222C6C3D692E74696D653F22222B7528652E686F7572292B612B7528652E';
wwv_flow_imp.g_varchar2_table(46) := '6D696E757465292B28692E6861735365636F6E643F612B7528652E7365636F6E64293A2222293A22223B72657475726E20642B286426266C3F733A2222292B6C7D2C453D66756E6374696F6E28742C65297B72657475726E206D2874293D3D3D6D286529';
wwv_flow_imp.g_varchar2_table(47) := '7D2C783D66756E6374696F6E2874297B72657475726E20742E736C69636528292E736F72742866756E6374696F6E28742C65297B766172206E3D6D2874292C693D6D2865293B72657475726E206E3C693F2D313A6E3E693F313A307D297D2C4D3D66756E';
wwv_flow_imp.g_varchar2_table(48) := '6374696F6E28742C652C6E297B69662821652E6C656E6774682972657475726E22223B76617220693D742E6F7074696F6E732E6D6F64657C7C2273696E676C65222C6F3D2272616E6765223D3D3D693F782865292E736C69636528302C32293A652C723D';
wwv_flow_imp.g_varchar2_table(49) := '2272616E6765223D3D3D693F742E6F7074696F6E732E72616E6765536570617261746F723A742E6F7074696F6E732E6D756C7469706C65536570617261746F723B72657475726E206F2E6D61702866756E6374696F6E2865297B72657475726E2066756E';
wwv_flow_imp.g_varchar2_table(50) := '6374696F6E28742C652C6E297B76617220693D6E3F742E6F7074696F6E732E736570617261746F7243686172732E746172676574446174653A742E6F7074696F6E732E736570617261746F7243686172732E646174653B72657475726E22222B652E7965';
wwv_flow_imp.g_varchar2_table(51) := '61722B692B7528652E6D6F6E7468292B692B7528652E646179297D28742C652C6E297D292E6A6F696E2872297D2C493D66756E6374696F6E28742C65297B766172206E3D742E6F7074696F6E732E6D6F64657C7C2273696E676C65223B69662821657C7C';
wwv_flow_imp.g_varchar2_table(52) := '2273696E676C65223D3D3D6E2972657475726E5B5D3B666F722876617220693D2272616E6765223D3D3D6E3F742E6F7074696F6E732E72616E6765536570617261746F723A742E6F7074696F6E732E6D756C7469706C65536570617261746F722C6F3D65';
wwv_flow_imp.g_varchar2_table(53) := '2E73706C69742869292C723D5B5D2C613D303B613C6F2E6C656E6774683B612B2B297B76617220733D6F5B615D2E7472696D28293B6966284128742C7329297B76617220753D5328742C73293B722E70757368287B796561723A752E796561722C6D6F6E';
wwv_flow_imp.g_varchar2_table(54) := '74683A752E6D6F6E74682C6461793A752E6461797D297D7D72657475726E2272616E6765223D3D3D6E3F782872292E736C69636528302C32293A727D2C413D66756E6374696F6E28742C65297B72657475726E212165262679286228742C65292C5B342C';
wwv_flow_imp.g_varchar2_table(55) := '322C325D297D2C563D66756E6374696F6E28742C65297B72657475726E212165262643285F28742C65292C742E6F7074696F6E732E6861735365636F6E64297D2C6A3D66756E6374696F6E2874297B76617220652C6E3D6E756C6C3D3D28653D742E696E';
wwv_flow_imp.g_varchar2_table(56) := '707574293F766F696420303A652E76616C75653B696628216E2972657475726E22223B696628742E6F7074696F6E732E74617267657456616C756554797065297B6966282273696E676C6522213D3D28742E6F7074696F6E732E6D6F64657C7C2273696E';
wwv_flow_imp.g_varchar2_table(57) := '676C652229297B76617220693D4928742C6E293B69662822677265676F7269616E223D3D3D742E6F7074696F6E732E74617267657456616C756554797065297B766172206F3D692E6D61702866756E6374696F6E2874297B72657475726E206128742C70';
wwv_flow_imp.g_varchar2_table(58) := '28742E796561722C742E6D6F6E74682C742E64617929297D293B72657475726E204D28742C6F2C2130297D72657475726E206E7D76617220723D5328742C6E293B69662822677265676F7269616E223D3D3D742E6F7074696F6E732E7461726765745661';
wwv_flow_imp.g_varchar2_table(59) := '6C756554797065297B76617220733D7028722E796561722C722E6D6F6E74682C722E646179293B72657475726E205428742C6128722C73292C2130297D7D72657475726E206E7D2C4C3D66756E6374696F6E28297B7472797B69662877696E646F772E74';
wwv_flow_imp.g_varchar2_table(60) := '6F70262677696E646F772E746F70213D3D77696E646F77262677696E646F772E746F702E646F63756D656E74262677696E646F772E746F702E646F63756D656E742E626F64792972657475726E2077696E646F772E746F707D63617463682874297B7D72';
wwv_flow_imp.g_varchar2_table(61) := '657475726E2077696E646F777D2C4E3D66756E6374696F6E2874297B69662874262622626F647922213D3D74262674213D3D646F63756D656E742E626F64792972657475726E20743B76617220653D4C28293B72657475726E2066756E6374696F6E2874';
wwv_flow_imp.g_varchar2_table(62) := '297B69662874213D3D77696E646F77297B76617220653D742E646F63756D656E743B69662821652E676574456C656D656E744279496428226A64702D686F73742D6373732229297B766172206E3D646F63756D656E742E717565727953656C6563746F72';
wwv_flow_imp.g_varchar2_table(63) := '28276C696E6B5B687265662A3D226A616C616C69646174657069636B65722E637373225D27293B6966286E297B76617220693D652E637265617465456C656D656E7428226C696E6B22293B72657475726E20692E69643D226A64702D686F73742D637373';
wwv_flow_imp.g_varchar2_table(64) := '222C692E72656C3D227374796C657368656574222C692E687265663D6E2E687265662C766F696420652E686561642E617070656E644368696C642869297D666F7228766172206F3D22222C723D303B723C646F63756D656E742E7374796C655368656574';
wwv_flow_imp.g_varchar2_table(65) := '732E6C656E6774683B722B2B297472797B666F722876617220613D646F63756D656E742E7374796C655368656574735B725D2E63737352756C65737C7C5B5D2C733D303B733C612E6C656E6774683B732B2B29615B735D2E637373546578742E696E6465';
wwv_flow_imp.g_varchar2_table(66) := '784F6628226A64702D22293E2D312626286F2B3D615B735D2E637373546578742B225C6E22297D63617463682874297B7D6966286F297B76617220753D652E637265617465456C656D656E7428227374796C6522293B752E69643D226A64702D686F7374';
wwv_flow_imp.g_varchar2_table(67) := '2D637373222C752E74657874436F6E74656E743D6F2C652E686561642E617070656E644368696C642875297D7D7D7D2865292C652E646F63756D656E742E626F64797D2C4F3D7B77696E3A6E756C6C2C6672616D653A6E756C6C2C74696D65723A6E756C';
wwv_flow_imp.g_varchar2_table(68) := '6C7D2C503D66756E6374696F6E28297B76617220743D4F2E77696E3B69662874297B7472797B742E646F63756D656E742E72656D6F76654576656E744C697374656E65722822636C69636B222C67652C2130292C742E646F63756D656E742E72656D6F76';
wwv_flow_imp.g_varchar2_table(69) := '654576656E744C697374656E65722876742C4465292C742E72656D6F76654576656E744C697374656E65722822726573697A65222C6665292C4F2E74696D65722626742E636C656172496E74657276616C284F2E74696D6572297D63617463682874297B';
wwv_flow_imp.g_varchar2_table(70) := '7D4F2E77696E3D6E756C6C2C4F2E6672616D653D6E756C6C2C4F2E74696D65723D6E756C6C7D7D2C423D66756E6374696F6E28297B76617220743D73653B69662874297B7472797B5028297D63617463682874297B7D7472797B742E7265766572745065';
wwv_flow_imp.g_varchar2_table(71) := '6E64696E6728297D63617463682874297B7D7472797B742E697353686F773D21317D63617463682874297B7D7472797B742E5F6470436F6E7461696E65722626742E5F6470436F6E7461696E65722E706172656E744E6F64652626742E5F6470436F6E74';
wwv_flow_imp.g_varchar2_table(72) := '61696E65722E706172656E744E6F64652E72656D6F76654368696C6428742E5F6470436F6E7461696E6572292C742E6F7665726C6179456C656D656E742626742E6F7665726C6179456C656D656E742E706172656E744E6F64652626742E6F7665726C61';
wwv_flow_imp.g_varchar2_table(73) := '79456C656D656E742E706172656E744E6F64652E72656D6F76654368696C6428742E6F7665726C6179456C656D656E74297D63617463682874297B7D7D7D2C483D226A6470222C6B3D226469762E222B482C593D482B222D636F6E7461696E6572222C52';
wwv_flow_imp.g_varchar2_table(74) := '3D482B222D6F7665726C6179222C7A3D6B2B222D7965617273222C713D6B2B222D79656172222C573D6B2B222D6D6F6E746873222C463D6B2B222D6D6F6E7468222C4A3D6B2B222D64617973222C513D6B2B222D646179732D686561646572222C243D6B';
wwv_flow_imp.g_varchar2_table(75) := '2B222D646179222C553D6B2B222D6461792E6E6F742D696E2D6D6F6E7468222C473D6B2B222D6461792E64697361626C65642D646179222C4B3D552B222E64697361626C65642D646179222C583D6B2B222D6461792D6E616D65222C5A3D6B2B222D6963';
wwv_flow_imp.g_varchar2_table(76) := '6F6E2D706C7573222C74743D6B2B222D69636F6E2D6D696E7573222C65743D6B2B222D666F6F746572222C6E743D6B2B222D62746E2D746F646179222C69743D6B2B222D62746E2D656D707479222C6F743D6B2B222D62746E2D636C6F7365222C72743D';
wwv_flow_imp.g_varchar2_table(77) := '6B2B222D62746E2D636F6E6669726D222C61743D6B2B222D74696D652D636F6E7461696E6572222C73743D6B2B222D74696D65222C75743D2273656C6563746564222C64743D226E6F742D696E2D72616E6765222C6C743D22686F6C696461792D646179';
wwv_flow_imp.g_varchar2_table(78) := '222C68743D482B223A6368616E6765222C63743D226368616E6765222C70743D63742C6D743D22636C69636B222C66743D22666F637573696E222C76743D226B6579646F776E222C79743D22746F646179222C67743D2261747472222C77743D22646174';
wwv_flow_imp.g_varchar2_table(79) := '612D6A64702D222C44743D77742B227461726765742D76616C75652D696E707574222C62743D77742B227461726765742D76616C75652D74797065222C5F743D77742B226D6F6465222C43743D77742B226861732D7365636F6E64222C53743D77742B22';
wwv_flow_imp.g_varchar2_table(80) := '6F6E6C792D64617465222C54743D77742B226F6E6C792D74696D65222C45743D5B22D8B4222C22DB8C222C22D8AF222C22D8B3222C22DA86222C22D9BE222C22D8AC225D2C78743D5B22D981D8B1D988D8B1D8AFDB8CD986222C22D8A7D8B1D8AFDB8CD8';
wwv_flow_imp.g_varchar2_table(81) := 'A8D987D8B4D8AA222C22D8AED8B1D8AFD8A7D8AF222C22D8AADB8CD8B1222C22D985D8B1D8AFD8A7D8AF222C22D8B4D987D8B1DB8CD988D8B1222C22D985D987D8B1222C22D8A2D8A8D8A7D986222C22D8A2D8B0D8B1222C22D8AFDB8C222C22D8A8D987';
wwv_flow_imp.g_varchar2_table(82) := 'D985D986222C22D8A7D8B3D981D986D8AF225D2C4D743D7B646174653A222F222C6265747765656E3A2220222C74696D653A223A222C746172676574446174653A222D222C7461726765744265747765656E3A2220222C74617267657454696D653A223A';
wwv_flow_imp.g_varchar2_table(83) := '227D2C49743D5B22696E697444617465222C226D696E44617465222C226D617844617465225D2C41743D7B696E6974446174653A77742B22696E69742D64617465222C6D696E446174653A77742B226D696E2D64617465222C6D6178446174653A77742B';
wwv_flow_imp.g_varchar2_table(84) := '226D61782D64617465222C6D696E54696D653A77742B226D696E2D74696D65222C6D617854696D653A77742B226D61782D74696D65222C74617267657456616C7565496E7075743A44742C74617267657456616C7565547970653A62742C6D6F64653A5F';
wwv_flow_imp.g_varchar2_table(85) := '742C6861735365636F6E643A43747D2C56743D5B226D696E54696D65222C226D617854696D65225D2C6A743D5B2273696E676C65222C2272616E6765222C226D756C7469706C65225D2C4C743D2276697369626C65222C4E743D22626C6F636B222C4F74';
wwv_flow_imp.g_varchar2_table(86) := '3D226E6F6E65222C50743D66756E6374696F6E2874297B6966285B2268746D6C222C22626F6479222C2223646F63756D656E74225D2E696E6465784F662828742E6E6F64654E616D657C7C2222292E746F4C6F776572436173652829293E3D3029726574';
wwv_flow_imp.g_varchar2_table(87) := '75726E2077696E646F773B6966287420696E7374616E63656F662048544D4C456C656D656E74297B76617220653D77696E646F772E676574436F6D70757465645374796C652874292C6E3D652E6F766572666C6F772C693D652E6F766572666C6F77582C';
wwv_flow_imp.g_varchar2_table(88) := '6F3D652E6F766572666C6F77593B6966282F6175746F7C7363726F6C6C7C6F7665726C61792F2E74657374286E2B6F2B69292972657475726E20747D72657475726E20507428742E706172656E744E6F6465297D2C42743D66756E6374696F6E2874297B';
wwv_flow_imp.g_varchar2_table(89) := '7472797B72657475726E206E28742E636F6D706F73656450617468293F742E636F6D706F7365645061746828295B305D3A742E7461726765747D63617463682865297B72657475726E20742E7461726765747D7D2C48743D66756E6374696F6E2874297B';
wwv_flow_imp.g_varchar2_table(90) := '76617220653D646F63756D656E742E6372656174654576656E7428224576656E7422293B72657475726E20652E696E69744576656E7428742C21302C2130292C657D2C6B743D66756E6374696F6E28742C65297B74262628742E64697370617463684576';
wwv_flow_imp.g_varchar2_table(91) := '656E74284874286529292C742E64697370617463684576656E7428487428226368616E67652229292C742E64697370617463684576656E742848742822696E707574222929297D2C59743D66756E6374696F6E28742C65297B742E696E6E657248544D4C';
wwv_flow_imp.g_varchar2_table(92) := '3D657D2C52743D66756E6374696F6E28742C6E2C6F2C722C612C73297B766F696420303D3D3D73262628733D227465787422293B76617220753D742E73706C697428222E22293B743D752E736869667428297C7C22646976223B76617220643D752C6C3D';
wwv_flow_imp.g_varchar2_table(93) := '77696E646F772E646F63756D656E742E637265617465456C656D656E742874293B69662869286E29297B76617220683D77696E646F772E646F63756D656E742E717565727953656C6563746F72286E293B6966282168297468726F77206E657720457272';
wwv_flow_imp.g_varchar2_table(94) := '6F722822506172656E7420656C656D656E74206E6F7420666F756E643A20222B6E293B682E617070656E644368696C64286C297D656C7365206E2E617070656E644368696C64286C293B72657475726E20642E6C656E6774682626286C2E636C6173734E';
wwv_flow_imp.g_varchar2_table(95) := '616D653D642E6A6F696E2822202229292C6F262672262666756E6374696F6E28742C652C6E297B666F722876617220693D652E73706C697428222022292C6F3D302C723D692E6C656E6774683B6F3C723B6F2B2B29742E6164644576656E744C69737465';
wwv_flow_imp.g_varchar2_table(96) := '6E657228695B6F5D2C6E2C2131297D286C2C6F2C72292C652861297C7C282268746D6C223D3D3D733F5974286C2C61293A6C2E74657874436F6E74656E743D61292C6C7D2C7A743D66756E6374696F6E28742C65297B72657475726E20653F742E746F53';
wwv_flow_imp.g_varchar2_table(97) := '7472696E6728292E7265706C616365282F5C642F672C66756E6374696F6E2874297B72657475726E22DBB0DBB1DBB2DBB3DBB4DBB5DBB6DBB7DBB8DBB9225B7061727365496E7428742C3130295D7D293A747D2C71743D66756E6374696F6E28742C652C';
wwv_flow_imp.g_varchar2_table(98) := '6E297B76617220693D5B5D3B28216E7C7C6E3C3D30292626286E3D31293B666F7228766172206F3D743B6F3C3D653B6F2B3D6E29692E707573682875286F29293B72657475726E20697D2C57743D66756E6374696F6E28742C652C6E297B76617220693D';
wwv_flow_imp.g_varchar2_table(99) := '52742873742C65292C6F3D5274282273656C656374222C692C70742C66756E6374696F6E2865297B76617220693B742E73657456616C7565287728742C742E696E697454696D652C2828693D7B7D295B6E5D3D66756E6374696F6E2874297B7265747572';
wwv_flow_imp.g_varchar2_table(100) := '6E204E756D62657228742E7461726765742E76616C7565297D2865292C692929297D293B6F2E746162496E6465783D2D313B666F722876617220722C732C753D28723D66756E6374696F6E2874297B72657475726E2061287B686F75723A302C6D696E75';
wwv_flow_imp.g_varchar2_table(101) := '74653A302C7365636F6E643A307D2C742E6F7074696F6E732E6D696E54696D657C7C7B7D297D2874292C733D66756E6374696F6E2874297B72657475726E2061287B686F75723A32332C6D696E7574653A35392C7365636F6E643A35397D2C742E6F7074';
wwv_flow_imp.g_varchar2_table(102) := '696F6E732E6D617854696D657C7C7B7D297D2874292C22686F7572223D3D3D6E3F717428722E686F75722C732E686F75722C742E6F7074696F6E732E686F7572496E6372656D656E74293A226D696E757465223D3D3D6E3F66756E6374696F6E28742C65';
wwv_flow_imp.g_varchar2_table(103) := '2C6E297B72657475726E20652E686F75723D3D3D6E2E686F75723F717428652E6D696E7574652C6E2E6D696E7574652C742E6F7074696F6E732E6D696E757465496E6372656D656E74293A742E696E697454696D652E686F75723D3D3D652E686F75723F';
wwv_flow_imp.g_varchar2_table(104) := '717428652E6D696E7574652C35392C742E6F7074696F6E732E6D696E757465496E6372656D656E74293A742E696E697454696D652E686F75723D3D3D6E2E686F75723F717428302C6E2E6D696E7574652C742E6F7074696F6E732E6D696E757465496E63';
wwv_flow_imp.g_varchar2_table(105) := '72656D656E74293A717428302C35392C742E6F7074696F6E732E6D696E757465496E6372656D656E74297D28742C722C73293A66756E6374696F6E28742C652C6E297B72657475726E20652E686F75723D3D3D6E2E686F75722626652E6D696E7574653D';
wwv_flow_imp.g_varchar2_table(106) := '3D3D6E2E6D696E7574653F717428652E7365636F6E642C6E2E7365636F6E64293A742E696E697454696D652E686F75723D3D3D652E686F75722626742E696E697454696D652E6D696E7574653D3D3D652E6D696E7574653F717428652E7365636F6E642C';
wwv_flow_imp.g_varchar2_table(107) := '3539293A742E696E697454696D652E686F75723D3D3D6E2E686F75722626742E696E697454696D652E6D696E7574653D3D3D6E2E6D696E7574653F717428302C6E2E7365636F6E64293A717428302C3539297D28742C722C7329292C643D303B643C752E';
wwv_flow_imp.g_varchar2_table(108) := '6C656E6774683B642B2B297B766172206C3D755B645D2C683D527428226F7074696F6E222C6F293B682E76616C75653D6C2E746F537472696E6728292C682E746578743D7A74286C2C742E6F7074696F6E732E7065727369616E446967697473292E746F';
wwv_flow_imp.g_varchar2_table(109) := '537472696E6728292C682E73656C65637465643D7061727365496E74286C293D3D3D4E756D62657228742E67657456616C75655B6E5D7C7C742E696E697454696D655B6E5D297D7D2C46743D66756E6374696F6E2874297B72657475726E20363D3D3D74';
wwv_flow_imp.g_varchar2_table(110) := '3F222E6C6173742D7765656B2E222B6C743A22227D2C4A743D66756E6374696F6E28742C65297B766172206E2C692C6F2C722C612C733D66756E6374696F6E2874297B72657475726E7B796561723A742E796561722C6D6F6E74683A742E6D6F6E74682C';
wwv_flow_imp.g_varchar2_table(111) := '6461793A742E6461797D7D2865292C753D742E6F7074696F6E732E6D6F64657C7C2273696E676C65223B6966282273696E676C65223D3D3D752972657475726E20742E696E70757456616C75652E6461793D3D3D652E6461792626742E696E7075745661';
wwv_flow_imp.g_varchar2_table(112) := '6C75652E796561723D3D3D652E796561722626742E696E70757456616C75652E6D6F6E74683D3D3D652E6D6F6E74683F222E222B75743A22223B696628226D756C7469706C65223D3D3D75297B666F722876617220643D303B643C742E73656C65637465';
wwv_flow_imp.g_varchar2_table(113) := '6444617465732E6C656E6774683B642B2B296966284528732C742E73656C656374656444617465735B645D292972657475726E222E222B75743B72657475726E22227D72657475726E20742E73656C656374656444617465732E6C656E6774683F452873';
wwv_flow_imp.g_varchar2_table(114) := '2C742E73656C656374656444617465735B305D293F222E222B75742B222E72616E67652D7374617274223A323D3D3D742E73656C656374656444617465732E6C656E67746826264528732C742E73656C656374656444617465735B315D293F222E222B75';
wwv_flow_imp.g_varchar2_table(115) := '742B222E72616E67652D656E64223A323D3D3D742E73656C656374656444617465732E6C656E6774682626286E3D732C693D742E73656C656374656444617465735B305D2C6F3D742E73656C656374656444617465735B315D2C723D6D286E292C613D78';
wwv_flow_imp.g_varchar2_table(116) := '285B692C6F5D292C723E6D28615B305D292626723C6D28615B315D29293F222E696E2D72616E6765223A22223A22227D2C51743D66756E6374696F6E28742C652C6E2C69297B766172206F2C722C612C732C753D22504C5553223D3D3D692C643D22222C';
wwv_flow_imp.g_varchar2_table(117) := '6C3D753F5A3A74742C683D752626286E756C6C3D3D286F3D742E6F7074696F6E732E6D617844617465293F766F696420303A6F2E79656172293D3D3D742E696E6974446174652E796561722C633D752626286E756C6C3D3D28723D742E6F7074696F6E73';
wwv_flow_imp.g_varchar2_table(118) := '2E6D617844617465293F766F696420303A722E6D6F6E7468293D3D3D742E696E6974446174652E6D6F6E74682C703D21752626286E756C6C3D3D28613D742E6F7074696F6E732E6D696E44617465293F766F696420303A612E79656172293D3D3D742E69';
wwv_flow_imp.g_varchar2_table(119) := '6E6974446174652E796561722C6D3D21752626286E756C6C3D3D28733D742E6F7074696F6E732E6D696E44617465293F766F696420303A732E6D6F6E7468293D3D3D742E696E6974446174652E6D6F6E74682C663D753F742E6F7074696F6E732E706C75';
wwv_flow_imp.g_varchar2_table(120) := '7348746D6C3A742E6F7074696F6E732E6D696E757348746D6C3B6E3F28687C7C7029262628643D6474293A28682626637C7C7026266D29262628643D6474292C5274286C2B222E222B642C652C6D742C66756E6374696F6E28297B6E3F753F742E696E63';
wwv_flow_imp.g_varchar2_table(121) := '72656173655965617228293A742E64656372656173655965617228293A753F742E696E6372656173654D6F6E746828293A742E64656372656173654D6F6E746828297D2C662C2268746D6C22297D2C24743D66756E6374696F6E28742C652C6E297B5174';
wwv_flow_imp.g_varchar2_table(122) := '28742C652C6E2C22504C555322297D2C55743D66756E6374696F6E28742C652C6E297B517428742C652C6E2C224D494E555322297D2C47743D66756E6374696F6E2874297B72657475726E20742E7461726765742E76616C75657D2C4B743D66756E6374';
wwv_flow_imp.g_varchar2_table(123) := '696F6E2874297B76617220652C6E3D5274287A2C742E6470436F6E7461696E6572293B247428742C6E2C2130293B76617220693D527428712C6E293B557428742C6E2C2130293B766172206F3D6E756C6C213D28653D742E6F7074696F6E732E75736544';
wwv_flow_imp.g_varchar2_table(124) := '726F70646F776E5965617273293F653A742E6F7074696F6E732E75736544726F70446F776E59656172732C723D5274286F3F2273656C656374223A22696E707574222C692C226B65797570206368616E6765222C66756E6374696F6E2865297B76617220';
wwv_flow_imp.g_varchar2_table(125) := '6E3D4E756D626572284774286529293B6E3C3165337C7C6E3E3265337C7C742E796561724368616E6765286E297D293B6966286F297B722E7365744174747269627574652822746162696E646578222C222D3122293B666F722876617220613D66756E63';
wwv_flow_imp.g_varchar2_table(126) := '74696F6E2874297B76617220652C6E3B66756E6374696F6E20692874297B72657475726E203130302A4D6174682E726F756E6428742F313030297D766172206F3D742E696E6974446174652E796561723B72657475726E7B6D696E3A286E756C6C3D3D28';
wwv_flow_imp.g_varchar2_table(127) := '653D742E6F7074696F6E732E6D696E44617465293F766F696420303A652E79656172297C7C69286F2D323030292C6D61783A286E756C6C3D3D286E3D742E6F7074696F6E732E6D617844617465293F766F696420303A6E2E79656172297C7C69286F2B32';
wwv_flow_imp.g_varchar2_table(128) := '3030297D7D2874292C733D612E6D696E3B733C3D612E6D61783B732B2B297B76617220753D527428226F7074696F6E222C72293B752E76616C75653D732E746F537472696E6728292C752E746578743D7A7428732C742E6F7074696F6E732E7065727369';
wwv_flow_imp.g_varchar2_table(129) := '616E446967697473292E746F537472696E6728292C752E73656C65637465643D733D3D3D742E696E6974446174652E796561727D7D656C736520722E746162496E6465783D2D312C722E76616C75653D742E696E6974446174652E796561722E746F5374';
wwv_flow_imp.g_varchar2_table(130) := '72696E6728292C722E747970653D226E756D626572227D2C58743D66756E6374696F6E2874297B4B742874292C66756E6374696F6E2874297B76617220653D527428572C742E6470436F6E7461696E6572293B247428742C652C2131293B766172206E3D';
wwv_flow_imp.g_varchar2_table(131) := '527428462C65293B557428742C652C2131293B76617220693D5274282273656C656374222C6E2C63742C66756E6374696F6E2865297B742E6D6F6E74684368616E6765284E756D62657228477428652929297D293B692E746162496E6465783D2D313B66';
wwv_flow_imp.g_varchar2_table(132) := '6F7228766172206F3D66756E6374696F6E2874297B76617220653D742E696E6974446174652E796561722C6E3D742E6F7074696F6E732E6D696E446174652C693D742E6F7074696F6E732E6D6178446174652C6F3D5B5D2C723D312C613D31323B653D3D';
wwv_flow_imp.g_varchar2_table(133) := '3D286E756C6C3D3D6E3F766F696420303A6E2E79656172293F28723D6E2E6D6F6E74682C653D3D3D286E756C6C3D3D693F766F696420303A692E7965617229262628613D692E6D6F6E746829293A653D3D3D286E756C6C3D3D693F766F696420303A692E';
wwv_flow_imp.g_varchar2_table(134) := '7965617229262628723D312C613D692E6D6F6E7468293B666F722876617220733D723B733C3D613B732B2B296F2E707573682873293B72657475726E206F7D2874292C723D742E6F7074696F6E732E6D6F6E7468732C613D303B613C6F2E6C656E677468';
wwv_flow_imp.g_varchar2_table(135) := '3B612B2B297B76617220733D527428226F7074696F6E222C69293B732E76616C75653D6F5B615D2E746F537472696E6728292C732E746578743D7A7428725B6F5B615D2D315D2C742E6F7074696F6E732E7065727369616E446967697473292E746F5374';
wwv_flow_imp.g_varchar2_table(136) := '72696E6728292C732E73656C65637465643D6F5B615D3D3D3D742E696E6974446174652E6D6F6E74687D7D2874292C66756E6374696F6E2874297B666F722876617220653D527428512C742E6470436F6E7461696E6572292C693D5274284A2C742E6470';
wwv_flow_imp.g_varchar2_table(137) := '436F6E7461696E6572292C6F3D303B6F3C373B6F2B2B29527428582B4674286F292C652C766F696420302C766F696420302C7A7428742E6F7074696F6E732E646179735B6F5D2C742E6F7074696F6E732E7065727369616E446967697473292E746F5374';
wwv_flow_imp.g_varchar2_table(138) := '72696E672829293B666F722876617220723D66756E6374696F6E2865297B72657475726E21652E6461797C7C652E696E4265666F72654D6F6E74683F652E6461793D313A652E6461792B3D312C652E696E4265666F72654D6F6E74683D21312C652E696E';
wwv_flow_imp.g_varchar2_table(139) := '41667465724D6F6E74683D21312C652E697356616C69643D21312C652E6973486F6C696461793D21312C652E6973486F6C6C794461793D21312C652E636C6173734E616D653D22222C652E796561723D742E696E6974446174652E796561722C652E6D6F';
wwv_flow_imp.g_varchar2_table(140) := '6E74683D742E696E6974446174652E6D6F6E74682C652E7765656B4461793D6828652E796561722C652E6D6F6E74682C652E646179292C657D2C733D72287B7D292C753D6328732E796561722C732E6D6F6E7468292C643D732E7765656B4461792C6C3D';
wwv_flow_imp.g_varchar2_table(141) := '372A4D6174682E6365696C2828642B75292F37292D312C703D313D3D3D732E6D6F6E74683F31323A732E6D6F6E74682D312C6D3D31323D3D3D732E6D6F6E74683F313A732E6D6F6E74682B312C663D31323D3D3D703F732E796561722D313A732E796561';
wwv_flow_imp.g_varchar2_table(142) := '722C763D313D3D3D6D3F732E796561722B313A732E796561722C793D28313D3D3D732E6D6F6E74683F6328732E796561722D312C70293A6328732E796561722C7029292D642C673D302C773D66756E6374696F6E28297B732E696E4265666F72654D6F6E';
wwv_flow_imp.g_varchar2_table(143) := '74683D732E6461793C3D642626623C642C732E696E41667465724D6F6E74683D623E3D752B642C28732E696E4265666F72654D6F6E74687C7C732E696E41667465724D6F6E746829262628732E696E4265666F72654D6F6E74683F28792B2B2C732E6461';
wwv_flow_imp.g_varchar2_table(144) := '793D792C732E796561723D662C732E6D6F6E74683D70293A28672B2B2C732E6461793D672C732E796561723D762C732E6D6F6E74683D6D292C732E7765656B4461793D6828732E796561722C732E6D6F6E74682C732E64617929292C732E697356616C69';
wwv_flow_imp.g_varchar2_table(145) := '643D4428742C732E796561722C732E6D6F6E74682C732E646179292C732E636C6173734E616D653D4674286828732E796561722C732E6D6F6E74682C732E64617929292C732E636C6173734E616D652B3D4A7428742C73292C742E746F6461792E646179';
wwv_flow_imp.g_varchar2_table(146) := '3D3D3D732E6461792626742E746F6461792E796561723D3D3D732E796561722626742E746F6461792E6D6F6E74683D3D3D732E6D6F6E7468262628732E636C6173734E616D652B3D222E746F64617922292C6E28742E6F7074696F6E732E64617952656E';
wwv_flow_imp.g_varchar2_table(147) := '646572696E672926266128732C742E6F7074696F6E732E64617952656E646572696E6728732C742E696E70757429292C28732E6973486F6C696461797C7C732E6973486F6C6C7944617929262628732E636C6173734E616D652B3D222E222B6C74293B76';
wwv_flow_imp.g_varchar2_table(148) := '617220653D732E697356616C69643F243A473B28732E696E4265666F72654D6F6E74687C7C732E696E41667465724D6F6E746829262628653D552C732E697356616C69647C7C28653D4B29293B766172206F3D527428652B732E636C6173734E616D652C';
wwv_flow_imp.g_varchar2_table(149) := '692C766F696420302C766F696420302C7A7428732E6461792C742E6F7074696F6E732E7065727369616E446967697473292E746F537472696E672829293B6F2E6461793D732E6461792C6F2E6D6F6E74683D732E6D6F6E74682C6F2E796561723D732E79';
wwv_flow_imp.g_varchar2_table(150) := '6561722C732E697356616C696426266F2E6164644576656E744C697374656E6572286D742C66756E6374696F6E28297B742E73657456616C7565287B796561723A6F2E796561722C6D6F6E74683A6F2E6D6F6E74682C6461793A6F2E6461797D297D292C';
wwv_flow_imp.g_varchar2_table(151) := '722873297D2C623D303B623C3D6C3B622B2B297728297D2874297D2C5A743D66756E6374696F6E2874297B76617220652C6E3D52742865742C742E6470436F6E7461696E65722C766F696420302C766F696420302C766F69642030293B696628742E6F70';
wwv_flow_imp.g_varchar2_table(152) := '74696F6E732E74696D65262652742872742C6E2C6D742C66756E6374696F6E28297B742E636F6E6669726D56616C756528297D2C22D8AAD8A7DB8CDB8CD8AF22292C742E6F7074696F6E732E73686F77546F64617942746E2626742E6F7074696F6E732E';
wwv_flow_imp.g_varchar2_table(153) := '64617465297B76617220693D66756E6374696F6E2874297B72657475726E204428742C742E746F6461792E796561722C742E746F6461792E6D6F6E74682C742E746F6461792E646179297D2874292C6F3D742E6F7074696F6E732E74696D653F22D987D9';
wwv_flow_imp.g_varchar2_table(154) := '85E2808CD8A7DAA9D986D988D986223A22D8A7D985D8B1D988D8B2223B5274286E742B28693F22223A222E64697361626C65642D62746E22292C6E2C6D742C66756E6374696F6E28297B6966286929696628742E6F7074696F6E732E74696D65297B7661';
wwv_flow_imp.g_varchar2_table(155) := '7220653D756528293B742E73657456616C7565287B796561723A742E746F6461792E796561722C6D6F6E74683A742E746F6461792E6D6F6E74682C6461793A742E746F6461792E6461792C686F75723A652E686F75722C6D696E7574653A652E6D696E75';
wwv_flow_imp.g_varchar2_table(156) := '74652C7365636F6E643A652E7365636F6E647D297D656C736520742E73657456616C756528742E746F646179297D2C6F297D742E6F7074696F6E732E646174657C7C21742E6F7074696F6E732E74696D657C7C6E756C6C213D28653D742E696E70757429';
wwv_flow_imp.g_varchar2_table(157) := '2626652E76616C7565262621742E6F7074696F6E732E73686F7753656C65637454696D6542746E416C776179737C7C5274286E742C6E2C6D742C66756E6374696F6E28297B742E73657456616C756528742E696E697454696D65292C742E686964652829';
wwv_flow_imp.g_varchar2_table(158) := '7D2C22D8A7D986D8AAD8AED8A7D8A822292C742E6F7074696F6E732E73686F77456D70747942746E262652742869742C6E2C6D742C66756E6374696F6E28297B742E636C65616E56616C756528292C742E6F7074696F6E732E6869646541667465724368';
wwv_flow_imp.g_varchar2_table(159) := '616E67652626742E6869646528297D2C22D8AED8A7D984DB8C22292C742E6F7074696F6E732E73686F77436C6F736542746E26265274286F742C6E2C6D742C66756E6374696F6E28297B742E6869646528297D2C22D8A8D8B3D8AAD98622297D2C74653D';
wwv_flow_imp.g_varchar2_table(160) := '2F5E23283F3A5B302D39612D665D7B337D7C5B302D39612D665D7B347D7C5B302D39612D665D7B367D7C5B302D39612D665D7B387D29242F692C65653D66756E6374696F6E2874297B76617220653D742E5F6470436F6E7461696E65723B69662865297B';
wwv_flow_imp.g_varchar2_table(161) := '766172206E3D742E6F7074696F6E732E7468656D654D6F64652C693D226461726B223D3D3D6E7C7C226C69676874223D3D3D6E3F6E3A66756E6374696F6E2874297B7472797B666F722876617220653D742C6E3D742626742E6F776E6572446F63756D65';
wwv_flow_imp.g_varchar2_table(162) := '6E742E64656661756C74566965777C7C77696E646F773B652626313D3D3D652E6E6F6465547970653B297B76617220693D6E2E676574436F6D70757465645374796C652865292E6261636B67726F756E64436F6C6F722E6D61746368282F726762613F5C';
wwv_flow_imp.g_varchar2_table(163) := '28285B5E295D2B295C292F293B69662869297B766172206F3D695B315D2E73706C6974282F5B5C732C5C2F5D2B2F292E66696C74657228426F6F6C65616E292E6D6170287061727365466C6F6174293B696628286F2E6C656E6774683E333F6F5B335D3A';
wwv_flow_imp.g_varchar2_table(164) := '31293E2E352972657475726E282E3239392A6F5B305D2B2E3538372A6F5B315D2B2E3131342A6F5B325D292F3235353C2E34353F226461726B223A226C69676874227D653D652E706172656E74456C656D656E747D7D63617463682874297B7D7472797B';
wwv_flow_imp.g_varchar2_table(165) := '72657475726E2077696E646F772E6D617463684D65646961262677696E646F772E6D617463684D65646961282228707265666572732D636F6C6F722D736368656D653A206461726B2922292E6D6174636865733F226461726B223A226C69676874227D63';
wwv_flow_imp.g_varchar2_table(166) := '617463682874297B7D72657475726E226C69676874227D28742E696E707574293B652E7365744174747269627574652822646174612D6A64702D7468656D65222C69293B766172206F3D742E6F7074696F6E732E7072696D617279436F6C6F723B6F2626';
wwv_flow_imp.g_varchar2_table(167) := '74652E74657374286F293F28652E7374796C652E73657450726F706572747928222D2D6A64702D7072696D617279222C6F292C652E7374796C652E73657450726F706572747928222D2D6A64702D7072696D6172792D696E6B222C66756E6374696F6E28';
wwv_flow_imp.g_varchar2_table(168) := '74297B76617220653D742E736C6963652831293B652E6C656E6774683C3D34262628653D652E6368617241742830292B652E6368617241742830292B652E6368617241742831292B652E6368617241742831292B652E6368617241742832292B652E6368';
wwv_flow_imp.g_varchar2_table(169) := '61724174283229293B766172206E3D5B7061727365496E7428652E73756273747228302C32292C3136292C7061727365496E7428652E73756273747228322C32292C3136292C7061727365496E7428652E73756273747228342C32292C3136295D2E6D61';
wwv_flow_imp.g_varchar2_table(170) := '702866756E6374696F6E2874297B72657475726E28742F3D323535293C3D2E30333932383F742F31322E39323A4D6174682E706F772828742B2E303535292F312E3035352C322E34297D293B72657475726E2E323132362A6E5B305D2B2E373135322A6E';
wwv_flow_imp.g_varchar2_table(171) := '5B315D2B2E303732322A6E5B325D3E2E353F2223313131383237223A2223666666666666227D286F2929293A28652E7374796C652E72656D6F766550726F706572747928222D2D6A64702D7072696D61727922292C652E7374796C652E72656D6F766550';
wwv_flow_imp.g_varchar2_table(172) := '726F706572747928222D2D6A64702D7072696D6172792D696E6B2229297D7D2C6E653D66756E6374696F6E2874297B597428742E6470436F6E7461696E65722C2222292C65652874292C742E6F7074696F6E732E64617465262658742874292C742E6F70';
wwv_flow_imp.g_varchar2_table(173) := '74696F6E732E74696D65262666756E6374696F6E2874297B76617220653D61742B28742E6F7074696F6E732E74696D65262621742E6F7074696F6E732E646174653F222E6A64702D6F6E6C792D74696D65223A2222292C6E3D527428652C742E6470436F';
wwv_flow_imp.g_varchar2_table(174) := '6E7461696E6572293B742E6F7074696F6E732E6861735365636F6E642626577428742C6E2C227365636F6E6422292C577428742C6E2C226D696E75746522292C577428742C6E2C22686F757222297D2874292C5A742874297D3B7661722069653D2F6970';
wwv_flow_imp.g_varchar2_table(175) := '686F6E657C69706F647C616E64726F69647C69657C626C61636B62657272797C66656E6E65632F2E74657374286E756C6C3D3D28743D77696E646F772E6E6176696761746F72297C7C6E756C6C3D3D28743D742E757365724167656E74293F766F696420';
wwv_flow_imp.g_varchar2_table(176) := '303A742E746F4C6F776572436173652829292C6F653D66756E6374696F6E28742C65297B72657475726E206E3D652E73706C697428742E6F7074696F6E732E736570617261746F7243686172732E74696D65292C693D742E6F7074696F6E732E68617353';
wwv_flow_imp.g_varchar2_table(177) := '65636F6E642C43286E2C69293F7B686F75723A7061727365496E74286E5B305D2C3130292C6D696E7574653A7061727365496E74286E5B315D2C3130292C7365636F6E643A7061727365496E74286E5B325D2C3130297C7C307D3A6E756C6C3B76617220';
wwv_flow_imp.g_varchar2_table(178) := '6E2C697D2C72653D66756E6374696F6E28742C652C72297B76617220613D66756E6374696F6E286E2C69297B766172206F2C723D745B6E5D2C613D655B6E5D2C733D49742E696E6465784F66286E293E2D312626723D3D3D79743F652E746F6461793A72';
wwv_flow_imp.g_varchar2_table(179) := '2C753D4F626A6563742E6765744F776E50726F706572747944657363726970746F7228652C6E293B6E756C6C213D752626752E676574262621752E736574262664656C65746520655B6E5D2C655B6E5D3D6E756C6C213D286F3D6E756C6C213D733F733A';
wwv_flow_imp.g_varchar2_table(180) := '61293F6F3A697D2C733D66756E6374696F6E2874297B6966282274617267657456616C7565496E707574223D3D3D742972657475726E2066756E6374696F6E28297B76617220743B72657475726E206E756C6C3D3D28743D722E696E707574293F766F69';
wwv_flow_imp.g_varchar2_table(181) := '6420303A742E676574417474726962757465284474297D3B6966282274617267657456616C756554797065223D3D3D742972657475726E2066756E6374696F6E28297B76617220743B72657475726E206E756C6C3D3D28743D722E696E707574293F766F';
wwv_flow_imp.g_varchar2_table(182) := '696420303A742E676574417474726962757465286274297D3B696628226D6F6465223D3D3D742972657475726E2066756E6374696F6E28297B76617220742C653B72657475726E28653D6E756C6C3D3D28743D722E696E707574293F766F696420303A74';
wwv_flow_imp.g_varchar2_table(183) := '2E676574417474726962757465285F74292926266A742E696E6465784F662865293E2D313F653A2273696E676C65227D3B696628226861735365636F6E64223D3D3D742972657475726E2066756E6374696F6E28297B76617220742C652C6E3B72657475';
wwv_flow_imp.g_varchar2_table(184) := '726E20653D6E756C6C3D3D28743D722E696E707574293F766F696420303A742E6765744174747269627574652841742E6861735365636F6E64292C6E3D21302C6E756C6C3D3D657C7C22223D3D3D653F6E3A2266616C736522213D3D657D3B7661722065';
wwv_flow_imp.g_varchar2_table(185) := '3D41745B745D2C6E3D56742E696E6465784F662874293E2D313B72657475726E2066756E6374696F6E28297B72657475726E2066756E6374696F6E28742C65297B766172206E2C613D6E756C6C3D3D286E3D722E696E707574293F766F696420303A6E2E';
wwv_flow_imp.g_varchar2_table(186) := '6765744174747269627574652874293B69662821652626613D3D3D79742972657475726E206F28722E746F646179293B69662821692861292972657475726E7B7D3B7472797B613D646F63756D656E742E717565727953656C6563746F722861292E7661';
wwv_flow_imp.g_varchar2_table(187) := '6C75657D63617463682874297B7D72657475726E20653F5628722C61293F5328722C61293A6F6528722C61297C7C7B7D3A4128722C61293F5328722C61293A7B7D7D28652C6E297D7D3B66756E6374696F6E2075286E297B696628745B6E5D3D3D3D6774';
wwv_flow_imp.g_varchar2_table(188) := '7C7C2264617465223D3D3D6E7C7C2274696D65223D3D3D6E297B226461746522213D3D6E26262274696D6522213D3D6E262664656C65746520655B6E5D3B76617220693D66756E6374696F6E28297B72657475726E7B7D7D3B6966282264617465223D3D';
wwv_flow_imp.g_varchar2_table(189) := '3D6E297B766172206F2C753D6E756C6C213D286F3D742E64617465293F6F3A652E646174653B64656C65746520655B6E5D2C693D66756E6374696F6E28297B76617220742C653B72657475726E21286E756C6C213D28743D722E696E707574292626742E';
wwv_flow_imp.g_varchar2_table(190) := '6861734174747269627574652854742929262628757C7C286E756C6C3D3D28653D722E696E707574293F766F696420303A652E6861734174747269627574652853742929297D7D656C7365206966282274696D65223D3D3D6E297B76617220642C6C3D6E';
wwv_flow_imp.g_varchar2_table(191) := '756C6C213D28643D742E74696D65293F643A652E74696D653B64656C65746520655B6E5D2C693D66756E6374696F6E28297B76617220742C653B72657475726E21286E756C6C213D28743D722E696E707574292626742E68617341747472696275746528';
wwv_flow_imp.g_varchar2_table(192) := '537429292626286C7C7C286E756C6C3D3D28653D722E696E707574293F766F696420303A652E6861734174747269627574652854742929297D7D656C736520693D73286E293B77696E646F772E4F626A6563742E646566696E6550726F70657274792865';
wwv_flow_imp.g_varchar2_table(193) := '2C6E2C7B6765743A692C656E756D657261626C653A21302C636F6E666967757261626C653A21307D297D656C73657B76617220683D655B6E5D3B64656C65746520655B6E5D2C61286E2C68297D72657475726E20657D72657475726E20612822636F6E74';
wwv_flow_imp.g_varchar2_table(194) := '61696E6572222C22626F647922292C61282273656C6563746F72222C22696E7075745B646174612D6A64705D22292C6128227A496E646578222C316535292C6128226175746F53686F77222C2130292C6128226175746F48696465222C2130292C612822';
wwv_flow_imp.g_varchar2_table(195) := '6175746F526561644F6E6C79496E707574222C6965292C612822746F705370616365222C30292C612822626F74746F6D5370616365222C30292C6128226F766572666C6F775370616365222C2D3130292C6128226869646541667465724368616E676522';
wwv_flow_imp.g_varchar2_table(196) := '2C2130292C6128226869646541667465724368616E67655769746854696D65222C2131292C6128226368616E67654D6F6E7468526F7461746559656172222C2131292C61282273686F77546F64617942746E222C2130292C61282273686F77456D707479';
wwv_flow_imp.g_varchar2_table(197) := '42746E222C2130292C61282273686F77436C6F736542746E222C6965292C612822636F6E6669726D427574746F6E222C2130292C6128227072696D617279436F6C6F72222C2222292C6128227468656D654D6F6465222C226175746F22292C6128227368';
wwv_flow_imp.g_varchar2_table(198) := '6F7753656C65637454696D6542746E416C77617973222C2131292C6128226861735365636F6E64222C2130292C61282264617465222C2130292C61282274696D65222C2131292C61282264617973222C4574292C6128226D6F6E746873222C7874292C61';
wwv_flow_imp.g_varchar2_table(199) := '2822736570617261746F724368617273222C4D74292C6128227065727369616E446967697473222C2131292C612822706C757348746D6C222C273C7376672076696577426F783D2230203020313032342031303234223E3C673E3C7061746820643D224D';
wwv_flow_imp.g_varchar2_table(200) := '38313020353534682D32353676323536682D3834762D323536682D323536762D383468323536762D32353668383476323536683235367638347A223E3C2F706174683E3C2F673E3C2F7376673E27292C6128226D696E757348746D6C222C273C73766720';
wwv_flow_imp.g_varchar2_table(201) := '76696577426F783D2230203020313032342031303234223E3C673E3C7061746820643D224D38313020353534682D353936762D3834683539367638347A223E3C2F706174683E3C2F673E3C2F7376673E27292C766F69642030213D3D742E75736544726F';
wwv_flow_imp.g_varchar2_table(202) := '70446F776E59656172732626766F696420303D3D3D742E75736544726F70646F776E5965617273262628652E75736544726F70646F776E59656172733D742E75736544726F70446F776E5965617273292C61282275736544726F70646F776E5965617273';
wwv_flow_imp.g_varchar2_table(203) := '222C2130292C652E75736544726F70446F776E59656172733D652E75736544726F70646F776E59656172732C612822746F646179222C6C2829292C612822706F736974696F6E222C226C65667422292C6128226D696E757465496E6372656D656E74222C';
wwv_flow_imp.g_varchar2_table(204) := '31292C612822686F7572496E6372656D656E74222C31292C6128226D6F6465222C2273696E676C6522292C61282272616E6765536570617261746F72222C22202D2022292C6128226D756C7469706C65536570617261746F72222C222C2022292C6E2874';
wwv_flow_imp.g_varchar2_table(205) := '2E64617952656E646572696E6729262628652E64617952656E646572696E673D742E64617952656E646572696E67292C742E696E697454696D652626742E696E697454696D65213D3D79742626742E696E697454696D65213D3D6774262628652E696E69';
wwv_flow_imp.g_varchar2_table(206) := '7454696D653D742E696E697454696D65292C742E696E6974446174653D3D3D7974262628652E696E6974446174653D652E746F646179292C742E6D696E446174653D3D3D7974262628652E6D696E446174653D652E746F646179292C742E6D6178446174';
wwv_flow_imp.g_varchar2_table(207) := '653D3D3D7974262628652E6D6178446174653D652E746F646179292C653D75282274696D6522292C653D7528226461746522292C653D752822696E69744461746522292C653D7528226D696E4461746522292C653D7528226D61784461746522292C653D';
wwv_flow_imp.g_varchar2_table(208) := '7528226D696E54696D6522292C653D7528226D617854696D6522292C653D75282274617267657456616C7565496E70757422292C653D75282274617267657456616C75655479706522292C653D7528226D6F646522292C653D7528226861735365636F6E';
wwv_flow_imp.g_varchar2_table(209) := '6422297D2C61653D66756E6374696F6E28297B66756E6374696F6E207428742C65297B746869732E636F6E7461696E65723D766F696420302C746869732E73656C6563746F723D766F696420302C746869732E7A496E6465783D766F696420302C746869';
wwv_flow_imp.g_varchar2_table(210) := '732E6175746F53686F773D766F696420302C746869732E6175746F486964653D766F696420302C746869732E6175746F526561644F6E6C79496E7075743D766F696420302C746869732E746F7053706163653D766F696420302C746869732E626F74746F';
wwv_flow_imp.g_varchar2_table(211) := '6D53706163653D766F696420302C746869732E6F766572666C6F7753706163653D766F696420302C746869732E6869646541667465724368616E67653D766F696420302C746869732E6869646541667465724368616E67655769746854696D653D766F69';
wwv_flow_imp.g_varchar2_table(212) := '6420302C746869732E6368616E67654D6F6E7468526F74617465596561723D766F696420302C746869732E73686F77546F64617942746E3D766F696420302C746869732E73686F77456D70747942746E3D766F696420302C746869732E73686F77436C6F';
wwv_flow_imp.g_varchar2_table(213) := '736542746E3D766F696420302C746869732E636F6E6669726D427574746F6E3D766F696420302C746869732E7072696D617279436F6C6F723D766F696420302C746869732E7468656D654D6F64653D766F696420302C746869732E73686F7753656C6563';
wwv_flow_imp.g_varchar2_table(214) := '7454696D6542746E416C776179733D766F696420302C746869732E64617952656E646572696E673D766F696420302C746869732E6D696E446174653D766F696420302C746869732E6D6178446174653D766F696420302C746869732E696E697444617465';
wwv_flow_imp.g_varchar2_table(215) := '3D766F696420302C746869732E6D696E54696D653D766F696420302C746869732E6D617854696D653D766F696420302C746869732E696E697454696D653D766F696420302C746869732E646174653D766F696420302C746869732E74696D653D766F6964';
wwv_flow_imp.g_varchar2_table(216) := '20302C746869732E746F6461793D766F696420302C746869732E6861735365636F6E643D766F696420302C746869732E74617267657456616C7565496E7075743D766F696420302C746869732E74617267657456616C7565547970653D766F696420302C';
wwv_flow_imp.g_varchar2_table(217) := '746869732E646179733D766F696420302C746869732E6D6F6E7468733D766F696420302C746869732E736570617261746F7243686172733D766F696420302C746869732E7065727369616E4469676974733D766F696420302C746869732E706C75734874';
wwv_flow_imp.g_varchar2_table(218) := '6D6C3D766F696420302C746869732E6D696E757348746D6C3D766F696420302C746869732E75736544726F70646F776E59656172733D766F696420302C746869732E75736544726F70446F776E59656172733D766F696420302C746869732E706F736974';
wwv_flow_imp.g_varchar2_table(219) := '696F6E3D766F696420302C746869732E6D696E757465496E6372656D656E743D766F696420302C746869732E686F7572496E6372656D656E743D766F696420302C746869732E6D6F64653D766F696420302C746869732E72616E6765536570617261746F';
wwv_flow_imp.g_varchar2_table(220) := '723D766F696420302C746869732E6D756C7469706C65536570617261746F723D766F696420302C726528747C7C7B7D2C7228652E6F7074696F6E73293F746869733A652E6F7074696F6E732C65297D72657475726E20742E70726F746F747970652E7570';
wwv_flow_imp.g_varchar2_table(221) := '646174653D66756E6374696F6E28742C65297B726528747C7C7B7D2C746869732C65297D2C747D28292C73653D7B696E69743A66756E6374696F6E2874297B746869732E7570646174654F7074696F6E732874292C456C656D656E742E70726F746F7479';
wwv_flow_imp.g_varchar2_table(222) := '70652E6D6174636865733D456C656D656E742E70726F746F747970652E6D6174636865737C7C456C656D656E742E70726F746F747970652E6D61746368657353656C6563746F727C7C456C656D656E742E70726F746F747970652E6D6F7A4D6174636865';
wwv_flow_imp.g_varchar2_table(223) := '7353656C6563746F727C7C456C656D656E742E70726F746F747970652E6D734D61746368657353656C6563746F727C7C456C656D656E742E70726F746F747970652E6F4D61746368657353656C6563746F727C7C456C656D656E742E70726F746F747970';
wwv_flow_imp.g_varchar2_table(224) := '652E7765626B69744D61746368657353656C6563746F722C77696E646F772E72656D6F76654576656E744C697374656E65722822726573697A65222C6665292C77696E646F772E6164644576656E744C697374656E65722822726573697A65222C666529';
wwv_flow_imp.g_varchar2_table(225) := '2C646F63756D656E742E626F64792E72656D6F76654576656E744C697374656E65722822636C69636B222C7765292C646F63756D656E742E626F64792E6164644576656E744C697374656E65722822636C69636B222C7765292C646F63756D656E742E72';
wwv_flow_imp.g_varchar2_table(226) := '656D6F76654576656E744C697374656E65722822636C69636B222C79652C2130292C646F63756D656E742E6164644576656E744C697374656E65722822636C69636B222C79652C2130292C66756E6374696F6E2874297B696628646F63756D656E742E62';
wwv_flow_imp.g_varchar2_table(227) := '6F64792E72656D6F76654576656E744C697374656E65722866742C7665292C21742972657475726E3B646F63756D656E742E626F64792E6164644576656E744C697374656E65722866742C7665297D28746869732E6F7074696F6E732E73656C6563746F';
wwv_flow_imp.g_varchar2_table(228) := '72297D2C7570646174654F7074696F6E733A66756E6374696F6E2874297B7228746869732E6F7074696F6E73293F746869732E6F7074696F6E733D6E657720616528742C74686973293A746869732E6F7074696F6E732E75706461746528742C74686973';
wwv_flow_imp.g_varchar2_table(229) := '292C636528297D2C6F7074696F6E733A7B7D2C696E7075743A6E756C6C2C69735472616E736974696F6E696E673A21312C676574206470436F6E7461696E657228297B72657475726E20746869732E5F6470436F6E7461696E65722626746869732E5F64';
wwv_flow_imp.g_varchar2_table(230) := '70436F6E7461696E65722E6973436F6E6E65637465647C7C28746869732E5F6470436F6E7461696E65723D527428592C4E28746869732E6F7074696F6E732E636F6E7461696E657229292C746869732E5F6470436F6E7461696E65722E73657441747472';
wwv_flow_imp.g_varchar2_table(231) := '69627574652822746162696E646578222C222D312229292C746869732E6F7665726C6179456C656D656E742626746869732E6F7665726C6179456C656D656E742E6973436F6E6E65637465647C7C28746869732E6F7665726C6179456C656D656E743D52';
wwv_flow_imp.g_varchar2_table(232) := '7428522C4E28746869732E6F7074696F6E732E636F6E7461696E65722929292C636528292C746869732E5F6470436F6E7461696E65727D2C67657420746F64617928297B72657475726E20746869732E5F746F6461793D746869732E5F746F6461797C7C';
wwv_flow_imp.g_varchar2_table(233) := '746869732E6F7074696F6E732E746F6461797C7C6C28292C746869732E5F746F6461797D2C67657420696E70757456616C756528297B76617220742C653D286E756C6C3D3D28743D746869732E696E707574293F766F696420303A742E76616C7565297C';
wwv_flow_imp.g_varchar2_table(234) := '7C22223B72657475726E2066756E6374696F6E28742C65297B69662821652972657475726E21313B766172206E3D742E6F7074696F6E732E736570617261746F7243686172732C693D66286E2E64617465292C6F3D66286E2E74696D65292C723D66286E';
wwv_flow_imp.g_varchar2_table(235) := '2E6265747765656E292C613D742E6F7074696F6E732E646174653F225C5C647B347D222B692B225C5C647B327D222B692B225C5C647B327D223A22222C733D742E6F7074696F6E732E74696D653F225C5C647B327D222B6F2B225C5C647B327D222B2874';
wwv_flow_imp.g_varchar2_table(236) := '2E6F7074696F6E732E6861735365636F6E643F6F2B225C5C647B327D223A2222293A22223B72657475726E206E65772052656745787028225E222B612B28612626733F723A2222292B732B222422292E746573742865297D28746869732C65297C7C4128';
wwv_flow_imp.g_varchar2_table(237) := '746869732C65293F5328746869732C65293A7B7D7D2C67657420696E69744461746528297B72657475726E20746869732E6F7074696F6E732E696E6974446174653F746869732E6F7074696F6E732E696E6974446174653A28746869732E5F696E697444';
wwv_flow_imp.g_varchar2_table(238) := '6174657C7C28746869732E5F696E6974446174653D6728746869732C66756E6374696F6E2874297B76617220652C6E3D286E756C6C3D3D28653D742E696E707574293F766F696420303A652E76616C7565297C7C22223B696628216E2972657475726E20';
wwv_flow_imp.g_varchar2_table(239) := '742E6F7074696F6E732E696E6974446174657C7C6F28742E746F646179293B6966284128742C6E292972657475726E205328742C6E293B72657475726E206F28742E746F646179297D28746869732929292C746869732E5F696E697444617465297D2C67';
wwv_flow_imp.g_varchar2_table(240) := '657420696E697454696D6528297B72657475726E20746869732E5F696E697454696D657C7C28746869732E5F696E697454696D653D7728746869732C66756E6374696F6E2874297B76617220652C6E3D756528292C6F3D286E756C6C3D3D28653D742E69';
wwv_flow_imp.g_varchar2_table(241) := '6E707574293F766F696420303A652E76616C7565297C7C742E6F7074696F6E732E696E697454696D657C7C6E3B6966282169286F292972657475726E206F3B6966285628742C6F292972657475726E205328742C6F293B72657475726E206E7D28746869';
wwv_flow_imp.g_varchar2_table(242) := '732929292C746869732E5F696E697454696D657D2C5F647261773A66756E6374696F6E28297B6E652874686973297D2C73686F773A66756E6374696F6E2874297B76617220653D746869733B746869732E72657665727450656E64696E6728292C646528';
wwv_flow_imp.g_varchar2_table(243) := '74686973292C746869732E696E7075743D742C746869732E5F636F6D6D69747465643D742E76616C75652C746869732E5F70656E64696E673D21312C6C652874686973292C746869732E5F6472617728292C66756E6374696F6E28742C65297B652E6175';
wwv_flow_imp.g_varchar2_table(244) := '746F526561644F6E6C79496E707574262621742E726561644F6E6C79262628742E7365744174747269627574652822726561646F6E6C79222C22726561646F6E6C7922292C742E726561644F6E6C793D2130297D28742C746869732E6F7074696F6E7329';
wwv_flow_imp.g_varchar2_table(245) := '2C746869732E69735472616E736974696F6E696E673D21302C686528746869732C2130292C73657454696D656F75742866756E6374696F6E28297B686528652C2130292C652E697353686F773D21302C652E69735472616E736974696F6E696E673D2131';
wwv_flow_imp.g_varchar2_table(246) := '7D2C333030292C746869732E736574506F736974696F6E28292C66756E6374696F6E2874297B6D6528292C73652E5F7363726F6C6C506172656E743D50742874292C73652E5F7363726F6C6C48616E646C65723D70652C73652E5F7363726F6C6C506172';
wwv_flow_imp.g_varchar2_table(247) := '656E742E6164644576656E744C697374656E657228227363726F6C6C222C73652E5F7363726F6C6C48616E646C65722C2131297D2874292C646F63756D656E742E6164644576656E744C697374656E65722876742C4465292C66756E6374696F6E28297B';
wwv_flow_imp.g_varchar2_table(248) := '76617220743D73652E5F6470436F6E7461696E65723B696628742626742E6F776E6572446F63756D656E74213D3D646F63756D656E74297B5028293B76617220653D4C28293B7472797B652E646F63756D656E742E6164644576656E744C697374656E65';
wwv_flow_imp.g_varchar2_table(249) := '722822636C69636B222C67652C2130292C652E646F63756D656E742E6164644576656E744C697374656E65722876742C4465292C652E6164644576656E744C697374656E65722822726573697A65222C6665292C4F2E77696E3D652C4F2E6672616D653D';
wwv_flow_imp.g_varchar2_table(250) := '77696E646F772E6672616D65456C656D656E742C4F2E74696D65723D652E736574496E74657276616C2866756E6374696F6E28297B76617220743D4F2E6672616D652C653D21303B7472797B653D21747C7C21742E6973436F6E6E65637465647C7C303D';
wwv_flow_imp.g_varchar2_table(251) := '3D3D742E676574436C69656E74526563747328292E6C656E6774687D63617463682874297B7D6526264228297D2C323030297D63617463682874297B7D77696E646F772E72656D6F76654576656E744C697374656E657228227061676568696465222C42';
wwv_flow_imp.g_varchar2_table(252) := '292C77696E646F772E6164644576656E744C697374656E657228227061676568696465222C42297D7D28297D2C686964653A66756E6374696F6E28297B696628746869732E5F70656E64696E67297B76617220743D746869732E696E7075743B74262628';
wwv_flow_imp.g_varchar2_table(253) := '746869732E5F70656E64696E673D21312C746869732E5F636F6D6D69747465643D742E76616C75652C6B7428742C6874292C746869732E73657454617267657456616C75652829297D656C736520746869732E72657665727450656E64696E6728293B50';
wwv_flow_imp.g_varchar2_table(254) := '28292C686528746869732C2131292C746869732E697353686F773D21312C6D6528292C646F63756D656E742E72656D6F76654576656E744C697374656E65722876742C4465297D2C736574506F736974696F6E3A66756E6374696F6E28297B6966287468';
wwv_flow_imp.g_varchar2_table(255) := '69732E696E7075742626746869732E6470436F6E7461696E65722E7374796C652E7669736962696C6974793D3D3D4C74297B76617220743D746869732E5F6470436F6E7461696E65722626746869732E5F6470436F6E7461696E65722E6F776E6572446F';
wwv_flow_imp.g_varchar2_table(256) := '63756D656E74213D3D646F63756D656E742C653D743F4C28293A77696E646F772C6E3D743F66756E6374696F6E28297B76617220743D302C653D302C6E3D77696E646F773B7472797B666F72283B6E213D3D6E2E746F7026266E2E6672616D65456C656D';
wwv_flow_imp.g_varchar2_table(257) := '656E743B297B76617220693D6E2E6672616D65456C656D656E742E676574426F756E64696E67436C69656E745265637428292C6F3D6E2E706172656E742E676574436F6D70757465645374796C65286E2E6672616D65456C656D656E74293B742B3D692E';
wwv_flow_imp.g_varchar2_table(258) := '6C6566742B287061727365466C6F6174286F2E626F726465724C6566745769647468297C7C30292B287061727365466C6F6174286F2E70616464696E674C656674297C7C30292C652B3D692E746F702B287061727365466C6F6174286F2E626F72646572';
wwv_flow_imp.g_varchar2_table(259) := '546F705769647468297C7C30292B287061727365466C6F6174286F2E70616464696E67546F70297C7C30292C6E3D6E2E706172656E747D7D63617463682874297B7D72657475726E7B783A742C793A657D7D28293A7B783A302C793A307D2C693D746869';
wwv_flow_imp.g_varchar2_table(260) := '732E696E7075742E676574426F756E64696E67436C69656E745265637428292C6F3D692E6865696768742C723D692E6C6566742B6E2E782C613D692E746F702B6E2E792B6F3B746869732E6F7074696F6E732E746F705370616365262628612B3D746869';
wwv_flow_imp.g_varchar2_table(261) := '732E6F7074696F6E732E746F705370616365293B76617220733D652E646F63756D656E742E626F64792E6F666673657457696474682C753D746869732E6470436F6E7461696E65722E6F666673657457696474682C643D746869732E6470436F6E746169';
wwv_flow_imp.g_varchar2_table(262) := '6E65722E6F66667365744865696768742C6C3D746869732E6F7074696F6E732E706F736974696F6E3B227269676874223D3D3D6C3F28723D722B692E77696474682D75292B753E3D73262628722D3D722B752D28732B28746869732E6F7074696F6E732E';
wwv_flow_imp.g_varchar2_table(263) := '6F766572666C6F7753706163657C7C302929293A2263656E746572223D3D3D6C262628723D722B692E77696474682F322D752F32292B753E3D73262628722D3D722B752D28732B28746869732E6F7074696F6E732E6F766572666C6F7753706163657C7C';
wwv_flow_imp.g_varchar2_table(264) := '302929292C722B753E3D73262628722D3D722B752D28732B28746869732E6F7074696F6E732E6F766572666C6F7753706163657C7C302929292C723C30262628723D30292C612D6F3E3D642626612B643E3D652E696E6E6572486569676874262628612D';
wwv_flow_imp.g_varchar2_table(265) := '3D642B6F2B28746869732E6F7074696F6E732E626F74746F6D53706163657C7C30292B28746869732E6F7074696F6E732E746F7053706163657C7C3029292C746869732E6470436F6E7461696E65722E7374796C652E706F736974696F6E3D2266697865';
wwv_flow_imp.g_varchar2_table(266) := '64222C746869732E6470436F6E7461696E65722E7374796C652E6C6566743D722B227078222C746869732E6470436F6E7461696E65722E7374796C652E746F703D612B227078227D7D2C6765742067657456616C756528297B72657475726E2074686973';
wwv_flow_imp.g_varchar2_table(267) := '2E5F76616C75653D746869732E5F76616C75657C7C746869732E696E70757456616C75657C7C7B7D2C746869732E5F76616C75657D2C73657456616C75653A66756E6374696F6E2874297B696628746869732E6F7074696F6E732E646174652626227369';
wwv_flow_imp.g_varchar2_table(268) := '6E676C6522213D3D28746869732E6F7074696F6E732E6D6F64657C7C2273696E676C652229262628226E756D626572223D3D747970656F6628653D74292E796561722626226E756D626572223D3D747970656F6620652E6D6F6E74682626226E756D6265';
wwv_flow_imp.g_varchar2_table(269) := '72223D3D747970656F6620652E64617929292166756E6374696F6E28742C65297B2272616E6765223D3D3D28742E6F7074696F6E732E6D6F64657C7C2273696E676C6522293F66756E6374696F6E28742C65297B69662821742E73656C65637465644461';
wwv_flow_imp.g_varchar2_table(270) := '7465732E6C656E6774687C7C323D3D3D742E73656C656374656444617465732E6C656E6774682972657475726E20766F696428742E73656C656374656444617465733D5B655D293B742E73656C656374656444617465733D78285B742E73656C65637465';
wwv_flow_imp.g_varchar2_table(271) := '6444617465735B305D2C655D297D28742C65293A66756E6374696F6E28742C65297B666F7228766172206E3D5B5D2C693D21302C6F3D303B6F3C742E73656C656374656444617465732E6C656E6774683B6F2B2B294528742E73656C6563746564446174';
wwv_flow_imp.g_varchar2_table(272) := '65735B6F5D2C65293F693D21313A6E2E7075736828742E73656C656374656444617465735B6F5D293B6926266E2E707573682865293B742E73656C656374656444617465733D78286E297D28742C65293B2166756E6374696F6E2874297B742E696E7075';
wwv_flow_imp.g_varchar2_table(273) := '74262628742E696E7075742E76616C75653D4D28742C742E73656C65637465644461746573292C6B7428742E696E7075742C687429293B742E73657454617267657456616C756528292C2272616E6765223D3D3D28742E6F7074696F6E732E6D6F64657C';
wwv_flow_imp.g_varchar2_table(274) := '7C2273696E676C6522292626323D3D3D742E73656C656374656444617465732E6C656E6774682626742E6F7074696F6E732E6869646541667465724368616E67653F742E6869646528293A742E5F6472617728297D2874297D28746869732C74293B656C';
wwv_flow_imp.g_varchar2_table(275) := '73657B76617220653B746869732E5F76616C75653D61287B796561723A746869732E746F6461792E796561722C6D6F6E74683A746869732E746F6461792E6D6F6E74682C6461793A746869732E746F6461792E6461792C686F75723A746869732E696E69';
wwv_flow_imp.g_varchar2_table(276) := '7454696D652E686F75722C6D696E7574653A746869732E696E697454696D652E6D696E7574652C7365636F6E643A746869732E696E697454696D652E7365636F6E647D2C6128746869732E5F76616C75657C7C7B7D2C7429292C746869732E5F696E6974';
wwv_flow_imp.g_varchar2_table(277) := '54696D653D6E756C6C3B766172206E2C692C6F3D2121746869732E6F7074696F6E732E636F6E6669726D427574746F6E3B696628746869732E696E707574262628746869732E696E7075742E76616C75653D286E3D746869732C693D746869732E5F7661';
wwv_flow_imp.g_varchar2_table(278) := '6C75652C54286E2C6929292C6F3F746869732E5F70656E64696E673D21303A6B7428746869732E696E7075742C687429292C6F7C7C746869732E73657454617267657456616C756528292C6F297B696628746869732E5F6472617728292C21746869732E';
wwv_flow_imp.g_varchar2_table(279) := '6F7074696F6E732E74696D652972657475726E20766F696420746869732E636F6E6669726D56616C756528297D656C736521746869732E6F7074696F6E732E6869646541667465724368616E67657C7C746869732E6F7074696F6E732E74696D65262621';
wwv_flow_imp.g_varchar2_table(280) := '746869732E6F7074696F6E732E6869646541667465724368616E67655769746854696D653F746869732E5F6472617728293A746869732E6869646528297D7D2C636F6E6669726D56616C75653A66756E6374696F6E28297B76617220743D746869732E69';
wwv_flow_imp.g_varchar2_table(281) := '6E7075743B742626746869732E5F70656E64696E67262628746869732E5F70656E64696E673D21312C746869732E5F636F6D6D69747465643D742E76616C75652C6B7428742C6874292C746869732E73657454617267657456616C75652829292C746869';
wwv_flow_imp.g_varchar2_table(282) := '732E6869646528297D2C72657665727450656E64696E673A66756E6374696F6E28297B746869732E5F70656E64696E672626746869732E696E707574262628746869732E696E7075742E76616C75653D746869732E5F636F6D6D69747465647C7C222229';
wwv_flow_imp.g_varchar2_table(283) := '2C746869732E5F70656E64696E673D21317D2C636C65616E56616C75653A66756E6374696F6E28297B746869732E5F70656E64696E673D21312C746869732E5F636F6D6D69747465643D22222C746869732E73656C656374656444617465733D5B5D2C74';
wwv_flow_imp.g_varchar2_table(284) := '6869732E696E707574262628746869732E696E7075742E76616C75653D22222C6B7428746869732E696E7075742C687429292C746869732E73657454617267657456616C756528297D2C73657454617267657456616C75653A66756E6374696F6E28297B';
wwv_flow_imp.g_varchar2_table(285) := '696628746869732E6F7074696F6E732E74617267657456616C7565496E707574297B76617220743D746869732E6F7074696F6E732E74617267657456616C7565496E70757420696E7374616E63656F662048544D4C456C656D656E743F5B746869732E6F';
wwv_flow_imp.g_varchar2_table(286) := '7074696F6E732E74617267657456616C7565496E7075745D3A646F63756D656E742E717565727953656C6563746F72416C6C28746869732E6F7074696F6E732E74617267657456616C7565496E707574293B696628742626742E6C656E67746829666F72';
wwv_flow_imp.g_varchar2_table(287) := '2876617220653D303B653C742E6C656E6774683B652B2B297B745B655D2E76616C75653D6A2874686973297D7D7D2C696E6372656173654D6F6E74683A66756E6374696F6E28297B696628746869732E5F696E697444617465297B76617220743D31323D';
wwv_flow_imp.g_varchar2_table(288) := '3D3D746869732E5F696E6974446174652E6D6F6E74683B746869732E6F7074696F6E732E6368616E67654D6F6E7468526F74617465596561722626742626746869732E696E6372656173655965617228292C746869732E6D6F6E74684368616E67652874';
wwv_flow_imp.g_varchar2_table(289) := '3F313A746869732E5F696E6974446174652E6D6F6E74682B31297D7D2C64656372656173654D6F6E74683A66756E6374696F6E28297B696628746869732E5F696E697444617465297B76617220743D313D3D3D746869732E5F696E6974446174652E6D6F';
wwv_flow_imp.g_varchar2_table(290) := '6E74683B746869732E6F7074696F6E732E6368616E67654D6F6E7468526F74617465596561722626742626746869732E64656372656173655965617228292C746869732E6D6F6E74684368616E676528743F31323A746869732E5F696E6974446174652E';
wwv_flow_imp.g_varchar2_table(291) := '6D6F6E74682D31297D7D2C6D6F6E74684368616E67653A66756E6374696F6E2874297B746869732E5F696E697444617465262628746869732E5F696E6974446174653D6728746869732C746869732E5F696E6974446174652C7B6D6F6E74683A747D292C';
wwv_flow_imp.g_varchar2_table(292) := '746869732E5F647261772829297D2C696E637265617365596561723A66756E6374696F6E28297B746869732E5F696E6974446174652626746869732E796561724368616E676528746869732E5F696E6974446174652E796561722B31297D2C6465637265';
wwv_flow_imp.g_varchar2_table(293) := '617365596561723A66756E6374696F6E28297B746869732E5F696E6974446174652626746869732E796561724368616E676528746869732E5F696E6974446174652E796561722D31297D2C796561724368616E67653A66756E6374696F6E2874297B7468';
wwv_flow_imp.g_varchar2_table(294) := '69732E5F696E697444617465262628746869732E5F696E6974446174653D6728746869732C746869732E5F696E6974446174652C7B796561723A747D292C746869732E5F647261772829297D2C5F6470436F6E7461696E65723A766F696420302C6F7665';
wwv_flow_imp.g_varchar2_table(295) := '726C6179456C656D656E743A766F696420302C5F7363726F6C6C506172656E743A766F696420302C5F7363726F6C6C48616E646C65723A766F696420302C5F746F6461793A766F696420302C5F696E6974446174653A6E756C6C2C5F696E697454696D65';
wwv_flow_imp.g_varchar2_table(296) := '3A6E756C6C2C5F76616C75653A6E756C6C2C73656C656374656444617465733A5B5D2C697353686F773A21317D3B66756E6374696F6E20756528297B76617220743D6E657720446174653B72657475726E7B686F75723A742E676574486F75727328292C';
wwv_flow_imp.g_varchar2_table(297) := '6D696E7574653A742E6765744D696E7574657328292C7365636F6E643A307D7D66756E6374696F6E2064652874297B742E5F696E6974446174653D6E756C6C2C742E5F696E697454696D653D6E756C6C2C742E5F76616C75653D6E756C6C2C742E73656C';
wwv_flow_imp.g_varchar2_table(298) := '656374656444617465733D5B5D7D66756E6374696F6E206C652874297B76617220653B2273696E676C6522213D3D28742E6F7074696F6E732E6D6F64657C7C2273696E676C652229262628742E73656C656374656444617465733D4928742C286E756C6C';
wwv_flow_imp.g_varchar2_table(299) := '3D3D28653D742E696E707574293F766F696420303A652E76616C7565297C7C222229297D66756E6374696F6E20686528742C65297B742E6470436F6E7461696E65722E7374796C652E7669736962696C6974793D653F4C743A2268696464656E222C742E';
wwv_flow_imp.g_varchar2_table(300) := '6470436F6E7461696E65722E7374796C652E646973706C61793D653F4E743A4F742C742E6F7665726C6179456C656D656E74262628742E6F7665726C6179456C656D656E742E7374796C652E646973706C61793D653F4E743A4F74297D66756E6374696F';
wwv_flow_imp.g_varchar2_table(301) := '6E20636528297B76617220742C652C6E3D73652E6F7074696F6E732E7A496E6465783B226E756D626572223D3D747970656F66206E2626286E756C6C213D28743D73652E5F6470436F6E7461696E6572292626742E6973436F6E6E656374656426262873';
wwv_flow_imp.g_varchar2_table(302) := '652E5F6470436F6E7461696E65722E7374796C652E7A496E6465783D537472696E67286E29292C6E756C6C213D28653D73652E6F7665726C6179456C656D656E74292626652E6973436F6E6E656374656426262873652E6F7665726C6179456C656D656E';
wwv_flow_imp.g_varchar2_table(303) := '742E7374796C652E7A496E6465783D537472696E67286E2D312929297D66756E6374696F6E20706528297B73652E736574506F736974696F6E28297D66756E6374696F6E206D6528297B73652E5F7363726F6C6C506172656E74262673652E5F7363726F';
wwv_flow_imp.g_varchar2_table(304) := '6C6C48616E646C657226262873652E5F7363726F6C6C506172656E742E72656D6F76654576656E744C697374656E657228227363726F6C6C222C73652E5F7363726F6C6C48616E646C6572292C73652E5F7363726F6C6C506172656E743D766F69642030';
wwv_flow_imp.g_varchar2_table(305) := '2C73652E5F7363726F6C6C48616E646C65723D766F69642030297D66756E6374696F6E20666528297B73652E736574506F736974696F6E28297D7661722076653D66756E6374696F6E2874297B73652E6F7074696F6E732E6175746F53686F772626742E';
wwv_flow_imp.g_varchar2_table(306) := '7461726765742626742E7461726765742E6D6174636865732873652E6F7074696F6E732E73656C6563746F7229262673652E73686F7728742E746172676574297D3B7661722079653D66756E6374696F6E2874297B76617220653D42742874292C6E3D65';
wwv_flow_imp.g_varchar2_table(307) := '2626652E636C6F736573743F652E636C6F7365737428222E6A64702D7472696767657222293A6E756C6C3B6966286E297B76617220693D66756E6374696F6E2874297B666F722876617220653D742E706172656E744E6F64652C6E3D303B6526266E3C34';
wwv_flow_imp.g_varchar2_table(308) := '3B6E2B2B2C653D652E706172656E744E6F6465297B76617220693D652E717565727953656C6563746F722822696E7075745B646174612D6A64705D22293B696628692972657475726E20697D72657475726E206E756C6C7D286E293B69262628742E7072';
wwv_flow_imp.g_varchar2_table(309) := '6576656E7444656661756C7428292C692E64697361626C65647C7C692E726561644F6E6C7926262173652E6F7074696F6E732E6175746F526561644F6E6C79496E7075747C7C2873652E697353686F77262673652E696E7075743D3D3D693F73652E6869';
wwv_flow_imp.g_varchar2_table(310) := '646528293A73652E73686F7728692929297D7D2C67653D66756E6374696F6E2874297B73652E6F7074696F6E732E6175746F48696465262673652E697353686F7726262828742E636F6D706F736564506174683F742E636F6D706F736564506174682829';
wwv_flow_imp.g_varchar2_table(311) := '3A5B5D292E696E6465784F662873652E5F6470436F6E7461696E6572293E2D317C7C73652E686964652829297D2C77653D66756E6374696F6E2874297B76617220653D42742874293B6966282128652626652E636C6F736573742626652E636C6F736573';
wwv_flow_imp.g_varchar2_table(312) := '7428222E6A64702D74726967676572222929297B766172206E2C692C6F2C723D286E3D73652E6470436F6E7461696E65722C286F3D28693D74292E706174687C7C692E636F6D706F736564506174682626692E636F6D706F7365645061746828297C7C21';
wwv_flow_imp.g_varchar2_table(313) := '31293F2D31213D3D6F2E696E6465784F66286E293A6E2E6F7574657248544D4C2E696E6465784F6628692E7461726765742E6F7574657248544D4C293E2D31292C613D42742874293D3D3D73652E696E7075743B73652E6F7074696F6E732E6175746F48';
wwv_flow_imp.g_varchar2_table(314) := '696465262673652E697353686F772626217226262161262673652E6869646528297D7D3B66756E6374696F6E2044652874297B76617220653B22457363617065223D3D3D742E6B657926262873652E69735472616E736974696F6E696E677C7C286E756C';
wwv_flow_imp.g_varchar2_table(315) := '6C3D3D28653D73652E696E707574297C7C6E756C6C3D3D652E626C75727C7C652E626C757228292C73652E68696465282929297D7661722062653D66756E6374696F6E2874297B72657475726E20537472696E67286E756C6C3D3D743F22223A74292E72';
wwv_flow_imp.g_varchar2_table(316) := '65706C616365282F5BDBB02DDBB95D2F672C66756E6374696F6E2874297B72657475726E20742E63686172436F646541742830292D313737367D292E7265706C616365282F5BD9A02DD9A95D2F672C66756E6374696F6E2874297B72657475726E20742E';
wwv_flow_imp.g_varchar2_table(317) := '63686172436F646541742830292D313633327D297D2C5F653D66756E6374696F6E2874297B72657475726E28743D537472696E67287061727365496E7428742C3130297C7C3029292E6C656E6774683C323F2230222B743A747D2C43653D66756E637469';
wwv_flow_imp.g_varchar2_table(318) := '6F6E2874297B72657475726E20742E686173417474726962757465285374293F2244223A2274727565223D3D3D742E676574417474726962757465284374293F2253223A2254227D2C53653D66756E6374696F6E28742C65297B766172206E2C692C6F2C';
wwv_flow_imp.g_varchar2_table(319) := '723D62652874292E6D61746368282F5C642B2F67297C7C5B5D3B696628722E6C656E6774683C332972657475726E206E756C6C3B696628725B305D2E6C656E6774683E3D33296E3D725B305D2C693D725B315D2C6F3D725B325D3B656C73657B76617220';
wwv_flow_imp.g_varchar2_table(320) := '613D7061727365496E7428725B325D2C3130297C7C303B6E3D725B325D2E6C656E6774683E3D333F725B325D3A537472696E672828613E3D37303F313330303A31343030292B61292C652626652E676574417474726962757465262622444D59223D3D3D';
wwv_flow_imp.g_varchar2_table(321) := '652E6765744174747269627574652822646174612D6A64702D646174652D6F7264657222293F286F3D725B305D2C693D725B315D293A28693D725B305D2C6F3D725B315D297D72657475726E7B796561723A6E2C6D6F6E74683A5F652869292C6461793A';
wwv_flow_imp.g_varchar2_table(322) := '5F65286F292C686F75723A5F6528725B335D292C6D696E7574653A5F6528725B345D292C7365636F6E643A5F6528725B355D297D7D2C54653D66756E6374696F6E2874297B72657475726E20742E796561722B222F222B742E6D6F6E74682B222F222B74';
wwv_flow_imp.g_varchar2_table(323) := '2E6461792B2220222B742E686F75722B223A222B742E6D696E7574652B223A222B742E7365636F6E647D2C45653D66756E6374696F6E2874297B76617220653D742E706172656E744E6F64653B72657475726E20653F652E717565727953656C6563746F';
wwv_flow_imp.g_varchar2_table(324) := '722822696E7075745B646174612D6A64702D68696464656E5D22293A6E756C6C7D2C78653D4F626A6563742E6765744F776E50726F706572747944657363726970746F722848544D4C496E707574456C656D656E742E70726F746F747970652C2276616C';
wwv_flow_imp.g_varchar2_table(325) := '756522292C4D653D66756E6374696F6E28742C65297B78652E7365742E63616C6C28742C65297D2C49653D66756E6374696F6E2874297B77696E646F772E6A51756572793F77696E646F772E6A51756572792874292E7472696767657228226368616E67';
wwv_flow_imp.g_varchar2_table(326) := '6522293A6B7428742C226368616E676522297D2C41653D66756E6374696F6E28742C65297B766172206E3D78652E6765742E63616C6C2865292C693D6E3F5365286E2C74293A6E756C6C3B696628216E7C7C69297B69662869297B742E73657441747472';
wwv_flow_imp.g_varchar2_table(327) := '69627574652822646174612D6A64702D6F7269672D74696D65222C692E686F75722B223A222B692E6D696E7574652B223A222B692E7365636F6E64292C742E76616C75653D66756E6374696F6E28742C65297B766172206E3D73652E6F7074696F6E737C';
wwv_flow_imp.g_varchar2_table(328) := '7C7B7D2C693D6E2E736570617261746F7243686172737C7C4D742C6F3D43652874292C723D652E796561722B692E646174652B652E6D6F6E74682B692E646174652B652E6461793B72657475726E224422213D3D6F262628722B3D692E6265747765656E';
wwv_flow_imp.g_varchar2_table(329) := '2B652E686F75722B692E74696D652B652E6D696E7574652C2253223D3D3D6F262628722B3D692E74696D652B652E7365636F6E6429292C7A7428722C21216E2E7065727369616E446967697473297D28742C69293B766172206F3D54652869293B6F213D';
wwv_flow_imp.g_varchar2_table(330) := '3D6E26264D6528652C6F297D656C736520742E76616C75653D22223B2166756E6374696F6E2874297B73652E696E7075743D3D3D742626286465287365292C6C65287365292C73652E697353686F77262673652E5F647261772829297D2874297D7D2C56';
wwv_flow_imp.g_varchar2_table(331) := '653D66756E6374696F6E2874297B76617220653D742E7461726765743B652626652E6D6174636865732626652E6D6174636865732822696E7075745B646174612D6A64705D2229262666756E6374696F6E2874297B76617220653D45652874293B696628';
wwv_flow_imp.g_varchar2_table(332) := '652626282173652E5F70656E64696E677C7C73652E696E707574213D3D7429297B766172206E3D626528742E76616C7565292E7472696D28292C693D22223B6966286E297B766172206F3D5365286E2C74293B696628216F2972657475726E3B76617220';
wwv_flow_imp.g_varchar2_table(333) := '723D43652874293B6966282244223D3D3D72297B76617220613D28742E6765744174747269627574652822646174612D6A64702D6F7269672D74696D6522297C7C2230303A30303A303022292E73706C697428223A22293B6F2E686F75723D5F6528615B';
wwv_flow_imp.g_varchar2_table(334) := '305D292C6F2E6D696E7574653D5F6528615B315D292C6F2E7365636F6E643D5F6528615B325D297D656C73652254223D3D3D722626286F2E7365636F6E643D22303022293B693D5465286F297D78652E6765742E63616C6C286529213D3D692626284D65';
wwv_flow_imp.g_varchar2_table(335) := '28652C69292C4965286529297D7D2865297D3B646F63756D656E742E6164644576656E744C697374656E657228226368616E6765222C56652C2130292C646F63756D656E742E6164644576656E744C697374656E65722822666F6375736F7574222C5665';
wwv_flow_imp.g_varchar2_table(336) := '2C2130293B766172206A652C4C652C4E653D66756E6374696F6E28742C652C6E297B76617220693D45652874293B69662869297B766172206F3D78652E6765742E63616C6C2869293B73652E5F70656E64696E67262673652E696E7075743D3D3D742626';
wwv_flow_imp.g_varchar2_table(337) := '2873652E5F70656E64696E673D2131292C4D6528692C657C7C2222292C416528742C69292C73652E696E7075743D3D3D7426262873652E5F636F6D6D69747465643D742E76616C7565292C6E7C7C78652E6765742E63616C6C2869293D3D3D6F7C7C4965';
wwv_flow_imp.g_varchar2_table(338) := '2869297D7D3B77696E646F772E6A616C616C69446174657069636B65723D7B737461727457617463683A66756E6374696F6E2874297B766F696420303D3D3D74262628743D7B7D293B76617220653D66756E6374696F6E28297B72657475726E2073652E';
wwv_flow_imp.g_varchar2_table(339) := '696E69742874297D3B646F63756D656E742E626F64793F6528293A646F63756D656E742E6164644576656E744C697374656E65722822444F4D436F6E74656E744C6F61646564222C652C7B6F6E63653A21307D297D2C7365744974656D56616C75653A66';
wwv_flow_imp.g_varchar2_table(340) := '756E6374696F6E28742C652C6E297B4E6528742C652C6E297D2C6765744974656D56616C75653A66756E6374696F6E2874297B76617220653D45652874293B72657475726E20653F652E76616C75653A22227D2C73686F773A66756E6374696F6E287429';
wwv_flow_imp.g_varchar2_table(341) := '7B73652E73686F772874297D2C686964653A66756E6374696F6E28297B73652E6869646528297D2C7570646174654F7074696F6E733A66756E6374696F6E2874297B73652E7570646174654F7074696F6E732874297D7D2C6A653D66756E6374696F6E28';
wwv_flow_imp.g_varchar2_table(342) := '74297B69662821742E5F6A6470426F756E64297B76617220653D742E706172656E744E6F64653F742E706172656E744E6F64652E717565727953656C6563746F722822696E7075745B646174612D6A64705D22293A6E756C6C3B69662865297B742E5F6A';
wwv_flow_imp.g_varchar2_table(343) := '6470426F756E643D21303B7472797B4F626A6563742E646566696E6550726F706572747928742C2276616C7565222C7B636F6E666967757261626C653A21302C656E756D657261626C653A21302C6765743A66756E6374696F6E28297B72657475726E20';
wwv_flow_imp.g_varchar2_table(344) := '78652E6765742E63616C6C2874297D2C7365743A66756E6374696F6E286E297B78652E7365742E63616C6C28742C6E292C416528652C74297D7D297D63617463682874297B7D2166756E6374696F6E28742C65297B69662821742E5F6A64705265676973';
wwv_flow_imp.g_varchar2_table(345) := '74657265642626742E6964262677696E646F772E617065782626617065782E6974656D2626617065782E6974656D2E63726561746526262821742E636C6F736573747C7C21742E636C6F7365737428222E612D4756222929297B742E5F6A647052656769';
wwv_flow_imp.g_varchar2_table(346) := '7374657265643D21303B766172206E3D66756E6374696F6E28297B72657475726E2077696E646F772E6A51756572792865292E636C6F7365737428222E742D466F726D2D6974656D577261707065722C2074642C202E612D47562D63656C6C22292E6669';
wwv_flow_imp.g_varchar2_table(347) := '6E6428222E6A64702D7472696767657222297D3B7472797B617065782E6974656D2E63726561746528742E69642C7B6974656D5F747970653A224A414C414C495F444154455F5049434B4552222C6E756C6C56616C75653A22222C67657456616C75653A';
wwv_flow_imp.g_varchar2_table(348) := '66756E6374696F6E28297B72657475726E20742E76616C75657D2C73657456616C75653A66756E6374696F6E28742C6E2C69297B4E6528652C742C69297D2C736574466F637573546F3A66756E6374696F6E28297B72657475726E2077696E646F772E6A';
wwv_flow_imp.g_varchar2_table(349) := '51756572792865297D2C656E61626C653A66756E6374696F6E28297B652E64697361626C65643D21312C742E64697361626C65643D21312C6E28292E70726F70282264697361626C6564222C2131297D2C64697361626C653A66756E6374696F6E28297B';
wwv_flow_imp.g_varchar2_table(350) := '652E64697361626C65643D21302C742E64697361626C65643D21302C6E28292E70726F70282264697361626C6564222C2130297D2C697344697361626C65643A66756E6374696F6E28297B72657475726E20652E64697361626C65647D7D297D63617463';
wwv_flow_imp.g_varchar2_table(351) := '682874297B7D7D7D28742C65297D7D7D2C4C653D66756E6374696F6E2874297B7472797B69662821747C7C31213D3D742E6E6F646554797065262639213D3D742E6E6F6465547970652972657475726E3B742E6D6174636865732626742E6D6174636865';
wwv_flow_imp.g_varchar2_table(352) := '732822696E7075745B646174612D6A64702D68696464656E5D222926266A652874293B666F722876617220653D742E717565727953656C6563746F72416C6C3F742E717565727953656C6563746F72416C6C2822696E7075745B646174612D6A64702D68';
wwv_flow_imp.g_varchar2_table(353) := '696464656E5D22293A5B5D2C6E3D303B6E3C652E6C656E6774683B6E2B2B296A6528655B6E5D297D63617463682874297B7D7D2C77696E646F772E4D75746174696F6E4F6273657276657226266E6577204D75746174696F6E4F62736572766572286675';
wwv_flow_imp.g_varchar2_table(354) := '6E6374696F6E2874297B666F722876617220653D303B653C742E6C656E6774683B652B2B29666F7228766172206E3D745B655D2E61646465644E6F6465732C693D303B693C6E2E6C656E6774683B692B2B294C65286E5B695D297D292E6F627365727665';
wwv_flow_imp.g_varchar2_table(355) := '28646F63756D656E742E646F63756D656E74456C656D656E742C7B6368696C644C6973743A21302C737562747265653A21307D292C226C6F6164696E67223D3D3D646F63756D656E742E726561647953746174653F646F63756D656E742E616464457665';
wwv_flow_imp.g_varchar2_table(356) := '6E744C697374656E65722822444F4D436F6E74656E744C6F61646564222C66756E6374696F6E28297B4C6528646F63756D656E74297D293A4C6528646F63756D656E74292C77696E646F772E617065782626617065782E6974656D2626617065782E6974';
wwv_flow_imp.g_varchar2_table(357) := '656D2E61646441747461636848616E646C65722626617065782E6974656D2E61646441747461636848616E646C65722866756E6374696F6E2874297B696628742626742E6C656E67746829666F722876617220653D303B653C742E6C656E6774683B652B';
wwv_flow_imp.g_varchar2_table(358) := '2B294C6528745B655D293B656C7365204C6528646F63756D656E74297D297D28293B';
null;
end;
/
begin
wwv_flow_imp_shared.create_plugin_file(
 p_id=>wwv_flow_imp.id(64673173861044220)
,p_plugin_id=>wwv_flow_imp.id(438448083865680986)
,p_file_name=>'jalalidatepicker.min.js'
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
