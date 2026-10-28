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
 p_version_yyyy_mm_dd=>'2024.05.31'
,p_release=>'24.1.0'
,p_default_workspace_id=>3600412333796893
,p_default_application_id=>100
,p_default_id_offset=>0
,p_default_owner=>'APEX360'
);
end;
/
 
prompt APPLICATION 100 - date_picker
--
-- Application Export:
--   Application:     100
--   Name:            date_picker
--   Date and Time:   22:04 Monday October 26, 2026
--   Exported By:     ADMIN
--   Flashback:       0
--   Export Type:     Component Export
--   Manifest
--     PLUGIN: 158266056596050555837
--   Manifest End
-- Version:         24.1.0
--   Instance ID:     2200103291828121
--

begin
  -- replace components
  wwv_flow_imp.g_mode := 'REPLACE';
end;
/
prompt --application/shared_components/plugins/item_type/ir_apex360_persiandatepicker
begin
wwv_flow_imp_shared.create_plugin(
 p_id=>wwv_flow_imp.id(158266056596050555837)
,p_plugin_type=>'ITEM TYPE'
,p_name=>'IR.APEX360.PERSIANDATEPICKER'
,p_display_name=>'APEX360 Persian Date Picker (Jalali)'
,p_supported_component_types=>'APEX_APPLICATION_PAGE_ITEMS:APEX_APPL_PAGE_IG_COLUMNS'
,p_javascript_file_urls=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#PLUGIN_FILES#js/apex360-dp-jalali-calendar.js',
'#PLUGIN_FILES#js/apex360-persian-datepicker.js'))
,p_css_file_urls=>'#PLUGIN_FILES#css/apex360-persian-datepicker.css'
,p_plsql_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'procedure render(',
'  p_item   in            apex_plugin.t_item,',
'  p_plugin in            apex_plugin.t_plugin,',
'  p_param  in            apex_plugin.t_item_render_param,',
'  p_result in out nocopy apex_plugin.t_item_render_result',
')',
'as',
'  v_display_format  varchar2(60)  := nvl(p_item.attributes.get_varchar2(''attribute_01''), nvl(p_item.format_mask, ''YYYY/MM/DD''));',
'  -- Return format is always YYYY/MM/DD (HH:MI appended automatically when Show Time=Y)',
'  v_return_format   varchar2(60)  := ''YYYY/MM/DD'';',
'  v_persian_digits  varchar2(1)   := nvl(p_item.attributes.get_varchar2(''attribute_03''), ''Y'');',
'  v_show_today      varchar2(1)   := nvl(p_item.attributes.get_varchar2(''attribute_04''), ''Y'');',
'  v_show_clear      varchar2(1)   := nvl(p_item.attributes.get_varchar2(''attribute_05''), ''Y'');',
unistr('  v_placeholder     varchar2(200) := nvl(p_item.attributes.get_varchar2(''attribute_06''), ''\0627\0646\062A\062E\0627\0628 \062A\0627\0631\06CC\062E'');'),
'  v_min_type        varchar2(10)  := nvl(p_item.attributes.get_varchar2(''attribute_07''), ''none'');',
'  v_min_item        varchar2(255) := p_item.attributes.get_varchar2(''attribute_08'');',
'  v_min_static      varchar2(50)  := p_item.attributes.get_varchar2(''attribute_09'');',
'  v_max_type        varchar2(10)  := nvl(p_item.attributes.get_varchar2(''attribute_10''), ''none'');',
'  v_max_item        varchar2(255) := p_item.attributes.get_varchar2(''attribute_11'');',
'  v_max_static      varchar2(50)  := p_item.attributes.get_varchar2(''attribute_12'');',
'  v_show_time       varchar2(1)   := nvl(p_item.attributes.get_varchar2(''attribute_13''), ''N'');',
'  v_manual_input    varchar2(1)   := nvl(p_item.attributes.get_varchar2(''attribute_14''), ''N'');',
'  v_show_on         varchar2(10)  := nvl(p_item.attributes.get_varchar2(''attribute_15''), ''button'');',
'  v_holidays        varchar2(32767) := p_item.attributes.get_varchar2(''attribute_16'');',
'  v_disable_holiday varchar2(1)   := nvl(p_item.attributes.get_varchar2(''attribute_17''), ''N'');',
'  v_show_year       varchar2(1)   := nvl(p_item.attributes.get_varchar2(''attribute_18''), ''Y'');',
'  v_show_month      varchar2(1)   := nvl(p_item.attributes.get_varchar2(''attribute_19''), ''Y'');',
'  v_display_as      varchar2(10)  := nvl(p_item.attributes.get_varchar2(''attribute_20''), ''popup'');',
'  v_year_range      varchar2(200) := p_item.attributes.get_varchar2(''attribute_21'');',
'  v_month_range     varchar2(200) := p_item.attributes.get_varchar2(''attribute_22'');',
'  v_holiday_json    varchar2(32767) := p_item.attributes.get_varchar2(''attribute_23'');',
'  v_calendar_year   varchar2(10)  := nvl(p_item.attributes.get_varchar2(''attribute_24''), ''jalali'');',
'  v_min_val         varchar2(50)  := case',
'    when v_min_type = ''static'' then v_min_static',
'    when v_min_type = ''item''   then apex_util.get_session_state(v_min_item)',
'    else null end;',
'  v_max_val         varchar2(50)  := case',
'    when v_max_type = ''static'' then v_max_static',
'    when v_max_type = ''item''   then apex_util.get_session_state(v_max_item)',
'    else null end;',
'  v_current_value   varchar2(255) := p_param.value;',
'  v_return_fmt_eff  varchar2(60)  := v_return_format;',
'  v_display_fmt_eff varchar2(60)  := v_display_format;',
'  v_required_attr   varchar2(30)  := case when p_item.is_required then '' required="required"'' else '''' end;',
'  v_html            varchar2(32767);',
'begin',
'  if v_show_time = ''Y'' then',
'    v_return_fmt_eff  := ''YYYY/MM/DD HH:MI'';',
'    if instr(upper(v_display_fmt_eff),''HH'') = 0 then',
'      v_display_fmt_eff := v_display_fmt_eff || '' HH:MI'';',
'    end if;',
'  end if;',
'  if p_param.is_readonly or p_param.is_printer_friendly then',
'    apex_plugin_util.print_hidden_if_readonly(',
'      p_item_name           => p_item.name,',
'      p_value               => v_current_value,',
'      p_is_readonly         => p_param.is_readonly,',
'      p_is_printer_friendly => p_param.is_printer_friendly',
'    );',
'    declare',
'      v_disp_value varchar2(255) := v_current_value;',
'    begin',
'      -- Apply +1180 imperial offset for display only; session stays Jalali',
'      if v_calendar_year = ''imperial'' and length(v_current_value) >= 10 then',
'        v_disp_value := to_char(to_number(substr(v_current_value,1,4)) + 1180)',
'                        || substr(v_current_value, 5);',
'      end if;',
'      htp.p(''<span id="'' || apex_escape.html_attribute(p_item.name)',
'            || ''_DISPLAY" class="display_only apex360-pdp-display-only" dir="rtl">''',
'            || apex_escape.html(v_disp_value) || ''</span>'');',
'    end;',
'    p_result.is_navigable := false;',
'    return;',
'  end if;',
'  v_html :=',
'    ''<input type="text"''',
'    || '' id="''             || apex_escape.html_attribute(p_item.name) || ''"''',
'    || '' name="''           || apex_plugin.get_input_name_for_page_item(false) || ''"''',
'    || '' class="apex360-pdp-input"''',
'    || '' data-plugin-name="IR.APEX360.PERSIANDATEPICKER"''',
'    || '' value="''          || apex_escape.html_attribute(v_current_value) || ''"''',
'    || '' data-display-format="'' || apex_escape.html_attribute(v_display_fmt_eff) || ''"''',
'    || '' data-return-format="''  || apex_escape.html_attribute(v_return_fmt_eff)  || ''"''',
'    || '' data-persian-digits="'' || apex_escape.html_attribute(v_persian_digits) || ''"''',
'    || '' data-show-today="''     || apex_escape.html_attribute(v_show_today)     || ''"''',
'    || '' data-show-clear="''     || apex_escape.html_attribute(v_show_clear)     || ''"''',
'    || '' data-placeholder="''    || apex_escape.html_attribute(v_placeholder)    || ''"''',
'    || '' data-show-time="''      || apex_escape.html_attribute(v_show_time)      || ''"''',
'    || '' data-manual-input="''   || apex_escape.html_attribute(v_manual_input)   || ''"''',
'    || '' data-show-on="''        || apex_escape.html_attribute(v_show_on)        || ''"''',
'    || '' data-disable-holiday="''|| apex_escape.html_attribute(v_disable_holiday)|| ''"''',
'    || '' data-min-date-type="''  || apex_escape.html_attribute(v_min_type)       || ''"''',
'    || case when v_min_type = ''item''   then '' data-min-date-item="''   || apex_escape.html_attribute(nvl(v_min_item,   '''')) || ''"'' else '''' end',
'    || case when v_min_type = ''static'' then '' data-min-date-static="'' || apex_escape.html_attribute(nvl(v_min_static, '''')) || ''"'' else '''' end',
'    || '' data-max-date-type="''  || apex_escape.html_attribute(v_max_type)       || ''"''',
'    || case when v_max_type = ''item''   then '' data-max-date-item="''   || apex_escape.html_attribute(nvl(v_max_item,   '''')) || ''"'' else '''' end',
'    || case when v_max_type = ''static'' then '' data-max-date-static="'' || apex_escape.html_attribute(nvl(v_max_static, '''')) || ''"'' else '''' end',
'    || case when v_holidays is not null and length(v_holidays) > 0',
'            then '' data-holidays="'' || apex_escape.html_attribute(v_holidays) || ''"''',
'            else '''' end',
'    || '' data-show-year="''     || apex_escape.html_attribute(v_show_year)    || ''"''',
'    || '' data-show-month="''    || apex_escape.html_attribute(v_show_month)   || ''"''',
'    || '' data-display-as="''    || apex_escape.html_attribute(v_display_as)   || ''"''',
'    || '' data-calendar-year="'' || apex_escape.html_attribute(v_calendar_year) || ''"''',
'    || case when v_year_range   is not null then '' data-year-range="''   || apex_escape.html_attribute(v_year_range)   || ''"'' else '''' end',
'    || case when v_month_range  is not null then '' data-month-range="''  || apex_escape.html_attribute(v_month_range)  || ''"'' else '''' end',
'    || case when v_holiday_json is not null and length(v_holiday_json) > 0',
'            then '' data-holiday-json="'' || apex_escape.html_attribute(v_holiday_json) || ''"''',
'            else '''' end',
'    || v_required_attr || '' autocomplete="off"/>'';',
'  htp.p(v_html);',
'  p_result.is_navigable := true;',
'exception when others then',
'  apex_debug.error(''Persian Date Picker render: '' || sqlerrm); raise;',
'end render;'))
,p_api_version=>2
,p_render_function=>'render'
,p_standard_attributes=>'VISIBLE:LABEL:SESSION_STATE:SOURCE:FORMAT_MASK:FORMAT_MASK_DATE_ONLY:READONLY:REQUIRED:ELEMENT'
,p_substitute_attributes=>true
,p_version_scn=>15757074521777
,p_subscribe_plugin_settings=>true
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
unistr('\062A\0642\0648\06CC\0645 \0634\0645\0633\06CC Oracle APEX'),
unistr('\0637\0631\0627\062D\06CC \0648 \062A\0648\0633\0639\0647: \0645\062C\062A\0628\06CC \062D\0627\062C\06CC \0639\0644\06CC\0642\0644\06CC \06AF\06CC\0648\06CC'),
unistr('\0627\06CC\0646 \067E\0644\0627\06AF\06CC\0646 \0628\0627 \0647\062F\0641 \0641\0631\0627\0647\0645\200C\06A9\0631\062F\0646 \0627\0645\06A9\0627\0646 \0627\0646\062A\062E\0627\0628 \062A\0627\0631\06CC\062E \0634\0645\0633\06CC \062F\0631 \0628\0631\0646\0627\0645\0647\200C\0647\0627\06CC Oracle APEX \0637\0631\0627\062D\06CC \0648 \062A\0648\0633\0639\0647 \062F\0627\062F\0647 \0634\062F\0647 \0627\0633\062A.'),
unistr('**\0633\0641\0627\0631\0634 \0637\0631\0627\062D\06CC \0648 \062A\0648\0633\0639\0647 \067E\0644\0627\06AF\06CC\0646 \0627\062E\062A\0635\0627\0635\06CC:**'),
unistr('\D83C\DF10 https://apex360.ir'),
unistr('\2709 info@apex360.ir'),
unistr('**\0627\0631\062A\0628\0627\0637 \0628\0627 \062A\0648\0633\0639\0647\200C\062F\0647\0646\062F\0647:**'),
'LinkedIn: https://www.linkedin.com/in/mojtaba-aligholi',
'GitHub: https://github.com/mojtabagivi',
'Email: mojtaba.givi@gmail.com',
'phone: 09123241271',
unistr('Copyright \00A9 2026 Mojtaba Haji Aligholi Givi. All rights reserved.'),
unistr('\06A9\0644\06CC\0647 \062D\0642\0648\0642 \0645\0627\062F\06CC \0648 \0645\0639\0646\0648\06CC \0627\06CC\0646 \067E\0644\0627\06AF\06CC\0646 \0645\062A\0639\0644\0642 \0628\0647 \0637\0631\0627\062D \0648 \062A\0648\0633\0639\0647\200C\062F\0647\0646\062F\0647 \0622\0646 \0627\0633\062A. \0647\0631\06AF\0648\0646\0647 \0628\0627\0632\0646\0634\0631\060C \062A\0648\0632\06CC\0639 \06CC\0627 \0627\0633\062A\0641\0627\062F\0647 \062E\0627\0631\062C \0627\0632 \0634\0631\0627\06CC\0637 \0645\062C\0648\0632\060C \0645\0646\0648\0637 \0628\0647 \06A9\0633\0628 \0627\062C\0627\0632\0647 \0627\0632 \0645\0627\0644\06A9 \0627\062B\0631 \0627\0633\062A.')))
,p_version_identifier=>'24.2.0'
,p_about_url=>'https://apex360.ir'
,p_files_version=>65
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(158266056596049556837)
,p_plugin_id=>wwv_flow_imp.id(158266056596050555837)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>1
,p_display_sequence=>20
,p_static_id=>'attribute_01'
,p_prompt=>'Display Format'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'YYYY/MM/DD'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
,p_help_text=>unistr('Format displayed to the user in the input field. Does NOT affect session state \2014 that is always controlled by Return Format. Supports month names (MON, fmMonth), weekday names (fmDay), time (HH:MI).')
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(158266056596049556939)
,p_plugin_attribute_id=>wwv_flow_imp.id(158266056596049556837)
,p_display_sequence=>40
,p_display_value=>'DD-MM-YYYY (10-01-1405)'
,p_return_value=>'DD-MM-YYYY'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(158266056596049556943)
,p_plugin_attribute_id=>wwv_flow_imp.id(158266056596049556837)
,p_display_sequence=>80
,p_display_value=>unistr('fmDay, fmDD fmMonth, YYYY (\062F\0648\0634\0646\0628\0647\060C 10 \0641\0631\0648\0631\062F\06CC\0646\060C 1405)')
,p_return_value=>'fmDay, fmDD fmMonth, YYYY'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(158266056596049556941)
,p_plugin_attribute_id=>wwv_flow_imp.id(158266056596049556837)
,p_display_sequence=>60
,p_display_value=>unistr('fmDD/MON/YYYY (10/\0641\0631\0648\0631\062F\06CC\0646/1405)')
,p_return_value=>'fmDD/MON/YYYY'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(158266056596049556942)
,p_plugin_attribute_id=>wwv_flow_imp.id(158266056596049556837)
,p_display_sequence=>70
,p_display_value=>unistr('fmDD-MON-YYYY (10-\0641\0631\0648\0631\062F\06CC\0646-1405)')
,p_return_value=>'fmDD-MON-YYYY'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(158266056596049556944)
,p_plugin_attribute_id=>wwv_flow_imp.id(158266056596049556837)
,p_display_sequence=>90
,p_display_value=>unistr('fmDD-MON-YYYY HH:MI (10-\0641\0631\0648\0631\062F\06CC\0646-1405 14:30)')
,p_return_value=>'fmDD-MON-YYYY HH:MI'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(158266056596049556945)
,p_plugin_attribute_id=>wwv_flow_imp.id(158266056596049556837)
,p_display_sequence=>100
,p_display_value=>unistr('fmMonth (\0641\0631\0648\0631\062F\06CC\0646)')
,p_return_value=>'fmMonth'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(158266056596049556936)
,p_plugin_attribute_id=>wwv_flow_imp.id(158266056596049556837)
,p_display_sequence=>10
,p_display_value=>'YYYY/MM/DD (1405/01/10)'
,p_return_value=>'YYYY/MM/DD'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(158266056596049556938)
,p_plugin_attribute_id=>wwv_flow_imp.id(158266056596049556837)
,p_display_sequence=>30
,p_display_value=>'YYYY-MM-DD (1405-01-10)'
,p_return_value=>'YYYY-MM-DD'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(158266056596049556937)
,p_plugin_attribute_id=>wwv_flow_imp.id(158266056596049556837)
,p_display_sequence=>20
,p_display_value=>'YYYY/MM/DD HH:MI (1405/01/10 14:30)'
,p_return_value=>'YYYY/MM/DD HH:MI'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(158266056596049556940)
,p_plugin_attribute_id=>wwv_flow_imp.id(158266056596049556837)
,p_display_sequence=>50
,p_display_value=>unistr('YYYY/MON (\0641\0631\0648\0631\062F\06CC\0646/1405)')
,p_return_value=>'YYYY/MON'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(158266056596049556839)
,p_plugin_id=>wwv_flow_imp.id(158266056596050555837)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>3
,p_display_sequence=>80
,p_static_id=>'attribute_03'
,p_prompt=>'Show Persian Digits'
,p_attribute_type=>'CHECKBOX'
,p_is_required=>false
,p_default_value=>'Y'
,p_is_translatable=>false
,p_help_text=>'Show Persian digits in calendar. Session state always stores Latin digits.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(158266056596049556840)
,p_plugin_id=>wwv_flow_imp.id(158266056596050555837)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>4
,p_display_sequence=>90
,p_static_id=>'attribute_04'
,p_prompt=>'Show Today Button'
,p_attribute_type=>'CHECKBOX'
,p_is_required=>false
,p_default_value=>'Y'
,p_is_translatable=>false
,p_help_text=>'Show the Today button.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(158266056596049556841)
,p_plugin_id=>wwv_flow_imp.id(158266056596050555837)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>5
,p_display_sequence=>100
,p_static_id=>'attribute_05'
,p_prompt=>'Show Clear Button'
,p_attribute_type=>'CHECKBOX'
,p_is_required=>false
,p_default_value=>'Y'
,p_is_translatable=>false
,p_help_text=>'Show the Clear button.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(158266056596049556842)
,p_plugin_id=>wwv_flow_imp.id(158266056596050555837)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>6
,p_display_sequence=>40
,p_static_id=>'attribute_06'
,p_prompt=>'Placeholder Text'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_default_value=>unistr('\0627\0646\062A\062E\0627\0628 \062A\0627\0631\06CC\062E')
,p_is_translatable=>true
,p_help_text=>'Placeholder shown when no date selected.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(158266056596049556843)
,p_plugin_id=>wwv_flow_imp.id(158266056596050555837)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>7
,p_display_sequence=>50
,p_static_id=>'attribute_07'
,p_prompt=>'Minimum Date'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'none'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
,p_help_text=>'Restricts the earliest selectable date. None = no restriction. Item = read from a page item at runtime. Static = a fixed date value.'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(158266056596049556907)
,p_plugin_attribute_id=>wwv_flow_imp.id(158266056596049556843)
,p_display_sequence=>20
,p_display_value=>'Item'
,p_return_value=>'item'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(158266056596049556906)
,p_plugin_attribute_id=>wwv_flow_imp.id(158266056596049556843)
,p_display_sequence=>10
,p_display_value=>'None'
,p_return_value=>'none'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(158266056596049556908)
,p_plugin_attribute_id=>wwv_flow_imp.id(158266056596049556843)
,p_display_sequence=>30
,p_display_value=>'Static'
,p_return_value=>'static'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(158266056596049556844)
,p_plugin_id=>wwv_flow_imp.id(158266056596050555837)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>8
,p_display_sequence=>55
,p_static_id=>'attribute_08'
,p_prompt=>'Minimum Item'
,p_attribute_type=>'PAGE ITEM'
,p_is_required=>true
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(158266056596049556843)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'item'
,p_help_text=>'The item that determines the minimum allowed value. This must be a page item that is either on the current, or global page.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(158266056596049556845)
,p_plugin_id=>wwv_flow_imp.id(158266056596050555837)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>9
,p_display_sequence=>56
,p_static_id=>'attribute_09'
,p_prompt=>'Minimum Static'
,p_attribute_type=>'TEXT'
,p_is_required=>true
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(158266056596049556843)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'static'
,p_help_text=>'Earliest date in Return Format, e.g. 1400/01/01. Applies to calendar and manual input. You may also use a page item substitution (e.g. &P1_DATE.) to supply the value dynamically.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(158266056596049556846)
,p_plugin_id=>wwv_flow_imp.id(158266056596050555837)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>10
,p_display_sequence=>60
,p_static_id=>'attribute_10'
,p_prompt=>'Maximum Date'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'none'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
,p_help_text=>'Restricts the latest selectable date. None = no restriction. Item = read from a page item at runtime. Static = a fixed date value.'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(158266056596049556917)
,p_plugin_attribute_id=>wwv_flow_imp.id(158266056596049556846)
,p_display_sequence=>20
,p_display_value=>'Item'
,p_return_value=>'item'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(158266056596049556916)
,p_plugin_attribute_id=>wwv_flow_imp.id(158266056596049556846)
,p_display_sequence=>10
,p_display_value=>'None'
,p_return_value=>'none'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(158266056596049556918)
,p_plugin_attribute_id=>wwv_flow_imp.id(158266056596049556846)
,p_display_sequence=>30
,p_display_value=>'Static'
,p_return_value=>'static'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(158266056596049556847)
,p_plugin_id=>wwv_flow_imp.id(158266056596050555837)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>11
,p_display_sequence=>65
,p_static_id=>'attribute_11'
,p_prompt=>'Maximum Item'
,p_attribute_type=>'PAGE ITEM'
,p_is_required=>true
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(158266056596049556846)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'item'
,p_help_text=>'The item that determines the maximum allowed value. This must be a page item that is either on the current, or global page.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(158266056596049556848)
,p_plugin_id=>wwv_flow_imp.id(158266056596050555837)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>12
,p_display_sequence=>66
,p_static_id=>'attribute_12'
,p_prompt=>'Maximum Static'
,p_attribute_type=>'TEXT'
,p_is_required=>true
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(158266056596049556846)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'static'
,p_help_text=>'Latest date in Return Format, e.g. 1410/12/29. Applies to calendar and manual input. You may also use a page item substitution (e.g. &P1_DATE.) to supply the value dynamically.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(158266056596049556849)
,p_plugin_id=>wwv_flow_imp.id(158266056596050555837)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>13
,p_display_sequence=>70
,p_static_id=>'attribute_13'
,p_prompt=>'Show Time'
,p_attribute_type=>'CHECKBOX'
,p_is_required=>false
,p_default_value=>'N'
,p_is_translatable=>false
,p_help_text=>'Add HH:MM (24h) time picker. Session state: YYYY/MM/DD HH:MM.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(158266056596049556850)
,p_plugin_id=>wwv_flow_imp.id(158266056596050555837)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>14
,p_display_sequence=>120
,p_static_id=>'attribute_14'
,p_prompt=>'Allow Manual Input'
,p_attribute_type=>'CHECKBOX'
,p_is_required=>false
,p_default_value=>'N'
,p_is_translatable=>false
,p_help_text=>'Allow typing a date directly in Return Format.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(158266056596049556851)
,p_plugin_id=>wwv_flow_imp.id(158266056596050555837)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>15
,p_display_sequence=>110
,p_static_id=>'attribute_15'
,p_prompt=>'Show On'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'focus'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
,p_help_text=>'Icon Click: only the calendar button opens the picker. Item Focus: clicking or tabbing into the field also opens the picker.'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(158266056596049556986)
,p_plugin_attribute_id=>wwv_flow_imp.id(158266056596049556851)
,p_display_sequence=>10
,p_display_value=>'Icon Click'
,p_return_value=>'button'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(158266056596049556987)
,p_plugin_attribute_id=>wwv_flow_imp.id(158266056596049556851)
,p_display_sequence=>5
,p_display_value=>'Item Focus'
,p_return_value=>'focus'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(158266056596049556852)
,p_plugin_id=>wwv_flow_imp.id(158266056596050555837)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>16
,p_display_sequence=>120
,p_static_id=>'attribute_16'
,p_prompt=>'Exception Dates'
,p_attribute_type=>'TEXTAREA'
,p_is_required=>false
,p_is_translatable=>false
,p_help_text=>'Comma-separated list of exception dates (holidays, closures) in YYYY-MM-DD format. Example: 1405-05-01,1405-05-02,1405-07-03. These dates appear in red. Persian digits accepted.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(158266056596049556853)
,p_plugin_id=>wwv_flow_imp.id(158266056596050555837)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>17
,p_display_sequence=>130
,p_static_id=>'attribute_17'
,p_prompt=>'Disable Holiday'
,p_attribute_type=>'CHECKBOX'
,p_is_required=>false
,p_default_value=>'N'
,p_is_translatable=>false
,p_help_text=>'If Yes, holiday dates and Fridays cannot be selected in the calendar or via manual input.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(158266056596049556854)
,p_plugin_id=>wwv_flow_imp.id(158266056596050555837)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>18
,p_display_sequence=>130
,p_static_id=>'attribute_18'
,p_prompt=>'Show Year'
,p_attribute_type=>'CHECKBOX'
,p_is_required=>false
,p_default_value=>'Y'
,p_is_translatable=>false
,p_help_text=>'Show the year spinner in the calendar header.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(158266056596049556855)
,p_plugin_id=>wwv_flow_imp.id(158266056596050555837)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>19
,p_display_sequence=>140
,p_static_id=>'attribute_19'
,p_prompt=>'Show Month'
,p_attribute_type=>'CHECKBOX'
,p_is_required=>false
,p_default_value=>'Y'
,p_is_translatable=>false
,p_help_text=>'Show the month label (clickable dropdown) in the calendar header.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(158266056596049556856)
,p_plugin_id=>wwv_flow_imp.id(158266056596050555837)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>20
,p_display_sequence=>10
,p_static_id=>'attribute_20'
,p_prompt=>'Display As'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>false
,p_default_value=>'popup'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
,p_help_text=>'Popup: calendar appears when user clicks the icon or field (default). Inline: calendar is always visible on the page, embedded directly in the item position.'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(158266056596049557037)
,p_plugin_attribute_id=>wwv_flow_imp.id(158266056596049556856)
,p_display_sequence=>20
,p_display_value=>'Inline'
,p_return_value=>'inline'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(158266056596049557036)
,p_plugin_attribute_id=>wwv_flow_imp.id(158266056596049556856)
,p_display_sequence=>10
,p_display_value=>'Popup'
,p_return_value=>'popup'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(158266056596049556857)
,p_plugin_id=>wwv_flow_imp.id(158266056596050555837)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>21
,p_display_sequence=>135
,p_static_id=>'attribute_21'
,p_prompt=>'Year Range'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(158266056596049556854)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'Y'
,p_help_text=>'Optional. Comma-separated list of allowed Jalali years. e.g. 1404,1405,1406,1407. Only these years will appear in the year dropdown and be valid for selection and manual input. Leave empty to allow all years. Note: when Year Range is set, the year na'
||'vigation arrows (prev/next year) are automatically hidden; navigation is done via the year dropdown only.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(158266056596049556858)
,p_plugin_id=>wwv_flow_imp.id(158266056596050555837)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>22
,p_display_sequence=>145
,p_static_id=>'attribute_22'
,p_prompt=>'Month Range'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(158266056596049556855)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'Y'
,p_help_text=>'Optional. Comma-separated list of allowed month numbers (01-12). e.g. 01,03,06,07. Only these months will appear in the month dropdown and be valid for selection and manual input. Leave empty to allow all months. Note: when Month Range is set, the mo'
||'nth navigation arrows (prev/next month) are automatically hidden; navigation is done via the month dropdown only.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(158266056596049556859)
,p_plugin_id=>wwv_flow_imp.id(158266056596050555837)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>23
,p_display_sequence=>125
,p_static_id=>'attribute_23'
,p_prompt=>'Holiday Dates'
,p_attribute_type=>'TEXTAREA'
,p_is_required=>false
,p_is_translatable=>false
,p_help_text=>unistr('JSON array of holiday dates with names. Dates appear in red and a tooltip shows the name on mouseover. Format: [{"date":"1405-01-01","name":"\0646\0648\0631\0648\0632"},{"date":"1405-01-13","name":"\0633\06CC\0632\062F\0647 \0628\062F\0631"}]. Behaves the same as Exception Dates (blocks selection when')
||unistr(' Disable Holiday = Yes). To get official Iranian public holidays in JSON format, use the apex360 API: https://service.apex360.info/iran/holidays?year=1405&token=MY_SECRET_TOKEN \2014 change the year parameter as needed. To obtain your API token contact i')
||'nfo@apex360.info.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(158266056596049556860)
,p_plugin_id=>wwv_flow_imp.id(158266056596050555837)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>24
,p_display_sequence=>15
,p_static_id=>'attribute_24'
,p_prompt=>'Calendar Year'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'jalali'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
,p_help_text=>unistr('Controls how the year is displayed in the calendar header, year dropdown, and the date shown to the user. Session state and all internal logic always use the Jalali year. Imperial year = Jalali + 1180 (e.g. 1405/01/01 \2192 2585/01/01). This is a display')
||'-only setting; the stored value is never affected.'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(158266056596050579837)
,p_plugin_attribute_id=>wwv_flow_imp.id(158266056596049556860)
,p_display_sequence=>10
,p_display_value=>unistr('\062C\0644\0627\0644\06CC')
,p_return_value=>'jalali'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(158266056596050579838)
,p_plugin_attribute_id=>wwv_flow_imp.id(158266056596049556860)
,p_display_sequence=>20
,p_display_value=>unistr('\0634\0627\0647\0646\0634\0627\0647\06CC')
,p_return_value=>'imperial'
);
end;
/
begin
wwv_flow_imp.g_varchar2_table := wwv_flow_imp.empty_varchar2_table;
wwv_flow_imp.g_varchar2_table(1) := '2F2A2A0A202A2041504558333630205065727369616E2044617465205069636B657220E28094204353530A202A0A202A204C61796F75743A0A202A20204865616465723A205B20E280B9204D6F6E746820E280BA205D202E2E2E2E2E2E2E2E2E2E2E2E2E';
wwv_flow_imp.g_varchar2_table(2) := '2E205B20E296B2205965617220E296BC205D20202852544C290A202A2020466F6F7465723A205B20D8AAD8A3DB8CDB8CD8AF205D205B20D8A7D985D8B1D988D8B2205D205B7370616365725D205B20F09F9590204848E297873A4D4DE29787205D0A202A';
wwv_flow_imp.g_varchar2_table(3) := '0A202A20E29480E29480205061746368202874686973206275696C642920E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E2';
wwv_flow_imp.g_varchar2_table(4) := '9480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E294800A202A202056697375616C207374796C65207469676874656E65642074';
wwv_flow_imp.g_varchar2_table(5) := '6F206C6F6F6B20636C6F73657220746F20746865206E617469766520415045582032342E3220446174650A202A20205069636B65723A0A202A20202020E280A220536D616C6C65722C2072656374616E67756C6172206461792063656C6C7320286E6F20';
wwv_flow_imp.g_varchar2_table(6) := '6C6172676520636972636C65290A202A20202020E280A220486F7665722F73656C65637465642F746F646179207573652074686520415045582070616C65747465206C696B6520746865206E6174697665207069636B65720A202A20202020E280A22046';
wwv_flow_imp.g_varchar2_table(7) := '6F6F74657220627574746F6E7320757365204150455820627574746F6E207374796C65732028736D616C6C65722C206C6573732070616464696E67290A202A20202020E280A220506F707570207769647468206D61746368657320746865206E61746976';
wwv_flow_imp.g_varchar2_table(8) := '65207069636B657220287E3238307078290A202A20202020E280A2207A2D696E6465782069732064796E616D6963616C6C792072616973656420627920746865204A5320636F64652C2062757420612073616E6520666C6F6F722069730A202A20202020';
wwv_flow_imp.g_varchar2_table(9) := '20206B657074206865726520617320612066616C6C6261636B0A202A202054686520706F702D757020697320616C736F207374796C656420736F2069742072656D61696E732076697375616C6C7920636F6E73697374656E74206576656E207768656E0A';
wwv_flow_imp.g_varchar2_table(10) := '202A2020697420697320686F7374656420696E2074686520504152454E542077696E646F77202841504558204D6F64616C204469616C6F6720506167652063617365292E0A202A20E29480E29480E29480E29480E29480E29480E29480E29480E29480E2';
wwv_flow_imp.g_varchar2_table(11) := '9480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E294';
wwv_flow_imp.g_varchar2_table(12) := '80E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E294800A202A2F0A0A2F2A20E29480E29480204869646465';
wwv_flow_imp.g_varchar2_table(13) := '6E2073657373696F6E2D737461746520696E70757420E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480';
wwv_flow_imp.g_varchar2_table(14) := 'E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480202A2F0A696E7075742E617065783336302D7064702D696E707574207B0A2020706F736974696F6E3A206162736F6C7574652021696D706F7274616E743B2077696474683A20';
wwv_flow_imp.g_varchar2_table(15) := '3170782021696D706F7274616E743B206865696768743A203170782021696D706F7274616E743B0A20206F766572666C6F773A2068696464656E2021696D706F7274616E743B206F7061636974793A20302021696D706F7274616E743B20706F696E7465';
wwv_flow_imp.g_varchar2_table(16) := '722D6576656E74733A206E6F6E652021696D706F7274616E743B0A7D0A0A2F2A20E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E2';
wwv_flow_imp.g_varchar2_table(17) := '9590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E295';
wwv_flow_imp.g_varchar2_table(18) := '90E29590E29590E29590E29590E29590E29590E29590E29590E29590E295900A202020575241505045520A202020E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590';
wwv_flow_imp.g_varchar2_table(19) := 'E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E2';
wwv_flow_imp.g_varchar2_table(20) := '9590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590202A2F0A2E617065783336302D7064702D77726170706572207B0A2020646973706C61793A20666C65783B20666C65782D64697265637469';
wwv_flow_imp.g_varchar2_table(21) := '6F6E3A20726F773B20616C69676E2D6974656D733A20737472657463683B0A202077696474683A20313030253B20626F782D73697A696E673A20626F726465722D626F783B0A7D0A2E617065783336302D7064702D777261707065722D2D64697361626C';
wwv_flow_imp.g_varchar2_table(22) := '6564207B206F7061636974793A20302E36353B20706F696E7465722D6576656E74733A206E6F6E653B207D0A0A2F2A20756E69636F64652D626964693A20706C61696E74657874206C657473207468652062726F777365722064657465726D696E652070';
wwv_flow_imp.g_varchar2_table(23) := '617261677261706820646972656374696F6E0A20202066726F6D207468652076616C75652773206669727374207374726F6E672063686172616374657220E2809420736F205065727369616E206461746520666F726D6174730A20202028737461727469';
wwv_flow_imp.g_varchar2_table(24) := '6E6720776974682061205065727369616E206C6574746572206C696B6520D8AFD988D8B4D986D8A8D98729206175746F6D61746963616C6C7920646973706C61792052544C2C0A2020207768696C65206E756D6572696320666F726D6174732028737461';
wwv_flow_imp.g_varchar2_table(25) := '7274696E67207769746820313430352920646973706C6179204C54522E204E6F204A532062696469206861636B73206E65656465642E202A2F0A2E617065783336302D7064702D77726170706572202E617065783336302D7064702D646973706C617920';
wwv_flow_imp.g_varchar2_table(26) := '7B0A2020646972656374696F6E3A206C74723B0A2020746578742D616C69676E3A206C6566743B0A2020756E69636F64652D626964693A20706C61696E746578743B0A7D0A2E752D52544C202E617065783336302D7064702D77726170706572202E6170';
wwv_flow_imp.g_varchar2_table(27) := '65783336302D7064702D646973706C6179207B0A2020646972656374696F6E3A206C74723B0A2020746578742D616C69676E3A2072696768743B0A2020756E69636F64652D626964693A20706C61696E746578743B0A7D0A0A2E617065783336302D7064';
wwv_flow_imp.g_varchar2_table(28) := '702D6C7472202E617065783336302D7064702D646973706C6179207B0A20206F726465723A20313B20626F726465722D696E6C696E652D656E643A206E6F6E653B0A2020626F726465722D73746172742D656E642D7261646975733A20303B20626F7264';
wwv_flow_imp.g_varchar2_table(29) := '65722D656E642D656E642D7261646975733A20303B0A7D0A2E617065783336302D7064702D72746C202E617065783336302D7064702D646973706C6179207B0A20206F726465723A20323B20626F726465722D696E6C696E652D73746172743A206E6F6E';
wwv_flow_imp.g_varchar2_table(30) := '653B0A2020626F726465722D73746172742D73746172742D7261646975733A20303B20626F726465722D656E642D73746172742D7261646975733A20303B0A7D0A2E617065783336302D7064702D646973706C61795B726561646F6E6C795D2020202020';
wwv_flow_imp.g_varchar2_table(31) := '20207B20637572736F723A20706F696E7465723B207D0A2E617065783336302D7064702D646973706C61793A6E6F74285B726561646F6E6C795D29207B20637572736F723A20746578743B207D0A2E617065783336302D7064702D646973706C61792D2D';
wwv_flow_imp.g_varchar2_table(32) := '6572722020202020202020202020207B20626F726465722D636F6C6F723A20766172282D2D612D70616C657474652D64616E6765722C2023433733373337292021696D706F7274616E743B207D0A0A2E617065783336302D7064702D6C7472202E612D42';
wwv_flow_imp.g_varchar2_table(33) := '7574746F6E2D2D63616C656E646172207B206F726465723A20323B207D0A2E617065783336302D7064702D72746C202E612D427574746F6E2D2D63616C656E646172207B206F726465723A20313B207D0A0A2F2A20E29590E29590E29590E29590E29590';
wwv_flow_imp.g_varchar2_table(34) := 'E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E2';
wwv_flow_imp.g_varchar2_table(35) := '9590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E295900A202020504F5055500A2020204E617469';
wwv_flow_imp.g_varchar2_table(36) := '766520415045582044617465205069636B6572206973207E323830707820776964653B20776520666F6C6C6F77207468652073616D652077696474682E0A2020207A2D696E64657820666C6F6F722069732033303030302028746865204A532072616973';
wwv_flow_imp.g_varchar2_table(37) := '65732069742064796E616D6963616C6C79207768656E2061206D6F64616C0A20202069732070726573656E742C2062757420333030303020616C7265616479206265617473206576657279207374617469632041504558206C61796572292E0A202020E2';
wwv_flow_imp.g_varchar2_table(38) := '9590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E295';
wwv_flow_imp.g_varchar2_table(39) := '90E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590202A2F';
wwv_flow_imp.g_varchar2_table(40) := '0A2E617065783336302D7064702D706F707570207B0A2020706F736974696F6E3A2066697865643B207A2D696E6465783A2033303030303B0A202077696474683A206175746F3B206D61782D77696474683A2033313770783B0A2020626F782D73697A69';
wwv_flow_imp.g_varchar2_table(41) := '6E673A20626F726465722D626F783B20646972656374696F6E3A2072746C3B0A2020666F6E742D66616D696C793A20766172282D2D612D626173652D666F6E742D66616D696C792C202D6170706C652D73797374656D2C20426C696E6B4D616353797374';
wwv_flow_imp.g_varchar2_table(42) := '656D466F6E742C20225365676F65205549222C20417269616C2C2073616E732D7365726966293B0A2020666F6E742D73697A653A20766172282D2D612D626173652D68746D6C2D666F6E742D73697A652C2031337078293B206C696E652D686569676874';
wwv_flow_imp.g_varchar2_table(43) := '3A20312E34353B0A2020636F6C6F723A20766172282D2D612D6669656C642D746578742D636F6C6F722C2023343034303430293B0A20206261636B67726F756E642D636F6C6F723A20766172282D2D612D6669656C642D636F6E7461696E65722D626163';
wwv_flow_imp.g_varchar2_table(44) := '6B67726F756E642D636F6C6F722C2023666666293B0A2020626F726465723A2031707820736F6C696420766172282D2D612D6669656C642D636F6E7461696E65722D626F726465722D636F6C6F722C2023643064306430293B0A2020626F726465722D72';
wwv_flow_imp.g_varchar2_table(45) := '61646975733A20766172282D2D612D6669656C642D636F6E7461696E65722D626F726465722D7261646975732C20302E33373572656D293B0A2020626F782D736861646F773A20766172282D2D612D6669656C642D636F6E7461696E65722D736861646F';
wwv_flow_imp.g_varchar2_table(46) := '772C2030203670782031387078207267626128302C302C302C2E313829293B0A20206F766572666C6F773A2068696464656E3B0A2020616E696D6174696F6E3A2070647046616465496E20302E317320656173652D6F75743B0A7D0A2F2A205768656E20';
wwv_flow_imp.g_varchar2_table(47) := '74686520706F7075702069732072656E646572656420696E2074686520504152454E542077696E646F7720286D6F64616C207061676520696672616D650A20202063617365292C2074686520706172656E7420646F63756D656E742773203C626F64793E';
wwv_flow_imp.g_varchar2_table(48) := '206D61792068617665206120646966666572656E74206261636B67726F756E640A202020616E6420666F6E7420737461636B3B20666F7263652074686520706F70757020746F20616C77617973206C6F6F6B207468652073616D65207265676172646C65';
wwv_flow_imp.g_varchar2_table(49) := '73730A2020206F662069747320686F737420646F63756D656E742E202A2F0A2E617065783336302D7064702D706F7075702D2D63726F73732D6672616D65207B0A2020666F6E742D66616D696C793A202D6170706C652D73797374656D2C20426C696E6B';
wwv_flow_imp.g_varchar2_table(50) := '4D616353797374656D466F6E742C20225365676F65205549222C205461686F6D612C20417269616C2C2073616E732D73657269663B0A2020666F6E742D73697A653A20313370783B0A2020636F6C6F723A20233430343034303B0A20206261636B67726F';
wwv_flow_imp.g_varchar2_table(51) := '756E642D636F6C6F723A20236666663B0A2020626F726465722D636F6C6F723A20236430643064303B0A2020626F782D736861646F773A2030203670782031387078207267626128302C302C302C2E3138293B0A7D0A406B65796672616D657320706470';
wwv_flow_imp.g_varchar2_table(52) := '46616465496E207B0A202066726F6D207B206F7061636974793A20303B207472616E73666F726D3A207472616E736C61746559282D347078293B207D0A2020746F2020207B206F7061636974793A20313B207472616E73666F726D3A207472616E736C61';
wwv_flow_imp.g_varchar2_table(53) := '7465592830293B207D0A7D0A0A2F2A20E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590';
wwv_flow_imp.g_varchar2_table(54) := 'E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E2';
wwv_flow_imp.g_varchar2_table(55) := '9590E29590E29590E29590E295900A2020204845414445520A20202052544C206C61796F75743A206D6F6E74682D626C6F636B2028726967687429207C20796561722D626C6F636B20286C656674290A202020436F6D70616374206865696768742C206C';
wwv_flow_imp.g_varchar2_table(56) := '696768746572206261636B67726F756E6420E2809420636C6F73657220746F206E617469766520415045582E0A202020E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E2';
wwv_flow_imp.g_varchar2_table(57) := '9590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E295';
wwv_flow_imp.g_varchar2_table(58) := '90E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590202A2F0A2E617065783336302D7064702D686561646572207B0A2020646973706C61793A20666C65783B20616C69676E2D6974656D73';
wwv_flow_imp.g_varchar2_table(59) := '3A2063656E7465723B0A202070616464696E673A2036707820387078203470783B0A2020757365722D73656C6563743A206E6F6E653B20646972656374696F6E3A2072746C3B0A20206261636B67726F756E642D636F6C6F723A20766172282D2D612D72';
wwv_flow_imp.g_varchar2_table(60) := '6567696F6E2D6865616465722D6261636B67726F756E642D636F6C6F722C2023663766376638293B0A20206761703A203470783B0A20206A7573746966792D636F6E74656E743A2073706163652D6265747765656E3B0A2020666C65782D777261703A20';
wwv_flow_imp.g_varchar2_table(61) := '6E6F777261703B0A2020626F726465722D626F74746F6D3A2031707820736F6C696420766172282D2D612D6669656C642D636F6E7461696E65722D626F726465722D636F6C6F722C2023656365636563293B0A7D0A0A2F2A20E29480E294802059656172';
wwv_flow_imp.g_varchar2_table(62) := '20626C6F636B3A205B20E296B2207C20796561722D6C626C207C20E296BC205D20696E6C696E6520E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480';
wwv_flow_imp.g_varchar2_table(63) := 'E29480202A2F0A2E617065783336302D7064702D796561722D626C6F636B207B0A2020646973706C61793A20666C65783B20616C69676E2D6974656D733A2063656E7465723B0A2020666C65783A20302030206175746F3B206761703A203270783B0A7D';
wwv_flow_imp.g_varchar2_table(64) := '0A0A2F2A20436C69636B61626C652079656172206C6162656C202A2F0A2E617065783336302D7064702D796561722D6C626C207B0A2020666F6E742D73697A653A20312E32656D3B0A2020666F6E742D7765696768743A20766172282D2D612D62617365';
wwv_flow_imp.g_varchar2_table(65) := '2D666F6E742D7765696768742D626F6C642C20373030293B0A2020636F6C6F723A20766172282D2D612D6669656C642D746578742D636F6C6F722C2023316131613161293B0A20206D696E2D77696474683A20343470783B20746578742D616C69676E3A';
wwv_flow_imp.g_varchar2_table(66) := '2063656E7465723B2070616464696E673A20327078203470783B0A20206261636B67726F756E643A207472616E73706172656E743B20626F726465723A2031707820736F6C6964207472616E73706172656E743B0A2020626F726465722D726164697573';
wwv_flow_imp.g_varchar2_table(67) := '3A20766172282D2D612D627574746F6E2D626F726465722D7261646975732C20302E31323572656D293B0A2020637572736F723A20706F696E7465723B20666F6E742D66616D696C793A20696E68657269743B206C696E652D6865696768743A20312E34';
wwv_flow_imp.g_varchar2_table(68) := '3B0A20202D7765626B69742D617070656172616E63653A206E6F6E653B20617070656172616E63653A206E6F6E653B206F75746C696E653A206E6F6E653B0A20207472616E736974696F6E3A206261636B67726F756E642D636F6C6F7220302E31733B0A';
wwv_flow_imp.g_varchar2_table(69) := '7D0A2E617065783336302D7064702D796561722D6C626C3A686F76657220207B206261636B67726F756E642D636F6C6F723A207267626128302C302C302C2E3036293B207D0A0A2F2A2059656172207370696E6E657220627574746F6E732028E296B220';
wwv_flow_imp.g_varchar2_table(70) := 'E296BC2920E2809420494E4C494E452C206C6566742F7269676874206F66206C6162656C202A2F0A2E617065783336302D7064702D796561722D62746E207B0A2020646973706C61793A20696E6C696E652D666C65783B20616C69676E2D6974656D733A';
wwv_flow_imp.g_varchar2_table(71) := '2063656E7465723B206A7573746966792D636F6E74656E743A2063656E7465723B0A2020666F6E742D73697A653A20312E32656D3B0A2020666F6E742D7765696768743A20766172282D2D612D626173652D666F6E742D7765696768742D626F6C642C20';
wwv_flow_imp.g_varchar2_table(72) := '373030293B0A2020636F6C6F723A20766172282D2D612D6669656C642D746578742D6D757465642D636F6C6F722C2023373037303730293B0A20206D696E2D77696474683A20323270783B206865696768743A20323270783B20746578742D616C69676E';
wwv_flow_imp.g_varchar2_table(73) := '3A2063656E7465723B2070616464696E673A20303B0A20206261636B67726F756E643A207472616E73706172656E743B20626F726465723A2031707820736F6C6964207472616E73706172656E743B0A2020626F726465722D7261646975733A20766172';
wwv_flow_imp.g_varchar2_table(74) := '282D2D612D627574746F6E2D626F726465722D7261646975732C20302E31323572656D293B0A2020637572736F723A20706F696E7465723B20666F6E742D66616D696C793A20696E68657269743B206C696E652D6865696768743A20313B0A20202D7765';
wwv_flow_imp.g_varchar2_table(75) := '626B69742D617070656172616E63653A206E6F6E653B20617070656172616E63653A206E6F6E653B206F75746C696E653A206E6F6E653B0A20207472616E736974696F6E3A206261636B67726F756E642D636F6C6F7220302E31733B0A7D0A2E61706578';
wwv_flow_imp.g_varchar2_table(76) := '3336302D7064702D796561722D62746E3A686F766572207B206261636B67726F756E642D636F6C6F723A207267626128302C302C302C2E3036293B207D0A0A2F2A20E29480E29480204D6F6E746820626C6F636B3A206D6F6E7468206C6162656C206F6E';
wwv_flow_imp.g_varchar2_table(77) := '6C7920E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480202A2F0A';
wwv_flow_imp.g_varchar2_table(78) := '2E617065783336302D7064702D6D6F6E74682D626C6F636B207B0A2020646973706C61793A20666C65783B20616C69676E2D6974656D733A2063656E7465723B206A7573746966792D636F6E74656E743A2063656E7465723B206761703A203270783B0A';
wwv_flow_imp.g_varchar2_table(79) := '202077696474683A2031333070783B0A7D0A0A2F2A20E29480E29480204D6F6E7468206172726F7720626C6F636B3A206E617620627574746F6E73206F6E6C7920286C65667420736964652920E29480E29480E29480E29480E29480E29480E29480E294';
wwv_flow_imp.g_varchar2_table(80) := '80E29480E29480E29480E29480202A2F0A2E617065783336302D7064702D6D6F6E74682D6172726F772D626C6F636B207B0A2020646973706C61793A20666C65783B0A20206A7573746966792D636F6E74656E743A20666C65782D656E643B0A20206761';
wwv_flow_imp.g_varchar2_table(81) := '703A203270783B0A202077696474683A2031333070783B0A2020616C69676E2D6974656D733A2063656E7465723B0A7D0A0A2F2A20436C69636B61626C65206D6F6E7468206C6162656C202A2F0A2E617065783336302D7064702D6D6F6E74682D6C626C';
wwv_flow_imp.g_varchar2_table(82) := '207B0A2020666F6E742D73697A653A2031656D3B0A2020666F6E742D7765696768743A20766172282D2D612D626173652D666F6E742D7765696768742D626F6C642C20373030293B0A2020636F6C6F723A20766172282D2D612D6669656C642D74657874';
wwv_flow_imp.g_varchar2_table(83) := '2D636F6C6F722C2023316131613161293B0A2020746578742D616C69676E3A2063656E7465723B2070616464696E673A20327078203670783B0A20206261636B67726F756E643A207472616E73706172656E743B20626F726465723A2031707820736F6C';
wwv_flow_imp.g_varchar2_table(84) := '6964207472616E73706172656E743B0A2020626F726465722D7261646975733A20766172282D2D612D627574746F6E2D626F726465722D7261646975732C20302E31323572656D293B0A2020637572736F723A20706F696E7465723B20666F6E742D6661';
wwv_flow_imp.g_varchar2_table(85) := '6D696C793A20696E68657269743B206C696E652D6865696768743A20312E343B0A20202D7765626B69742D617070656172616E63653A206E6F6E653B20617070656172616E63653A206E6F6E653B206F75746C696E653A206E6F6E653B0A20207472616E';
wwv_flow_imp.g_varchar2_table(86) := '736974696F6E3A206261636B67726F756E642D636F6C6F7220302E31733B0A202077686974652D73706163653A206E6F777261703B0A7D0A2E617065783336302D7064702D6D6F6E74682D6C626C3A686F766572207B206261636B67726F756E642D636F';
wwv_flow_imp.g_varchar2_table(87) := '6C6F723A207267626128302C302C302C2E3036293B207D0A0A2F2A204E61762063686576726F6E20627574746F6E732028E280B920E280BA2920E280942073616D6520636F6D706163742073697A65206173207468652079656172207370696E6E657220';
wwv_flow_imp.g_varchar2_table(88) := '2A2F0A2E617065783336302D7064702D6E6176207B0A2020646973706C61793A20696E6C696E652D666C65783B20616C69676E2D6974656D733A2063656E7465723B206A7573746966792D636F6E74656E743A2063656E7465723B0A202077696474683A';
wwv_flow_imp.g_varchar2_table(89) := '20323470783B206865696768743A20323470783B2070616464696E673A20303B206D617267696E3A20303B0A20206261636B67726F756E643A207472616E73706172656E743B20626F726465723A2031707820736F6C6964207472616E73706172656E74';
wwv_flow_imp.g_varchar2_table(90) := '3B0A2020626F726465722D7261646975733A20766172282D2D612D627574746F6E2D626F726465722D7261646975732C20302E31323572656D293B0A2020637572736F723A20706F696E7465723B20636F6C6F723A20766172282D2D612D6669656C642D';
wwv_flow_imp.g_varchar2_table(91) := '746578742D636F6C6F722C2023343034303430293B0A2020666F6E742D73697A653A20323070783B206C696E652D6865696768743A20313B20666F6E742D7765696768743A203430303B0A20202D7765626B69742D617070656172616E63653A206E6F6E';
wwv_flow_imp.g_varchar2_table(92) := '653B20617070656172616E63653A206E6F6E653B206F75746C696E653A206E6F6E653B0A20207472616E736974696F6E3A206261636B67726F756E642D636F6C6F7220302E31733B0A7D0A2E617065783336302D7064702D6E61763A686F766572207B0A';
wwv_flow_imp.g_varchar2_table(93) := '20206261636B67726F756E642D636F6C6F723A207267626128302C302C302C2E3036293B0A7D0A0A2F2A20E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590';
wwv_flow_imp.g_varchar2_table(94) := 'E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E2';
wwv_flow_imp.g_varchar2_table(95) := '9590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E295900A20202044524F50444F574E204F5645524C415920202879656172202F206D6F6E7468202F20686F7572202F206D696E757465206C697374290A20';
wwv_flow_imp.g_varchar2_table(96) := '2020E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E295';
wwv_flow_imp.g_varchar2_table(97) := '90E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590';
wwv_flow_imp.g_varchar2_table(98) := '202A2F0A2E617065783336302D7064702D6464207B0A2020706F736974696F6E3A206162736F6C7574653B20746F703A20303B20696E7365742D696E6C696E652D656E643A20303B0A202077696474683A2031333070783B206D61782D6865696768743A';
wwv_flow_imp.g_varchar2_table(99) := '20313030253B0A20206F766572666C6F772D793A206175746F3B206261636B67726F756E642D636F6C6F723A20233263326332633B0A2020626F726465722D7261646975733A20766172282D2D612D6669656C642D636F6E7461696E65722D626F726465';
wwv_flow_imp.g_varchar2_table(100) := '722D7261646975732C20302E33373572656D293B0A2020626F782D736861646F773A2030203470782032307078207267626128302C302C302C2E34293B207A2D696E6465783A2031303B0A20207363726F6C6C6261722D77696474683A207468696E3B20';
wwv_flow_imp.g_varchar2_table(101) := '7363726F6C6C6261722D636F6C6F723A2072676261283235352C3235352C3235352C2E3329207472616E73706172656E743B0A7D0A2E617065783336302D7064702D64643A3A2D7765626B69742D7363726F6C6C626172207B2077696474683A20347078';
wwv_flow_imp.g_varchar2_table(102) := '3B207D0A2E617065783336302D7064702D64643A3A2D7765626B69742D7363726F6C6C6261722D7468756D62207B206261636B67726F756E643A2072676261283235352C3235352C3235352C2E33293B20626F726465722D7261646975733A203270783B';
wwv_flow_imp.g_varchar2_table(103) := '207D0A2E617065783336302D7064702D64643A3A2D7765626B69742D7363726F6C6C6261722D747261636B207B206261636B67726F756E643A207472616E73706172656E743B207D0A2E617065783336302D7064702D64642D6C697374207B206C697374';
wwv_flow_imp.g_varchar2_table(104) := '2D7374796C653A206E6F6E653B206D617267696E3A20303B2070616464696E673A2034707820303B207D0A2E617065783336302D7064702D64642D6974656D207B0A2020646973706C61793A20666C65783B20616C69676E2D6974656D733A2063656E74';
wwv_flow_imp.g_varchar2_table(105) := '65723B206A7573746966792D636F6E74656E743A2073706163652D6265747765656E3B0A202070616464696E673A2036707820313270783B20636F6C6F723A2072676261283235352C3235352C3235352C2E3932293B0A2020666F6E742D73697A653A20';
wwv_flow_imp.g_varchar2_table(106) := '312E3135656D3B20666F6E742D7765696768743A203430303B0A2020637572736F723A20706F696E7465723B20646972656374696F6E3A2072746C3B207472616E736974696F6E3A206261636B67726F756E642D636F6C6F7220302E3038733B0A7D0A2E';
wwv_flow_imp.g_varchar2_table(107) := '617065783336302D7064702D64642D6974656D3A686F766572207B206261636B67726F756E642D636F6C6F723A2072676261283235352C3235352C3235352C2E3132293B207D0A2E617065783336302D7064702D64642D6974656D2D2D73656C207B0A20';
wwv_flow_imp.g_varchar2_table(108) := '206261636B67726F756E642D636F6C6F723A20766172282D2D612D70616C657474652D7072696D6172792C2023323536464642292021696D706F7274616E743B0A2020636F6C6F723A20236666662021696D706F7274616E743B0A2020666F6E742D7765';
wwv_flow_imp.g_varchar2_table(109) := '696768743A20766172282D2D612D626173652D666F6E742D7765696768742D626F6C642C20373030293B0A7D0A2E617065783336302D7064702D64642D636865636B3A3A6265666F7265207B20636F6E74656E743A2022E29C93223B20666F6E742D7369';
wwv_flow_imp.g_varchar2_table(110) := '7A653A20313270783B206C696E652D6865696768743A20313B207D0A0A2F2A20E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E295';
wwv_flow_imp.g_varchar2_table(111) := '90E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590';
wwv_flow_imp.g_varchar2_table(112) := 'E29590E29590E29590E29590E29590E29590E29590E29590E29590E295900A2020204441592D4F462D5745454B204845414445522020286D6F726520636F6D706163742C206E617469766520415045582D6C696B65290A202020E29590E29590E29590E2';
wwv_flow_imp.g_varchar2_table(113) := '9590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E295';
wwv_flow_imp.g_varchar2_table(114) := '90E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590202A2F0A2E61706578333630';
wwv_flow_imp.g_varchar2_table(115) := '2D7064702D646F77207B0A2020646973706C61793A20677269643B20677269642D74656D706C6174652D636F6C756D6E733A2072657065617428372C20316672293B0A202070616464696E673A2034707820347078203270783B0A20206261636B67726F';
wwv_flow_imp.g_varchar2_table(116) := '756E642D636F6C6F723A207472616E73706172656E743B0A7D0A2E617065783336302D7064702D646F772D63656C6C207B0A2020746578742D616C69676E3A2063656E7465723B2070616464696E673A2034707820303B206C696E652D6865696768743A';
wwv_flow_imp.g_varchar2_table(117) := '20312E323B0A2020666F6E742D73697A653A20302E3738656D3B0A2020666F6E742D7765696768743A20766172282D2D612D626173652D666F6E742D7765696768742D626F6C642C20373030293B0A2020636F6C6F723A20766172282D2D612D6669656C';
wwv_flow_imp.g_varchar2_table(118) := '642D746578742D6D757465642D636F6C6F722C2023373037303730293B0A2020746578742D7472616E73666F726D3A207570706572636173653B0A7D0A2E617065783336302D7064702D646F772D63656C6C3A6C6173742D6368696C64207B20636F6C6F';
wwv_flow_imp.g_varchar2_table(119) := '723A20766172282D2D612D70616C657474652D64616E6765722C2023433733373337293B207D0A0A2F2A20E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590';
wwv_flow_imp.g_varchar2_table(120) := 'E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E2';
wwv_flow_imp.g_varchar2_table(121) := '9590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E295900A202020444159204752494420E280942072656374616E67756C61722063656C6C732C206E617469766520415045582D6C696B6520686F7665722F';
wwv_flow_imp.g_varchar2_table(122) := '73656C656374696F6E0A202020287265706C6163657320746865206F6C64206C617267652063697263756C6172206461792063656C6C73290A202020E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E2';
wwv_flow_imp.g_varchar2_table(123) := '9590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E295';
wwv_flow_imp.g_varchar2_table(124) := '90E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590202A2F0A2E617065783336302D7064702D67726964207B2070616464696E673A20327078203470782034';
wwv_flow_imp.g_varchar2_table(125) := '70783B207D0A2E617065783336302D7064702D677269642D726F77207B20646973706C61793A20677269643B20677269642D74656D706C6174652D636F6C756D6E733A2072657065617428372C20316672293B207D0A0A0A2E617065783336302D706470';
wwv_flow_imp.g_varchar2_table(126) := '2D646179207B0A2020646973706C61793A20666C65783B20616C69676E2D6974656D733A2063656E7465723B206A7573746966792D636F6E74656E743A2063656E7465723B0A20206865696768743A20333270783B2077696474683A20313030253B2070';
wwv_flow_imp.g_varchar2_table(127) := '616464696E673A203270783B206D617267696E3A20303B0A20206261636B67726F756E643A207472616E73706172656E743B20626F726465723A206E6F6E653B20626F726465722D7261646975733A20303B0A2020666F6E742D73697A653A20302E3932';
wwv_flow_imp.g_varchar2_table(128) := '656D3B0A2020666F6E742D7765696768743A20766172282D2D612D626173652D666F6E742D7765696768742D626F6C642C20363030293B0A2020636F6C6F723A20766172282D2D612D6669656C642D746578742D636F6C6F722C2023343034303430293B';
wwv_flow_imp.g_varchar2_table(129) := '0A2020666F6E742D66616D696C793A20696E68657269743B206C696E652D6865696768743A20313B0A2020637572736F723A20706F696E7465723B20626F782D73697A696E673A20626F726465722D626F783B0A20202D7765626B69742D617070656172';
wwv_flow_imp.g_varchar2_table(130) := '616E63653A206E6F6E653B20617070656172616E63653A206E6F6E653B206F75746C696E653A206E6F6E653B0A2020706F736974696F6E3A2072656C61746976653B0A2020626F726465722D7261646975733A20766172282D2D612D627574746F6E2D62';
wwv_flow_imp.g_varchar2_table(131) := '6F726465722D7261646975732C20302E31323572656D293B0A20207472616E736974696F6E3A206261636B67726F756E642D636F6C6F7220302E3038732C20636F6C6F7220302E3038733B0A7D0A0A2E617065783336302D7064702D677269642D2D7065';
wwv_flow_imp.g_varchar2_table(132) := '727369616E202E617065783336302D7064702D646179207B0A2020666F6E742D73697A653A20302E3936656D3B0A2020666F6E742D7765696768743A20766172282D2D612D626173652D666F6E742D7765696768742D626F6C642C20373030293B0A7D0A';
wwv_flow_imp.g_varchar2_table(133) := '0A2F2A20486F7665723A20737562746C652067726179206261636B67726F756E64206C696B65206E6174697665204150455820286E6F20636972636C65206F75746C696E6529202A2F0A2E617065783336302D7064702D6461793A686F7665723A6E6F74';
wwv_flow_imp.g_varchar2_table(134) := '282E617065783336302D7064702D6461792D2D656D707479293A6E6F74282E617065783336302D7064702D6461792D2D6F666629207B0A20206261636B67726F756E642D636F6C6F723A20766172282D2D612D627574746F6E2D686F7665722D6261636B';
wwv_flow_imp.g_varchar2_table(135) := '67726F756E642D636F6C6F722C207267626128302C302C302C2E303629293B0A7D0A2E617065783336302D7064702D646179207370616E207B20706F736974696F6E3A2072656C61746976653B207A2D696E6465783A20313B207D0A0A2F2A20546F6461';
wwv_flow_imp.g_varchar2_table(136) := '793A206F75746C696E656420626F7820286B657074207468652076697375616C2063756520627574206C696768746572207468616E206265666F726529202A2F0A2E617065783336302D7064702D6461792D2D746F646179207B0A2020626F782D736861';
wwv_flow_imp.g_varchar2_table(137) := '646F773A20696E7365742030203020302031707820766172282D2D612D70616C657474652D7072696D6172792C2023323536464642293B0A2020636F6C6F723A20766172282D2D612D70616C657474652D7072696D6172792C2023323536464642293B0A';
wwv_flow_imp.g_varchar2_table(138) := '7D0A2F2A2053656C65637465643A2066696C6C656420626F78206C696B65206E61746976652041504558202A2F0A2E617065783336302D7064702D6461792D2D73656C207B0A20206261636B67726F756E642D636F6C6F723A20766172282D2D612D7061';
wwv_flow_imp.g_varchar2_table(139) := '6C657474652D7072696D6172792C2023323536464642292021696D706F7274616E743B0A2020636F6C6F723A20236666662021696D706F7274616E743B0A2020626F782D736861646F773A206E6F6E652021696D706F7274616E743B0A7D0A2F2A204672';
wwv_flow_imp.g_varchar2_table(140) := '69646179202620486F6C696461793A207265642074657874202A2F0A2E617065783336302D7064702D6461792D2D667269207B20636F6C6F723A20766172282D2D612D70616C657474652D64616E6765722C2023433733373337293B207D0A2E61706578';
wwv_flow_imp.g_varchar2_table(141) := '3336302D7064702D6461792D2D686F6C207B20636F6C6F723A20766172282D2D612D70616C657474652D64616E6765722C2023433733373337293B207D0A2E617065783336302D7064702D6461792D2D73656C2E617065783336302D7064702D6461792D';
wwv_flow_imp.g_varchar2_table(142) := '2D6672692C0A2E617065783336302D7064702D6461792D2D73656C2E617065783336302D7064702D6461792D2D686F6C207B20636F6C6F723A20236666662021696D706F7274616E743B207D0A2F2A2044697361626C6564202A2F0A2E61706578333630';
wwv_flow_imp.g_varchar2_table(143) := '2D7064702D6461792D2D6F6666207B20636F6C6F723A20766172282D2D612D6669656C642D746578742D6D757465642D636F6C6F722C2023633063306330292021696D706F7274616E743B20637572736F723A206E6F742D616C6C6F7765643B207D0A2E';
wwv_flow_imp.g_varchar2_table(144) := '617065783336302D7064702D6461792D2D6F66663A686F766572207B206261636B67726F756E643A207472616E73706172656E742021696D706F7274616E743B207D0A2E617065783336302D7064702D6461792D2D6F66662E617065783336302D706470';
wwv_flow_imp.g_varchar2_table(145) := '2D6461792D2D6672692C0A2E617065783336302D7064702D6461792D2D6F66662E617065783336302D7064702D6461792D2D686F6C207B20636F6C6F723A20766172282D2D612D70616C657474652D64616E6765722C2023433733373337292021696D70';
wwv_flow_imp.g_varchar2_table(146) := '6F7274616E743B206F7061636974793A20302E353B207D0A2E617065783336302D7064702D6461792D2D656D707479207B20637572736F723A2064656661756C743B20706F696E7465722D6576656E74733A206E6F6E653B207D0A2E617065783336302D';
wwv_flow_imp.g_varchar2_table(147) := '7064702D6461792D2D656D7074793A686F766572207B206261636B67726F756E643A207472616E73706172656E743B207D0A0A2F2A20E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E2';
wwv_flow_imp.g_varchar2_table(148) := '9590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E295';
wwv_flow_imp.g_varchar2_table(149) := '90E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E295900A202020464F4F54455220E280942074696D6520636F6E74726F6C7320617265204E4F5720494E204845524520286469';
wwv_flow_imp.g_varchar2_table(150) := '73706C61792D6D6F6E74682E706E67206C61796F7574290A2020204C61796F7574202852544C293A205B20D8AAD8A3DB8CDB8CD8AF205D205B20D8A7D985D8B1D988D8B2205D205BD9BED8A7DAA920DAA9D8B1D8AFD9865D205B6175746F2D7370616365';
wwv_flow_imp.g_varchar2_table(151) := '725D205B20F09F9590204848E296B2E296BC3A4D4DE296B2E296BC205D0A202020436F6D706163742C206E617469766520415045582D6C696B6520627574746F6E207374796C696E672E0A202020E29590E29590E29590E29590E29590E29590E29590E2';
wwv_flow_imp.g_varchar2_table(152) := '9590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E295';
wwv_flow_imp.g_varchar2_table(153) := '90E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590202A2F0A2E617065783336302D7064702D666F6F74657220';
wwv_flow_imp.g_varchar2_table(154) := '7B0A2020646973706C61793A20666C65783B20616C69676E2D6974656D733A2063656E7465723B0A202070616464696E673A20347078203670783B0A2020626F726465722D746F703A2031707820736F6C696420766172282D2D612D6669656C642D636F';
wwv_flow_imp.g_varchar2_table(155) := '6E7461696E65722D626F726465722D636F6C6F722C2023656365636563293B0A2020646972656374696F6E3A2072746C3B206761703A203270783B0A2020666C65782D777261703A206E6F777261703B206D696E2D6865696768743A20333670783B0A20';
wwv_flow_imp.g_varchar2_table(156) := '206A7573746966792D636F6E74656E743A2073706163652D6265747765656E3B0A20206261636B67726F756E642D636F6C6F723A207472616E73706172656E743B0A7D0A0A2F2A2054696D6520696E6C696E6520626C6F636B20E2809420707573686564';
wwv_flow_imp.g_varchar2_table(157) := '20746F20746865204C454654202852544C20656E642920766961206D617267696E2D696E6C696E652D73746172743A6175746F202A2F0A2E617065783336302D7064702D74696D652D696E6C696E65207B0A2020646973706C61793A2020202020666C65';
wwv_flow_imp.g_varchar2_table(158) := '783B0A2020616C69676E2D6974656D733A2063656E7465723B0A2020646972656374696F6E3A2020206C74723B20202020202020202F2A2074696D65207265616473206C656674E286927269676874202A2F0A20206761703A2020202020202020203270';
wwv_flow_imp.g_varchar2_table(159) := '783B0A20206D617267696E2D696E6C696E652D73746172743A20303B0A7D0A0A2F2A20436C6F636B2069636F6E202A2F0A2E617065783336302D7064702D74696D652D69636F6E207B0A2020646973706C61793A20696E6C696E652D666C65783B20616C';
wwv_flow_imp.g_varchar2_table(160) := '69676E2D6974656D733A2063656E7465723B0A2020636F6C6F723A20766172282D2D612D6669656C642D746578742D6D757465642D636F6C6F722C2023383838293B0A2020666F6E742D73697A653A20313370783B206D617267696E2D696E6C696E652D';
wwv_flow_imp.g_varchar2_table(161) := '656E643A203270783B0A2020637572736F723A20706F696E7465723B0A202070616464696E673A203270783B0A2020626F726465722D7261646975733A20766172282D2D612D627574746F6E2D626F726465722D7261646975732C20302E31323572656D';
wwv_flow_imp.g_varchar2_table(162) := '293B0A20207472616E736974696F6E3A206261636B67726F756E642D636F6C6F7220302E31733B0A7D0A2E617065783336302D7064702D74696D652D69636F6E3A686F766572207B206261636B67726F756E642D636F6C6F723A207267626128302C302C';
wwv_flow_imp.g_varchar2_table(163) := '302C2E3036293B207D0A0A2F2A2054696D65206374726C20636F6C756D6E2E202A2F0A2E617065783336302D7064702D74696D652D6374726C207B0A2020646973706C61793A20666C65783B20666C65782D646972656374696F6E3A20636F6C756D6E3B';
wwv_flow_imp.g_varchar2_table(164) := '0A2020616C69676E2D6974656D733A2063656E7465723B206A7573746966792D636F6E74656E743A2063656E7465723B0A7D0A0A2F2A2054696D652076616C756520627574746F6E2028636C69636B61626C652C206F70656E732064726F70646F776E29';
wwv_flow_imp.g_varchar2_table(165) := '202A2F0A2E617065783336302D7064702D74696D652D696E70207B0A2020646973706C61793A20696E6C696E652D666C65783B20616C69676E2D6974656D733A2063656E7465723B206A7573746966792D636F6E74656E743A2063656E7465723B0A2020';
wwv_flow_imp.g_varchar2_table(166) := '77696474683A20323670783B206D696E2D6865696768743A20313870783B0A2020746578742D616C69676E3A2063656E7465723B0A2020666F6E742D73697A653A20312E3035656D3B20666F6E742D66616D696C793A20766172282D2D612D626173652D';
wwv_flow_imp.g_varchar2_table(167) := '666F6E742D66616D696C792D6D6F6E6F2C206D6F6E6F7370616365293B0A2020666F6E742D7765696768743A20766172282D2D612D626173652D666F6E742D7765696768742D626F6C642C20373030293B0A2020636F6C6F723A20766172282D2D612D66';
wwv_flow_imp.g_varchar2_table(168) := '69656C642D746578742D636F6C6F722C2023343034303430293B0A20206261636B67726F756E643A207472616E73706172656E743B20626F726465723A206E6F6E653B0A2020626F726465722D626F74746F6D3A2032707820736F6C696420766172282D';
wwv_flow_imp.g_varchar2_table(169) := '2D612D6669656C642D636F6E7461696E65722D626F726465722D636F6C6F722C2023646464293B0A202070616464696E673A2030203270783B20637572736F723A20706F696E7465723B0A20202D7765626B69742D617070656172616E63653A206E6F6E';
wwv_flow_imp.g_varchar2_table(170) := '653B20617070656172616E63653A206E6F6E653B206F75746C696E653A206E6F6E653B0A20207472616E736974696F6E3A20626F726465722D636F6C6F7220302E31733B0A7D0A2E617065783336302D7064702D74696D652D696E703A686F766572207B';
wwv_flow_imp.g_varchar2_table(171) := '20626F726465722D626F74746F6D2D636F6C6F723A20766172282D2D612D70616C657474652D7072696D6172792C2023323536464642293B207D0A2E617065783336302D7064702D74696D652D696E702E69732D616374697665207B20626F726465722D';
wwv_flow_imp.g_varchar2_table(172) := '626F74746F6D2D636F6C6F723A20766172282D2D612D70616C657474652D7072696D6172792C2023323536464642293B20636F6C6F723A20766172282D2D612D70616C657474652D7072696D6172792C2023323536464642293B207D0A0A2E6170657833';
wwv_flow_imp.g_varchar2_table(173) := '36302D7064702D74696D652D62746E207B0A2020646973706C61793A20696E6C696E652D666C65783B20616C69676E2D6974656D733A2063656E7465723B206A7573746966792D636F6E74656E743A2063656E7465723B0A2020666F6E742D73697A653A';
wwv_flow_imp.g_varchar2_table(174) := '20302E39656D3B0A2020666F6E742D7765696768743A20766172282D2D612D626173652D666F6E742D7765696768742D626F6C642C20373030293B0A2020636F6C6F723A20766172282D2D612D6669656C642D746578742D6D757465642D636F6C6F722C';
wwv_flow_imp.g_varchar2_table(175) := '2023373037303730293B0A20206D696E2D77696474683A20323070783B206865696768743A20313470783B20746578742D616C69676E3A2063656E7465723B2070616464696E673A20303B0A20206261636B67726F756E643A207472616E73706172656E';
wwv_flow_imp.g_varchar2_table(176) := '743B20626F726465723A206E6F6E653B0A2020626F726465722D7261646975733A20766172282D2D612D627574746F6E2D626F726465722D7261646975732C20302E31323572656D293B0A2020637572736F723A20706F696E7465723B20666F6E742D66';
wwv_flow_imp.g_varchar2_table(177) := '616D696C793A20696E68657269743B206C696E652D6865696768743A20313B0A20202D7765626B69742D617070656172616E63653A206E6F6E653B20617070656172616E63653A206E6F6E653B206F75746C696E653A206E6F6E653B0A20207472616E73';
wwv_flow_imp.g_varchar2_table(178) := '6974696F6E3A206261636B67726F756E642D636F6C6F7220302E31733B0A7D0A2E617065783336302D7064702D74696D652D62746E3A686F766572207B206261636B67726F756E642D636F6C6F723A207267626128302C302C302C2E3036293B20636F6C';
wwv_flow_imp.g_varchar2_table(179) := '6F723A20766172282D2D612D6669656C642D746578742D636F6C6F722C2023343034303430293B207D0A0A2E617065783336302D7064702D74696D652D736570207B0A2020666F6E742D73697A653A2031656D3B20666F6E742D7765696768743A203430';
wwv_flow_imp.g_varchar2_table(180) := '303B20636F6C6F723A20766172282D2D612D6669656C642D746578742D636F6C6F722C2023343034303430293B0A2020616C69676E2D73656C663A2063656E7465723B2070616464696E673A2030203170783B2070616464696E672D626F74746F6D3A20';
wwv_flow_imp.g_varchar2_table(181) := '3270783B0A7D0A0A2F2A20E29480E2948020466F6F74657220616374696F6E20627574746F6E7320E28094204150455820746578742D6C696E6B207374796C6520E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E294';
wwv_flow_imp.g_varchar2_table(182) := '80E29480E29480E294800A202A20536D616C6C65722070616464696E672C206E6F2066756C6C20626F7264657220E28094206D617463686573206E617469766520415045582064617465207069636B65720A202A20666F6F74657220627574746F6E7320';
wwv_flow_imp.g_varchar2_table(183) := '2822546F64617922202F2022436C65617222206C696E6B73292E202A2F0A2E617065783336302D7064702D666F6F742D62746E207B0A20202D7765626B69742D617070656172616E63653A206E6F6E653B20617070656172616E63653A206E6F6E653B20';
wwv_flow_imp.g_varchar2_table(184) := '637572736F723A20706F696E7465723B206F75746C696E653A206E6F6E653B0A2020666F6E742D66616D696C793A20696E68657269743B20666F6E742D73697A653A20302E383572656D3B0A20206C696E652D6865696768743A20766172282D2D612D62';
wwv_flow_imp.g_varchar2_table(185) := '7574746F6E2D6C696E652D6865696768742C2031367078293B20666F6E742D7765696768743A203430303B0A2020626F726465722D7261646975733A20766172282D2D612D627574746F6E2D626F726465722D7261646975732C20302E31323572656D29';
wwv_flow_imp.g_varchar2_table(186) := '3B0A20207472616E736974696F6E3A206261636B67726F756E642D636F6C6F7220302E3132732C20626F726465722D636F6C6F7220302E3132732C20636F6C6F7220302E3132733B0A20206261636B67726F756E642D636F6C6F723A207472616E737061';
wwv_flow_imp.g_varchar2_table(187) := '72656E743B0A2020626F726465723A2031707820736F6C6964207472616E73706172656E743B0A2020636F6C6F723A20766172282D2D612D6669656C642D746578742D636F6C6F722C2023343034303430293B0A202070616464696E673A203470782036';
wwv_flow_imp.g_varchar2_table(188) := '70783B0A202077686974652D73706163653A206E6F777261703B0A7D0A2E617065783336302D7064702D666F6F742D62746E3A686F766572207B206261636B67726F756E642D636F6C6F723A207267626128302C302C302C2E3036293B207D0A0A2F2A20';
wwv_flow_imp.g_varchar2_table(189) := 'D8A7D985D8B1D988D8B220E280942074657874206C696E6B207374796C652C207072696D61727920626C75652C206E6F20626F72646572202A2F0A2E617065783336302D7064702D666F6F742D62746E2E617065783336302D7064702D746F646179207B';
wwv_flow_imp.g_varchar2_table(190) := '0A2020626F726465723A206E6F6E653B206261636B67726F756E643A207472616E73706172656E743B0A2020636F6C6F723A20766172282D2D612D70616C657474652D7072696D6172792C2023323536464642293B2070616464696E673A203470782036';
wwv_flow_imp.g_varchar2_table(191) := '70783B0A7D0A2E617065783336302D7064702D666F6F742D62746E2E617065783336302D7064702D746F6461793A686F766572207B20746578742D6465636F726174696F6E3A20756E6465726C696E653B206261636B67726F756E643A207472616E7370';
wwv_flow_imp.g_varchar2_table(192) := '6172656E743B207D0A0A2F2A20D9BED8A7DAA920DAA9D8B1D8AFD98620E280942074657874206C696E6B207374796C652C2064616E676572207265642C206E6F20626F72646572202A2F0A2E617065783336302D7064702D666F6F742D62746E2E617065';
wwv_flow_imp.g_varchar2_table(193) := '783336302D7064702D636C656172207B0A2020626F726465723A206E6F6E653B206261636B67726F756E643A207472616E73706172656E743B0A2020636F6C6F723A20766172282D2D612D70616C657474652D64616E6765722C2023433733373337293B';
wwv_flow_imp.g_varchar2_table(194) := '2070616464696E673A20347078203670783B0A7D0A2E617065783336302D7064702D666F6F742D62746E2E617065783336302D7064702D636C6561723A686F766572207B20746578742D6465636F726174696F6E3A20756E6465726C696E653B20626163';
wwv_flow_imp.g_varchar2_table(195) := '6B67726F756E643A207472616E73706172656E743B207D0A0A2F2A20D8AAD8A3DB8CDB8CD8AF20E2809420736D616C6C20736F6C696420627574746F6E20286F6E6C792072656E6465726564207768656E2053686F772054696D65206973206F6E29202A';
wwv_flow_imp.g_varchar2_table(196) := '2F0A2E617065783336302D7064702D666F6F742D62746E2E617065783336302D7064702D636C6F7365207B0A20206261636B67726F756E642D636F6C6F723A20766172282D2D612D70616C657474652D7072696D6172792C2023323536464642293B0A20';
wwv_flow_imp.g_varchar2_table(197) := '20626F726465722D636F6C6F723A2020202020766172282D2D612D70616C657474652D7072696D6172792C2023323536464642293B0A2020636F6C6F723A202020202020202020202020236666663B0A2020666F6E742D7765696768743A202020202020';
wwv_flow_imp.g_varchar2_table(198) := '766172282D2D612D626173652D666F6E742D7765696768742D626F6C642C20363030293B0A202070616464696E673A2034707820313070783B0A7D0A2E617065783336302D7064702D666F6F742D62746E2E617065783336302D7064702D636C6F73653A';
wwv_flow_imp.g_varchar2_table(199) := '686F766572207B0A20206261636B67726F756E642D636F6C6F723A20766172282D2D612D70616C657474652D7072696D6172792D686F7665722C2023316135656530293B0A2020626F726465722D636F6C6F723A2020202020766172282D2D612D70616C';
wwv_flow_imp.g_varchar2_table(200) := '657474652D7072696D6172792D686F7665722C2023316135656530293B0A7D0A0A2F2A20E29480E29480204D69736320E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E2';
wwv_flow_imp.g_varchar2_table(201) := '9480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E294';
wwv_flow_imp.g_varchar2_table(202) := '80E29480E29480E29480E29480E29480E29480E29480202A2F0A2E617065783336302D7064702D646973706C61792D6F6E6C79207B0A2020646973706C61793A20696E6C696E652D626C6F636B3B20646972656374696F6E3A2072746C3B20746578742D';
wwv_flow_imp.g_varchar2_table(203) := '616C69676E3A2072696768743B0A2020666F6E742D66616D696C793A20766172282D2D612D626173652D666F6E742D66616D696C792C2073616E732D7365726966293B0A2020636F6C6F723A20766172282D2D612D6669656C642D746578742D636F6C6F';
wwv_flow_imp.g_varchar2_table(204) := '722C2023343034303430293B2070616464696E673A2034707820303B0A7D0A0A5B636C6173732A3D22612D4756225D202E617065783336302D7064702D777261707065722C0A2E612D4947202E617065783336302D7064702D77726170706572207B2077';
wwv_flow_imp.g_varchar2_table(205) := '696474683A20313030253B207D0A0A2E752D52544C202E7065727369616E446174657069636B65722D69672D646972207B20646972656374696F6E3A206C74723B207D0A0A406D6564696120286D61782D77696474683A20333830707829207B0A20202E';
wwv_flow_imp.g_varchar2_table(206) := '617065783336302D7064702D6461792020207B206865696768743A20323870783B207D0A20202E617065783336302D7064702D686561646572207B2070616464696E673A2034707820367078203270783B207D0A20202E617065783336302D7064702D66';
wwv_flow_imp.g_varchar2_table(207) := '6F6F746572207B2070616464696E673A20347078203470783B207D0A7D0A0A2F2A20E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590';
wwv_flow_imp.g_varchar2_table(208) := 'E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E2';
wwv_flow_imp.g_varchar2_table(209) := '9590E29590E29590E29590E29590E29590E29590E29590E29590E29590E295900A202020494E4C494E4520444953504C4159204D4F44450A202020E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E295';
wwv_flow_imp.g_varchar2_table(210) := '90E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590';
wwv_flow_imp.g_varchar2_table(211) := 'E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590202A2F0A2E617065783336302D7064702D777261707065722D2D696E6C696E65207B0A2020646973706C61';
wwv_flow_imp.g_varchar2_table(212) := '793A2020626C6F636B3B0A202077696474683A202020206175746F3B0A7D0A2E617065783336302D7064702D706F7075702D2D696E6C696E65207B0A2020706F736974696F6E3A2072656C61746976652021696D706F7274616E743B0A2020746F703A20';
wwv_flow_imp.g_varchar2_table(213) := '20202020206175746F2021696D706F7274616E743B0A20206C6566743A20202020206175746F2021696D706F7274616E743B0A202077696474683A202020206175746F2021696D706F7274616E743B0A20206D61782D77696474683A2033313770783B0A';
wwv_flow_imp.g_varchar2_table(214) := '20207A2D696E6465783A2020313B0A2020616E696D6174696F6E3A206E6F6E653B0A2020646973706C61793A2020626C6F636B2021696D706F7274616E743B0A2020626F782D736861646F773A20766172282D2D612D6669656C642D636F6E7461696E65';
wwv_flow_imp.g_varchar2_table(215) := '722D736861646F772C20302032707820387078207267626128302C302C302C2E313029293B0A7D0A2F2A20496E6C696E653A206E6F20636C6F736520627574746F6E206E6565646564202A2F0A2E617065783336302D7064702D706F7075702D2D696E6C';
wwv_flow_imp.g_varchar2_table(216) := '696E65202E617065783336302D7064702D636C6F7365207B20646973706C61793A206E6F6E653B207D0A0A2F2A20E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590';
wwv_flow_imp.g_varchar2_table(217) := 'E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E2';
wwv_flow_imp.g_varchar2_table(218) := '9590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E295900A202020484F4C49444159204A534F4E20544F4F4C5449500A20202053686F777320686F6C69646179206E616D65206F6E20686F76657220';
wwv_flow_imp.g_varchar2_table(219) := '76696120435353207573696E6720636F6E74656E743A61747472287469746C65290A202020E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590';
wwv_flow_imp.g_varchar2_table(220) := 'E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E2';
wwv_flow_imp.g_varchar2_table(221) := '9590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590202A2F0A2F2A2047726964206E65656473206F766572666C6F773A76697369626C6520736F20746F6F6C7469702063616E206573636170652063656C6C20626F75';
wwv_flow_imp.g_varchar2_table(222) := '6E6473202A2F0A2E617065783336302D7064702D677269642C0A2E617065783336302D7064702D677269642D726F77207B0A20206F766572666C6F773A2076697369626C653B0A7D0A2E617065783336302D7064702D6461795B7469746C655D207B0A20';
wwv_flow_imp.g_varchar2_table(223) := '20706F736974696F6E3A2072656C61746976653B0A20206F766572666C6F773A2076697369626C653B0A7D0A2F2A20546F6F6C74697020627562626C65202A2F0A2E617065783336302D7064702D6461795B7469746C655D3A686F7665723A3A61667465';
wwv_flow_imp.g_varchar2_table(224) := '72207B0A2020636F6E74656E743A2061747472287469746C65293B0A2020706F736974696F6E3A206162736F6C7574653B0A2020626F74746F6D3A2063616C632831303025202B20367078293B0A20206C6566743A203530253B0A20207472616E73666F';
wwv_flow_imp.g_varchar2_table(225) := '726D3A207472616E736C61746558282D353025293B0A20206261636B67726F756E643A20726762612832302C32302C32302C2E3935293B0A2020636F6C6F723A20236666663B0A2020666F6E742D73697A653A20302E373272656D3B0A2020666F6E742D';
wwv_flow_imp.g_varchar2_table(226) := '66616D696C793A20696E68657269743B0A20206C696E652D6865696768743A20312E343B0A202070616464696E673A20347078203870783B0A2020626F726465722D7261646975733A203570783B0A2020706F696E7465722D6576656E74733A206E6F6E';
wwv_flow_imp.g_varchar2_table(227) := '653B0A20207A2D696E6465783A2033303030303B0A2020646972656374696F6E3A2072746C3B0A202077696474683A206D61782D636F6E74656E743B0A20206D61782D77696474683A2031383070783B0A202077686974652D73706163653A206E6F726D';
wwv_flow_imp.g_varchar2_table(228) := '616C3B0A2020746578742D616C69676E3A2063656E7465723B0A2020626F782D736861646F773A20302032707820387078207267626128302C302C302C2E33293B0A7D0A2F2A20546F6F6C746970206172726F77202A2F0A2E617065783336302D706470';
wwv_flow_imp.g_varchar2_table(229) := '2D6461795B7469746C655D3A686F7665723A3A6265666F7265207B0A2020636F6E74656E743A2027273B0A2020706F736974696F6E3A206162736F6C7574653B0A2020626F74746F6D3A2063616C632831303025202B20317078293B0A20206C6566743A';
wwv_flow_imp.g_varchar2_table(230) := '203530253B0A20207472616E73666F726D3A207472616E736C61746558282D353025293B0A2020626F726465723A2035707820736F6C6964207472616E73706172656E743B0A2020626F726465722D746F702D636F6C6F723A20726762612832302C3230';
wwv_flow_imp.g_varchar2_table(231) := '2C32302C2E3935293B0A2020706F696E7465722D6576656E74733A206E6F6E653B0A20207A2D696E6465783A2033303030303B0A7D0A';
null;
end;
/
begin
wwv_flow_imp_shared.create_plugin_file(
 p_id=>wwv_flow_imp.id(158266056596050556188)
,p_plugin_id=>wwv_flow_imp.id(158266056596050555837)
,p_file_name=>'css/apex360-persian-datepicker.css'
,p_mime_type=>'text/css'
,p_file_content=>wwv_flow_imp.varchar2_to_blob(wwv_flow_imp.g_varchar2_table)
);
end;
/
begin
wwv_flow_imp.g_varchar2_table := wwv_flow_imp.empty_varchar2_table;
wwv_flow_imp.g_varchar2_table(1) := '2F2A2A0A202A204972616E69616E2028536F6C61722048696A7269202F204A616C616C69292043616C656E64617220E28094205374616E64616C6F6E65204C6962726172790A202A204578747261637465642066726F6D206A71756572792E63616C656E';
wwv_flow_imp.g_varchar2_table(2) := '646172732E6972616E69616E2E6A73206279204B6569746820576F6F6420284D4954206C6963656E6365290A202A204164617074656420746F20776F726B20574954484F555420616E792065787465726E616C20646570656E64656E6369657320286E6F';
wwv_flow_imp.g_varchar2_table(3) := '20242E63616C656E64617273206E6565646564292E0A202A0A202A204578706F7365642061733A2077696E646F772E4972616E69616E43616C0A202A0A202A204150493A0A202A2020204972616E69616E43616C2E746F4972616E69616E286759656172';
wwv_flow_imp.g_varchar2_table(4) := '2C20674D6F6E74682C2067446179292020202020E28692207B792C206D2C20647D0A202A2020204972616E69616E43616C2E746F477265676F7269616E2869596561722C20694D6F6E74682C20694461792920202020E28692207B67792C20676D2C2067';
wwv_flow_imp.g_varchar2_table(5) := '647D0A202A2020204972616E69616E43616C2E746F64617928292020202020202020202020202020202020202020202020202020202020E28692207B792C206D2C20647D0A202A2020204972616E69616E43616C2E64617973496E4D6F6E746828796561';
wwv_flow_imp.g_varchar2_table(6) := '722C206D6F6E746829202020202020202020202020E28692206E756D6265720A202A2020204972616E69616E43616C2E69734C656170287965617229202020202020202020202020202020202020202020202020E2869220626F6F6C65616E0A202A2020';
wwv_flow_imp.g_varchar2_table(7) := '204972616E69616E43616C2E6461794F665765656B2869596561722C20694D6F6E74682C206944617929202020202020E2869220302D362028303D53617420E280A620363D467269290A202A2020204972616E69616E43616C2E697356616C696428792C';
wwv_flow_imp.g_varchar2_table(8) := '206D2C2064292020202020202020202020202020202020202020E2869220626F6F6C65616E0A202A2020204972616E69616E43616C2E666F726D617428792C206D2C20642C20666D742C207573655065727369616E2920202020E2869220737472696E67';
wwv_flow_imp.g_varchar2_table(9) := '0A202A2020204972616E69616E43616C2E7061727365287374722C20666D7429202020202020202020202020202020202020202020E28692207B792C6D2C647D206F72206E756C6C0A202A2020204972616E69616E43616C2E746F5065727369616E2873';
wwv_flow_imp.g_varchar2_table(10) := '74722920202020202020202020202020202020202020202020E2869220737472696E672077697468205065727369616E206469676974730A202A2020204972616E69616E43616C2E746F4C6174696E287374722920202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(11) := '2020202020202020E2869220737472696E672077697468204C6174696E206469676974730A202A0A202A204D6F6E7468206E616D657320284661727369293A0A202A2020204972616E69616E43616C2E6D6F6E74684E616D65735B302E2E31315D0A202A';
wwv_flow_imp.g_varchar2_table(12) := '2020204972616E69616E43616C2E6D6F6E74684E616D657353686F72745B302E2E31315D0A202A0A202A20446179206E616D657320284661727369293A20206461794E616D65735B302E2E365D2020303D53617420E280A620363D4672690A202A0A202A';
wwv_flow_imp.g_varchar2_table(13) := '20416C676F726974686D206372656469743A204B6569746820576F6F642C206B62776F6F642E617540676D61696C2E636F6D2C204D61726368203230323520284D4954290A202A2F0A2866756E6374696F6E2028676C6F62616C29207B0A202027757365';
wwv_flow_imp.g_varchar2_table(14) := '20737472696374273B0A0A20202F2A20E29480E294802048656C7065722061726974686D6574696320E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E294';
wwv_flow_imp.g_varchar2_table(15) := '80E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480202A2F0A202066756E6374696F6E2064697628612C206229207B2072657475726E';
wwv_flow_imp.g_varchar2_table(16) := '207E7E2861202F2062293B207D0A202066756E6374696F6E206D6F6428612C206229207B2072657475726E2061202D207E7E2861202F206229202A20623B207D0A0A20202F2A20E29480E29480205370656369616C207965617220626F756E6461726965';
wwv_flow_imp.g_varchar2_table(17) := '7320666F72206C6561702063616C63756C6174696F6E20E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480202A2F0A2020766172205350454349414C203D205B2D36312C20392C2033382C';
wwv_flow_imp.g_varchar2_table(18) := '203139392C203432362C203638362C203735362C203831382C20313131312C20313138312C0A2020202020202020202020202020202020313231302C20313633352C20323036302C20323039372C20323139322C20323236322C20323332342C20323339';
wwv_flow_imp.g_varchar2_table(19) := '342C20323435362C20333137385D3B0A2020766172204C415354203D205350454349414C2E6C656E677468202D20313B0A0A20202F2A20E29480E29480204461797320706572206D6F6E74682028636F6D6D6F6E20796561722920E29480E29480E29480';
wwv_flow_imp.g_varchar2_table(20) := 'E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480202A2F0A202076617220444159535F5045525F';
wwv_flow_imp.g_varchar2_table(21) := '4D4F4E5448203D205B33312C2033312C2033312C2033312C2033312C2033312C2033302C2033302C2033302C2033302C2033302C2032395D3B0A0A20202F2A20E29480E29480205065727369616E2064696769747320E29480E29480E29480E29480E294';
wwv_flow_imp.g_varchar2_table(22) := '80E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480';
wwv_flow_imp.g_varchar2_table(23) := 'E29480E29480E29480E29480E29480E29480E29480202A2F0A20207661722046415F444947495453203D205B27DBB0272C27DBB1272C27DBB2272C27DBB3272C27DBB4272C27DBB5272C27DBB6272C27DBB7272C27DBB8272C27DBB9275D3B0A0A202066';
wwv_flow_imp.g_varchar2_table(24) := '756E6374696F6E20746F5065727369616E2873747229207B0A2020202072657475726E20537472696E6728737472292E7265706C616365282F5B302D395D2F672C2066756E6374696F6E286429207B2072657475726E2046415F4449474954535B2B645D';
wwv_flow_imp.g_varchar2_table(25) := '3B207D293B0A20207D0A202066756E6374696F6E20746F4C6174696E2873747229207B0A2020202072657475726E20537472696E6728737472290A2020202020202E7265706C616365282F5BDBB02DDBB95D2F672C2066756E6374696F6E286429207B20';
wwv_flow_imp.g_varchar2_table(26) := '72657475726E2046415F4449474954532E696E6465784F662864293B207D290A2020202020202E7265706C616365282F5BD9A02DD9A95D2F672C2066756E6374696F6E286429207B2072657475726E20642E63686172436F64654174283029202D203078';
wwv_flow_imp.g_varchar2_table(27) := '303636303B207D293B0A20207D0A202066756E6374696F6E2070616432286E29207B2072657475726E206E203C203130203F20273027202B206E203A202727202B206E3B207D0A0A20202F2A20E29480E29480205965617220696E666F20E29480E29480';
wwv_flow_imp.g_varchar2_table(28) := 'E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E2';
wwv_flow_imp.g_varchar2_table(29) := '9480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480202A2F0A202066756E6374696F6E2079656172496E666F287965617229207B0A202020206966202879656172203C203029207B2079';
wwv_flow_imp.g_varchar2_table(30) := '6561722B2B3B207D0A20202020766172206779203D2079656172202B203632313B0A20202020766172206D20203D202D31343B0A20202020766172207072657653706563203D205350454349414C5B305D3B0A202020207661722073706563446966663B';
wwv_flow_imp.g_varchar2_table(31) := '0A20202020666F7220287661722069203D20313B2069203C3D204C41535420262620287370656344696666203D205350454349414C5B695D202D2070726576537065632C205350454349414C5B695D203C3D2079656172293B20692B2B29207B0A202020';
wwv_flow_imp.g_varchar2_table(32) := '2020206D202B3D2038202A206469762873706563446966662C20333329202B20646976286D6F642873706563446966662C203333292C2034293B0A2020202020207072657653706563203D205350454349414C5B695D3B0A202020207D0A202020207661';
wwv_flow_imp.g_varchar2_table(33) := '72206F6666736574203D2079656172202D2070726576537065633B0A202020206D202B3D2038202A20646976286F66667365742C20333329202B20646976286D6F64286F66667365742C20333329202B20332C2034293B0A20202020696620286D6F6428';
wwv_flow_imp.g_varchar2_table(34) := '73706563446966662C20333329203D3D3D2034202626207370656344696666202D206F6666736574203D3D3D203429207B206D2B2B3B207D0A20202020766172207220202020203D206469762867792C203429202D206469762833202A20286469762867';
wwv_flow_imp.g_varchar2_table(35) := '792C2031303029202B2031292C203429202D203135303B0A20202020766172206D61726368203D203230202B206D202D20723B0A20202020696620287370656344696666202D206F6666736574203C203629207B0A2020202020206F6666736574203D20';
wwv_flow_imp.g_varchar2_table(36) := '6F6666736574202D207370656344696666202B203333202A20646976287370656344696666202B20342C203333293B0A202020207D0A20202020766172206C656170203D206D6F64286D6F64286F6666736574202B20312C20333329202D20312C203429';
wwv_flow_imp.g_varchar2_table(37) := '3B0A202020206C656170203D20286C656170203D3D3D202D31203F2034203A206C656170293B0A2020202072657475726E207B2067793A2067792C206C6561703A206C6561702C206D617263683A206D61726368207D3B0A20207D0A0A2020202066756E';
wwv_flow_imp.g_varchar2_table(38) := '6374696F6E2067326428796561722C206D6F6E74682C2064617929207B0A202020207661722069203D207E7E2831343631202A202879656172202B207E7E28286D6F6E7468202D203829202F203629202B2031303031303029202F203429202B0A202020';
wwv_flow_imp.g_varchar2_table(39) := '2020202020202020207E7E2828313533202A2028286D6F6E7468202B203929202520313229202B203229202F203529202B20646179202D2033343834303430383B0A2020202072657475726E2069202D207E7E2833202A207E7E282879656172202B2031';
wwv_flow_imp.g_varchar2_table(40) := '3030313030202B207E7E28286D6F6E7468202D203829202F20362929202F2031303029202F203429202B20373532202D20302E353B0A20207D0A0A202066756E6374696F6E2064326779286A6429207B0A20202020766172206920203D2034202A20286A';
wwv_flow_imp.g_varchar2_table(41) := '64202B20302E3529202B20313339333631363331202B0A2020202020202020202020202034202A207E7E2833202A207E7E282834202A20286A64202B20302E3529202B2031383331383737323029202F2031343630393729202F203429202D2033393038';
wwv_flow_imp.g_varchar2_table(42) := '3B0A20202020766172206A20203D2035202A207E7E2828692025203134363129202F203429202B203330383B0A2020202076617220676D203D20287E7E286A202F2031353329202520313229202B20313B0A20202020766172206764203D207E7E28286A';
wwv_flow_imp.g_varchar2_table(43) := '20252031353329202F203529202B20313B0A20202020766172206779203D207E7E2869202F203134363129202D20313030313030202B207E7E282838202D20676D29202F2036293B0A2020202072657475726E207B2067793A2067792C20676D3A20676D';
wwv_flow_imp.g_varchar2_table(44) := '2C2067643A206764207D3B0A20207D0A0A20202F2A20557365204A5320446174652061726974686D6574696320666F72204A616C616C692D3E477265676F7269616E20E2809420696D6D756E6520746F204A444E20726F756E64696E672062756773202A';
wwv_flow_imp.g_varchar2_table(45) := '2F0A202066756E6374696F6E206972616E69616E546F4A53446174652869792C20696D2C20696429207B0A2020202076617220696E666F203D2079656172496E666F286979293B0A20202020766172206E6F7772757A203D206E6577204461746528696E';
wwv_flow_imp.g_varchar2_table(46) := '666F2E67792C20322C20696E666F2E6D61726368293B202F2F2032203D204D617263680A20202020766172206461794F6659656172203D2028696D203C3D2036290A2020202020203F2028696D202D203129202A203331202B20286964202D2031290A20';
wwv_flow_imp.g_varchar2_table(47) := '20202020203A20313836202B2028696D202D203729202A203330202B20286964202D2031293B0A2020202072657475726E206E65772044617465286E6F7772757A2E67657454696D652829202B206461794F6659656172202A203836343030303030293B';
wwv_flow_imp.g_varchar2_table(48) := '0A20207D0A0A202066756E6374696F6E206A64546F4972616E69616E286A6429207B0A202020206A64203D204D6174682E666C6F6F72286A6429202B20302E353B0A202020207661722067203D2064326779286A64293B0A20202020766172206979203D';
wwv_flow_imp.g_varchar2_table(49) := '20672E6779202D203632313B0A2020202076617220696E666F203D2079656172496E666F286979293B0A20202020766172206A644E203D2067326428672E67792C20332C20696E666F2E6D61726368293B0A20202020766172206B2020203D204D617468';
wwv_flow_imp.g_varchar2_table(50) := '2E666C6F6F72286A64202D206A644E293B0A20202020696620286B203E3D203029207B0A202020202020696620286B203C3D2031383529207B0A202020202020202076617220696D203D2031202B207E7E286B202F203331293B0A202020202020202076';
wwv_flow_imp.g_varchar2_table(51) := '6172206964203D20286B202520333129202B20313B0A202020202020202072657475726E207B20793A2069792C206D3A20696D2C20643A206964207D3B0A2020202020207D0A2020202020206B202D3D203138363B0A202020207D20656C7365207B0A20';
wwv_flow_imp.g_varchar2_table(52) := '202020202069792D2D3B0A202020202020696E666F203D2079656172496E666F286979293B0A2020202020206B202B3D203137393B0A20202020202069662028696E666F2E6C656170203D3D3D203129207B206B2B2B3B207D0A202020207D0A20202020';
wwv_flow_imp.g_varchar2_table(53) := '76617220696D32203D2037202B207E7E286B202F203330293B0A2020202076617220696432203D20286B202520333029202B20313B0A2020202072657475726E207B20793A2069792C206D3A20696D322C20643A20696432207D3B0A20207D0A0A202076';
wwv_flow_imp.g_varchar2_table(54) := '6172204972616E69616E43616C203D207B0A0A202020206D6F6E74684E616D65733A205B27D981D8B1D988D8B1D8AFDB8CD986272C27D8A7D8B1D8AFDB8CD8A8D987D8B4D8AA272C27D8AED8B1D8AFD8A7D8AF272C27D8AADB8CD8B1272C27D985D8B1D8';
wwv_flow_imp.g_varchar2_table(55) := 'AFD8A7D8AF272C27D8B4D987D8B1DB8CD988D8B1272C0A202020202020202020202020202020202027D985D987D8B1272C27D8A2D8A8D8A7D986272C27D8A2D8B0D8B1272C27D8AFDB8C272C27D8A8D987D985D986272C27D8A7D8B3D981D986D8AF275D';
wwv_flow_imp.g_varchar2_table(56) := '2C0A202020206D6F6E74684E616D657353686F72743A205B27D981D8B1D988D8B1D8AFDB8CD986272C27D8A7D8B1D8AFDB8CD8A8D987D8B4D8AA272C27D8AED8B1D8AFD8A7D8AF272C27D8AADB8CD8B1272C27D985D8B1D8AFD8A7D8AF272C27D8B4D987';
wwv_flow_imp.g_varchar2_table(57) := 'D8B1DB8CD988D8B1272C0A2020202020202020202020202020202020202020202027D985D987D8B1272C27D8A2D8A8D8A7D986272C27D8A2D8B0D8B1272C27D8AFDB8C272C27D8A8D987D985D986272C27D8A7D8B3D981D986D8AF275D2C0A202020202F';
wwv_flow_imp.g_varchar2_table(58) := '2F20303D5361742C20313D53756E2C20323D4D6F6E2C20333D5475652C20343D5765642C20353D5468752C20363D4672690A202020206461794E616D65733A205B27D8B4D986D8A8D987272C27DB8CDAA9D8B4D986D8A8D987272C27D8AFD988D8B4D986';
wwv_flow_imp.g_varchar2_table(59) := 'D8A8D987272C27D8B3D987E2808CD8B4D986D8A8D987272C27DA86D987D8A7D8B1D8B4D986D8A8D987272C27D9BED986D8ACD8B4D986D8A8D987272C27D8ACD985D8B9D987275D2C0A0A20202020746F5065727369616E3A20746F5065727369616E2C0A';
wwv_flow_imp.g_varchar2_table(60) := '20202020746F4C6174696E3A202020746F4C6174696E2C0A0A20202020746F4972616E69616E3A2066756E6374696F6E2867792C20676D2C20676429207B0A20202020202072657475726E206A64546F4972616E69616E286732642867792C20676D2C20';
wwv_flow_imp.g_varchar2_table(61) := '676429293B0A202020207D2C0A0A20202020746F477265676F7269616E3A2066756E6374696F6E2869792C20696D2C20696429207B0A202020202020766172206A7344617465203D206972616E69616E546F4A53446174652869792C20696D2C20696429';
wwv_flow_imp.g_varchar2_table(62) := '3B0A20202020202072657475726E207B2067793A206A73446174652E67657446756C6C5965617228292C20676D3A206A73446174652E6765744D6F6E746828292B312C2067643A206A73446174652E676574446174652829207D3B0A202020207D2C0A0A';
wwv_flow_imp.g_varchar2_table(63) := '20202020746F6461793A2066756E6374696F6E2829207B0A202020202020766172206E6F77203D206E6577204461746528293B0A20202020202072657475726E204972616E69616E43616C2E746F4972616E69616E286E6F772E67657446756C6C596561';
wwv_flow_imp.g_varchar2_table(64) := '7228292C206E6F772E6765744D6F6E746828292B312C206E6F772E676574446174652829293B0A202020207D2C0A0A2020202069734C6561703A2066756E6374696F6E287965617229207B0A20202020202072657475726E2079656172496E666F287965';
wwv_flow_imp.g_varchar2_table(65) := '6172292E6C656170203D3D3D20303B0A202020207D2C0A0A2020202064617973496E4D6F6E74683A2066756E6374696F6E28796561722C206D6F6E746829207B0A202020202020696620286D6F6E7468203C2031207C7C206D6F6E7468203E2031322920';
wwv_flow_imp.g_varchar2_table(66) := '72657475726E20303B0A202020202020696620286D6F6E7468203C3D2036292072657475726E2033313B0A202020202020696620286D6F6E7468203C3D203131292072657475726E2033303B0A20202020202072657475726E204972616E69616E43616C';
wwv_flow_imp.g_varchar2_table(67) := '2E69734C656170287965617229203F203330203A2032393B0A202020207D2C0A0A202020206461794F665765656B3A2066756E6374696F6E2869792C20696D2C20696429207B0A202020202020766172206A7344617465203D206972616E69616E546F4A';
wwv_flow_imp.g_varchar2_table(68) := '53446174652869792C20696D2C206964293B0A20202020202072657475726E20286A73446174652E6765744461792829202B203129202520373B0A202020207D2C0A0A20202020697356616C69643A2066756E6374696F6E28792C206D2C206429207B0A';
wwv_flow_imp.g_varchar2_table(69) := '202020202020696620282179207C7C206D203C2031207C7C206D203E203132207C7C2064203C2031292072657475726E2066616C73653B0A20202020202072657475726E2064203C3D204972616E69616E43616C2E64617973496E4D6F6E746828792C20';
wwv_flow_imp.g_varchar2_table(70) := '6D293B0A202020207D2C0A0A202020202F2A2A0A20202020202A20466F726D6174204972616E69616E206461746520746F20737472696E672E0A20202020202A20537570706F7274656420746F6B656E7320286170706C69656420696E2074686973206F';
wwv_flow_imp.g_varchar2_table(71) := '72646572293A0A20202020202A202020666D44617920202020E28692207765656B646179206E616D652028D8AFD988D8B4D986D8A8D987206574632E290A20202020202A202020666D4D6F6E74682020E286922066756C6C206D6F6E7468206E616D6520';
wwv_flow_imp.g_varchar2_table(72) := '28D981D8B1D988D8B1D8AFDB8CD986206574632E290A20202020202A202020666D44442020202020E286922064617920776974686F7574206C656164696E67207A65726F2028DBB1206F722031290A20202020202A2020204D4F4E202020202020E28692';
wwv_flow_imp.g_varchar2_table(73) := '2066756C6C206D6F6E7468206E616D652028616C69617320666F7220666D4D6F6E7468290A20202020202A202020595959592020202020E2869220342D646967697420796561720A20202020202A202020595959202020202020E2869220342D64696769';
wwv_flow_imp.g_varchar2_table(74) := '7420796561722028616C6961732C2073616D65290A20202020202A2020204D4D20202020202020E2869220322D6469676974206D6F6E7468206E756D6265720A20202020202A202020444420202020202020E2869220322D6469676974206461790A2020';
wwv_flow_imp.g_varchar2_table(75) := '2020202A20202048483A4D4920202020E2869220686F75723A6D696E75746520706C616365686F6C64657220286B6570742061732D69732C2063616C6C657220617070656E64732074696D65290A20202020202A2F0A20202020666F726D61743A206675';
wwv_flow_imp.g_varchar2_table(76) := '6E6374696F6E28792C206D2C20642C20666D742C207573655065727369616E2C2068682C206D6929207B0A202020202020666D74203D20666D74207C7C2027595959592F4D4D2F4444273B0A2020202020206868203D2028686820213D3D20756E646566';
wwv_flow_imp.g_varchar2_table(77) := '696E656429203F206868203A20303B0A2020202020206D69203D20286D6920213D3D20756E646566696E656429203F206D69203A20303B0A0A202020202020766172206D6F6E74684E616D65203D204972616E69616E43616C2E6D6F6E74684E616D6573';
wwv_flow_imp.g_varchar2_table(78) := '5B6D202D20315D207C7C2027273B0A20202020202076617220646F77202020202020203D204972616E69616E43616C2E6461794F665765656B28792C206D2C2064293B0A202020202020766172206461794E616D652020203D204972616E69616E43616C';
wwv_flow_imp.g_varchar2_table(79) := '2E6461794E616D65735B646F775D207C7C2027273B0A20202020202076617220644E6F5A65726F2020203D20537472696E672864293B0A20202020202076617220685374722020202020203D2070616432286868293B0A202020202020766172206D5374';
wwv_flow_imp.g_varchar2_table(80) := '722020202020203D2070616432286D69293B0A0A20202020202076617220726573756C74203D20666D740A20202020202020202E7265706C616365282F666D4461792F672C2020206461794E616D65290A20202020202020202E7265706C616365282F66';
wwv_flow_imp.g_varchar2_table(81) := '6D4D6F6E74682F672C206D6F6E74684E616D65290A20202020202020202E7265706C616365282F666D44442F672C20202020644E6F5A65726F290A20202020202020202E7265706C616365282F4D4F4E2F672C20202020206D6F6E74684E616D65290A20';
wwv_flow_imp.g_varchar2_table(82) := '202020202020202E7265706C616365282F595959597C5959592F672C20537472696E67287929290A20202020202020202E7265706C616365282F4D4D2F672C20202020202070616432286D29290A20202020202020202E7265706C616365282F44442F67';
wwv_flow_imp.g_varchar2_table(83) := '2C20202020202070616432286429290A20202020202020202E7265706C616365282F48483A4D492F672C20202068537472202B20273A27202B206D537472293B0A0A20202020202072657475726E207573655065727369616E203F20746F506572736961';
wwv_flow_imp.g_varchar2_table(84) := '6E28726573756C7429203A20726573756C743B0A202020207D2C0A0A202020202F2A2A0A20202020202A205061727365204972616E69616E206461746520737472696E6720E28692207B792C206D2C20647D206F72206E756C6C2E0A20202020202A204F';
wwv_flow_imp.g_varchar2_table(85) := '6E6C7920706172736573206E756D6572696320666F726D6174732028595959592F4D4D2F44442C2044442F4D4D2F595959592C20595959592D4D4D2D4444206574632E290A20202020202A204E6F6E2D6E756D6572696320646973706C617920666F726D';
wwv_flow_imp.g_varchar2_table(86) := '61747320286D6F6E7468206E616D65732C20646179206E616D65732920617265206E6F74207061727365642E0A20202020202A2F0A2020202070617273653A2066756E6374696F6E287374722C20666D7429207B0A202020202020696620282173747229';
wwv_flow_imp.g_varchar2_table(87) := '2072657475726E206E756C6C3B0A202020202020737472203D20746F4C6174696E28537472696E6728737472292E7472696D2829293B0A202020202020666D74203D2028666D74207C7C2027595959592F4D4D2F444427292E746F557070657243617365';
wwv_flow_imp.g_varchar2_table(88) := '28293B0A0A2020202020202F2F204F6E6C7920617474656D707420706172736520666F72206E756D657269632D6F6E6C7920666F726D6174730A2020202020207661722079496478203D20666D742E696E6465784F6628275959595927293B0A20202020';
wwv_flow_imp.g_varchar2_table(89) := '2020766172206D496478203D20666D742E696E6465784F6628274D4D27293B0A2020202020207661722064496478203D20666D742E696E6465784F662827444427293B0A2020202020206966202879496478203C2030207C7C206D496478203C2030207C';
wwv_flow_imp.g_varchar2_table(90) := '7C2064496478203C2030292072657475726E206E756C6C3B0A0A202020202020766172207365704D61746368203D207374722E6D61746368282F5B5E302D395D2F293B0A20202020202076617220736570203D207365704D61746368203F207365704D61';
wwv_flow_imp.g_varchar2_table(91) := '7463685B305D203A20272F273B0A202020202020766172207061727473203D207374722E73706C697428736570293B0A2020202020206966202870617274732E6C656E677468203C2033292072657475726E206E756C6C3B0A0A20202020202076617220';
wwv_flow_imp.g_varchar2_table(92) := '6F72646572203D205B0A20202020202020207B20743A202779272C20693A2079496478207D2C0A20202020202020207B20743A20276D272C20693A206D496478207D2C0A20202020202020207B20743A202764272C20693A2064496478207D0A20202020';
wwv_flow_imp.g_varchar2_table(93) := '20205D2E736F72742866756E6374696F6E28612C2062297B2072657475726E20612E69202D20622E693B207D293B0A0A2020202020207661722076616C73203D207B7D3B0A202020202020666F7220287661722069203D20303B2069203C20333B20692B';
wwv_flow_imp.g_varchar2_table(94) := '2B29207B0A202020202020202076616C735B6F726465725B695D2E745D203D207061727365496E742870617274735B695D2C203130293B0A2020202020207D0A202020202020696620282176616C732E79207C7C202176616C732E6D207C7C202176616C';
wwv_flow_imp.g_varchar2_table(95) := '732E64292072657475726E206E756C6C3B0A20202020202069662028214972616E69616E43616C2E697356616C69642876616C732E792C2076616C732E6D2C2076616C732E6429292072657475726E206E756C6C3B0A20202020202072657475726E207B';
wwv_flow_imp.g_varchar2_table(96) := '20793A2076616C732E792C206D3A2076616C732E6D2C20643A2076616C732E64207D3B0A202020207D2C0A0A20202020636F6D706172653A2066756E6374696F6E28612C206229207B0A20202020202069662028612E7920213D3D20622E792920726574';
wwv_flow_imp.g_varchar2_table(97) := '75726E20612E79203C20622E79203F202D31203A20313B0A20202020202069662028612E6D20213D3D20622E6D292072657475726E20612E6D203C20622E6D203F202D31203A20313B0A20202020202069662028612E6420213D3D20622E642920726574';
wwv_flow_imp.g_varchar2_table(98) := '75726E20612E64203C20622E64203F202D31203A20313B0A20202020202072657475726E20303B0A202020207D0A20207D3B0A0A2020676C6F62616C2E4972616E69616E43616C203D204972616E69616E43616C3B0A0A7D28747970656F662077696E64';
wwv_flow_imp.g_varchar2_table(99) := '6F7720213D3D2027756E646566696E656427203F2077696E646F77203A207468697329293B0A';
null;
end;
/
begin
wwv_flow_imp_shared.create_plugin_file(
 p_id=>wwv_flow_imp.id(158266056596050556186)
,p_plugin_id=>wwv_flow_imp.id(158266056596050555837)
,p_file_name=>'js/apex360-dp-jalali-calendar.js'
,p_mime_type=>'application/javascript'
,p_file_content=>wwv_flow_imp.varchar2_to_blob(wwv_flow_imp.g_varchar2_table)
);
end;
/
begin
wwv_flow_imp.g_varchar2_table := wwv_flow_imp.empty_varchar2_table;
wwv_flow_imp.g_varchar2_table(1) := '2F2A0A202A20204F7261636C652041504558205065727369616E20284A616C616C692F4972616E69616E292044617465205069636B65720A202A2020506C7567696E3A2049522E415045583336302E5045525349414E444154455049434B45520A202A20';
wwv_flow_imp.g_varchar2_table(2) := '20415045582076657273696F6E733A2032342E322B0A202A2020437265617465642042792053616565642048617373616E706F75720A202A2020436F6D70616E79203A205061796120536865746162616E20416E6469736865682841504558333630292D';
wwv_flow_imp.g_varchar2_table(3) := '2068747470733A2F2F617065783336302E696E666F0A202A202044617465202020203A20323032362F30340A202A202054656C656772616D3A2040536165656448617373616E706F7572207C2040617065783336300A202A202054776974746572203A20';
wwv_flow_imp.g_varchar2_table(4) := '4048617373616E706F757253616565640A202A2020456D61696C2020203A20696E666F40617065783336302E696E666F0A202A2F0A2F2A2A0A202A20406E616D65737061636520617065783336300A202A2F0A7661722061706578333630203D20617065';
wwv_flow_imp.g_varchar2_table(5) := '78333630207C7C207B7D3B0A0A3B2866756E6374696F6E2028242C20617065782C2049432C20617065783336302C20756E646566696E656429207B0A20202775736520737472696374273B0A0A20206966202821494329207B0A20202020636F6E736F6C';
wwv_flow_imp.g_varchar2_table(6) := '652E6572726F7228275B617065783336302E5044505D204972616E69616E43616C206E6F7420666F756E6420E28094206C6F6164206A616C616C692D63616C656E6461722E6A7320666972737427293B0A2020202072657475726E3B0A20207D0A0A2020';
wwv_flow_imp.g_varchar2_table(7) := '76617220504C5547494E5F4E414D45203D2027617065783336305065727369616E446174655069636B6572273B0A0A0A202066756E6374696F6E2070616432286E29207B2072657475726E206E203C203130203F20273027202B206E203A202727202B20';
wwv_flow_imp.g_varchar2_table(8) := '6E3B207D0A0A202066756E6374696F6E2069735061676552544C2829207B2072657475726E2024282768746D6C27292E686173436C6173732827752D52544C27293B207D0A0A202066756E6374696F6E207061727365486F6C6964617973287374722C20';
wwv_flow_imp.g_varchar2_table(9) := '6F666673657429207B0A2020202076617220736574203D207B7D3B0A202020206966202821737472292072657475726E207365743B0A202020206F6666736574203D206F6666736574207C7C20303B0A2020202076617220656E7472696573203D204943';
wwv_flow_imp.g_varchar2_table(10) := '2E746F4C6174696E28537472696E672873747229292E73706C697428272C27293B0A20202020666F7220287661722069203D20303B2069203C20656E74726965732E6C656E6774683B20692B2B29207B0A2020202020207661722065203D20656E747269';
wwv_flow_imp.g_varchar2_table(11) := '65735B695D2E7472696D28292E7265706C616365282F2D2F672C20272F27293B0A202020202020766172207061727473203D20652E73706C697428272F27293B0A2020202020206966202870617274732E6C656E67746820213D3D20332920636F6E7469';
wwv_flow_imp.g_varchar2_table(12) := '6E75653B0A2020202020207661722079203D207061727365496E742870617274735B305D2C313029202D206F66667365743B0A202020202020766172206D203D207061727365496E742870617274735B315D2C3130292C2064203D207061727365496E74';
wwv_flow_imp.g_varchar2_table(13) := '2870617274735B325D2C3130293B0A2020202020206966202879202626206D202626206429207365745B792B272F272B6D2B272F272B645D203D20747275653B0A202020207D0A2020202072657475726E207365743B0A20207D0A0A202066756E637469';
wwv_flow_imp.g_varchar2_table(14) := '6F6E20686F6C696461794B6579286429207B2072657475726E20642E792B272F272B642E6D2B272F272B642E643B207D0A0A20202F2A2A20506172736520636F6D6D612D7365706172617465642079656172206C6973743A2022313430342C313430352C';
wwv_flow_imp.g_varchar2_table(15) := '313430362220E2869220536574207B313430343A747275652C2E2E2E7D202A2F0A202066756E6374696F6E2070617273655965617252616E6765287374722C206F666673657429207B0A2020202076617220736574203D207B7D3B0A2020202069662028';
wwv_flow_imp.g_varchar2_table(16) := '21737472292072657475726E207365743B0A202020206F6666736574203D206F6666736574207C7C20303B0A2020202049432E746F4C6174696E28537472696E672873747229292E73706C697428272C27292E666F72456163682866756E6374696F6E28';
wwv_flow_imp.g_varchar2_table(17) := '7629207B0A202020202020766172206E203D207061727365496E7428762E7472696D28292C203130293B0A202020202020696620286E29207365745B6E202D206F66667365745D203D20747275653B0A202020207D293B0A2020202072657475726E2073';
wwv_flow_imp.g_varchar2_table(18) := '65743B0A20207D0A0A20202F2A2A20506172736520636F6D6D612D736570617261746564206D6F6E7468206C6973743A202230312C30332C30362220E2869220536574207B313A747275652C333A747275652C363A747275657D202A2F0A202066756E63';
wwv_flow_imp.g_varchar2_table(19) := '74696F6E2070617273654D6F6E746852616E67652873747229207B0A2020202076617220736574203D207B7D3B0A202020206966202821737472292072657475726E207365743B0A2020202049432E746F4C6174696E28537472696E672873747229292E';
wwv_flow_imp.g_varchar2_table(20) := '73706C697428272C27292E666F72456163682866756E6374696F6E287629207B0A202020202020766172206E203D207061727365496E7428762E7472696D28292C203130293B0A202020202020696620286E203E3D2031202626206E203C3D2031322920';
wwv_flow_imp.g_varchar2_table(21) := '7365745B6E5D203D20747275653B0A202020207D293B0A2020202072657475726E207365743B0A20207D0A0A20202F2A2A0A2020202A20506172736520686F6C69646179204A534F4E2E0A2020202A20496E707574206D61792062653A0A2020202A2020';
wwv_flow_imp.g_varchar2_table(22) := '202D206120737472696E6720203A20275B7B2264617465223A22313430352D30312D3031222C226E616D65223A22D986D988D8B1D988D8B2227D2C2E2E2E5D270A2020202A2020202D20616E20417272617920203A206A51756572792773202E64617461';
wwv_flow_imp.g_varchar2_table(23) := '2829206175746F2D7061727365732076616C6964204A534F4E206174747269627574657320696E746F206F626A656374730A2020202A2052657475726E733A207B2022313430352F312F31223A2022D986D988D8B1D988D8B2222C202E2E2E207D20206B';
wwv_flow_imp.g_varchar2_table(24) := '6579656420617320792F6D2F6420286E6F206C656164696E67207A65726F732C206D61746368657320686F6C696461794B6579290A2020202A2F0A202066756E6374696F6E207061727365486F6C696461794A736F6E28696E7075742C206F6666736574';
wwv_flow_imp.g_varchar2_table(25) := '29207B0A202020206F6666736574203D206F6666736574207C7C20303B0A20202020766172206D6170203D207B7D3B0A202020206966202821696E707574292072657475726E206D61703B0A20202020766172206172723B0A20202020747279207B0A20';
wwv_flow_imp.g_varchar2_table(26) := '20202020206966202841727261792E6973417272617928696E7075742929207B0A20202020202020202F2F206A517565727920616C72656164792070617273656420746865204A534F4E2061747472696275746520696E746F20616E20617272617920E2';
wwv_flow_imp.g_varchar2_table(27) := '809420757365206469726563746C790A2020202020202020617272203D20696E7075743B0A2020202020207D20656C73652069662028747970656F6620696E707574203D3D3D20276F626A6563742729207B0A2020202020202020617272203D205B696E';
wwv_flow_imp.g_varchar2_table(28) := '7075745D3B0A2020202020207D20656C7365207B0A20202020202020202F2F20506C61696E20737472696E6720E280942070617273652069742028646F204E4F542063616C6C20746F4C6174696E206F6E207468652077686F6C65204A534F4E290A2020';
wwv_flow_imp.g_varchar2_table(29) := '202020202020617272203D204A534F4E2E706172736528537472696E6728696E707574292E7472696D2829293B0A2020202020207D0A202020202020696620282141727261792E697341727261792861727229292072657475726E206D61703B0A202020';
wwv_flow_imp.g_varchar2_table(30) := '2020206172722E666F72456163682866756E6374696F6E286974656D29207B0A202020202020202069662028216974656D207C7C20216974656D2E64617465292072657475726E3B0A20202020202020202F2F204F6E6C7920636F6E7665727420646967';
wwv_flow_imp.g_varchar2_table(31) := '69747320696E207468652064617465206669656C642C206E6576657220696E20746865206E616D650A202020202020202076617220646174654C6174696E203D2049432E746F4C6174696E28537472696E67286974656D2E6461746529292E7472696D28';
wwv_flow_imp.g_varchar2_table(32) := '292E7265706C616365282F2D2F672C20272F27293B0A2020202020202020766172207061727473203D20646174654C6174696E2E73706C697428272F27293B0A20202020202020206966202870617274732E6C656E67746820213D3D2033292072657475';
wwv_flow_imp.g_varchar2_table(33) := '726E3B0A20202020202020207661722079203D207061727365496E742870617274735B305D2C20313029202D206F66667365743B0A2020202020202020766172206D203D207061727365496E742870617274735B315D2C203130292C0A20202020202020';
wwv_flow_imp.g_varchar2_table(34) := '202020202064203D207061727365496E742870617274735B325D2C203130293B0A2020202020202020696620282179207C7C20216D207C7C202164292072657475726E3B0A2020202020202020766172206B6579203D2079202B20272F27202B206D202B';
wwv_flow_imp.g_varchar2_table(35) := '20272F27202B20643B202020202F2F206D61746368657320686F6C696461794B6579282920666F726D61740A2020202020202020766172206E616D65203D20537472696E67286974656D2E6E616D65207C7C202727293B0A20202020202020206D61705B';
wwv_flow_imp.g_varchar2_table(36) := '6B65795D203D206D61705B6B65795D203F206D61705B6B65795D202B2027202F2027202B206E616D65203A206E616D653B0A2020202020207D293B0A202020207D206361746368286529207B0A2020202020202F2F2073696C656E74206661696C20E280';
wwv_flow_imp.g_varchar2_table(37) := '942072657475726E20776861746576657220776173206275696C740A202020207D0A2020202072657475726E206D61703B0A20207D0A0A202066756E6374696F6E207265736F6C766544617465426F756E6428747970652C206974656D4E616D652C2073';
wwv_flow_imp.g_varchar2_table(38) := '746174696356616C2C2072466D7429207B0A20202020696620282174797065207C7C2074797065203D3D3D20276E6F6E6527292072657475726E206E756C6C3B0A2020202076617220726177203D2027273B0A202020206966202874797065203D3D3D20';
wwv_flow_imp.g_varchar2_table(39) := '276974656D2729207B0A202020202020747279207B20726177203D20617065782E6974656D286974656D4E616D65292E67657456616C756528293B207D206361746368286529207B20726177203D2027273B207D0A202020207D20656C73652069662028';
wwv_flow_imp.g_varchar2_table(40) := '74797065203D3D3D20277374617469632729207B0A202020202020726177203D2073746174696356616C207C7C2027273B0A202020207D0A202020206966202821726177292072657475726E206E756C6C3B0A2020202072657475726E2049432E706172';
wwv_flow_imp.g_varchar2_table(41) := '73652849432E746F4C6174696E28537472696E6728726177292E7472696D2829292C2072466D7429207C7C206E756C6C3B0A20207D0A0A20202F2A2A0A2020202A205061727365206D616E75616C20696E7075742074686174206D617920696E636C7564';
wwv_flow_imp.g_varchar2_table(42) := '652074696D652E0A2020202A2052657475726E73207B20646174653A207B792C6D2C647D2C20683A206E756D6265722C206D3A206E756D626572207D206F72206E756C6C2E0A2020202A2072466D74206973207468652052455455524E20666F726D6174';
wwv_flow_imp.g_varchar2_table(43) := '2028616C77617973206E756D657269632C20652E672E20595959592F4D4D2F4444292E0A2020202A2F0A202066756E6374696F6E2070617273654D616E75616C5769746854696D65287261772C2064466D742C2068617354696D6529207B0A2020202072';
wwv_flow_imp.g_varchar2_table(44) := '6177203D2049432E746F4C6174696E28537472696E6728726177207C7C202727292E7472696D2829293B0A20202020726177203D207261772E7265706C616365282F5B5C75303646302D5C75303646395D2F672C2066756E6374696F6E2863297B207265';
wwv_flow_imp.g_varchar2_table(45) := '7475726E20632E63686172436F64654174283029202D203078303646303B207D293B0A202020206966202821726177292072657475726E206E756C6C3B0A202020207661722068203D20302C206D69203D20303B0A2020202076617220744D6174636820';
wwv_flow_imp.g_varchar2_table(46) := '3D207261772E6D61746368282F285C647B312C327D293A285C647B327D29242F293B0A2020202069662028744D6174636829207B0A2020202020206820203D204D6174682E6D696E2832332C204D6174682E6D617828302C202B744D617463685B315D29';
wwv_flow_imp.g_varchar2_table(47) := '293B0A2020202020206D69203D204D6174682E6D696E2835392C204D6174682E6D617828302C202B744D617463685B325D29293B0A202020202020726177203D207261772E736C69636528302C207261772E6C656E677468202D20744D617463685B305D';
wwv_flow_imp.g_varchar2_table(48) := '2E6C656E677468292E7472696D28292E7265706C616365282F5B2D5C735D2B242F2C202727293B0A202020207D0A2020202076617220665570203D202864466D74207C7C2027595959592F4D4D2F444427292E746F55707065724361736528293B0A2020';
wwv_flow_imp.g_varchar2_table(49) := '202076617220642020203D206E756C6C3B0A2020202069662028665570203D3D3D2027595959592F4D4F4E27207C7C20665570203D3D3D2027464D4D4F4E544827292072657475726E206E756C6C3B0A20202020696620286655702E696E6465784F6628';
wwv_flow_imp.g_varchar2_table(50) := '274D4F4E2729203E3D2030202626206655702E696E6465784F662827595959592729203E3D203029207B0A202020202020766172207061727473203D207261772E73706C6974282F5B2D5C2F5D2F293B0A2020202020206966202870617274732E6C656E';
wwv_flow_imp.g_varchar2_table(51) := '677468203E3D203329207B0A20202020202020207661722079506F73203D206655702E696E6465784F6628275959595927292C206D506F73203D206655702E696E6465784F6628274D4F4E27293B0A20202020202020207661722064506F73203D206655';
wwv_flow_imp.g_varchar2_table(52) := '702E696E6465784F662827464D44442729203E3D2030203F206655702E696E6465784F662827464D44442729203A206655702E696E6465784F662827444427293B0A2020202020202020766172206F72646572203D205B7B743A2779272C693A79506F73';
wwv_flow_imp.g_varchar2_table(53) := '7D2C7B743A276D272C693A6D506F737D2C7B743A2764272C693A64506F737D5D0A20202020202020202020202020202020202020202E736F72742866756E6374696F6E28612C62297B2072657475726E20612E69202D20622E693B207D293B0A20202020';
wwv_flow_imp.g_varchar2_table(54) := '202020207661722076203D207B7D3B0A2020202020202020666F7220287661722069203D20303B2069203C20333B20692B2B29207B0A2020202020202020202076617220746F6B203D206F726465725B695D2E742C2076616C203D202870617274735B69';
wwv_flow_imp.g_varchar2_table(55) := '5D207C7C202727292E7472696D28293B0A20202020202020202020696620202020202028746F6B203D3D3D202779272920762E79203D207061727365496E742876616C2C203130293B0A20202020202020202020656C73652069662028746F6B203D3D3D';
wwv_flow_imp.g_varchar2_table(56) := '202764272920762E64203D207061727365496E742876616C2C203130293B0A20202020202020202020656C7365202020202020202020202020202020202020762E6D203D2070617273654D6F6E74684E616D652876616C293B0A20202020202020207D0A';
wwv_flow_imp.g_varchar2_table(57) := '202020202020202069662028762E7920262620762E6D20262620762E642026262049432E697356616C696428762E792C20762E6D2C20762E6429292064203D207B793A762E792C6D3A762E6D2C643A762E647D3B0A2020202020207D0A202020207D0A20';
wwv_flow_imp.g_varchar2_table(58) := '202020696620282164202626206655702E696E6465784F662827464D4441592729203E3D2030202626206655702E696E6465784F662827464D4D4F4E54482729203E3D203029207B0A202020202020766172207332203D207261772E7265706C61636528';
wwv_flow_imp.g_varchar2_table(59) := '2F5E5B5E5C645D2B2F2C202727292E7265706C616365282F5B5C75303630432C5D2F672C20272027292E7472696D28293B0A202020202020766172207370203D2073322E73706C6974282F5C732B2F293B0A2020202020206966202873702E6C656E6774';
wwv_flow_imp.g_varchar2_table(60) := '68203E3D203329207B0A2020202020202020766172206464323D7061727365496E742873705B305D2C3130292C206D6D323D70617273654D6F6E74684E616D652873705B315D292C207979323D7061727365496E742873705B73702E6C656E6774682D31';
wwv_flow_imp.g_varchar2_table(61) := '5D2C3130293B0A202020202020202069662028646432202626206D6D32202626207979322026262049432E697356616C6964287979322C6D6D322C646432292920643D7B793A7979322C6D3A6D6D322C643A6464327D3B0A2020202020207D0A20202020';
wwv_flow_imp.g_varchar2_table(62) := '7D0A20202020696620282164292064203D2049432E7061727365287261772C2064466D74293B0A20202020696620282164292072657475726E206E756C6C3B0A2020202072657475726E207B20646174653A20642C20683A20682C206D3A206D69207D3B';
wwv_flow_imp.g_varchar2_table(63) := '0A20207D0A0A2020766172204D4F4E54485F4641203D205B27272C27D981D8B1D988D8B1D8AFDB8CD986272C27D8A7D8B1D8AFDB8CD8A8D987D8B4D8AA272C27D8AED8B1D8AFD8A7D8AF272C27D8AADB8CD8B1272C27D985D8B1D8AFD8A7D8AF272C27D8';
wwv_flow_imp.g_varchar2_table(64) := 'B4D987D8B1DB8CD988D8B1272C27D985D987D8B1272C27D8A2D8A8D8A7D986272C27D8A2D8B0D8B1272C27D8AFDB8C272C27D8A8D987D985D986272C27D8A7D8B3D981D986D8AF275D3B0A0A202066756E6374696F6E2070617273654D6F6E74684E616D';
wwv_flow_imp.g_varchar2_table(65) := '652873747229207B0A20202020737472203D20537472696E6728737472207C7C202727292E7472696D28293B0A20202020666F7220287661722069203D20313B2069203C3D2031323B20692B2B29207B20696620284D4F4E54485F46415B695D203D3D3D';
wwv_flow_imp.g_varchar2_table(66) := '20737472292072657475726E20693B207D0A2020202072657475726E20303B0A20207D0A0A202066756E6374696F6E207361666552657475726E466D7428666D7429207B0A2020202072657475726E202F4D4F4E7C666D4D6F6E74687C666D4461792F69';
wwv_flow_imp.g_varchar2_table(67) := '2E7465737428666D7429203F2027595959592F4D4D2F444427203A20666D743B0A20207D0A0A202066756E6374696F6E206E6F726D616C697A654A616C616C6956616C75652876616C29207B0A20202020696620282176616C292072657475726E207661';
wwv_flow_imp.g_varchar2_table(68) := '6C3B0A2020202076616C203D2049432E746F4C6174696E28537472696E672876616C292E7472696D2829293B0A2020202076617220746D203D2027272C206461746570617274203D2076616C3B0A2020202076617220744D61746368203D2076616C2E6D';
wwv_flow_imp.g_varchar2_table(69) := '61746368282F20285C647B312C327D3A5C647B327D29242F293B0A2020202069662028744D6174636829207B0A202020202020766172206870203D20744D617463685B315D2E73706C697428273A27293B0A202020202020746D203D20272027202B2028';
wwv_flow_imp.g_varchar2_table(70) := '2730272B68705B305D292E736C696365282D3229202B20273A27202B20282730272B68705B315D292E736C696365282D32293B0A2020202020206461746570617274203D2076616C2E736C69636528302C2076616C2E6C656E677468202D20744D617463';
wwv_flow_imp.g_varchar2_table(71) := '685B305D2E6C656E677468293B0A202020207D0A20202020766172206D203D2064617465706172742E6D61746368282F5E285C647B312C327D295C2F285C647B312C327D295C2F285C647B347D29242F293B0A20202020696620286D202626202B6D5B33';
wwv_flow_imp.g_varchar2_table(72) := '5D203E3D2031333030202626202B6D5B335D203C3D203135303029207B0A2020202020206461746570617274203D206D5B335D202B20272F27202B20282730272B6D5B315D292E736C696365282D3229202B20272F27202B20282730272B6D5B325D292E';
wwv_flow_imp.g_varchar2_table(73) := '736C696365282D32293B0A202020207D0A2020202072657475726E206461746570617274202B20746D3B0A20207D0A0A20207661722044454641554C5453203D207B0A20202020646973706C6179466F726D61743A2020202027595959592F4D4D2F4444';
wwv_flow_imp.g_varchar2_table(74) := '272C0A2020202072657475726E466F726D61743A202020202027595959592F4D4D2F4444272C0A202020207573655065727369616E4469676974733A20747275652C0A2020202073686F77546F646179427574746F6E3A2020747275652C0A2020202073';
wwv_flow_imp.g_varchar2_table(75) := '686F77436C656172427574746F6E3A2020747275652C0A2020202073686F7754696D653A20202020202020202066616C73652C0A20202020616C6C6F774D616E75616C496E7075743A2066616C73652C0A2020202073686F774F6E3A2020202020202020';
wwv_flow_imp.g_varchar2_table(76) := '20202027627574746F6E272C0A20202020686F6C69646179733A2020202020202020207B7D2C0A2020202064697361626C65486F6C696461793A20202066616C73652C0A2020202073686F77596561723A202020202020202020747275652C0A20202020';
wwv_flow_imp.g_varchar2_table(77) := '73686F774D6F6E74683A2020202020202020747275652C0A20202020646973706C617941733A202020202020202027706F707570272C2020202F2F2027706F70757027207C2027696E6C696E65270A2020202063616C656E646172596561723A20202020';
wwv_flow_imp.g_varchar2_table(78) := '20276A616C616C69272C20202F2F20276A616C616C6927207C2027696D70657269616C272028646973706C6179206F6E6C793B2073657373696F6E20616C77617973204A616C616C69290A202020206D696E44617465547970653A202020202020276E6F';
wwv_flow_imp.g_varchar2_table(79) := '6E65272C0A202020206D696E446174654974656D3A20202020202027272C0A202020206D696E446174655374617469633A2020202027272C0A202020206D617844617465547970653A202020202020276E6F6E65272C0A202020206D6178446174654974';
wwv_flow_imp.g_varchar2_table(80) := '656D3A20202020202027272C0A202020206D6178446174655374617469633A2020202027272C0A202020207965617252616E67653A20202020202020207B7D2C2020202F2F20736574206F6620616C6C6F776564207965617273207B7D203D20616C6C0A';
wwv_flow_imp.g_varchar2_table(81) := '202020206D6F6E746852616E67653A202020202020207B7D2C2020202F2F20736574206F6620616C6C6F776564206D6F6E746873207B7D203D20616C6C0A20202020686F6C696461794A736F6E3A2020202020207B7D2C2020202F2F206D6170206F6620';
wwv_flow_imp.g_varchar2_table(82) := '6461746520E28692206E616D6520666F7220746F6F6C7469700A2020202064697361626C65643A20202020202020202066616C73652C0A20202020706C616365686F6C6465723A20202020202027D8A7D986D8AAD8AED8A7D8A820D8AAD8A7D8B1DB8CD8';
wwv_flow_imp.g_varchar2_table(83) := 'AE270A20207D3B0A0A20200A2020617065783336302E676574417574686F72203D2066756E6374696F6E202829207B0A2020202072657475726E202753616565642048617373616E706F7572207C205061796120536865746162616E20416E6469736865';
wwv_flow_imp.g_varchar2_table(84) := '6820284150455833363029207C2068747470733A2F2F617065783336302E696E666F273B0A20207D3B0A0A0A20202F2A20E29480E2948020496D70657269616C20796561722068656C70657220E29480E29480E29480E29480E29480E29480E29480E294';
wwv_flow_imp.g_varchar2_table(85) := '80E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E294800A2020202A2052657475726E';
wwv_flow_imp.g_varchar2_table(86) := '732074686520646973706C6179207965617220666F72207468652063616C656E6461722068656164657220616E6420666F726D61747465640A2020202A20737472696E672E20496E7465726E616C20646174657320285F73656C2C205F76696577292061';
wwv_flow_imp.g_varchar2_table(87) := '726520414C57415953204A616C616C692E0A2020202A20496D70657269616C203D204A616C616C69202B2031313830202028652E672E203134303520E286922032353835290A2020202A2F0A202066756E6374696F6E20696D70657269616C4F66667365';
wwv_flow_imp.g_varchar2_table(88) := '74286F70747329207B0A2020202072657475726E206F7074732E63616C656E64617259656172203D3D3D2027696D70657269616C27203F2031313830203A20303B0A20207D0A0A20202F2A20E29590E29590E29590E29590E29590E29590E29590E29590';
wwv_flow_imp.g_varchar2_table(89) := 'E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E2';
wwv_flow_imp.g_varchar2_table(90) := '9590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E295900A2020202A204E455720E2809420';
wwv_flow_imp.g_varchar2_table(91) := '4D6F64616C202F20696672616D652068656C706572730A2020202A0A2020202A205768656E2074686520706167652069732072656E646572656420696E7369646520616E2041504558204D6F64616C204469616C6F6720506167652C2074686520706167';
wwv_flow_imp.g_varchar2_table(92) := '650A2020202A2072756E7320696E7369646520616E203C696672616D653E2E2020416E7920706F70757020617070656E64656420746F2074686520696672616D652773203C626F64793E0A2020202A2063616E206E657665722065736361706520746865';
wwv_flow_imp.g_varchar2_table(93) := '20696672616D65277320626F756E647320E280942069742069732067656F6D6574726963616C6C7920636C69707065640A2020202A20746F20746865206D6F64616C206672616D652C206576656E207769746820706F736974696F6E3A66697865642E0A';
wwv_flow_imp.g_varchar2_table(94) := '2020202A0A2020202A20546865206E617469766520415045582044617465205069636B65722068616E646C657320746869732062792072656E646572696E672069747320706F707570206174207468650A2020202A20746F702077696E646F772E202057';
wwv_flow_imp.g_varchar2_table(95) := '6520646F207468652073616D653A2064657465637420612073616D652D6F726967696E20706172656E742077696E646F7720616E640A2020202A20617070656E64206F757220706F70757020746F2074686520706172656E7420646F63756D656E742773';
wwv_flow_imp.g_varchar2_table(96) := '203C626F64793E2E20205768656E2074686520706172656E742069730A2020202A20756E726561636861626C65202863726F73732D6F726967696E292C20776520677261636566756C6C792066616C6C206261636B20746F207468652063757272656E74';
wwv_flow_imp.g_varchar2_table(97) := '0A2020202A2077696E646F772773203C626F64793E2E0A2020202A20E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590';
wwv_flow_imp.g_varchar2_table(98) := 'E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E2';
wwv_flow_imp.g_varchar2_table(99) := '9590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590202A2F0A202066756E6374696F6E20676574526F6F7457696E646F772829207B0A20202020747279207B0A2020202020202F2F204F6E6C792077616C6B20';
wwv_flow_imp.g_varchar2_table(100) := '75702074686520706172656E7420636861696E207768696C652077696E646F7773206172652073616D652D6F726967696E0A2020202020202F2F2028692E652E2077652063616E20616363657373202E646F63756D656E74292E2020416E204150455820';
wwv_flow_imp.g_varchar2_table(101) := '4D6F64616C204469616C6F6720506167652069730A2020202020202F2F20616C776179732073616D652D6F726967696E2C20736F2077696E646F772E706172656E7420697320726561636861626C652E0A2020202020207661722077203D2077696E646F';
wwv_flow_imp.g_varchar2_table(102) := '773B0A2020202020207768696C652028772E706172656E7420262620772E706172656E7420213D3D207729207B0A20202020202020202F2F20546F756368202E646F63756D656E7420746F207665726966792073616D652D6F726967696E3B207468726F';
wwv_flow_imp.g_varchar2_table(103) := '77732069662063726F73732D6F726967696E0A20202020202020202F2A2065736C696E742D64697361626C65206E6F2D756E757365642D76617273202A2F0A202020202020202076617220646F63203D20772E706172656E742E646F63756D656E743B0A';
wwv_flow_imp.g_varchar2_table(104) := '20202020202020202F2A2065736C696E742D656E61626C65206E6F2D756E757365642D76617273202A2F0A202020202020202077203D20772E706172656E743B0A2020202020207D0A20202020202072657475726E20773B0A202020207D206361746368';
wwv_flow_imp.g_varchar2_table(105) := '20286529207B0A20202020202072657475726E2077696E646F773B0A202020207D0A20207D0A0A202066756E6374696F6E206973496E73696465496672616D652829207B0A20202020747279207B2072657475726E2077696E646F772E746F7020213D3D';
wwv_flow_imp.g_varchar2_table(106) := '2077696E646F772E73656C663B207D0A20202020636174636820286529207B2072657475726E2066616C73653B207D0A20207D0A0A20202F2A20436F6D707574652074686520696672616D6520656C656D656E7420696E2074686520706172656E742077';
wwv_flow_imp.g_varchar2_table(107) := '696E646F77207468617420636F6E7461696E732075732E0A2020202A2052657475726E73206E756C6C20696620776520617265206E6F7420696E20616E20696672616D65206F722074686520706172656E7420697320756E726561636861626C652E202A';
wwv_flow_imp.g_varchar2_table(108) := '2F0A202066756E6374696F6E206765744F776E496672616D652829207B0A20202020747279207B0A20202020202069662028216973496E73696465496672616D652829292072657475726E206E756C6C3B0A2020202020202F2F2077696E646F772E6672';
wwv_flow_imp.g_varchar2_table(109) := '616D65456C656D656E7420697320746865203C696672616D653E20444F4D206E6F646520696E2074686520706172656E7420646F63756D656E740A20202020202072657475726E2077696E646F772E6672616D65456C656D656E74207C7C206E756C6C3B';
wwv_flow_imp.g_varchar2_table(110) := '0A202020207D20636174636820286529207B2072657475726E206E756C6C3B207D0A20207D0A0A20202F2A205069636B2061207A2D696E646578207468617420616C7761797320736974732061626F7665207468652041504558206D6F64616C206F7665';
wwv_flow_imp.g_varchar2_table(111) := '726C61792E0A2020202A0A2020202A2054686520556E6976657273616C205468656D65206D6F64616C206F7665726C617920282E75692D7769646765742D6F7665726C6179202F202E742D4469616C6F672D2D6D6F64616C290A2020202A206973206769';
wwv_flow_imp.g_varchar2_table(112) := '76656E20612063616C63756C61746564207A2D696E64657820287479706963616C6C7920313030302D323030302D697368292E2020496E7374656164206F660A2020202A20686172642D636F64696E672C2077652077616C6B2074686520746F7020646F';
wwv_flow_imp.g_varchar2_table(113) := '63756D656E7420616E642066696E6420746865206D6178696D756D207A2D696E646578206F660A2020202A20616E79207369626C696E67206469616C6F672F6F7665726C61792C207468656E2061646420312E2020576520616C736F20656E666F726365';
wwv_flow_imp.g_varchar2_table(114) := '206120666C6F6F7220736F0A2020202A2074686520706F707570206973206E657665722068696464656E20626568696E6420616E797468696E672E0A2020202A2F0A202066756E6374696F6E20636F6D70757465546F705A496E64657828726F6F74446F';
wwv_flow_imp.g_varchar2_table(115) := '6329207B0A2020202076617220666C6F6F72203D2033303030303B0A20202020747279207B0A202020202020766172206D6178203D20666C6F6F723B0A2020202020202428726F6F74446F63292E66696E6428272E75692D6469616C6F672C2E75692D77';
wwv_flow_imp.g_varchar2_table(116) := '69646765742D6F7665726C61792C2E742D4469616C6F672C2E742D4469616C6F672D2D6D6F64616C2C2E742D4469616C6F672D706167652C2E6469616C6F672D726567696F6E2C2E6F6A2D6469616C6F672C2E6F6A2D6469616C6F672D6F7665726C6179';
wwv_flow_imp.g_varchar2_table(117) := '27292E656163682866756E6374696F6E2829207B0A2020202020202020766172207A203D20242874686973292E63737328277A2D696E64657827293B0A2020202020202020696620287A202626207A20213D3D20276175746F2729207B207A203D207061';
wwv_flow_imp.g_varchar2_table(118) := '727365496E74287A2C203130293B20696620287A203E206D617829206D6178203D207A3B207D0A2020202020207D293B0A20202020202072657475726E206D6178202B20313B0A202020207D20636174636820286529207B0A2020202020207265747572';
wwv_flow_imp.g_varchar2_table(119) := '6E20666C6F6F723B0A202020207D0A20207D0A0A20202F2A20E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590';
wwv_flow_imp.g_varchar2_table(120) := 'E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E2';
wwv_flow_imp.g_varchar2_table(121) := '9590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E295900A2020202A204E455720E280942043726F73732D6672616D652043535320696E6A656374696F6E0A2020202A0A2020202A205768656E2074686520706F70757020';
wwv_flow_imp.g_varchar2_table(122) := '69732072656E646572656420696E2074686520504152454E5420646F63756D656E7420286D6F64616C207061676520696672616D650A2020202A2063617365292C2074686520706172656E7420646F63756D656E7420686173204E4F206B6E6F776C6564';
wwv_flow_imp.g_varchar2_table(123) := '6765206F662074686520706C7567696E2773204353532072756C65730A2020202A202874686F73652077657265206C6F6164656420696E746F2074686520696672616D652773203C686561643E2061732070617274206F66207468652041504558207061';
wwv_flow_imp.g_varchar2_table(124) := '6765292E0A2020202A204173206120726573756C742C2074686520706F707570277320602E617065783336302D7064702D2A6020636C617373657320776F756C642068617665206E6F207374796C65730A2020202A206170706C69656420616E64207468';
wwv_flow_imp.g_varchar2_table(125) := '652063616C656E64617220776F756C642072656E64657220636F6D706C6574656C7920756E7374796C656420E2809420746865206275670A2020202A207468652075736572206F627365727665642E0A2020202A0A2020202A204669783A207768656E20';
wwv_flow_imp.g_varchar2_table(126) := '7765206465746563742077652061726520696E7369646520616E20696672616D652C20776520636F6C6C65637420657665727920706C7567696E0A2020202A204353532072756C652028616E642074686520556E6976657273616C205468656D65204353';
wwv_flow_imp.g_varchar2_table(127) := '53207661726961626C6573207265666572656E636564206279207468650A2020202A20706F707570292066726F6D2074686520696672616D6520646F63756D656E7420616E6420696E6A656374207468656D20617320612073696E676C65203C7374796C';
wwv_flow_imp.g_varchar2_table(128) := '653E0A2020202A20656C656D656E7420696E2074686520706172656E7420646F63756D656E742773203C686561643E2E20205468697320697320646F6E65206F6E6365207065720A2020202A20706172656E7420646F63756D656E743B20737562736571';
wwv_flow_imp.g_varchar2_table(129) := '75656E742064617465207069636B657220696E7374616E636573207265757365207468652073616D650A2020202A20696E6A6563746564203C7374796C653E2E0A2020202A20E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590';
wwv_flow_imp.g_varchar2_table(130) := 'E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E2';
wwv_flow_imp.g_varchar2_table(131) := '9590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590202A2F0A0A20202F2A204D61726B657220617474';
wwv_flow_imp.g_varchar2_table(132) := '72696275746520776520736574206F6E206576657279203C7374796C653E20626C6F636B20776520696E6A65637420696E746F207468650A2020202A20706172656E7420646F63756D656E742C20736F2077652063616E2066696E64206974206C617465';
wwv_flow_imp.g_varchar2_table(133) := '722028616E6420736F207765206E6576657220696E6A6563740A2020202A207477696365292E202A2F0A2020766172205044505F4353535F494E4A4543545F41545452203D2027646174612D617065783336302D7064702D696E6A6563746564273B0A20';
wwv_flow_imp.g_varchar2_table(134) := '202F2A2053656E74696E656C206F6E2074686520706172656E742077696E646F77206F626A65637420E2809420736574206F6E63652074686520696E6A656374206861732072756E2C0A2020202A20736F206D756C7469706C652064617465207069636B';
wwv_flow_imp.g_varchar2_table(135) := '657220696E7374616E636573206F6E207468652073616D6520706167652073686172652074686520776F726B2E202A2F0A2020766172205044505F4353535F494E4A4543545F464C4147203D20275F5F61706578333630506470437373496E6A65637465';
wwv_flow_imp.g_varchar2_table(136) := '64273B0A0A20202F2A20436F6C6C6563742043535320746578742066726F6D2074686520696672616D6520646F63756D656E7420666F7220616C6C2072756C65732077686F73650A2020202A2073656C6563746F72206F7220636F6E74656E74206D656E';
wwv_flow_imp.g_varchar2_table(137) := '74696F6E732074686520706C7567696E277320636C6173736573206F722041504558207468656D650A2020202A207661726961626C657320746861742074686520706F70757020757365732E202A2F0A202066756E6374696F6E20636F6C6C656374506C';
wwv_flow_imp.g_varchar2_table(138) := '7567696E43737346726F6D446F6328646F6329207B0A20202020766172207061727473203D205B5D3B0A20202020747279207B0A2020202020202F2F20312920496E6C696E65203C7374796C653E20626C6F636B7320696E2074686520696672616D6520';
wwv_flow_imp.g_varchar2_table(139) := '3C686561643E0A202020202020766172207374796C6573203D20646F632E676574456C656D656E747342795461674E616D6528277374796C6527293B0A202020202020666F7220287661722069203D20303B2069203C207374796C65732E6C656E677468';
wwv_flow_imp.g_varchar2_table(140) := '3B20692B2B29207B0A2020202020202020766172207374203D207374796C65735B695D3B0A20202020202020202F2F20536B6970206F7572206F776E20696E6A6563746564207374796C65202873686F756C646E27742068617070656E20696E20696672';
wwv_flow_imp.g_varchar2_table(141) := '616D652C206275742073616665290A20202020202020206966202873742E676574417474726962757465285044505F4353535F494E4A4543545F41545452292920636F6E74696E75653B0A202020202020202076617220747874203D2073742E74657874';
wwv_flow_imp.g_varchar2_table(142) := '436F6E74656E74207C7C2073742E696E6E657254657874207C7C2027273B0A202020202020202069662028217478742920636F6E74696E75653B0A2020202020202020696620287478742E696E6465784F662827617065783336302D7064702729203E3D';
wwv_flow_imp.g_varchar2_table(143) := '2030207C7C0A2020202020202020202020207478742E696E6465784F6628272D2D612D70616C657474652729203E3D2030207C7C0A2020202020202020202020207478742E696E6465784F6628272D2D612D6669656C642729203E3D2030207C7C0A2020';
wwv_flow_imp.g_varchar2_table(144) := '202020202020202020207478742E696E6465784F6628272D2D612D627574746F6E2729203E3D2030207C7C0A2020202020202020202020207478742E696E6465784F6628272D2D612D626173652729203E3D2030207C7C0A202020202020202020202020';
wwv_flow_imp.g_varchar2_table(145) := '7478742E696E6465784F6628272D2D612D726567696F6E2729203E3D2030207C7C0A2020202020202020202020207478742E696E6465784F6628272D2D6F6A2D636F72652729203E3D2030207C7C0A2020202020202020202020207478742E696E646578';
wwv_flow_imp.g_varchar2_table(146) := '4F6628272D2D6F6A2D2729203E3D203029207B0A2020202020202020202070617274732E7075736828747874293B0A20202020202020207D0A2020202020207D0A2020202020202F2F2032292045787465726E616C203C6C696E6B2072656C3D22737479';
wwv_flow_imp.g_varchar2_table(147) := '6C657368656574223E20E280942066657463682076696120584852202873616D652D6F726967696E0A2020202020202F2F206F6E6C79292E202057652063616E2774207573652074686520636163686564204353534F4D2072756C65732072656C696162';
wwv_flow_imp.g_varchar2_table(148) := '6C79206163726F73730A2020202020202F2F20646F63756D656E747320626563617573652063726F73732D646F63756D656E74204353535374796C65536865657420616363657373206D61792062650A2020202020202F2F20726573747269637465643B';
wwv_flow_imp.g_varchar2_table(149) := '20666F722073616D652D6F726967696E207374796C657368656574732C2063737352756C65732049532061636365737369626C652E0A202020202020766172206C696E6B73203D20646F632E676574456C656D656E747342795461674E616D6528276C69';
wwv_flow_imp.g_varchar2_table(150) := '6E6B27293B0A202020202020666F722028766172206A203D20303B206A203C206C696E6B732E6C656E6774683B206A2B2B29207B0A2020202020202020766172206C6E203D206C696E6B735B6A5D3B0A202020202020202069662028286C6E2E72656C20';
wwv_flow_imp.g_varchar2_table(151) := '7C7C202727292E746F4C6F77657243617365282920213D3D20277374796C657368656574272920636F6E74696E75653B0A20202020202020207661722068726566203D206C6E2E68726566207C7C2027273B0A2020202020202020696620282168726566';
wwv_flow_imp.g_varchar2_table(152) := '2920636F6E74696E75653B0A2020202020202020747279207B0A20202020202020202020766172207368656574203D206C6E2E73686565743B0A20202020202020202020696620282173686565742920636F6E74696E75653B0A20202020202020202020';
wwv_flow_imp.g_varchar2_table(153) := '7661722072756C6573203D2073686565742E63737352756C6573207C7C2073686565742E72756C65733B0A20202020202020202020696620282172756C6573207C7C202172756C65732E6C656E6774682920636F6E74696E75653B0A2020202020202020';
wwv_flow_imp.g_varchar2_table(154) := '202076617220627566203D205B5D3B0A20202020202020202020666F722028766172206B203D20303B206B203C2072756C65732E6C656E6774683B206B2B2B29207B0A2020202020202020202020207661722072203D2072756C65735B6B5D3B0A202020';
wwv_flow_imp.g_varchar2_table(155) := '2020202020202020207661722063737354657874203D20722E63737354657874207C7C2027273B0A2020202020202020202020206966202821637373546578742920636F6E74696E75653B0A20202020202020202020202069662028637373546578742E';
wwv_flow_imp.g_varchar2_table(156) := '696E6465784F662827617065783336302D7064702729203E3D2030207C7C0A20202020202020202020202020202020637373546578742E696E6465784F6628272D2D612D70616C657474652729203E3D2030207C7C0A2020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(157) := '2020637373546578742E696E6465784F6628272D2D612D6669656C642729203E3D2030207C7C0A20202020202020202020202020202020637373546578742E696E6465784F6628272D2D612D627574746F6E2729203E3D2030207C7C0A20202020202020';
wwv_flow_imp.g_varchar2_table(158) := '202020202020202020637373546578742E696E6465784F6628272D2D612D626173652729203E3D2030207C7C0A20202020202020202020202020202020637373546578742E696E6465784F6628272D2D612D726567696F6E2729203E3D2030207C7C0A20';
wwv_flow_imp.g_varchar2_table(159) := '202020202020202020202020202020637373546578742E696E6465784F6628272D2D6F6A2D636F72652729203E3D2030207C7C0A20202020202020202020202020202020637373546578742E696E6465784F6628272D2D6F6A2D2729203E3D203029207B';
wwv_flow_imp.g_varchar2_table(160) := '0A20202020202020202020202020206275662E707573682863737354657874293B0A2020202020202020202020207D0A202020202020202020207D0A20202020202020202020696620286275662E6C656E677468292070617274732E7075736828627566';
wwv_flow_imp.g_varchar2_table(161) := '2E6A6F696E28275C6E2729293B0A20202020202020207D20636174636820286529207B0A202020202020202020202F2F2043726F73732D6F726967696E207374796C65736865657420E280942063737352756C657320616363657373207468726F77733B';
wwv_flow_imp.g_varchar2_table(162) := '20736B69702069742E0A20202020202020207D0A2020202020207D0A202020207D20636174636820286529207B0A2020202020202F2F20426573742D6566666F72743B20696620616E797468696E67206661696C732C206A7573742072657475726E2077';
wwv_flow_imp.g_varchar2_table(163) := '68617420776520686176652E0A202020207D0A2020202072657475726E2070617274732E6A6F696E28275C6E5C6E2F2A203D3D3D3D3D202A2F5C6E5C6E27293B0A20207D0A0A20202F2A205265736F6C76652043535320637573746F6D2070726F706572';
wwv_flow_imp.g_varchar2_table(164) := '7469657320287661726961626C65732920646566696E6564206F6E203A726F6F74202F2068746D6C206F660A2020202A2074686520696672616D6520646F63756D656E742C20736F2074686520706F70757020E28094207768696368206C697665732069';
wwv_flow_imp.g_varchar2_table(165) := '6E2074686520706172656E7420E280942063616E0A2020202A20736565207468656D2E202052657475726E7320612043535320737472696E67206C696B653A0A2020202A2020203A726F6F74207B202D2D612D70616C657474652D7072696D6172793A20';
wwv_flow_imp.g_varchar2_table(166) := '233235364646423B202D2D612D6669656C642D746578742D636F6C6F723A20233430343034303B202E2E2E207D0A2020202A2057652075736520676574436F6D70757465645374796C6520746F207265616420746865202A636F6D70757465642A207661';
wwv_flow_imp.g_varchar2_table(167) := '6C7565732C207768696368206D65616E732077650A2020202A20616C736F207069636B207570207661726961626C657320646566696E65642076696120406D65646961206F7220696E686572697465642066726F6D207468650A2020202A20556E697665';
wwv_flow_imp.g_varchar2_table(168) := '7273616C205468656D652072756E74696D652E202A2F0A202066756E6374696F6E20636F6C6C656374526F6F745661727346726F6D446F6328646F6329207B0A20202020766172206F7574203D205B5D3B0A20202020766172206E616D6573203D205B0A';
wwv_flow_imp.g_varchar2_table(169) := '202020202020272D2D612D70616C657474652D7072696D617279272C20272D2D612D70616C657474652D7072696D6172792D686F766572272C20272D2D612D70616C657474652D64616E676572272C0A202020202020272D2D612D70616C657474652D73';
wwv_flow_imp.g_varchar2_table(170) := '756363657373272C20272D2D612D70616C657474652D7761726E696E67272C0A202020202020272D2D612D6669656C642D746578742D636F6C6F72272C20272D2D612D6669656C642D746578742D6D757465642D636F6C6F72272C0A202020202020272D';
wwv_flow_imp.g_varchar2_table(171) := '2D612D6669656C642D636F6E7461696E65722D6261636B67726F756E642D636F6C6F72272C20272D2D612D6669656C642D636F6E7461696E65722D626F726465722D636F6C6F72272C0A202020202020272D2D612D6669656C642D636F6E7461696E6572';
wwv_flow_imp.g_varchar2_table(172) := '2D626F726465722D726164697573272C20272D2D612D6669656C642D636F6E7461696E65722D736861646F77272C0A202020202020272D2D612D626173652D666F6E742D66616D696C79272C20272D2D612D626173652D666F6E742D66616D696C792D6D';
wwv_flow_imp.g_varchar2_table(173) := '6F6E6F272C0A202020202020272D2D612D626173652D666F6E742D73697A65272C20272D2D612D626173652D68746D6C2D666F6E742D73697A65272C0A202020202020272D2D612D626173652D666F6E742D7765696768742D626F6C64272C0A20202020';
wwv_flow_imp.g_varchar2_table(174) := '2020272D2D612D627574746F6E2D626F726465722D636F6C6F72272C20272D2D612D627574746F6E2D626F726465722D726164697573272C0A202020202020272D2D612D627574746F6E2D6C696E652D686569676874272C20272D2D612D627574746F6E';
wwv_flow_imp.g_varchar2_table(175) := '2D686F7665722D6261636B67726F756E642D636F6C6F72272C0A202020202020272D2D612D726567696F6E2D6865616465722D6261636B67726F756E642D636F6C6F72270A202020205D3B0A20202020766172206F6A203D205B0A202020202020272D2D';
wwv_flow_imp.g_varchar2_table(176) := '6F6A2D636F72652D746578742D636F6C6F722D7072696D617279272C20272D2D6F6A2D636F72652D636F6C6F722D64697361626C65642D31272C0A202020202020272D2D6F6A2D636F72652D636F6C6F722D64697361626C65642D32272C20272D2D6F6A';
wwv_flow_imp.g_varchar2_table(177) := '2D636F72652D62672D636F6C6F722D616374697665272C0A202020202020272D2D6F6A2D636F72652D646976696465722D636F6C6F72270A202020205D3B0A2020202076617220616C6C203D206E616D65732E636F6E636174286F6A293B0A2020202074';
wwv_flow_imp.g_varchar2_table(178) := '7279207B0A2020202020207661722068746D6C203D20646F632E646F63756D656E74456C656D656E743B0A202020202020766172206373203D20646F632E64656661756C74566965772E676574436F6D70757465645374796C652868746D6C293B0A2020';
wwv_flow_imp.g_varchar2_table(179) := '20202020766172206B76203D205B5D3B0A202020202020666F7220287661722069203D20303B2069203C20616C6C2E6C656E6774683B20692B2B29207B0A2020202020202020766172206E203D20616C6C5B695D3B0A2020202020202020766172207620';
wwv_flow_imp.g_varchar2_table(180) := '3D2063732E67657450726F706572747956616C7565286E293B0A2020202020202020696620287629206B762E70757368286E202B20273A2027202B2076202B20273B27293B0A2020202020207D0A202020202020696620286B762E6C656E67746829206F';
wwv_flow_imp.g_varchar2_table(181) := '75742E7075736828273A726F6F74207B2027202B206B762E6A6F696E2827202729202B2027207D27293B0A202020207D20636174636820286529207B202F2A2069676E6F7265202A2F207D0A2020202072657475726E206F75742E6A6F696E28275C6E27';
wwv_flow_imp.g_varchar2_table(182) := '293B0A20207D0A0A20202F2A205075626C696320287065722D696E7374616E63652920696E6A6563746F723A2067617468657273204353532066726F6D2074686520696672616D6520646F63756D656E740A2020202A20616E6420777269746573206120';
wwv_flow_imp.g_varchar2_table(183) := '73696E676C65203C7374796C653E20696E746F2074686520706172656E7420646F63756D656E742773203C686561643E2C206275740A2020202A206F6E6C79206F6E63652070657220706172656E7420646F63756D656E742E202053756273657175656E';
wwv_flow_imp.g_varchar2_table(184) := '742064617465207069636B657220696E7374616E6365730A2020202A2066696E6420746865206D61726B657220616E6420736B69702074686520776F726B2E202A2F0A202066756E6374696F6E20696E6A656374506C7567696E437373496E746F506172';
wwv_flow_imp.g_varchar2_table(185) := '656E742873656C6629207B0A20202020747279207B0A20202020202076617220706172656E7457696E203D2073656C662E5F726F6F7457696E3B0A20202020202076617220706172656E74446F63203D2073656C662E5F726F6F74446F633B0A20202020';
wwv_flow_imp.g_varchar2_table(186) := '20206966202821706172656E74446F63292072657475726E3B0A0A2020202020202F2F20416C726561647920696E6A656374656420666F72207468697320706172656E742077696E646F773F20736B69702E0A20202020202069662028706172656E7457';
wwv_flow_imp.g_varchar2_table(187) := '696E5B5044505F4353535F494E4A4543545F464C41475D292072657475726E3B0A0A2020202020207661722063737354657874203D2027273B0A2020202020202F2F20312920506C7567696E204353532072756C65732028636F6C6C6563746564206672';
wwv_flow_imp.g_varchar2_table(188) := '6F6D207468697320696672616D652773207374796C65736865657473290A20202020202063737354657874202B3D20636F6C6C656374506C7567696E43737346726F6D446F6328646F63756D656E74293B0A2020202020202F2F20322920556E69766572';
wwv_flow_imp.g_varchar2_table(189) := '73616C205468656D6520435353207661726961626C65732074686520706F707570207265666572656E6365730A20202020202063737354657874202B3D20275C6E5C6E27202B20636F6C6C656374526F6F745661727346726F6D446F6328646F63756D65';
wwv_flow_imp.g_varchar2_table(190) := '6E74293B0A0A202020202020696620282163737354657874207C7C2021637373546578742E7265706C616365282F5C732F672C202727292E6C656E677468292072657475726E3B0A0A2020202020202F2F204275696C642061206672657368203C737479';
wwv_flow_imp.g_varchar2_table(191) := '6C653E20656C656D656E7420696E2074686520504152454E5420646F63756D656E740A202020202020766172207374796C65456C203D20706172656E74446F632E637265617465456C656D656E7428277374796C6527293B0A2020202020207374796C65';
wwv_flow_imp.g_varchar2_table(192) := '456C2E736574417474726962757465282774797065272C2027746578742F63737327293B0A2020202020207374796C65456C2E736574417474726962757465285044505F4353535F494E4A4543545F415454522C20277472756527293B0A202020202020';
wwv_flow_imp.g_varchar2_table(193) := '7374796C65456C2E7365744174747269627574652827646174612D736F75726365272C2027617065783336302D7065727369616E2D646174657069636B65722D696672616D6527293B0A2020202020202F2F20417070656E642074657874206E6F646520';
wwv_flow_imp.g_varchar2_table(194) := 'E28094207573696E672074657874436F6E74656E74206B65657073207468696E6773207361666520286E6F203C203E2070617273696E67292E0A2020202020207374796C65456C2E74657874436F6E74656E74203D20637373546578743B0A0A20202020';
wwv_flow_imp.g_varchar2_table(195) := '20202F2F20417070656E6420746F20706172656E74203C686561643E3B206966206E6F203C686561643E2C2066616C6C206261636B20746F203C626F64793E0A2020202020207661722068656164203D20706172656E74446F632E676574456C656D656E';
wwv_flow_imp.g_varchar2_table(196) := '747342795461674E616D6528276865616427295B305D207C7C20706172656E74446F632E626F64793B0A202020202020686561642E617070656E644368696C64287374796C65456C293B0A0A2020202020202F2F204D61726B2074686520706172656E74';
wwv_flow_imp.g_varchar2_table(197) := '2077696E646F7720736F207765206E6576657220696E6A65637420616761696E0A202020202020747279207B20706172656E7457696E5B5044505F4353535F494E4A4543545F464C41475D203D20747275653B207D20636174636820286529207B7D0A20';
wwv_flow_imp.g_varchar2_table(198) := '2020207D20636174636820286529207B0A2020202020202F2F20426573742D6566666F72743A20696620696E6A656374696F6E206661696C732C2074686520706F7075702077696C6C207374696C6C20776F726B206275740A2020202020202F2F206D61';
wwv_flow_imp.g_varchar2_table(199) := '79206C6F6F6B20756E7374796C656420696E2074686520706172656E742E20204C6F67206F6E636520666F7220646562756767696E672E0A202020202020747279207B206966202877696E646F772E636F6E736F6C652920636F6E736F6C652E7761726E';
wwv_flow_imp.g_varchar2_table(200) := '28275B617065783336302E5044505D2063726F73732D6672616D652043535320696E6A656374206661696C65643A272C2065293B207D206361746368285F29207B7D0A202020207D0A20207D0A0A20202F2A20E29590E29590E29590E29590E29590E295';
wwv_flow_imp.g_varchar2_table(201) := '90E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590';
wwv_flow_imp.g_varchar2_table(202) := 'E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E295900A2020202A205769646765740A2020202A20E29590E29590E29590E2';
wwv_flow_imp.g_varchar2_table(203) := '9590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E295';
wwv_flow_imp.g_varchar2_table(204) := '90E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590E29590202A2F0A202066756E6374696F6E2050445028656C';
wwv_flow_imp.g_varchar2_table(205) := '2C206F70747329207B0A20202020746869732E24656C2020202020202020203D202428656C293B0A20202020746869732E6F70747320202020202020203D20242E657874656E64287B7D2C2044454641554C54532C206F707473293B0A20202020746869';
wwv_flow_imp.g_varchar2_table(206) := '732E5F73656C20202020202020203D206E756C6C3B0A20202020746869732E5F74696D65202020202020203D207B20683A20302C206D3A2030207D3B0A20202020746869732E5F76696577202020202020203D206E756C6C3B0A20202020746869732E5F';
wwv_flow_imp.g_varchar2_table(207) := '6F70656E202020202020203D2066616C73653B0A20202020746869732E5F6A7573745069636B6564203D2066616C73653B0A20202020746869732E5F706F7075704D44202020203D2066616C73653B0A20202020746869732E5F64726F70646F776E2020';
wwv_flow_imp.g_varchar2_table(208) := '203D206E756C6C3B0A20202020746869732E5F6D696E44617465202020203D206E756C6C3B0A20202020746869732E5F6D617844617465202020203D206E756C6C3B0A20202020746869732E5F72746C20202020202020203D2069735061676552544C28';
wwv_flow_imp.g_varchar2_table(209) := '293B0A20202020746869732E5F75696420202020202020203D20746869732E24656C2E61747472282769642729207C7C2028277064705F27202B204D6174682E72616E646F6D28292E746F537472696E67283336292E736C696365283229293B0A202020';
wwv_flow_imp.g_varchar2_table(210) := '20746869732E5F696E6C696E6520202020203D2028746869732E6F7074732E646973706C61794173203D3D3D2027696E6C696E6527293B0A0A202020202F2A20E29480E29480204D6F64616C2D617761726520726F6F742077696E646F772F646F63756D';
wwv_flow_imp.g_varchar2_table(211) := '656E7420E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480202A2F0A2020202074686973';
wwv_flow_imp.g_varchar2_table(212) := '2E5F726F6F7457696E202020203D20676574526F6F7457696E646F7728293B0A20202020746869732E5F726F6F74446F63202020203D20746869732E5F726F6F7457696E2E646F63756D656E743B0A20202020746869732E5F696E496672616D65202020';
wwv_flow_imp.g_varchar2_table(213) := '3D206973496E73696465496672616D6528293B0A20202020746869732E5F6F776E496672616D6520203D206765744F776E496672616D6528293B0A0A20202020746869732E5F6275696C6428293B0A20207D0A0A20205044502E70726F746F7479706520';
wwv_flow_imp.g_varchar2_table(214) := '3D207B0A0A202020205F6275696C643A2066756E6374696F6E202829207B0A2020202020207661722073656C66203D20746869733B0A0A202020202020746869732E24656C2E637373287B0A2020202020202020706F736974696F6E3A20276162736F6C';
wwv_flow_imp.g_varchar2_table(215) := '757465272C2077696474683A2027317078272C206865696768743A2027317078272C0A20202020202020206F766572666C6F773A202768696464656E272C206F7061636974793A202730272C20706F696E7465724576656E74733A20276E6F6E65270A20';
wwv_flow_imp.g_varchar2_table(216) := '20202020207D292E617474722827746162696E646578272C20272D3127293B0A0A20202020202069662028746869732E5F696E6C696E6529207B0A20202020202020202F2F20E29480E2948020494E4C494E45206D6F64653A206E6F20696E7075742F62';
wwv_flow_imp.g_varchar2_table(217) := '7574746F6E2C20706F7075702072656E6465727320696E20706C61636520E29480E29480E29480E29480E294800A2020202020202020746869732E2477726170706572203D202428273C6469763E272C207B0A2020202020202020202027636C61737327';
wwv_flow_imp.g_varchar2_table(218) := '3A2027617065783336302D7064702D7772617070657220617065783336302D7064702D777261707065722D2D696E6C696E65270A20202020202020207D293B0A2020202020202020746869732E24646973706C6179203D202428273C696E7075743E272C';
wwv_flow_imp.g_varchar2_table(219) := '207B0A20202020202020202020747970653A202768696464656E272C2069643A20746869732E5F756964202B20275F444953504C4159270A20202020202020207D293B0A2020202020202020746869732E2462746E203D202428273C7370616E3E27293B';
wwv_flow_imp.g_varchar2_table(220) := '202F2F20706C616365686F6C64657220746F2061766F6964206E756C6C20726566730A2020202020202020746869732E24777261707065722E617070656E6428746869732E24646973706C6179293B0A2020202020202020746869732E24656C2E616674';
wwv_flow_imp.g_varchar2_table(221) := '657228746869732E2477726170706572293B0A0A2020202020202020746869732E24706F707570203D20746869732E5F6275696C64506F70757028293B0A2020202020202020746869732E24706F7075702E616464436C6173732827617065783336302D';
wwv_flow_imp.g_varchar2_table(222) := '7064702D706F7075702D2D696E6C696E6527292E73686F7728293B0A2020202020202020746869732E24777261707065722E617070656E6428746869732E24706F707570293B0A2020202020207D20656C7365207B0A20202020202020202F2F20E29480';
wwv_flow_imp.g_varchar2_table(223) := 'E2948020504F505550206D6F6465202864656661756C742920E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480';
wwv_flow_imp.g_varchar2_table(224) := 'E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E294800A2020202020202020766172206941747472203D207B0A20202020202020202020747970653A202774657874272C2069643A20746869732E5F756964202B2027';
wwv_flow_imp.g_varchar2_table(225) := '5F444953504C4159272C0A2020202020202020202027636C617373273A2027617065783336302D7064702D646973706C617920617065782D6974656D2D7465787420617065782D6974656D2D646174657069636B6572272C0A2020202020202020202070';
wwv_flow_imp.g_varchar2_table(226) := '6C616365686F6C6465723A20746869732E6F7074732E706C616365686F6C6465722C206175746F636F6D706C6574653A20276F6666272C0A2020202020202020202027617269612D686173706F707570273A202774727565272C2027617269612D657870';
wwv_flow_imp.g_varchar2_table(227) := '616E646564273A202766616C7365272C0A2020202020202020202027617269612D636F6E74726F6C73273A20746869732E5F756964202B20275F504F505550270A20202020202020207D3B0A20202020202020206966202821746869732E6F7074732E61';
wwv_flow_imp.g_varchar2_table(228) := '6C6C6F774D616E75616C496E707574292069417474722E726561646F6E6C79203D20747275653B0A2020202020202020746869732E24646973706C6179203D202428273C696E7075743E272C206941747472293B0A0A2020202020202020766172206963';
wwv_flow_imp.g_varchar2_table(229) := '6F6E436C73203D20746869732E6F7074732E73686F7754696D65203F2027612D49636F6E2069636F6E2D63616C656E6461722D74696D6527203A2027612D49636F6E2069636F6E2D63616C656E646172273B0A2020202020202020746869732E2462746E';
wwv_flow_imp.g_varchar2_table(230) := '203D202428273C627574746F6E3E272C207B0A20202020202020202020747970653A2027627574746F6E272C2027636C617373273A2027612D427574746F6E20612D427574746F6E2D2D63616C656E646172272C0A20202020202020202020746162696E';
wwv_flow_imp.g_varchar2_table(231) := '6465783A20272D31272C2027617269612D6C6162656C273A2027D8A8D8A7D8B220DAA9D8B1D8AFD98620D8AAD982D988DB8CD985270A20202020202020207D292E68746D6C28273C7370616E20636C6173733D2227202B2069636F6E436C73202B202722';
wwv_flow_imp.g_varchar2_table(232) := '20617269612D68696464656E3D2274727565223E3C2F7370616E3E27293B0A0A2020202020202020746869732E2477726170706572203D202428273C7370616E3E272C207B0A2020202020202020202027636C617373273A2027617065783336302D7064';
wwv_flow_imp.g_varchar2_table(233) := '702D777261707065722027202B2028746869732E5F72746C203F2027617065783336302D7064702D72746C27203A2027617065783336302D7064702D6C747227290A20202020202020207D292E617070656E6428746869732E24646973706C6179292E61';
wwv_flow_imp.g_varchar2_table(234) := '7070656E6428746869732E2462746E293B0A0A2020202020202020746869732E24656C2E616674657228746869732E2477726170706572293B0A0A2020202020202020746869732E24706F707570203D20746869732E5F6275696C64506F70757028293B';
wwv_flow_imp.g_varchar2_table(235) := '0A20202020202020202F2A20E29480E29480204D6F64616C2D617761726520706F70757020686F737420E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E2';
wwv_flow_imp.g_varchar2_table(236) := '9480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E294800A2020202020202020202A205768656E20696E7369646520616E2041504558204D6F64616C204469616C6F6720506167652028696672616D';
wwv_flow_imp.g_varchar2_table(237) := '65292C207765204D55535420617070656E640A2020202020202020202A2074686520706F70757020746F2074686520706172656E742077696E646F772773203C626F64793E2C206F746865727769736520697420776F756C642062650A20202020202020';
wwv_flow_imp.g_varchar2_table(238) := '20202A20636C69707065642062792074686520696672616D6520283D20746865206D6F64616C206672616D65292E20205768656E206E6F7420696E20616E0A2020202020202020202A20696672616D652C20776520757365207468652063757272656E74';
wwv_flow_imp.g_varchar2_table(239) := '20626F64792C2065786163746C79206173206265666F72652E202A2F0A202020202020202069662028746869732E5F696E496672616D6529207B0A20202020202020202020746869732E24706F7075702E616464436C6173732827617065783336302D70';
wwv_flow_imp.g_varchar2_table(240) := '64702D706F7075702D2D63726F73732D6672616D6527293B0A202020202020202020202F2A2054686520706F707570206C6976657320696E2074686520504152454E5420646F63756D656E742C20627574206F757220706C7567696E2043535320776173';
wwv_flow_imp.g_varchar2_table(241) := '0A20202020202020202020202A206C6F6164656420696E746F2074686520494652414D4520646F63756D656E74202877686572652074686973207363726970742072756E73292E0A20202020202020202020202A20576974686F75742068656C702C2074';
wwv_flow_imp.g_varchar2_table(242) := '686520706172656E7420646F63756D656E7420686173206E6F202E617065783336302D7064702D2A204353530A20202020202020202020202A2072756C65732C20736F2074686520706F70757020776F756C642072656E64657220756E7374796C65642E';
wwv_flow_imp.g_varchar2_table(243) := '0A20202020202020202020202A0A20202020202020202020202A20536F6C7574696F6E3A20636F707920657665727920706C7567696E204353532072756C652066726F6D2074686520696672616D6520646F63756D656E740A2020202020202020202020';
wwv_flow_imp.g_varchar2_table(244) := '2A20696E746F20612073696E676C65203C7374796C653E20656C656D656E74207468617420776520696E6A65637420696E746F2074686520706172656E740A20202020202020202020202A20646F63756D656E742773203C686561643E2E202057652061';
wwv_flow_imp.g_varchar2_table(245) := '6C736F20636F70792074686520556E6976657273616C205468656D652773204353530A20202020202020202020202A207661726961626C65732028746865202D2D612D2A20616E64202D2D6F6A2D2A20637573746F6D2070726F70657274696573292C20';
wwv_flow_imp.g_varchar2_table(246) := '626563617573650A20202020202020202020202A2074686520706F707570207265666572656E636573207468656D20616E6420746865792061726520646566696E6564206F6E207468650A20202020202020202020202A20696672616D652773203A726F';
wwv_flow_imp.g_varchar2_table(247) := '6F742E20205468697320697320646F6E65206C617A696C7920616E64206F6E6C79206F6E6365207065720A20202020202020202020202A20706172656E7420646F63756D656E742E202A2F0A20202020202020202020746869732E5F696E6A6563744373';
wwv_flow_imp.g_varchar2_table(248) := '73496E746F506172656E7428293B0A202020202020202020202428746869732E5F726F6F74446F632E626F6479292E617070656E6428746869732E24706F707570293B0A20202020202020207D20656C7365207B0A20202020202020202020242827626F';
wwv_flow_imp.g_varchar2_table(249) := '647927292E617070656E6428746869732E24706F707570293B0A20202020202020207D0A2020202020207D0A0A202020202020746869732E5F726573746F726556616C756528746869732E24656C2E76616C2829293B0A20202020202069662028746869';
wwv_flow_imp.g_varchar2_table(250) := '732E6F7074732E64697361626C65642920746869732E64697361626C6528293B0A202020202020746869732E5F62696E644576656E747328293B0A0A2020202020202F2F20496E6C696E653A206F70656E20696D6D6564696174656C7920616E64206B65';
wwv_flow_imp.g_varchar2_table(251) := '6570206F70656E0A20202020202069662028746869732E5F696E6C696E6529207B0A2020202020202020746869732E5F6F70656E203D20747275653B0A20202020202020207661722074203D2049432E746F64617928293B0A2020202020202020746869';
wwv_flow_imp.g_varchar2_table(252) := '732E5F76696577203D20746869732E5F73656C203F207B20793A20746869732E5F73656C2E792C206D3A20746869732E5F73656C2E6D207D203A207B20793A20742E792C206D3A20742E6D207D3B0A2020202020202020746869732E5F7265736F6C7665';
wwv_flow_imp.g_varchar2_table(253) := '4D696E4D617828293B0A2020202020202020746869732E5F72656E6465724772696428293B0A2020202020202020746869732E5F72656E64657254696D6528293B0A2020202020207D0A202020207D2C0A0A202020205F726573746F726556616C75653A';
wwv_flow_imp.g_varchar2_table(254) := '2066756E6374696F6E202876616C29207B0A202020202020696620282176616C292072657475726E3B0A202020202020766172206C6174696E56616C203D206E6F726D616C697A654A616C616C6956616C75652876616C293B0A20202020202076617220';
wwv_flow_imp.g_varchar2_table(255) := '7061727473203D206C6174696E56616C2E73706C697428272027293B0A2020202020207661722064203D2049432E70617273652870617274735B305D2C20746869732E6F7074732E72657475726E466F726D6174293B0A20202020202069662028216429';
wwv_flow_imp.g_varchar2_table(256) := '2072657475726E3B0A202020202020746869732E5F73656C203D20643B0A20202020202069662028746869732E6F7074732E73686F7754696D652026262070617274735B315D29207B0A2020202020202020766172207470203D2070617274735B315D2E';
wwv_flow_imp.g_varchar2_table(257) := '73706C697428273A27293B0A2020202020202020746869732E5F74696D65203D207B20683A204D6174682E6D696E2832332C2B74705B305D7C7C30292C206D3A204D6174682E6D696E2835392C2B74705B315D7C7C3029207D3B0A2020202020207D0A20';
wwv_flow_imp.g_varchar2_table(258) := '2020202020746869732E5F72656E646572446973706C617928293B0A202020207D2C0A0A202020205F6275696C64506F7075703A2066756E6374696F6E202829207B0A202020202020766172202470203D202428273C6469763E272C207B0A2020202020';
wwv_flow_imp.g_varchar2_table(259) := '20202069643A20746869732E5F756964202B20275F504F505550272C2027636C617373273A2027617065783336302D7064702D706F707570272C0A2020202020202020726F6C653A20276469616C6F67272C2027617269612D6C6162656C273A2027D8A7';
wwv_flow_imp.g_varchar2_table(260) := 'D986D8AAD8AED8A7D8A820D8AAD8A7D8B1DB8CD8AE272C0A202020202020202027617269612D6D6F64616C273A202774727565272C206469723A202772746C270A2020202020207D293B0A2020202020206966202821746869732E5F696E6C696E652920';
wwv_flow_imp.g_varchar2_table(261) := '24702E6869646528293B0A0A2020202020202F2F2048656164657220E280942073686F772F68696465207965617220616E64206D6F6E746820626C6F636B73206261736564206F6E206F7074696F6E730A2020202020207661722024686472203D202428';
wwv_flow_imp.g_varchar2_table(262) := '273C64697620636C6173733D22617065783336302D7064702D686561646572223E27293B0A0A20202020202076617220246D4C626C426C6F636B203D202428273C64697620636C6173733D22617065783336302D7064702D6D6F6E74682D626C6F636B22';
wwv_flow_imp.g_varchar2_table(263) := '3E27293B0A20202020202069662028746869732E6F7074732E73686F774D6F6E746829207B0A2020202020202020246D4C626C426C6F636B2E617070656E6428273C627574746F6E20747970653D22627574746F6E2220636C6173733D22617065783336';
wwv_flow_imp.g_varchar2_table(264) := '302D7064702D6D6F6E74682D6C626C20617065783336302D7064702D6C626C2D62746E22207469746C653D22D8A7D986D8AAD8AED8A7D8A820D985D8A7D9872220617269612D6C6162656C3D22D8A7D986D8AAD8AED8A7D8A820D985D8A7D987223E3C2F';
wwv_flow_imp.g_varchar2_table(265) := '627574746F6E3E27293B0A2020202020207D0A0A20202020202076617220247972426C6F636B203D202428273C64697620636C6173733D22617065783336302D7064702D796561722D626C6F636B223E27293B0A20202020202069662028746869732E6F';
wwv_flow_imp.g_varchar2_table(266) := '7074732E73686F775965617229207B0A2020202020202020766172205F6E6F597252616E6765203D204F626A6563742E6B65797328746869732E6F7074732E7965617252616E6765292E6C656E677468203D3D3D20303B0A202020202020202069662028';
wwv_flow_imp.g_varchar2_table(267) := '5F6E6F597252616E676529207B20247972426C6F636B2E617070656E6428273C627574746F6E20747970653D22627574746F6E2220636C6173733D22617065783336302D7064702D796561722D62746E20617065783336302D7064702D6E6578742D7965';
wwv_flow_imp.g_varchar2_table(268) := '617220617065783336302D7064702D796561722D757022207469746C653D22D8B3D8A7D98420D8A8D8B9D8AF2220617269612D6C6162656C3D22D8B3D8A7D98420D8A8D8B9D8AF223E262378323542343B3C2F627574746F6E3E27293B207D0A20202020';
wwv_flow_imp.g_varchar2_table(269) := '20202020247972426C6F636B2E617070656E6428273C627574746F6E20747970653D22627574746F6E2220636C6173733D22617065783336302D7064702D796561722D6C626C20617065783336302D7064702D6C626C2D62746E22207469746C653D22D8';
wwv_flow_imp.g_varchar2_table(270) := 'A7D986D8AAD8AED8A7D8A820D8B3D8A7D9842220617269612D6C6162656C3D22D8A7D986D8AAD8AED8A7D8A820D8B3D8A7D984223E3C2F627574746F6E3E27293B0A2020202020202020696620285F6E6F597252616E676529207B20247972426C6F636B';
wwv_flow_imp.g_varchar2_table(271) := '2E617070656E6428273C627574746F6E20747970653D22627574746F6E2220636C6173733D22617065783336302D7064702D796561722D62746E20617065783336302D7064702D707265762D7965617220617065783336302D7064702D796561722D646F';
wwv_flow_imp.g_varchar2_table(272) := '776E22207469746C653D22D8B3D8A7D98420D982D8A8D9842220617269612D6C6162656C3D22D8B3D8A7D98420D982D8A8D984223E262378323542453B3C2F627574746F6E3E27293B207D0A2020202020207D0A0A20202020202076617220246D4E6176';
wwv_flow_imp.g_varchar2_table(273) := '426C6F636B203D202428273C64697620636C6173733D22617065783336302D7064702D6D6F6E74682D6172726F772D626C6F636B223E27293B0A20202020202069662028746869732E6F7074732E73686F774D6F6E746829207B0A202020202020202076';
wwv_flow_imp.g_varchar2_table(274) := '6172205F6E6F4D6E52616E6765203D204F626A6563742E6B65797328746869732E6F7074732E6D6F6E746852616E6765292E6C656E677468203D3D3D20303B0A2020202020202020696620285F6E6F4D6E52616E676529207B20246D4E6176426C6F636B';
wwv_flow_imp.g_varchar2_table(275) := '2E617070656E6428273C627574746F6E20747970653D22627574746F6E2220636C6173733D22617065783336302D7064702D6E617620617065783336302D7064702D707265762D6D6F6E746822207469746C653D22D985D8A7D98720D982D8A8D9842220';
wwv_flow_imp.g_varchar2_table(276) := '617269612D6C6162656C3D22D985D8A7D98720D982D8A8D984223E262378323033393B3C2F627574746F6E3E27293B207D0A2020202020202020696620285F6E6F4D6E52616E676529207B20246D4E6176426C6F636B2E617070656E6428273C62757474';
wwv_flow_imp.g_varchar2_table(277) := '6F6E20747970653D22627574746F6E2220636C6173733D22617065783336302D7064702D6E617620617065783336302D7064702D6E6578742D6D6F6E746822207469746C653D22D985D8A7D98720D8A8D8B9D8AF2220617269612D6C6162656C3D22D985';
wwv_flow_imp.g_varchar2_table(278) := 'D8A7D98720D8A8D8B9D8AF223E262378323033413B3C2F627574746F6E3E27293B207D0A2020202020207D0A0A202020202020246864722E617070656E6428246D4C626C426C6F636B292E617070656E6428247972426C6F636B292E617070656E642824';
wwv_flow_imp.g_varchar2_table(279) := '6D4E6176426C6F636B293B0A0A20202020202076617220246468203D202428273C64697620636C6173733D22617065783336302D7064702D646F77223E27293B0A2020202020205B27D8B4272C27DB8C272C27D8AF272C27D8B3272C27DA86272C27D9BE';
wwv_flow_imp.g_varchar2_table(280) := '272C27D8AC275D2E666F72456163682866756E6374696F6E2864297B0A20202020202020202464682E617070656E6428273C7370616E20636C6173733D22617065783336302D7064702D646F772D63656C6C223E27202B2064202B20273C2F7370616E3E';
wwv_flow_imp.g_varchar2_table(281) := '27293B0A2020202020207D293B0A0A202020202020746869732E2467726964203D202428273C64697620636C6173733D22617065783336302D7064702D677269642220726F6C653D2267726964223E27293B0A0A202020202020746869732E2464726F70';
wwv_flow_imp.g_varchar2_table(282) := '646F776E203D202428273C64697620636C6173733D22617065783336302D7064702D64642220726F6C653D226C697374626F7822206469723D2272746C223E27292E6869646528293B0A202020202020746869732E2464644C6973742020203D20242827';
wwv_flow_imp.g_varchar2_table(283) := '3C756C20636C6173733D22617065783336302D7064702D64642D6C697374223E27293B0A202020202020746869732E2464726F70646F776E2E617070656E6428746869732E2464644C697374293B0A0A20202020202076617220246674203D202428273C';
wwv_flow_imp.g_varchar2_table(284) := '64697620636C6173733D22617065783336302D7064702D666F6F74657222206469723D2272746C223E27293B0A2020202020202F2F205468652022D8AAD8A3DB8CDB8CD8AF222028436F6E6669726D2920627574746F6E206973206F6E6C792075736566';
wwv_flow_imp.g_varchar2_table(285) := '756C207768656E207468652074696D65207069636B65722069730A2020202020202F2F20656E61626C656420286F7468657277697365206461792D636C69636B20616C726561647920636C6F7365732074686520706F7075702C2065786163746C79206C';
wwv_flow_imp.g_varchar2_table(286) := '696B650A2020202020202F2F20746865206E617469766520415045582044617465205069636B6572292E202054686973206D616B657320746865206E6F2D74696D652063617365206C6F6F6B0A2020202020202F2F2076697375616C6C79206964656E74';
wwv_flow_imp.g_varchar2_table(287) := '6963616C20746F20746865206E6174697665207069636B65722E0A2020202020206966202821746869732E5F696E6C696E6520262620746869732E6F7074732E73686F7754696D6529207B0A20202020202020202466742E617070656E6428273C627574';
wwv_flow_imp.g_varchar2_table(288) := '746F6E20747970653D22627574746F6E2220636C6173733D22617065783336302D7064702D666F6F742D62746E20617065783336302D7064702D636C6F7365223ED8AAD8A3DB8CDB8CD8AF3C2F627574746F6E3E27293B0A2020202020207D0A20202020';
wwv_flow_imp.g_varchar2_table(289) := '202069662028746869732E6F7074732E73686F77546F646179427574746F6E29207B0A20202020202020202466742E617070656E6428273C627574746F6E20747970653D22627574746F6E2220636C6173733D22617065783336302D7064702D666F6F74';
wwv_flow_imp.g_varchar2_table(290) := '2D62746E20617065783336302D7064702D746F646179223ED8A7D985D8B1D988D8B23C2F627574746F6E3E27293B0A2020202020207D0A20202020202069662028746869732E6F7074732E73686F77436C656172427574746F6E29207B0A202020202020';
wwv_flow_imp.g_varchar2_table(291) := '20202466742E617070656E6428273C627574746F6E20747970653D22627574746F6E2220636C6173733D22617065783336302D7064702D666F6F742D62746E20617065783336302D7064702D636C656172223ED9BED8A7DAA920DAA9D8B1D8AFD9863C2F';
wwv_flow_imp.g_varchar2_table(292) := '627574746F6E3E27293B0A2020202020207D0A20202020202069662028746869732E6F7074732E73686F7754696D6529207B0A2020202020202020746869732E2474696D65526F77203D202428273C64697620636C6173733D22617065783336302D7064';
wwv_flow_imp.g_varchar2_table(293) := '702D74696D652D696E6C696E6522206469723D226C7472223E27293B0A2020202020202020746869732E2474696D65526F772E68746D6C280A20202020202020202020273C7370616E20636C6173733D22617065783336302D7064702D74696D652D6963';
wwv_flow_imp.g_varchar2_table(294) := '6F6E223E3C7370616E20636C6173733D22612D49636F6E2069636F6E2D74696D652220617269612D68696464656E3D2274727565223E3C2F7370616E3E3C2F7370616E3E27202B0A20202020202020202020273C64697620636C6173733D226170657833';
wwv_flow_imp.g_varchar2_table(295) := '36302D7064702D74696D652D6374726C223E27202B0A202020202020202020202020273C627574746F6E20747970653D22627574746F6E2220636C6173733D22617065783336302D7064702D74696D652D62746E2220646174612D663D22682220646174';
wwv_flow_imp.g_varchar2_table(296) := '612D643D2231223E262378323542343B3C2F627574746F6E3E27202B0A202020202020202020202020273C627574746F6E20747970653D22627574746F6E2220636C6173733D22617065783336302D7064702D74696D652D62746E2220646174612D663D';
wwv_flow_imp.g_varchar2_table(297) := '22682220646174612D643D222D31223E262378323542453B3C2F627574746F6E3E27202B0A20202020202020202020273C2F6469763E27202B0A20202020202020202020273C64697620636C6173733D22617065783336302D7064702D74696D652D6374';
wwv_flow_imp.g_varchar2_table(298) := '726C223E27202B0A202020202020202020202020273C627574746F6E20747970653D22627574746F6E2220636C6173733D22617065783336302D7064702D74696D652D696E7020617065783336302D7064702D6820617065783336302D7064702D6C626C';
wwv_flow_imp.g_varchar2_table(299) := '2D62746E20617065783336302D7064702D682D62746E22207469746C653D22D8A7D986D8AAD8AED8A7D8A820D8B3D8A7D8B9D8AA2220617269612D6C6162656C3D22D8A7D986D8AAD8AED8A7D8A820D8B3D8A7D8B9D8AA223E30303C2F627574746F6E3E';
wwv_flow_imp.g_varchar2_table(300) := '27202B0A20202020202020202020273C2F6469763E27202B0A20202020202020202020273C7370616E20636C6173733D22617065783336302D7064702D74696D652D736570223E3A3C2F7370616E3E27202B0A20202020202020202020273C6469762063';
wwv_flow_imp.g_varchar2_table(301) := '6C6173733D22617065783336302D7064702D74696D652D6374726C223E27202B0A202020202020202020202020273C627574746F6E20747970653D22627574746F6E2220636C6173733D22617065783336302D7064702D74696D652D696E702061706578';
wwv_flow_imp.g_varchar2_table(302) := '3336302D7064702D6D20617065783336302D7064702D6C626C2D62746E20617065783336302D7064702D6D2D62746E22207469746C653D22D8A7D986D8AAD8AED8A7D8A820D8AFD982DB8CD982D9872220617269612D6C6162656C3D22D8A7D986D8AAD8';
wwv_flow_imp.g_varchar2_table(303) := 'AED8A7D8A820D8AFD982DB8CD982D987223E30303C2F627574746F6E3E27202B0A20202020202020202020273C2F6469763E27202B0A20202020202020202020273C64697620636C6173733D22617065783336302D7064702D74696D652D6374726C223E';
wwv_flow_imp.g_varchar2_table(304) := '27202B0A202020202020202020202020273C627574746F6E20747970653D22627574746F6E2220636C6173733D22617065783336302D7064702D74696D652D62746E2220646174612D663D226D2220646174612D643D2231223E262378323542343B3C2F';
wwv_flow_imp.g_varchar2_table(305) := '627574746F6E3E27202B0A202020202020202020202020273C627574746F6E20747970653D22627574746F6E2220636C6173733D22617065783336302D7064702D74696D652D62746E2220646174612D663D226D2220646174612D643D222D31223E2623';
wwv_flow_imp.g_varchar2_table(306) := '78323542453B3C2F627574746F6E3E27202B0A20202020202020202020273C2F6469763E270A2020202020202020293B0A20202020202020202466742E617070656E6428746869732E2474696D65526F77293B0A2020202020207D20656C7365207B0A20';
wwv_flow_imp.g_varchar2_table(307) := '20202020202020746869732E2474696D65526F77203D202428273C6469763E27292E6869646528293B0A2020202020207D0A0A20202020202072657475726E2024700A20202020202020202E617070656E642824686472290A20202020202020202E6170';
wwv_flow_imp.g_varchar2_table(308) := '70656E6428746869732E2464726F70646F776E290A20202020202020202E617070656E6428246468290A20202020202020202E617070656E6428746869732E2467726964290A20202020202020202E617070656E6428246674293B0A202020207D2C0A0A';
wwv_flow_imp.g_varchar2_table(309) := '202020205F7265736F6C76654D696E4D61783A2066756E6374696F6E2829207B0A202020202020766172206F203D20746869732E6F7074732C2072466D74203D206F2E72657475726E466F726D61743B0A202020202020746869732E5F6D696E44617465';
wwv_flow_imp.g_varchar2_table(310) := '203D207265736F6C766544617465426F756E64286F2E6D696E44617465547970652C206F2E6D696E446174654974656D2C206F2E6D696E446174655374617469632C2072466D74293B0A202020202020746869732E5F6D617844617465203D207265736F';
wwv_flow_imp.g_varchar2_table(311) := '6C766544617465426F756E64286F2E6D617844617465547970652C206F2E6D6178446174654974656D2C206F2E6D6178446174655374617469632C2072466D74293B0A202020207D2C0A0A202020205F62696E644576656E74733A2066756E6374696F6E';
wwv_flow_imp.g_varchar2_table(312) := '202829207B0A2020202020207661722073656C66203D20746869733B0A202020202020766172206E732020203D20272E7064705F27202B20746869732E5F7569643B0A0A2020202020206966202821746869732E5F696E6C696E6529207B0A2020202020';
wwv_flow_imp.g_varchar2_table(313) := '2020202F2F20427574746F6E20746F67676C65730A2020202020202020746869732E2462746E2E6F6E2827636C69636B27202B206E732C2066756E6374696F6E286529207B0A20202020202020202020652E70726576656E7444656661756C7428293B20';
wwv_flow_imp.g_varchar2_table(314) := '652E73746F7050726F7061676174696F6E28293B0A2020202020202020202073656C662E5F6F70656E203F2073656C662E636C6F73652829203A2073656C662E6F70656E28293B0A20202020202020207D293B0A0A202020202020202069662028746869';
wwv_flow_imp.g_varchar2_table(315) := '732E6F7074732E616C6C6F774D616E75616C496E70757429207B0A2020202020202020202069662028746869732E6F7074732E73686F774F6E203D3D3D2027666F6375732729207B0A202020202020202020202020746869732E24646973706C61792E6F';
wwv_flow_imp.g_varchar2_table(316) := '6E2827666F63757327202B206E732C2066756E6374696F6E2829207B0A2020202020202020202020202020696620282173656C662E5F6A7573745069636B6564202626202173656C662E5F6F70656E292073656C662E6F70656E28293B0A202020202020';
wwv_flow_imp.g_varchar2_table(317) := '202020202020202073656C662E5F73686F774564697461626C6556616C756528293B0A2020202020202020202020207D293B0A202020202020202020207D20656C7365207B0A202020202020202020202020746869732E24646973706C61792E6F6E2827';
wwv_flow_imp.g_varchar2_table(318) := '666F63757327202B206E732C2066756E6374696F6E2829207B0A202020202020202020202020202073656C662E5F73686F774564697461626C6556616C756528293B0A2020202020202020202020207D293B0A202020202020202020207D0A2020202020';
wwv_flow_imp.g_varchar2_table(319) := '2020202020746869732E24646973706C61792E6F6E2827626C757227202B206E732C2066756E6374696F6E2829207B0A2020202020202020202020206966202873656C662E5F706F7075704D44292072657475726E3B0A20202020202020202020202073';
wwv_flow_imp.g_varchar2_table(320) := '656C662E5F70617273654D616E75616C28293B2073656C662E636C6F736528293B0A202020202020202020207D293B0A20202020202020202020746869732E24646973706C61792E6F6E28276B6579646F776E27202B206E732C2066756E6374696F6E28';
wwv_flow_imp.g_varchar2_table(321) := '6529207B0A20202020202020202020202069662028652E6B6579203D3D3D2027456E746572272920207B20652E70726576656E7444656661756C7428293B2073656C662E5F70617273654D616E75616C28293B2073656C662E636C6F736528293B207D0A';
wwv_flow_imp.g_varchar2_table(322) := '20202020202020202020202069662028652E6B6579203D3D3D20274573636170652729207B2073656C662E5F72656E646572446973706C617928293B2073656C662E636C6F736528293B207D0A2020202020202020202020202F2F20497373756520323A';
wwv_flow_imp.g_varchar2_table(323) := '20636C6F736520706F707570207768656E20757365722073746172747320747970696E67206D616E75616C6C790A2020202020202020202020202F2F2028616E79207072696E7461626C65206B65792074686174206973206E6F742061206E6176696761';
wwv_flow_imp.g_varchar2_table(324) := '74696F6E2F6D6F646966696572206B6579290A2020202020202020202020206966202873656C662E5F6F70656E20262620652E6B65792E6C656E677468203D3D3D20312026262021652E6374726C4B65792026262021652E616C744B6579202626202165';
wwv_flow_imp.g_varchar2_table(325) := '2E6D6574614B657929207B0A202020202020202020202020202073656C662E636C6F736528293B0A2020202020202020202020207D0A202020202020202020207D293B0A20202020202020207D20656C7365207B0A202020202020202020206966202874';
wwv_flow_imp.g_varchar2_table(326) := '6869732E6F7074732E73686F774F6E203D3D3D2027666F6375732729207B0A202020202020202020202020746869732E24646973706C61792E6F6E2827666F63757327202B206E732C2066756E6374696F6E2829207B0A20202020202020202020202020';
wwv_flow_imp.g_varchar2_table(327) := '2073656C662E5F72656E646572446973706C617928293B0A20202020202020202020202020206966202873656C662E5F6A7573745069636B6564207C7C2073656C662E5F6F70656E292072657475726E3B0A202020202020202020202020202073656C66';
wwv_flow_imp.g_varchar2_table(328) := '2E6F70656E28293B0A2020202020202020202020207D293B0A202020202020202020207D20656C7365207B0A202020202020202020202020746869732E24646973706C61792E6F6E2827666F63757327202B206E732C2066756E6374696F6E2829207B20';
wwv_flow_imp.g_varchar2_table(329) := '73656C662E5F72656E646572446973706C617928293B207D293B0A202020202020202020207D0A20202020202020202020746869732E24646973706C61792E6F6E28276B6579646F776E27202B206E732C2066756E6374696F6E286529207B0A20202020';
wwv_flow_imp.g_varchar2_table(330) := '202020202020202069662028652E6B6579203D3D3D2027456E74657227207C7C20652E6B6579203D3D3D2027202729207B20652E70726576656E7444656661756C7428293B2073656C662E6F70656E28293B207D0A202020202020202020202020696620';
wwv_flow_imp.g_varchar2_table(331) := '28652E6B6579203D3D3D202745736361706527292073656C662E636C6F736528293B0A202020202020202020207D293B0A20202020202020207D0A0A2020202020202020746869732E24706F7075702E6F6E28276D6F757365646F776E27202B206E732C';
wwv_flow_imp.g_varchar2_table(332) := '2066756E6374696F6E2829207B2073656C662E5F706F7075704D44203D20747275653B207D293B0A20202020202020202428646F63756D656E74292E6F6E28276D6F757365757027202B206E732C20202066756E6374696F6E2829207B2073656C662E5F';
wwv_flow_imp.g_varchar2_table(333) := '706F7075704D44203D2066616C73653B207D293B0A20202020202020202F2A205768656E2074686520706F7075702069732072656E646572656420696E2074686520706172656E7420646F63756D656E7420286D6F64616C20706167650A202020202020';
wwv_flow_imp.g_varchar2_table(334) := '2020202A2063617365292C207765206D75737420616C736F206C697374656E206F6E2074686520706172656E7420646F63756D656E742C206F746865727769736520610A2020202020202020202A206D6F757365646F776E20696E736964652074686520';
wwv_flow_imp.g_varchar2_table(335) := '706F70757020776F756C646E27742073657420746865205F706F7075704D4420666C616720616E640A2020202020202020202A20746865206E65787420626C7572206F662074686520696E70757420776F756C6420636C6F73652074686520706F707570';
wwv_flow_imp.g_varchar2_table(336) := '20696D6D6564696174656C792E202A2F0A202020202020202069662028746869732E5F696E496672616D6529207B0A202020202020202020202428746869732E5F726F6F74446F63292E6F6E28276D6F757365757027202B206E732C2066756E6374696F';
wwv_flow_imp.g_varchar2_table(337) := '6E2829207B2073656C662E5F706F7075704D44203D2066616C73653B207D293B0A20202020202020207D0A0A20202020202020202F2A204F7574736964652D636C69636B2068616E646C65722E0A2020202020202020202A20202D20496620706F707570';
wwv_flow_imp.g_varchar2_table(338) := '20697320696E20746869732077696E646F772C207765206C697374656E206F6E207468697320646F63756D656E742E0A2020202020202020202A20202D20496620706F70757020697320696E2074686520706172656E742077696E646F7720286D6F6461';
wwv_flow_imp.g_varchar2_table(339) := '6C207061676520696672616D652063617365292C0A2020202020202020202A20202020776520414C534F206C697374656E206F6E2074686520706172656E7420646F63756D656E742C20736F20636C69636B696E6720616E7977686572650A2020202020';
wwv_flow_imp.g_varchar2_table(340) := '202020202A202020206F7574736964652074686520706F7075702028696E636C7564696E67206F7574736964652074686520696672616D652920636C6F7365732069742E202A2F0A20202020202020202428646F63756D656E74292E6F6E28276D6F7573';
wwv_flow_imp.g_varchar2_table(341) := '65646F776E27202B206E732C2066756E6374696F6E286529207B0A2020202020202020202073656C662E5F68616E646C654F757473696465436C69636B2865293B0A20202020202020207D293B0A202020202020202069662028746869732E5F696E4966';
wwv_flow_imp.g_varchar2_table(342) := '72616D6529207B0A202020202020202020202428746869732E5F726F6F74446F63292E6F6E28276D6F757365646F776E27202B206E732C2066756E6374696F6E286529207B0A20202020202020202020202073656C662E5F68616E646C654F7574736964';
wwv_flow_imp.g_varchar2_table(343) := '65436C69636B2865293B0A202020202020202020207D293B0A20202020202020207D0A0A2020202020202020746869732E24706F7075702E6F6E28276B6579646F776E27202B206E732C2066756E6374696F6E286529207B0A2020202020202020202069';
wwv_flow_imp.g_varchar2_table(344) := '662028652E6B6579203D3D3D20274573636170652729207B0A2020202020202020202020206966202873656C662E5F64726F70646F776E29207B2073656C662E5F636C6F736544726F70646F776E28293B207D0A202020202020202020202020656C7365';
wwv_flow_imp.g_varchar2_table(345) := '207B2073656C662E636C6F736528293B2073656C662E24646973706C61792E666F63757328293B207D0A202020202020202020207D0A20202020202020207D293B0A0A2020202020202020242877696E646F77292E6F6E28277363726F6C6C27202B206E';
wwv_flow_imp.g_varchar2_table(346) := '73202B202720726573697A6527202B206E732C2066756E6374696F6E2829207B0A202020202020202020206966202873656C662E5F6F70656E292073656C662E5F706F736974696F6E506F70757028293B0A20202020202020207D293B0A202020202020';
wwv_flow_imp.g_varchar2_table(347) := '20202F2A205768656E2074686520706F70757020697320696E2074686520706172656E742077696E646F772C2074686520696672616D6520697473656C662063616E0A2020202020202020202A206265206D6F7665642F726573697A6564206279207468';
wwv_flow_imp.g_varchar2_table(348) := '6520706172656E742773206D6F64616C206469616C6F67206472616767696E6720E28094207765206E6565640A2020202020202020202A20746F2072652D706F736974696F6E206F6E2074686520706172656E742773207363726F6C6C2F726573697A65';
wwv_flow_imp.g_varchar2_table(349) := '2061732077656C6C2E202A2F0A202020202020202069662028746869732E5F696E496672616D6529207B0A202020202020202020202428746869732E5F726F6F7457696E292E6F6E28277363726F6C6C27202B206E73202B202720726573697A6527202B';
wwv_flow_imp.g_varchar2_table(350) := '206E732C2066756E6374696F6E2829207B0A2020202020202020202020206966202873656C662E5F6F70656E292073656C662E5F706F736974696F6E506F70757028293B0A202020202020202020207D293B0A20202020202020207D0A2020202020207D';
wwv_flow_imp.g_varchar2_table(351) := '0A0A2020202020202F2F20E29480E2948020506F707570206E617669676174696F6E20E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E294';
wwv_flow_imp.g_varchar2_table(352) := '80E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E294800A202020202020746869732E24706F7075700A20202020202020202E6F6E2827636C69636B272C20272E617065';
wwv_flow_imp.g_varchar2_table(353) := '783336302D7064702D707265762D6D6F6E7468272C2066756E6374696F6E2829207B2073656C662E5F636C6F736544726F70646F776E28293B2073656C662E5F6E617628302C2D31293B207D290A20202020202020202E6F6E2827636C69636B272C2027';
wwv_flow_imp.g_varchar2_table(354) := '2E617065783336302D7064702D6E6578742D6D6F6E7468272C2066756E6374696F6E2829207B2073656C662E5F636C6F736544726F70646F776E28293B2073656C662E5F6E617628302C2031293B207D290A20202020202020202E6F6E2827636C69636B';
wwv_flow_imp.g_varchar2_table(355) := '272C20272E617065783336302D7064702D707265762D79656172272C202066756E6374696F6E2829207B2073656C662E5F636C6F736544726F70646F776E28293B2073656C662E5F6E6176282D312C30293B207D290A20202020202020202E6F6E282763';
wwv_flow_imp.g_varchar2_table(356) := '6C69636B272C20272E617065783336302D7064702D6E6578742D79656172272C202066756E6374696F6E2829207B2073656C662E5F636C6F736544726F70646F776E28293B2073656C662E5F6E61762820312C30293B207D290A20202020202020202E6F';
wwv_flow_imp.g_varchar2_table(357) := '6E2827636C69636B272C20272E617065783336302D7064702D746F646179272C20202020202066756E6374696F6E2829207B2073656C662E5F636C6F736544726F70646F776E28293B2073656C662E5F7069636B546F64617928293B207D290A20202020';
wwv_flow_imp.g_varchar2_table(358) := '202020202E6F6E2827636C69636B272C20272E617065783336302D7064702D74696D652D69636F6E272C202066756E6374696F6E2829207B0A202020202020202020202F2F205365742063757272656E742074696D65207768656E20636C6F636B206963';
wwv_flow_imp.g_varchar2_table(359) := '6F6E20697320636C69636B65640A20202020202020202020766172206E6F77203D206E6577204461746528293B0A2020202020202020202073656C662E5F74696D652E68203D206E6F772E676574486F75727328293B0A2020202020202020202073656C';
wwv_flow_imp.g_varchar2_table(360) := '662E5F74696D652E6D203D206E6F772E6765744D696E7574657328293B0A2020202020202020202073656C662E5F72656E64657254696D6528293B0A2020202020202020202073656C662E5F72656E646572446973706C617928293B0A20202020202020';
wwv_flow_imp.g_varchar2_table(361) := '20202073656C662E5F73796E6348696464656E28293B0A20202020202020207D290A20202020202020202E6F6E2827636C69636B272C20272E617065783336302D7064702D636C656172272C20202020202066756E6374696F6E2829207B2073656C662E';
wwv_flow_imp.g_varchar2_table(362) := '5F636C6F736544726F70646F776E28293B2073656C662E636C65617228293B207D290A20202020202020202E6F6E2827636C69636B272C20272E617065783336302D7064702D636C6F7365272C20202020202066756E6374696F6E2829207B2073656C66';
wwv_flow_imp.g_varchar2_table(363) := '2E5F636C6F736544726F70646F776E28293B2073656C662E636C6F736528293B207D290A20202020202020202E6F6E2827636C69636B272C20272E617065783336302D7064702D646179272C202020202020202066756E6374696F6E2829207B0A202020';
wwv_flow_imp.g_varchar2_table(364) := '2020202020202073656C662E5F636C6F736544726F70646F776E28293B0A20202020202020202020766172202463203D20242874686973293B0A202020202020202020206966202824632E686173436C6173732827617065783336302D7064702D646179';
wwv_flow_imp.g_varchar2_table(365) := '2D2D6F66662729207C7C2024632E686173436C6173732827617065783336302D7064702D6461792D2D656D7074792729292072657475726E3B0A20202020202020202020766172207069636B6564203D207B20793A202B24632E6461746128277927292C';
wwv_flow_imp.g_varchar2_table(366) := '206D3A202B24632E6461746128276D27292C20643A202B24632E646174612827642729207D3B0A202020202020202020206966202873656C662E6F7074732E73686F7754696D6529207B0A20202020202020202020202073656C662E5F73656C203D2070';
wwv_flow_imp.g_varchar2_table(367) := '69636B65643B0A20202020202020202020202073656C662E5F72656E6465724772696428293B2073656C662E5F72656E646572446973706C617928293B2073656C662E5F73796E6348696464656E28293B0A202020202020202020202020617065782E65';
wwv_flow_imp.g_varchar2_table(368) := '76656E742E747269676765722873656C662E24656C5B305D2C20276368616E676527293B0A202020202020202020207D20656C7365207B0A20202020202020202020202073656C662E5F7069636B287069636B6564293B0A202020202020202020207D0A';
wwv_flow_imp.g_varchar2_table(369) := '20202020202020207D293B0A0A2020202020202F2F2044726F70646F776E206F70656E6572730A202020202020746869732E24706F7075702E6F6E2827636C69636B272C20272E617065783336302D7064702D6D6F6E74682D6C626C272C2066756E6374';
wwv_flow_imp.g_varchar2_table(370) := '696F6E286529207B0A2020202020202020652E73746F7050726F7061676174696F6E28293B0A202020202020202073656C662E5F64726F70646F776E203D3D3D20276D6F6E746827203F2073656C662E5F636C6F736544726F70646F776E2829203A2073';
wwv_flow_imp.g_varchar2_table(371) := '656C662E5F6F70656E44726F70646F776E28276D6F6E746827293B0A2020202020207D293B0A202020202020746869732E24706F7075702E6F6E2827636C69636B272C20272E617065783336302D7064702D796561722D6C626C272C2066756E6374696F';
wwv_flow_imp.g_varchar2_table(372) := '6E286529207B0A2020202020202020652E73746F7050726F7061676174696F6E28293B0A202020202020202073656C662E5F64726F70646F776E203D3D3D20277965617227203F2073656C662E5F636C6F736544726F70646F776E2829203A2073656C66';
wwv_flow_imp.g_varchar2_table(373) := '2E5F6F70656E44726F70646F776E28277965617227293B0A2020202020207D293B0A202020202020746869732E24706F7075702E6F6E2827636C69636B272C20272E617065783336302D7064702D682D62746E272C2066756E6374696F6E286529207B0A';
wwv_flow_imp.g_varchar2_table(374) := '2020202020202020652E73746F7050726F7061676174696F6E28293B0A202020202020202073656C662E5F64726F70646F776E203D3D3D2027686F757227203F2073656C662E5F636C6F736544726F70646F776E2829203A2073656C662E5F6F70656E44';
wwv_flow_imp.g_varchar2_table(375) := '726F70646F776E2827686F757227293B0A2020202020207D293B0A202020202020746869732E24706F7075702E6F6E2827636C69636B272C20272E617065783336302D7064702D6D2D62746E272C2066756E6374696F6E286529207B0A20202020202020';
wwv_flow_imp.g_varchar2_table(376) := '20652E73746F7050726F7061676174696F6E28293B0A202020202020202073656C662E5F64726F70646F776E203D3D3D20276D696E75746527203F2073656C662E5F636C6F736544726F70646F776E2829203A2073656C662E5F6F70656E44726F70646F';
wwv_flow_imp.g_varchar2_table(377) := '776E28276D696E75746527293B0A2020202020207D293B0A0A202020202020746869732E24706F7075702E6F6E2827636C69636B272C20272E617065783336302D7064702D64642D6974656D272C2066756E6374696F6E2829207B0A2020202020202020';
wwv_flow_imp.g_varchar2_table(378) := '7661722076616C203D202B242874686973292E64617461282776616C27293B0A20202020202020207661722074797065203D2073656C662E5F64726F70646F776E3B0A202020202020202073656C662E5F636C6F736544726F70646F776E28293B0A2020';
wwv_flow_imp.g_varchar2_table(379) := '2020202020206966202874797065203D3D3D20276D6F6E7468272920207B2073656C662E5F766965772E6D203D2076616C3B2073656C662E5F72656E6465724772696428293B207D0A2020202020202020656C7365206966202874797065203D3D3D2027';
wwv_flow_imp.g_varchar2_table(380) := '7965617227292020207B2073656C662E5F766965772E79203D2076616C3B2073656C662E5F72656E6465724772696428293B207D0A2020202020202020656C7365206966202874797065203D3D3D2027686F757227292020207B2073656C662E5F74696D';
wwv_flow_imp.g_varchar2_table(381) := '652E68203D2076616C3B2073656C662E5F72656E64657254696D6528293B206966202873656C662E5F73656C29207B2073656C662E5F72656E646572446973706C617928293B2073656C662E5F73796E6348696464656E28293B20617065782E6576656E';
wwv_flow_imp.g_varchar2_table(382) := '742E747269676765722873656C662E24656C5B305D2C20276368616E676527293B207D207D0A2020202020202020656C7365206966202874797065203D3D3D20276D696E7574652729207B2073656C662E5F74696D652E6D203D2076616C3B2073656C66';
wwv_flow_imp.g_varchar2_table(383) := '2E5F72656E64657254696D6528293B206966202873656C662E5F73656C29207B2073656C662E5F72656E646572446973706C617928293B2073656C662E5F73796E6348696464656E28293B20617065782E6576656E742E747269676765722873656C662E';
wwv_flow_imp.g_varchar2_table(384) := '24656C5B305D2C20276368616E676527293B207D207D0A2020202020207D293B0A0A202020202020746869732E24706F7075702E6F6E2827636C69636B272C20272E617065783336302D7064702D74696D652D62746E272C2066756E6374696F6E282920';
wwv_flow_imp.g_varchar2_table(385) := '7B0A202020202020202073656C662E5F636C6F736544726F70646F776E28293B0A20202020202020207661722066203D20242874686973292E6461746128276627292C2064656C7461203D202B242874686973292E6461746128276427293B0A20202020';
wwv_flow_imp.g_varchar2_table(386) := '2020202073656C662E5F74696D655B665D203D2066203D3D3D20276827203F202873656C662E5F74696D652E68202B2064656C7461202B203234292025203234203A202873656C662E5F74696D652E6D202B2064656C7461202B2036302920252036303B';
wwv_flow_imp.g_varchar2_table(387) := '0A202020202020202073656C662E5F72656E64657254696D6528293B0A20202020202020206966202873656C662E5F73656C29207B2073656C662E5F72656E646572446973706C617928293B2073656C662E5F73796E6348696464656E28293B20617065';
wwv_flow_imp.g_varchar2_table(388) := '782E6576656E742E747269676765722873656C662E24656C5B305D2C20276368616E676527293B207D0A2020202020207D293B0A202020207D2C0A0A202020202F2A20E29480E2948020556E6966696564206F7574736964652D636C69636B2068616E64';
wwv_flow_imp.g_varchar2_table(389) := '6C657220E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E294800A20202020202A2057';
wwv_flow_imp.g_varchar2_table(390) := '6F726B7320666F7220626F74682073616D652D646F63756D656E7420616E642063726F73732D646F63756D656E7420286D6F64616C20696672616D65290A20202020202A20706F70757020706C6163656D656E74732E20206A51756572792773202E636C';
wwv_flow_imp.g_varchar2_table(391) := '6F7365737428292068616E646C65732063726F73732D646F63756D656E740A20202020202A206E6F64652074726565732066696E6520666F72206F7572206E656564732E202A2F0A202020205F68616E646C654F757473696465436C69636B3A2066756E';
wwv_flow_imp.g_varchar2_table(392) := '6374696F6E286529207B0A2020202020207661722073656C66203D20746869733B0A2020202020207661722024743B0A202020202020747279207B202474203D202428652E746172676574293B207D206361746368202865727229207B2072657475726E';
wwv_flow_imp.g_varchar2_table(393) := '3B207D0A202020202020747279207B0A20202020202020206966202824742E636C6F736573742873656C662E2477726170706572292E6C656E677468207C7C2024742E636C6F736573742873656C662E24706F707570292E6C656E677468292072657475';
wwv_flow_imp.g_varchar2_table(394) := '726E3B0A2020202020207D206361746368202865727229207B2072657475726E3B207D0A2020202020206966202873656C662E6F7074732E616C6C6F774D616E75616C496E707574292073656C662E5F70617273654D616E75616C28293B0A2020202020';
wwv_flow_imp.g_varchar2_table(395) := '2073656C662E636C6F736528293B0A202020207D2C0A0A202020202F2A20E29480E294802043726F73732D6672616D652043535320696E6A656374696F6E20E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E2';
wwv_flow_imp.g_varchar2_table(396) := '9480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E294800A20202020202A20577261707320746865206D6F64756C652D6C6576656C20696E6A65637450';
wwv_flow_imp.g_varchar2_table(397) := '6C7567696E437373496E746F506172656E7428292068656C70657220736F207468650A20202020202A207769646765742063616E2063616C6C206974206F6E206074686973602E20204964656D706F74656E7420E28094207468652068656C7065722073';
wwv_flow_imp.g_varchar2_table(398) := '6B6970730A20202020202A20776F726B2069662074686520706172656E742077696E646F7720616C726561647920686173206F7572203C7374796C653E20696E6A65637465642E202A2F0A202020205F696E6A656374437373496E746F506172656E743A';
wwv_flow_imp.g_varchar2_table(399) := '2066756E6374696F6E2829207B0A2020202020206966202821746869732E5F696E496672616D65292072657475726E3B0A202020202020696E6A656374506C7567696E437373496E746F506172656E742874686973293B0A202020207D2C0A0A20202020';
wwv_flow_imp.g_varchar2_table(400) := '2F2F2053686F77206564697461626C652076616C7565202852657475726E20466F726D6174202B2074696D65206966206170706C696361626C652920666F72206D616E75616C20747970696E670A202020205F73686F774564697461626C6556616C7565';
wwv_flow_imp.g_varchar2_table(401) := '3A2066756E6374696F6E2829207B0A2020202020206966202821746869732E5F73656C292072657475726E3B0A20202020202076617220646973705920203D20746869732E5F73656C2E79202B20696D70657269616C4F666673657428746869732E6F70';
wwv_flow_imp.g_varchar2_table(402) := '7473293B0A2020202020207661722065466D742020203D207361666552657475726E466D7428746869732E6F7074732E72657475726E466F726D6174293B0A2020202020207661722068617354696D65466D74203D202F48483A4D492F692E7465737428';
wwv_flow_imp.g_varchar2_table(403) := '65466D74293B0A202020202020766172207374723B0A2020202020206966202868617354696D65466D7429207B0A2020202020202020737472203D2049432E666F726D61742864697370592C20746869732E5F73656C2E6D2C20746869732E5F73656C2E';
wwv_flow_imp.g_varchar2_table(404) := '642C2065466D742C2066616C73652C20746869732E5F74696D652E682C20746869732E5F74696D652E6D293B0A2020202020207D20656C7365207B0A2020202020202020737472203D2049432E666F726D61742864697370592C20746869732E5F73656C';
wwv_flow_imp.g_varchar2_table(405) := '2E6D2C20746869732E5F73656C2E642C2065466D742C2066616C7365293B0A202020202020202069662028746869732E6F7074732E73686F7754696D6529207B20737472203D20737472202B20272027202B207061643228746869732E5F74696D652E68';
wwv_flow_imp.g_varchar2_table(406) := '29202B20273A27202B207061643228746869732E5F74696D652E6D293B207D0A2020202020207D0A202020202020746869732E24646973706C61792E76616C28737472293B0A202020207D2C0A0A202020205F6F70656E44726F70646F776E3A2066756E';
wwv_flow_imp.g_varchar2_table(407) := '6374696F6E287479706529207B0A2020202020207661722073656C66203D20746869733B0A202020202020746869732E5F64726F70646F776E203D20747970653B0A202020202020746869732E2464644C6973742E656D70747928293B0A202020202020';
wwv_flow_imp.g_varchar2_table(408) := '766172206974656D73203D205B5D2C2073656C65637465642C206661203D20746869732E6F7074732E7573655065727369616E4469676974733B0A0A2020202020206966202874797065203D3D3D20276D6F6E74682729207B0A20202020202020207661';
wwv_flow_imp.g_varchar2_table(409) := '72206861734D52203D204F626A6563742E6B65797328746869732E6F7074732E6D6F6E746852616E6765292E6C656E677468203E20303B0A2020202020202020666F722028766172206D203D20313B206D203C3D2031323B206D2B2B29207B0A20202020';
wwv_flow_imp.g_varchar2_table(410) := '20202020202069662028216861734D52207C7C20746869732E6F7074732E6D6F6E746852616E67655B6D5D29207B0A2020202020202020202020206974656D732E70757368287B2076616C3A206D2C206C6162656C3A2049432E6D6F6E74684E616D6573';
wwv_flow_imp.g_varchar2_table(411) := '5B6D2D315D207D293B0A202020202020202020207D0A20202020202020207D0A202020202020202073656C6563746564203D20746869732E5F766965772E6D3B0A2020202020207D20656C7365206966202874797065203D3D3D2027796561722729207B';
wwv_flow_imp.g_varchar2_table(412) := '0A2020202020202020766172206379203D20746869732E5F766965772E793B0A2020202020202020766172206861735952203D204F626A6563742E6B65797328746869732E6F7074732E7965617252616E6765292E6C656E677468203E20303B0A202020';
wwv_flow_imp.g_varchar2_table(413) := '202020202069662028686173595229207B0A202020202020202020202F2F204F6E6C792073686F7720616C6C6F7765642079656172732C20736F727465642064657363656E64696E670A202020202020202020204F626A6563742E6B6579732874686973';
wwv_flow_imp.g_varchar2_table(414) := '2E6F7074732E7965617252616E6765292E6D6170284E756D626572292E736F72742866756E6374696F6E28612C62297B72657475726E20622D613B7D292E666F72456163682866756E6374696F6E287929207B0A20202020202020202020202076617220';
wwv_flow_imp.g_varchar2_table(415) := '5F646C31203D2079202B20696D70657269616C4F66667365742873656C662E6F707473293B0A2020202020202020202020206974656D732E70757368287B2076616C3A20792C206C6162656C3A206661203F2049432E746F5065727369616E2853747269';
wwv_flow_imp.g_varchar2_table(416) := '6E67285F646C312929203A20537472696E67285F646C3129207D293B0A202020202020202020207D293B0A20202020202020207D20656C7365207B0A20202020202020202020666F7220287661722079203D2063792B31303B2079203E3D2063792D3135';
wwv_flow_imp.g_varchar2_table(417) := '3B20792D2D29207B0A202020202020202020202020766172205F646C32203D2079202B20696D70657269616C4F66667365742873656C662E6F707473293B0A2020202020202020202020206974656D732E70757368287B2076616C3A20792C206C616265';
wwv_flow_imp.g_varchar2_table(418) := '6C3A206661203F2049432E746F5065727369616E28537472696E67285F646C322929203A20537472696E67285F646C3229207D293B0A202020202020202020207D0A20202020202020207D0A202020202020202073656C6563746564203D2063793B0A20';
wwv_flow_imp.g_varchar2_table(419) := '20202020207D20656C7365206966202874797065203D3D3D2027686F75722729207B0A2020202020202020666F7220287661722068203D20303B2068203C3D2032333B20682B2B29206974656D732E70757368287B2076616C3A20682C206C6162656C3A';
wwv_flow_imp.g_varchar2_table(420) := '206661203F2049432E746F5065727369616E287061643228682929203A2070616432286829207D293B0A202020202020202073656C6563746564203D20746869732E5F74696D652E683B0A2020202020207D20656C7365206966202874797065203D3D3D';
wwv_flow_imp.g_varchar2_table(421) := '20276D696E7574652729207B0A2020202020202020666F722028766172206D69203D20303B206D69203C3D2035393B206D692B2B29206974656D732E70757368287B2076616C3A206D692C206C6162656C3A206661203F2049432E746F5065727369616E';
wwv_flow_imp.g_varchar2_table(422) := '2870616432286D692929203A2070616432286D6929207D293B0A202020202020202073656C6563746564203D20746869732E5F74696D652E6D3B0A2020202020207D0A0A202020202020766172202473656C4974656D203D206E756C6C3B0A2020202020';
wwv_flow_imp.g_varchar2_table(423) := '206974656D732E666F72456163682866756E6374696F6E286974656D29207B0A202020202020202076617220246C69203D202428273C6C693E272C207B0A2020202020202020202027636C617373273A2027617065783336302D7064702D64642D697465';
wwv_flow_imp.g_varchar2_table(424) := '6D27202B20286974656D2E76616C203D3D3D2073656C6563746564203F202720617065783336302D7064702D64642D6974656D2D2D73656C27203A202727292C0A2020202020202020202068746D6C3A206974656D2E76616C203D3D3D2073656C656374';
wwv_flow_imp.g_varchar2_table(425) := '6564203F206974656D2E6C6162656C202B20273C7370616E20636C6173733D22617065783336302D7064702D64642D636865636B223E3C2F7370616E3E27203A206974656D2E6C6162656C2C0A2020202020202020202027646174612D76616C273A2069';
wwv_flow_imp.g_varchar2_table(426) := '74656D2E76616C2C20726F6C653A20276F7074696F6E272C0A2020202020202020202027617269612D73656C6563746564273A206974656D2E76616C203D3D3D2073656C6563746564203F20277472756527203A202766616C7365270A20202020202020';
wwv_flow_imp.g_varchar2_table(427) := '207D293B0A202020202020202073656C662E2464644C6973742E617070656E6428246C69293B0A2020202020202020696620286974656D2E76616C203D3D3D2073656C656374656429202473656C4974656D203D20246C693B0A2020202020207D293B0A';
wwv_flow_imp.g_varchar2_table(428) := '0A202020202020746869732E2464726F70646F776E2E73686F7728293B0A202020202020696620282473656C4974656D29207B0A2020202020202020766172206464456C203D20746869732E2464726F70646F776E5B305D2C206C69456C203D20247365';
wwv_flow_imp.g_varchar2_table(429) := '6C4974656D5B305D3B0A20202020202020206464456C2E7363726F6C6C546F70203D206C69456C2E6F6666736574546F70202D206464456C2E636C69656E74486569676874202F2032202B206C69456C2E6F6666736574486569676874202F20323B0A20';
wwv_flow_imp.g_varchar2_table(430) := '20202020207D0A202020207D2C0A0A202020205F636C6F736544726F70646F776E3A2066756E6374696F6E2829207B0A2020202020206966202821746869732E5F64726F70646F776E292072657475726E3B0A202020202020746869732E5F64726F7064';
wwv_flow_imp.g_varchar2_table(431) := '6F776E203D206E756C6C3B0A202020202020746869732E2464726F70646F776E2E6869646528293B0A202020202020746869732E2464644C6973742E656D70747928293B0A202020207D2C0A0A202020202F2A20E29480E294802046495820313A205061';
wwv_flow_imp.g_varchar2_table(432) := '727365206D616E75616C20696E70757420696E636C7564696E672074696D65207061727420E29480E29480E29480E29480E29480E29480E29480E29480E29480E294802A2F0A202020205F70617273654D616E75616C3A2066756E6374696F6E2829207B';
wwv_flow_imp.g_varchar2_table(433) := '0A20202020202076617220726177496E707574203D20746869732E24646973706C61792E76616C28292E7472696D28293B0A2020202020206966202821726177496E70757429207B20746869732E636C65617228293B2072657475726E3B207D0A0A2020';
wwv_flow_imp.g_varchar2_table(434) := '202020202F2F204E617669676174696F6E2067756172643A20696620646973706C61792073686F77732074686520666F726D61747465642076616C7565202875736572206469646E27742065646974292C20736B69700A20202020202069662028746869';
wwv_flow_imp.g_varchar2_table(435) := '732E5F73656C29207B0A2020202020202020766172205F646973705920203D20746869732E5F73656C2E79202B20696D70657269616C4F666673657428746869732E6F707473293B0A2020202020202020766172205F686173544620203D202F48483A4D';
wwv_flow_imp.g_varchar2_table(436) := '492F692E7465737428746869732E6F7074732E646973706C6179466F726D6174293B0A2020202020202020766172205F6469737056616C203D205F68617354460A202020202020202020203F2049432E666F726D6174285F64697370592C20746869732E';
wwv_flow_imp.g_varchar2_table(437) := '5F73656C2E6D2C20746869732E5F73656C2E642C20746869732E6F7074732E646973706C6179466F726D61742C20746869732E6F7074732E7573655065727369616E4469676974732C20746869732E5F74696D652E682C20746869732E5F74696D652E6D';
wwv_flow_imp.g_varchar2_table(438) := '290A202020202020202020203A2049432E666F726D6174285F64697370592C20746869732E5F73656C2E6D2C20746869732E5F73656C2E642C20746869732E6F7074732E646973706C6179466F726D61742C20746869732E6F7074732E75736550657273';
wwv_flow_imp.g_varchar2_table(439) := '69616E446967697473293B0A202020202020202069662028215F686173544620262620746869732E6F7074732E73686F7754696D6529207B0A20202020202020202020766172205F6844203D20746869732E6F7074732E7573655065727369616E446967';
wwv_flow_imp.g_varchar2_table(440) := '697473203F2049432E746F5065727369616E287061643228746869732E5F74696D652E682929203A207061643228746869732E5F74696D652E68293B0A20202020202020202020766172205F6D44203D20746869732E6F7074732E757365506572736961';
wwv_flow_imp.g_varchar2_table(441) := '6E446967697473203F2049432E746F5065727369616E287061643228746869732E5F74696D652E6D2929203A207061643228746869732E5F74696D652E6D293B0A202020202020202020205F6469737056616C203D205F6469737056616C202B20272020';
wwv_flow_imp.g_varchar2_table(442) := '27202B205F6844202B20273A27202B205F6D443B0A20202020202020207D0A2020202020202020766172205F65466D743020203D207361666552657475726E466D7428746869732E6F7074732E72657475726E466F726D6174293B0A2020202020202020';
wwv_flow_imp.g_varchar2_table(443) := '766172205F686173544630203D202F48483A4D492F692E74657374285F65466D7430293B0A2020202020202020766172205F6564697456616C203D205F6861735446300A202020202020202020203F2049432E666F726D6174285F64697370592C207468';
wwv_flow_imp.g_varchar2_table(444) := '69732E5F73656C2E6D2C20746869732E5F73656C2E642C205F65466D74302C2066616C73652C20746869732E5F74696D652E682C20746869732E5F74696D652E6D290A202020202020202020203A2049432E666F726D6174285F64697370592C20746869';
wwv_flow_imp.g_varchar2_table(445) := '732E5F73656C2E6D2C20746869732E5F73656C2E642C205F65466D74302C2066616C7365293B0A202020202020202069662028215F68617354463020262620746869732E6F7074732E73686F7754696D6529207B205F6564697456616C203D205F656469';
wwv_flow_imp.g_varchar2_table(446) := '7456616C202B20272027202B207061643228746869732E5F74696D652E6829202B20273A27202B207061643228746869732E5F74696D652E6D293B207D0A202020202020202069662028726177496E707574203D3D3D205F6469737056616C207C7C2072';
wwv_flow_imp.g_varchar2_table(447) := '6177496E707574203D3D3D205F6564697456616C207C7C0A20202020202020202020202049432E746F4C6174696E28726177496E70757429203D3D3D2049432E746F4C6174696E285F6469737056616C29207C7C0A20202020202020202020202049432E';
wwv_flow_imp.g_varchar2_table(448) := '746F4C6174696E28726177496E70757429203D3D3D2049432E746F4C6174696E285F6564697456616C2929207B0A20202020202020202020746869732E5F72656E646572446973706C617928293B0A2020202020202020202072657475726E3B0A202020';
wwv_flow_imp.g_varchar2_table(449) := '20202020207D0A2020202020207D0A0A202020202020726177496E707574203D2049432E746F4C6174696E28726177496E707574293B0A202020202020726177496E707574203D20726177496E7075742E7265706C616365282F5B5C75303646302D5C75';
wwv_flow_imp.g_varchar2_table(450) := '303646395D2F672C2066756E6374696F6E2863297B2072657475726E20632E63686172436F64654174283029202D203078303646303B207D293B0A0A202020202020766172206F6666736574203D20696D70657269616C4F666673657428746869732E6F';
wwv_flow_imp.g_varchar2_table(451) := '707473293B0A2020202020207661722061646A7573746564496E707574203D20726177496E7075743B0A202020202020696620286F666673657420213D3D203029207B0A202020202020202061646A7573746564496E707574203D20726177496E707574';
wwv_flow_imp.g_varchar2_table(452) := '2E7265706C616365282F5E285C647B347D292F2C2066756E6374696F6E28797229207B0A20202020202020202020766172206E203D207061727365496E742879722C20313029202D206F66667365743B0A2020202020202020202072657475726E205374';
wwv_flow_imp.g_varchar2_table(453) := '72696E67286E293B0A20202020202020207D293B0A2020202020207D0A0A202020202020766172205F65466D7420203D207361666552657475726E466D7428746869732E6F7074732E72657475726E466F726D6174293B0A202020202020766172207061';
wwv_flow_imp.g_varchar2_table(454) := '72736564203D2070617273654D616E75616C5769746854696D652861646A7573746564496E7075742C205F65466D742C20746869732E6F7074732E73686F7754696D65293B0A202020202020746869732E5F7265736F6C76654D696E4D617828293B0A0A';
wwv_flow_imp.g_varchar2_table(455) := '2020202020206966202821706172736564207C7C20746869732E5F697344697361626C6564287061727365642E646174652929207B0A2020202020202020746869732E24646973706C61792E616464436C6173732827617065782D706167652D6974656D';
wwv_flow_imp.g_varchar2_table(456) := '2D6572726F7227293B0A2020202020202020766172205F6964203D20746869732E24656C2E617474722827696427293B0A202020202020202073657454696D656F75742866756E6374696F6E2829207B0A20202020202020202020747279207B20706172';
wwv_flow_imp.g_varchar2_table(457) := '656E742E617065782E6D6573736167652E636C6561724572726F727328293B207D206361746368286529207B7D0A20202020202020202020617065782E6D6573736167652E636C6561724572726F727328293B0A20202020202020202020617065782E6D';
wwv_flow_imp.g_varchar2_table(458) := '6573736167652E73686F774572726F7273285B7B0A202020202020202020202020747970653A20276572726F72272C206C6F636174696F6E3A202770616765272C20706167654974656D3A205F69642C0A2020202020202020202020206D657373616765';
wwv_flow_imp.g_varchar2_table(459) := '3A2027D8AAD8A7D8B1DB8CD8AE20D988D8A7D8B1D8AF20D8B4D8AFD98720D985D8B9D8AAD8A8D8B120D986DB8CD8B3D8AA272C20756E736166653A2066616C73650A202020202020202020207D5D293B0A20202020202020207D2C203130293B0A202020';
wwv_flow_imp.g_varchar2_table(460) := '202020202072657475726E3B0A2020202020207D0A202020202020746869732E5F73656C202020203D207061727365642E646174653B0A202020202020746869732E5F74696D652E68203D207061727365642E683B0A202020202020746869732E5F7469';
wwv_flow_imp.g_varchar2_table(461) := '6D652E6D203D207061727365642E6D3B0A202020202020746869732E24646973706C61792E72656D6F7665436C6173732827617065782D706167652D6974656D2D6572726F7227293B0A202020202020746869732E5F72656E646572446973706C617928';
wwv_flow_imp.g_varchar2_table(462) := '293B0A202020202020746869732E5F73796E6348696464656E28293B0A20202020202073657454696D656F75742866756E6374696F6E2829207B0A2020202020202020747279207B20706172656E742E617065782E6D6573736167652E636C6561724572';
wwv_flow_imp.g_varchar2_table(463) := '726F727328293B207D206361746368286529207B7D0A2020202020202020617065782E6D6573736167652E636C6561724572726F727328293B0A2020202020207D2C203530293B0A202020202020617065782E6576656E742E7472696767657228746869';
wwv_flow_imp.g_varchar2_table(464) := '732E24656C5B305D2C20276368616E676527293B0A202020207D2C0A0A202020206F70656E3A2066756E6374696F6E2829207B0A20202020202069662028746869732E5F6F70656E207C7C20746869732E6F7074732E64697361626C6564292072657475';
wwv_flow_imp.g_varchar2_table(465) := '726E3B0A202020202020746869732E5F7265736F6C76654D696E4D617828293B0A202020202020746869732E5F6F70656E203D20747275653B0A2020202020207661722074203D2049432E746F64617928293B0A202020202020746869732E5F76696577';
wwv_flow_imp.g_varchar2_table(466) := '203D20746869732E5F73656C203F207B20793A20746869732E5F73656C2E792C206D3A20746869732E5F73656C2E6D207D203A207B20793A20742E792C206D3A20742E6D207D3B0A202020202020746869732E5F72656E6465724772696428293B0A2020';
wwv_flow_imp.g_varchar2_table(467) := '20202020746869732E5F72656E64657254696D6528293B0A202020202020746869732E24706F7075702E73686F7728293B0A202020202020746869732E5F706F736974696F6E506F70757028293B0A202020202020746869732E24646973706C61792E61';
wwv_flow_imp.g_varchar2_table(468) := '7474722827617269612D657870616E646564272C20277472756527293B0A202020207D2C0A0A20202020636C6F73653A2066756E6374696F6E2829207B0A2020202020206966202821746869732E5F6F70656E207C7C20746869732E5F696E6C696E6529';
wwv_flow_imp.g_varchar2_table(469) := '2072657475726E3B0A202020202020746869732E5F636C6F736544726F70646F776E28293B0A202020202020746869732E5F6F70656E203D2066616C73653B0A202020202020746869732E24706F7075702E6869646528293B0A20202020202074686973';
wwv_flow_imp.g_varchar2_table(470) := '2E24646973706C61792E617474722827617269612D657870616E646564272C202766616C736527293B0A202020207D2C0A0A202020205F706F736974696F6E506F7075703A2066756E6374696F6E2829207B0A20202020202069662028746869732E5F69';
wwv_flow_imp.g_varchar2_table(471) := '6E6C696E65292072657475726E3B0A2020202020202F2F2055736520676574426F756E64696E67436C69656E745265637420666F722061636375726174652076696577706F727420636F6F726473207769746820706F736974696F6E3A66697865642E0A';
wwv_flow_imp.g_varchar2_table(472) := '2020202020202F2F205468697320776F726B7320636F72726563746C7920696E736964652049472063656C6C732C207472616E73666F726D656420636F6E7461696E6572732C20616E6420737469636B7920686561646572732E0A202020202020766172';
wwv_flow_imp.g_varchar2_table(473) := '2072656374203D20746869732E24777261707065725B305D2E676574426F756E64696E67436C69656E745265637428293B0A20202020202076617220706F7057203D20746869732E24706F7075702E6F757465725769647468287472756529207C7C2032';
wwv_flow_imp.g_varchar2_table(474) := '39363B0A20202020202076617220706F7048203D20746869732E24706F7075702E6F75746572486569676874287472756529207C7C203336303B0A0A2020202020202F2F2056696577706F72742064696D656E73696F6E7320636F6D652066726F6D2074';
wwv_flow_imp.g_varchar2_table(475) := '686520524F4F542077696E646F772C206265636175736520746861742773207468650A2020202020202F2F2077696E646F772077686F7365203C626F64793E20686F7374732074686520706F707570207768656E2077652061726520696E20616E206966';
wwv_flow_imp.g_varchar2_table(476) := '72616D652E0A2020202020207661722077696E48203D20746869732E5F726F6F7457696E2E696E6E65724865696768743B0A2020202020207661722077696E57203D20746869732E5F726F6F7457696E2E696E6E657257696474683B0A20202020202076';
wwv_flow_imp.g_varchar2_table(477) := '61722067617020203D20343B0A0A2020202020202F2F205472616E736C6174652077726170706572207265637420696E746F20524F4F542D77696E646F772076696577706F727420636F6F7264732E0A2020202020202F2F204966207765206172652069';
wwv_flow_imp.g_varchar2_table(478) := '6E20616E20696672616D652C206164642074686520696672616D652773206F776E206F66667365742077697468696E2074686520706172656E742E0A20202020202076617220746F70496E526F6F7420203D20726563742E746F703B0A20202020202076';
wwv_flow_imp.g_varchar2_table(479) := '6172206C656674496E526F6F74203D20726563742E6C6566743B0A20202020202069662028746869732E5F696E496672616D6520262620746869732E5F6F776E496672616D6529207B0A2020202020202020747279207B0A202020202020202020207661';
wwv_flow_imp.g_varchar2_table(480) := '72206952656374203D20746869732E5F6F776E496672616D652E676574426F756E64696E67436C69656E745265637428293B0A20202020202020202020746F70496E526F6F7420202B3D2069526563742E746F703B0A202020202020202020206C656674';
wwv_flow_imp.g_varchar2_table(481) := '496E526F6F74202B3D2069526563742E6C6566743B0A20202020202020207D20636174636820286529207B202F2A2069676E6F726520E280942066616C6C206261636B20746F206C6F63616C20636F6F726473202A2F207D0A2020202020207D0A0A2020';
wwv_flow_imp.g_varchar2_table(482) := '202020202F2F20506F736974696F6E2062656C6F7720777261707065722C206F722061626F7665206966206E6F7420656E6F7567682073706163652062656C6F770A20202020202076617220746F70203D2028746F70496E526F6F74202B20726563742E';
wwv_flow_imp.g_varchar2_table(483) := '686569676874202B20706F7048202B20676170203E2077696E4820262620746F70496E526F6F74203E20706F7048290A20202020202020202020202020203F20746F70496E526F6F74202D20706F7048202D206761700A20202020202020202020202020';
wwv_flow_imp.g_varchar2_table(484) := '203A20746F70496E526F6F74202B20726563742E686569676874202B206761703B0A202020202020746F7020203D204D6174682E6D6178286761702C204D6174682E6D696E28746F702C2077696E48202D20706F7048202D2067617029293B0A0A202020';
wwv_flow_imp.g_varchar2_table(485) := '202020766172206C656674203D20746869732E5F72746C203F20286C656674496E526F6F74202B20726563742E7769647468202D20706F705729203A206C656674496E526F6F743B0A2020202020206C656674203D204D6174682E6D6178286761702C20';
wwv_flow_imp.g_varchar2_table(486) := '4D6174682E6D696E286C6566742C2077696E57202D20706F7057202D2067617029293B0A0A2020202020202F2F2044796E616D6963207A2D696E6465783A20616C776179732061626F766520616E792076697369626C65206D6F64616C206F7665726C61';
wwv_flow_imp.g_varchar2_table(487) := '7920696E2074686520726F6F7420646F632E0A202020202020766172207A203D20636F6D70757465546F705A496E64657828746869732E5F726F6F74446F63293B0A202020202020746869732E24706F7075702E637373287B20706F736974696F6E3A20';
wwv_flow_imp.g_varchar2_table(488) := '276669786564272C20746F703A20746F702C206C6566743A206C6566742C207A496E6465783A207A207D293B0A202020207D2C0A0A202020205F6E61763A2066756E6374696F6E2864792C20646D29207B0A2020202020207661722079203D2074686973';
wwv_flow_imp.g_varchar2_table(489) := '2E5F766965772E79202B2064792C206D203D20746869732E5F766965772E6D202B20646D3B0A202020202020696620286D203E20313229207B206D203D20313B2020792B2B3B207D0A202020202020696620286D203C20312920207B206D203D2031323B';
wwv_flow_imp.g_varchar2_table(490) := '20792D2D3B207D0A202020202020746869732E5F76696577203D207B20793A20792C206D3A206D207D3B0A202020202020746869732E5F72656E6465724772696428293B0A202020207D2C0A0A202020205F72656E646572477269643A2066756E637469';
wwv_flow_imp.g_varchar2_table(491) := '6F6E2829207B0A2020202020207661722073656C66203D20746869733B0A2020202020207661722079203D20746869732E5F766965772E792C206D203D20746869732E5F766965772E6D3B0A202020202020766172206661203D20746869732E6F707473';
wwv_flow_imp.g_varchar2_table(492) := '2E7573655065727369616E4469676974732C20746F646179203D2049432E746F64617928293B0A0A20202020202069662028746869732E6F7074732E73686F775965617229207B0A2020202020202020766172205F6469737059203D2079202B20696D70';
wwv_flow_imp.g_varchar2_table(493) := '657269616C4F666673657428746869732E6F707473293B0A2020202020202020746869732E24706F7075702E66696E6428272E617065783336302D7064702D796561722D6C626C27292E74657874286661203F2049432E746F5065727369616E285F6469';
wwv_flow_imp.g_varchar2_table(494) := '73705929203A205F6469737059293B0A2020202020207D0A20202020202069662028746869732E6F7074732E73686F774D6F6E746829207B0A2020202020202020746869732E24706F7075702E66696E6428272E617065783336302D7064702D6D6F6E74';
wwv_flow_imp.g_varchar2_table(495) := '682D6C626C27292E746578742849432E6D6F6E74684E616D65735B6D202D20315D293B0A2020202020207D0A0A2020202020207661722064617973496E4D20203D2049432E64617973496E4D6F6E746828792C206D293B0A202020202020766172206669';
wwv_flow_imp.g_varchar2_table(496) := '727374444F57203D2049432E6461794F665765656B28792C206D2C2031293B0A0A202020202020746869732E24677269642E656D70747928293B0A202020202020746869732E24677269642E746F67676C65436C6173732827617065783336302D706470';
wwv_flow_imp.g_varchar2_table(497) := '2D677269642D2D7065727369616E272C2021216661293B0A2020202020207661722024726F77203D202428273C64697620636C6173733D22617065783336302D7064702D677269642D726F772220726F6C653D22726F77223E27293B0A20202020202076';
wwv_flow_imp.g_varchar2_table(498) := '617220636F756E74203D20303B0A0A202020202020666F7220287661722065203D20303B2065203C206669727374444F573B20652B2B29207B0A202020202020202024726F772E617070656E6428273C7370616E20636C6173733D22617065783336302D';
wwv_flow_imp.g_varchar2_table(499) := '7064702D64617920617065783336302D7064702D6461792D2D656D7074792220726F6C653D226772696463656C6C223E3C2F7370616E3E27293B0A2020202020202020636F756E742B2B3B0A2020202020207D0A0A202020202020666F72202876617220';
wwv_flow_imp.g_varchar2_table(500) := '64203D20313B2064203C3D2064617973496E4D3B20642B2B29207B0A202020202020202076617220637572203D207B20793A20792C206D3A206D2C20643A2064207D3B0A202020202020202076617220646F77203D2049432E6461794F665765656B2879';
wwv_flow_imp.g_varchar2_table(501) := '2C206D2C2064293B0A202020202020202076617220636C73203D205B27617065783336302D7064702D646179275D3B0A20202020202020206966202849432E636F6D70617265286375722C20746F64617929203D3D3D2030292020202020202020202020';
wwv_flow_imp.g_varchar2_table(502) := '20202020202020636C732E707573682827617065783336302D7064702D6461792D2D746F64617927293B0A202020202020202069662028746869732E5F73656C2026262049432E636F6D70617265286375722C20746869732E5F73656C29203D3D3D2030';
wwv_flow_imp.g_varchar2_table(503) := '2920636C732E707573682827617065783336302D7064702D6461792D2D73656C27293B0A202020202020202069662028646F77203D3D3D2036292020202020202020202020202020202020202020202020202020202020202020202020202020636C732E';
wwv_flow_imp.g_varchar2_table(504) := '707573682827617065783336302D7064702D6461792D2D66726927293B0A202020202020202069662028746869732E6F7074732E686F6C69646179735B686F6C696461794B657928637572295D29202020202020202020202020636C732E707573682827';
wwv_flow_imp.g_varchar2_table(505) := '617065783336302D7064702D6461792D2D686F6C27293B0A202020202020202069662028746869732E5F697344697361626C656428637572292920202020202020202020202020202020202020202020202020636C732E70757368282761706578333630';
wwv_flow_imp.g_varchar2_table(506) := '2D7064702D6461792D2D6F666627293B0A0A2020202020202020766172206461794C626C203D206661203F2049432E746F5065727369616E286429203A20537472696E672864293B0A202020202020202076617220684B65792020203D20792B272F272B';
wwv_flow_imp.g_varchar2_table(507) := '6D2B272F272B643B0A202020202020202076617220686A4E616D65203D2073656C662E6F7074732E686F6C696461794A736F6E5B684B65795D207C7C2027273B0A202020202020202069662028686A4E616D652920636C732E7075736828276170657833';
wwv_flow_imp.g_varchar2_table(508) := '36302D7064702D6461792D2D686F6C27293B20202F2F20616C736F206D61726B20617320686F6C696461790A2020202020202020766172202464617942746E203D202428273C627574746F6E3E272C207B0A20202020202020202020747970653A202762';
wwv_flow_imp.g_varchar2_table(509) := '7574746F6E272C2027636C617373273A20636C732E6A6F696E28272027292C0A2020202020202020202068746D6C3A20273C7370616E3E27202B206461794C626C202B20273C2F7370616E3E272C0A20202020202020202020726F6C653A202767726964';
wwv_flow_imp.g_varchar2_table(510) := '63656C6C272C0A2020202020202020202027617269612D6C6162656C273A2049432E6D6F6E74684E616D65735B6D2D315D202B20272027202B2064202B20272027202B20792C0A2020202020202020202027646174612D79273A20792C2027646174612D';
wwv_flow_imp.g_varchar2_table(511) := '6D273A206D2C2027646174612D64273A20640A20202020202020207D293B0A202020202020202069662028686A4E616D6529202464617942746E2E6174747228277469746C65272C20686A4E616D65293B0A202020202020202024726F772E617070656E';
wwv_flow_imp.g_varchar2_table(512) := '64282464617942746E293B0A2020202020202020636F756E742B2B3B0A0A202020202020202069662028636F756E7420252037203D3D3D203029207B0A20202020202020202020746869732E24677269642E617070656E642824726F77293B0A20202020';
wwv_flow_imp.g_varchar2_table(513) := '20202020202024726F77203D202428273C64697620636C6173733D22617065783336302D7064702D677269642D726F772220726F6C653D22726F77223E27293B0A20202020202020207D0A2020202020207D0A20202020202069662028636F756E742025';
wwv_flow_imp.g_varchar2_table(514) := '203720213D3D203029207B0A20202020202020207768696C652028636F756E742025203720213D3D203029207B0A2020202020202020202024726F772E617070656E6428273C7370616E20636C6173733D22617065783336302D7064702D646179206170';
wwv_flow_imp.g_varchar2_table(515) := '65783336302D7064702D6461792D2D656D7074792220726F6C653D226772696463656C6C223E3C2F7370616E3E27293B0A20202020202020202020636F756E742B2B3B0A20202020202020207D0A2020202020202020746869732E24677269642E617070';
wwv_flow_imp.g_varchar2_table(516) := '656E642824726F77293B0A2020202020207D0A202020207D2C0A0A202020205F72656E64657254696D653A2066756E6374696F6E2829207B0A2020202020206966202821746869732E6F7074732E73686F7754696D65292072657475726E3B0A20202020';
wwv_flow_imp.g_varchar2_table(517) := '2020766172206661203D20746869732E6F7074732E7573655065727369616E4469676974733B0A202020202020746869732E24706F7075702E66696E6428272E617065783336302D7064702D6827292E74657874286661203F2049432E746F5065727369';
wwv_flow_imp.g_varchar2_table(518) := '616E287061643228746869732E5F74696D652E682929203A207061643228746869732E5F74696D652E6829293B0A202020202020746869732E24706F7075702E66696E6428272E617065783336302D7064702D6D27292E74657874286661203F2049432E';
wwv_flow_imp.g_varchar2_table(519) := '746F5065727369616E287061643228746869732E5F74696D652E6D2929203A207061643228746869732E5F74696D652E6D29293B0A202020207D2C0A0A202020205F697344697361626C65643A2066756E6374696F6E286429207B0A2020202020206966';
wwv_flow_imp.g_varchar2_table(520) := '2028746869732E5F6D696E446174652026262049432E636F6D7061726528642C20746869732E5F6D696E4461746529203C2030292072657475726E20747275653B0A20202020202069662028746869732E5F6D6178446174652026262049432E636F6D70';
wwv_flow_imp.g_varchar2_table(521) := '61726528642C20746869732E5F6D61784461746529203E2030292072657475726E20747275653B0A2020202020202F2F20596561722072616E6765207265737472696374696F6E0A202020202020696620284F626A6563742E6B65797328746869732E6F';
wwv_flow_imp.g_varchar2_table(522) := '7074732E7965617252616E6765292E6C656E677468203E20302026262021746869732E6F7074732E7965617252616E67655B642E795D292072657475726E20747275653B0A2020202020202F2F204D6F6E74682072616E6765207265737472696374696F';
wwv_flow_imp.g_varchar2_table(523) := '6E0A202020202020696620284F626A6563742E6B65797328746869732E6F7074732E6D6F6E746852616E6765292E6C656E677468203E20302026262021746869732E6F7074732E6D6F6E746852616E67655B642E6D5D292072657475726E20747275653B';
wwv_flow_imp.g_varchar2_table(524) := '0A20202020202069662028746869732E6F7074732E64697361626C65486F6C6964617929207B0A20202020202020206966202849432E6461794F665765656B28642E792C20642E6D2C20642E6429203D3D3D2036292072657475726E20747275653B0A20';
wwv_flow_imp.g_varchar2_table(525) := '2020202020202069662028746869732E6F7074732E686F6C69646179735B686F6C696461794B65792864295D29202072657475726E20747275653B0A202020202020202069662028746869732E6F7074732E686F6C696461794A736F6E5B686F6C696461';
wwv_flow_imp.g_varchar2_table(526) := '794B65792864295D292072657475726E20747275653B0A2020202020207D0A20202020202072657475726E2066616C73653B0A202020207D2C0A0A202020200A202020205F72656E646572446973706C61793A2066756E6374696F6E2829207B0A202020';
wwv_flow_imp.g_varchar2_table(527) := '20202069662028746869732E5F696E6C696E65292072657475726E3B202F2F20696E6C696E6520686173206E6F20646973706C617920696E7075740A2020202020206966202821746869732E5F73656C29207B20746869732E24646973706C61792E7661';
wwv_flow_imp.g_varchar2_table(528) := '6C282727293B2072657475726E3B207D0A20202020202076617220666120203D20746869732E6F7074732E7573655065727369616E4469676974733B0A20202020202076617220666D74203D20746869732E6F7074732E646973706C6179466F726D6174';
wwv_flow_imp.g_varchar2_table(529) := '3B0A0A2020202020202F2F20466F726D61747320636F6E7461696E696E67205065727369616E206D6F6E74682F646179206E616D65732070726F647563652052544C20746578742E0A2020202020202F2F20536574206469723D72746C206F6E20746865';
wwv_flow_imp.g_varchar2_table(530) := '20696E70757420736F207468652062726F777365722773206269646920616C676F726974686D2072656E646572730A2020202020202F2F2074686520737472696E6720696E206E61747572616C205065727369616E2072656164696E67206F7264657220';
wwv_flow_imp.g_varchar2_table(531) := '28D8AFD988D8B4D986D8A8D987206F6E207468652072696768742C0A2020202020202F2F20DBB1DBB4DBB0DBB5206F6E20746865206C6566742920776974686F757420616E7920556E69636F646520656D62656464696E6720747269636B732E0A202020';
wwv_flow_imp.g_varchar2_table(532) := '2020202F2F204E756D657269632D6F6E6C7920666F726D61747320757365206469723D6C747220284C6174696E206469676974206F72646572292E0A202020202020766172206861735065727369616E4E616D65466D74203D202F4D4F4E7C666D4D6F6E';
wwv_flow_imp.g_varchar2_table(533) := '74687C666D4461792F2E7465737428666D74293B0A202020202020746869732E24646973706C61792E617474722827646972272C206861735065727369616E4E616D65466D74203F202772746C27203A20276C747227293B0A0A2020202020202F2F2043';
wwv_flow_imp.g_varchar2_table(534) := '6865636B20696620646973706C6179466F726D617420636F6E7461696E732048483A4D4920E2809420696620736F2C20706173732074696D652076616C7565730A2020202020207661722068617354696D65466D74203D202F48483A4D492F2E74657374';
wwv_flow_imp.g_varchar2_table(535) := '28666D74293B0A202020202020766172207374723B0A2020202020206966202868617354696D65466D7429207B0A2020202020202020737472203D2049432E666F726D617428746869732E5F73656C2E79202B20696D70657269616C4F66667365742874';
wwv_flow_imp.g_varchar2_table(536) := '6869732E6F707473292C20746869732E5F73656C2E6D2C20746869732E5F73656C2E642C20666D742C2066612C20746869732E5F74696D652E682C20746869732E5F74696D652E6D293B0A2020202020207D20656C7365207B0A20202020202020207374';
wwv_flow_imp.g_varchar2_table(537) := '72203D2049432E666F726D617428746869732E5F73656C2E79202B20696D70657269616C4F666673657428746869732E6F707473292C20746869732E5F73656C2E6D2C20746869732E5F73656C2E642C20666D742C206661293B0A20202020202020202F';
wwv_flow_imp.g_varchar2_table(538) := '2F20417070656E642074696D652073657061726174656C792069662073686F7754696D653D7472756520616E6420666F726D617420646F65736E277420696E636C7564652069740A202020202020202069662028746869732E6F7074732E73686F775469';
wwv_flow_imp.g_varchar2_table(539) := '6D6529207B0A20202020202020202020766172206844697370203D206661203F2049432E746F5065727369616E287061643228746869732E5F74696D652E682929203A207061643228746869732E5F74696D652E68293B0A202020202020202020207661';
wwv_flow_imp.g_varchar2_table(540) := '72206D44697370203D206661203F2049432E746F5065727369616E287061643228746869732E5F74696D652E6D2929203A207061643228746869732E5F74696D652E6D293B0A20202020202020202020737472203D20737472202B2027202027202B2068';
wwv_flow_imp.g_varchar2_table(541) := '44697370202B20273A27202B206D446973703B0A20202020202020207D0A2020202020207D0A202020202020746869732E24646973706C61792E76616C28737472292E72656D6F7665436C6173732827617065782D706167652D6974656D2D6572726F72';
wwv_flow_imp.g_varchar2_table(542) := '27293B0A202020207D2C0A0A202020205F73796E6348696464656E3A2066756E6374696F6E2829207B0A2020202020206966202821746869732E5F73656C29207B20746869732E24656C2E76616C282727293B2072657475726E3B207D0A202020202020';
wwv_flow_imp.g_varchar2_table(543) := '7661722072466D74203D207361666552657475726E466D7428746869732E6F7074732E72657475726E466F726D6174293B0A2020202020207661722068617354696D65466D74203D202F48483A4D492F692E746573742872466D74293B0A202020202020';
wwv_flow_imp.g_varchar2_table(544) := '766172207374723B0A2020202020206966202868617354696D65466D7429207B0A2020202020202020737472203D2049432E666F726D617428746869732E5F73656C2E792C20746869732E5F73656C2E6D2C20746869732E5F73656C2E642C2072466D74';
wwv_flow_imp.g_varchar2_table(545) := '2C2066616C73652C20746869732E5F74696D652E682C20746869732E5F74696D652E6D293B0A2020202020207D20656C7365207B0A2020202020202020737472203D2049432E666F726D617428746869732E5F73656C2E792C20746869732E5F73656C2E';
wwv_flow_imp.g_varchar2_table(546) := '6D2C20746869732E5F73656C2E642C2072466D742C2066616C7365293B0A202020202020202069662028746869732E6F7074732E73686F7754696D6529207B20737472202B3D20272027202B207061643228746869732E5F74696D652E6829202B20273A';
wwv_flow_imp.g_varchar2_table(547) := '27202B207061643228746869732E5F74696D652E6D293B207D0A2020202020207D0A202020202020746869732E24656C2E76616C28737472293B0A20202020202069662028746869732E5F696E6C696E6529207B20746869732E24646973706C61792E76';
wwv_flow_imp.g_varchar2_table(548) := '616C28737472293B207D0A202020207D2C0A0A202020205F7069636B3A2066756E6374696F6E286429207B0A202020202020746869732E5F6A7573745069636B6564203D20747275653B0A202020202020746869732E5F73656C203D20643B0A20202020';
wwv_flow_imp.g_varchar2_table(549) := '2020746869732E5F72656E646572446973706C617928293B20746869732E5F73796E6348696464656E28293B0A2020202020206966202821746869732E5F696E6C696E652920746869732E636C6F736528293B0A202020202020656C736520746869732E';
wwv_flow_imp.g_varchar2_table(550) := '5F72656E6465724772696428293B0A202020202020617065782E6576656E742E7472696767657228746869732E24656C5B305D2C20276368616E676527293B0A2020202020202F2F2052652D6170706C7920496D70657269616C20646973706C6179206F';
wwv_flow_imp.g_varchar2_table(551) := '6E2049472063656C6C206166746572206D6F64656C207570646174650A20202020202076617220247472203D20746869732E24656C2E636C6F736573742827747227293B0A202020202020696620282474722E6C656E677468202626202474722E66696E';
wwv_flow_imp.g_varchar2_table(552) := '64282774642E7065727369616E446174657069636B65722D69672D696D70657269616C27292E6C656E67746829207B0A202020202020202073657454696D656F75742866756E6374696F6E2829207B206669784947496D70657269616C446973706C6179';
wwv_flow_imp.g_varchar2_table(553) := '28247472293B207D2C203830293B0A2020202020207D0A2020202020207661722073656C66203D20746869733B0A20202020202073657454696D656F75742866756E6374696F6E2829207B2073656C662E5F6A7573745069636B6564203D2066616C7365';
wwv_flow_imp.g_varchar2_table(554) := '3B207D2C20333030293B0A202020207D2C0A0A202020205F7069636B546F6461793A2066756E6374696F6E2829207B0A2020202020207661722074203D2049432E746F64617928293B0A20202020202069662028746869732E5F697344697361626C6564';
wwv_flow_imp.g_varchar2_table(555) := '287429292072657475726E3B0A2020202020202F2F2055706461746520746865207669657720746F2073686F7720746F6461792773206D6F6E74682F796561720A202020202020746869732E5F76696577203D207B20793A20742E792C206D3A20742E6D';
wwv_flow_imp.g_varchar2_table(556) := '207D3B0A202020202020746869732E5F7069636B2874293B0A2020202020202F2F20466F7220696E6C696E65206D6F64652C2072652D72656E646572206772696420736F20746F64617920697320686967686C6967687465640A20202020202069662028';
wwv_flow_imp.g_varchar2_table(557) := '746869732E5F696E6C696E6529207B0A2020202020202020746869732E5F72656E6465724772696428293B0A2020202020202020746869732E5F72656E64657254696D6528293B0A2020202020207D0A202020207D2C0A0A2020202067657456616C7565';
wwv_flow_imp.g_varchar2_table(558) := '3A2066756E6374696F6E2829207B2072657475726E20746869732E24656C2E76616C28293B207D2C0A2020202073657456616C75653A2066756E6374696F6E287629207B0A20202020202069662028217629207B20746869732E636C65617228293B2072';
wwv_flow_imp.g_varchar2_table(559) := '657475726E3B207D0A202020202020766172207061727473203D206E6F726D616C697A654A616C616C6956616C75652876292E73706C697428272027293B0A2020202020207661722064203D2049432E70617273652870617274735B305D2C2074686973';
wwv_flow_imp.g_varchar2_table(560) := '2E6F7074732E72657475726E466F726D6174293B0A202020202020696620282164292072657475726E3B0A202020202020746869732E5F73656C203D20643B0A20202020202069662028746869732E6F7074732E73686F7754696D652026262070617274';
wwv_flow_imp.g_varchar2_table(561) := '735B315D29207B0A2020202020202020766172207470203D2070617274735B315D2E73706C697428273A27293B0A2020202020202020746869732E5F74696D65203D207B20683A204D6174682E6D696E2832332C2B74705B305D7C7C30292C206D3A204D';
wwv_flow_imp.g_varchar2_table(562) := '6174682E6D696E2835392C2B74705B315D7C7C3029207D3B0A2020202020207D0A202020202020746869732E5F72656E646572446973706C617928293B20746869732E5F73796E6348696464656E28293B0A20202020202069662028746869732E5F696E';
wwv_flow_imp.g_varchar2_table(563) := '6C696E6520262620746869732E5F766965772920746869732E5F72656E6465724772696428293B0A202020207D2C0A20202020636C6561723A2066756E6374696F6E2829207B0A202020202020746869732E5F73656C203D206E756C6C3B20746869732E';
wwv_flow_imp.g_varchar2_table(564) := '5F74696D65203D207B20683A20302C206D3A2030207D3B0A2020202020206966202821746869732E5F696E6C696E6529207B0A2020202020202020746869732E24646973706C61792E76616C282727292E72656D6F7665436C6173732827617065782D70';
wwv_flow_imp.g_varchar2_table(565) := '6167652D6974656D2D6572726F7227293B0A2020202020202020746869732E636C6F736528293B0A2020202020207D0A202020202020746869732E24656C2E76616C282727293B0A20202020202069662028746869732E5F696E6C696E65202626207468';
wwv_flow_imp.g_varchar2_table(566) := '69732E5F766965772920746869732E5F72656E6465724772696428293B0A202020202020617065782E6576656E742E7472696767657228746869732E24656C5B305D2C20276368616E676527293B0A202020207D2C0A2020202064697361626C653A2066';
wwv_flow_imp.g_varchar2_table(567) := '756E6374696F6E2829207B0A202020202020746869732E6F7074732E64697361626C6564203D20747275653B0A2020202020206966202821746869732E5F696E6C696E6529207B20746869732E24646973706C61792E70726F70282764697361626C6564';
wwv_flow_imp.g_varchar2_table(568) := '272C2074727565293B20746869732E2462746E2E70726F70282764697361626C6564272C2074727565293B207D0A202020202020746869732E24777261707065722E616464436C6173732827617065783336302D7064702D777261707065722D2D646973';
wwv_flow_imp.g_varchar2_table(569) := '61626C656427293B0A202020207D2C0A20202020656E61626C653A2066756E6374696F6E2829207B0A202020202020746869732E6F7074732E64697361626C6564203D2066616C73653B0A2020202020206966202821746869732E5F696E6C696E652920';
wwv_flow_imp.g_varchar2_table(570) := '7B20746869732E24646973706C61792E70726F70282764697361626C6564272C2066616C7365293B20746869732E2462746E2E70726F70282764697361626C6564272C2066616C7365293B207D0A202020202020746869732E24777261707065722E7265';
wwv_flow_imp.g_varchar2_table(571) := '6D6F7665436C6173732827617065783336302D7064702D777261707065722D2D64697361626C656427293B0A202020207D2C0A2020202073686F773A2066756E6374696F6E2829207B20746869732E24777261707065722E73686F7728293B207D2C0A20';
wwv_flow_imp.g_varchar2_table(572) := '202020686964653A2066756E6374696F6E2829207B206966202821746869732E5F696E6C696E652920746869732E636C6F736528293B20746869732E24777261707065722E6869646528293B207D2C0A2020202064657374726F793A2066756E6374696F';
wwv_flow_imp.g_varchar2_table(573) := '6E2829207B0A202020202020766172206E73203D20272E7064705F27202B20746869732E5F7569643B0A2020202020202428646F63756D656E74292E6F6666286E73293B20242877696E646F77292E6F6666286E73293B0A202020202020696620287468';
wwv_flow_imp.g_varchar2_table(574) := '69732E5F696E496672616D6529207B202428746869732E5F726F6F74446F63292E6F6666286E73293B202428746869732E5F726F6F7457696E292E6F6666286E73293B207D0A2020202020206966202821746869732E5F696E6C696E652920746869732E';
wwv_flow_imp.g_varchar2_table(575) := '24646973706C61792E6F6666286E73293B0A202020202020746869732E24706F7075702E6F6666286E73293B0A2020202020206966202821746869732E5F696E6C696E652920746869732E24706F7075702E72656D6F766528293B0A2020202020207468';
wwv_flow_imp.g_varchar2_table(576) := '69732E24777261707065722E72656D6F766528293B0A202020202020746869732E24656C2E637373287B20706F736974696F6E3A27272C2077696474683A27272C206865696768743A27272C206F766572666C6F773A27272C206F7061636974793A2727';
wwv_flow_imp.g_varchar2_table(577) := '2C20706F696E7465724576656E74733A2727207D292E72656D6F7665417474722827746162696E64657827293B0A202020202020242E72656D6F76654461746128746869732E24656C5B305D2C20504C5547494E5F4E414D45293B0A202020207D0A2020';
wwv_flow_imp.g_varchar2_table(578) := '7D3B0A0A2020242E666E5B504C5547494E5F4E414D455D203D2066756E6374696F6E286F70747329207B0A2020202072657475726E20746869732E656163682866756E6374696F6E2829207B0A2020202020206966202821242E6461746128746869732C';
wwv_flow_imp.g_varchar2_table(579) := '20504C5547494E5F4E414D45292920242E6461746128746869732C20504C5547494E5F4E414D452C206E65772050445028746869732C206F70747329293B0A202020207D293B0A20207D3B0A0A2020617065783336302E5065727369616E446174655069';
wwv_flow_imp.g_varchar2_table(580) := '636B6572203D205044503B0A0A202066756E6374696F6E2061747461636828704374782429207B0A20202020242827696E7075742E617065783336302D7064702D696E707574272C207043747824292E656163682866756E6374696F6E2829207B0A2020';
wwv_flow_imp.g_varchar2_table(581) := '2020202076617220656C203D20746869732C2024656C203D202428656C292C206964203D2024656C2E617474722827696427293B0A20202020202069662028242E6461746128656C2C20504C5547494E5F4E414D4529292072657475726E3B0A20202020';
wwv_flow_imp.g_varchar2_table(582) := '20206966202824656C2E646174612827706C7567696E2D6E616D65272920213D3D202749522E415045583336302E5045525349414E444154455049434B45522729207B0A2020202020202020617065782E64656275672E7761726E28275B617065783336';
wwv_flow_imp.g_varchar2_table(583) := '302E5044505D2053656375726974793A20706C7567696E206E616D65206D69736D617463682E27293B0A202020202020202072657475726E3B0A2020202020207D0A0A2020202020207661722072466D74203D2024656C2E64617461282772657475726E';
wwv_flow_imp.g_varchar2_table(584) := '2D666F726D6174272920207C7C2027595959592F4D4D2F4444273B0A2020202020207661722064466D74203D2024656C2E646174612827646973706C61792D666F726D61742729207C7C2072466D743B0A2020202020202F2F20436F6D7075746520696D';
wwv_flow_imp.g_varchar2_table(585) := '70657269616C206F6666736574206F6E636520E28094207573656420627920616C6C2070617273652066756E6374696F6E732062656C6F770A2020202020207661722063616C59656172202020202020203D2024656C2E64617461282763616C656E6461';
wwv_flow_imp.g_varchar2_table(586) := '722D796561722729207C7C20276A616C616C69273B0A2020202020207661722063616C596561724F6666736574203D2063616C59656172203D3D3D2027696D70657269616C27203F2031313830203A20303B0A20202020202076617220686F6C69646179';
wwv_flow_imp.g_varchar2_table(587) := '73203D207061727365486F6C69646179732824656C2E646174612827686F6C69646179732729207C7C2027272C2063616C596561724F6666736574293B0A0A202020202020766172206F707473203D207B0A2020202020202020646973706C6179466F72';
wwv_flow_imp.g_varchar2_table(588) := '6D61743A2020202064466D742C0A202020202020202072657475726E466F726D61743A202020202072466D742C0A20202020202020207573655065727369616E4469676974733A2024656C2E6461746128277065727369616E2D64696769747327292020';
wwv_flow_imp.g_varchar2_table(589) := '2020213D3D20274E272C0A202020202020202073686F77546F646179427574746F6E3A202024656C2E64617461282773686F772D746F64617927292020202020202020213D3D20274E272C0A202020202020202073686F77436C656172427574746F6E3A';
wwv_flow_imp.g_varchar2_table(590) := '202024656C2E64617461282773686F772D636C65617227292020202020202020213D3D20274E272C0A202020202020202073686F7754696D653A20202020202020202024656C2E64617461282773686F772D74696D6527292020202020202020203D3D3D';
wwv_flow_imp.g_varchar2_table(591) := '202759272C0A2020202020202020616C6C6F774D616E75616C496E7075743A2024656C2E6461746128276D616E75616C2D696E70757427292020202020203D3D3D202759272C0A202020202020202073686F774F6E3A202020202020202020202024656C';
wwv_flow_imp.g_varchar2_table(592) := '2E64617461282773686F772D6F6E272920202020202020202020207C7C2027627574746F6E272C0A202020202020202064697361626C65486F6C696461793A20202024656C2E64617461282764697361626C652D686F6C6964617927292020203D3D3D20';
wwv_flow_imp.g_varchar2_table(593) := '2759272C0A202020202020202073686F77596561723A20202020202020202024656C2E64617461282773686F772D796561722729202020202020202020213D3D20274E272C0A202020202020202073686F774D6F6E74683A202020202020202024656C2E';
wwv_flow_imp.g_varchar2_table(594) := '64617461282773686F772D6D6F6E746827292020202020202020213D3D20274E272C0A2020202020202020646973706C617941733A202020202020202024656C2E646174612827646973706C61792D6173272920202020202020207C7C2027706F707570';
wwv_flow_imp.g_varchar2_table(595) := '272C0A202020202020202063616C656E646172596561723A202020202063616C596561722C0A2020202020202020686F6C69646179733A202020202020202020686F6C69646179732C0A2020202020202020706C616365686F6C6465723A202020202020';
wwv_flow_imp.g_varchar2_table(596) := '24656C2E646174612827706C616365686F6C6465722729202020202020207C7C2027D8A7D986D8AAD8AED8A7D8A820D8AAD8A7D8B1DB8CD8AE272C0A202020202020202064697361626C65643A20202020202020202024656C2E70726F70282764697361';
wwv_flow_imp.g_varchar2_table(597) := '626C656427292C0A20202020202020206D696E44617465547970653A20202020202024656C2E6461746128276D696E2D646174652D74797065272920202020207C7C20276E6F6E65272C0A20202020202020206D696E446174654974656D3A2020202020';
wwv_flow_imp.g_varchar2_table(598) := '2024656C2E6461746128276D696E2D646174652D6974656D272920202020207C7C2027272C0A20202020202020206D696E446174655374617469633A2020202024656C2E6461746128276D696E2D646174652D73746174696327292020207C7C2027272C';
wwv_flow_imp.g_varchar2_table(599) := '0A20202020202020206D617844617465547970653A20202020202024656C2E6461746128276D61782D646174652D74797065272920202020207C7C20276E6F6E65272C0A20202020202020206D6178446174654974656D3A20202020202024656C2E6461';
wwv_flow_imp.g_varchar2_table(600) := '746128276D61782D646174652D6974656D272920202020207C7C2027272C0A20202020202020206D6178446174655374617469633A2020202024656C2E6461746128276D61782D646174652D73746174696327292020207C7C2027272C0A202020202020';
wwv_flow_imp.g_varchar2_table(601) := '20207965617252616E67653A202020202020202070617273655965617252616E67652824656C2E646174612827796561722D72616E676527292020207C7C2027272C2063616C596561724F6666736574292C0A20202020202020206D6F6E746852616E67';
wwv_flow_imp.g_varchar2_table(602) := '653A2020202020202070617273654D6F6E746852616E67652824656C2E6461746128276D6F6E74682D72616E6765272920207C7C202727292C0A2020202020202020686F6C696461794A736F6E3A2020202020207061727365486F6C696461794A736F6E';
wwv_flow_imp.g_varchar2_table(603) := '2824656C2E646174612827686F6C696461792D6A736F6E2729207C7C2027272C2063616C596561724F6666736574290A2020202020207D3B0A0A2020202020202F2F204C6567616379206261636B776172642D636F6D7061740A20202020202076617220';
wwv_flow_imp.g_varchar2_table(604) := '6C65676163794D696E203D2024656C2E6461746128276D696E2D6461746527292C206C65676163794D6178203D2024656C2E6461746128276D61782D6461746527293B0A202020202020696620286C65676163794D696E202626206F7074732E6D696E44';
wwv_flow_imp.g_varchar2_table(605) := '61746554797065203D3D3D20276E6F6E652729207B206F7074732E6D696E44617465547970653D27737461746963273B206F7074732E6D696E446174655374617469633D6C65676163794D696E3B207D0A202020202020696620286C65676163794D6178';
wwv_flow_imp.g_varchar2_table(606) := '202626206F7074732E6D61784461746554797065203D3D3D20276E6F6E652729207B206F7074732E6D617844617465547970653D27737461746963273B206F7074732E6D6178446174655374617469633D6C65676163794D61783B207D0A0A2020202020';
wwv_flow_imp.g_varchar2_table(607) := '2024656C5B504C5547494E5F4E414D455D286F707473293B0A20202020202076617220696E7374203D20242E6461746128656C2C20504C5547494E5F4E414D45293B0A0A2020202020206966202824656C2E686173436C61737328277065727369616E44';
wwv_flow_imp.g_varchar2_table(608) := '6174657069636B65722D69672D636F6C272929207B0A2020202020202020696E73742E24777261707065722E616464436C61737328277065727369616E446174657069636B65722D69672D64697227293B0A20202020202020202F2F2052656769737465';
wwv_flow_imp.g_varchar2_table(609) := '722063616C656E6461725965617220666F72207468697320636F6C756D6E20627920544420686561646572732076616C75650A2020202020202020766172202469675464203D2024656C2E636C6F736573742827746427293B0A20202020202020207661';
wwv_flow_imp.g_varchar2_table(610) := '72206864727320203D2024696754642E617474722827686561646572732729207C7C2024696754642E61747472282769642729207C7C2027273B0A2020202020202020696620286864727329207B20675F6967436F6C43616C596561725B686472735D20';
wwv_flow_imp.g_varchar2_table(611) := '3D206F7074732E63616C656E64617259656172207C7C20276A616C616C69273B207D0A20202020202020202F2F20416C736F2073746F726520627920696E707574206E616D6520666F722066616C6C6261636B206C6F6F6B75700A202020202020202076';
wwv_flow_imp.g_varchar2_table(612) := '617220696E7075744E616D65203D2024656C2E6174747228276E616D652729207C7C2027273B0A202020202020202069662028696E7075744E616D6529207B20675F6967436F6C43616C596561725B696E7075744E616D655D203D206F7074732E63616C';
wwv_flow_imp.g_varchar2_table(613) := '656E64617259656172207C7C20276A616C616C69273B207D0A2020202020207D0A0A202020202020617065782E6974656D2E6372656174652869642C207B0A20202020202020206974656D5F747970653A20275045525349414E5F444154455F5049434B';
wwv_flow_imp.g_varchar2_table(614) := '4552272C0A202020202020202067657456616C75653A2020202020202020202020202066756E6374696F6E2829202020207B2072657475726E20696E73742E67657456616C756528293B207D2C0A202020202020202073657456616C75653A2020202020';
wwv_flow_imp.g_varchar2_table(615) := '202020202020202066756E6374696F6E2876292020207B20696E73742E73657456616C75652876293B207D2C0A2020202020202020736574466F637573546F3A202020202020202020202066756E6374696F6E2829202020207B2072657475726E20696E';
wwv_flow_imp.g_varchar2_table(616) := '73742E24646973706C61793B207D2C0A202020202020202064697361626C653A202020202020202020202020202066756E6374696F6E2829202020207B20696E73742E64697361626C6528293B207D2C0A2020202020202020656E61626C653A20202020';
wwv_flow_imp.g_varchar2_table(617) := '202020202020202020202066756E6374696F6E2829202020207B20696E73742E656E61626C6528293B207D2C0A202020202020202073686F773A202020202020202020202020202020202066756E6374696F6E2829202020207B20696E73742E73686F77';
wwv_flow_imp.g_varchar2_table(618) := '28293B207D2C0A2020202020202020686964653A202020202020202020202020202020202066756E6374696F6E2829202020207B20696E73742E6869646528293B207D2C0A2020202020202020616464435353436C6173733A2020202020202020202066';
wwv_flow_imp.g_varchar2_table(619) := '756E6374696F6E2863292020207B20696E73742E24777261707065722E616464436C6173732863293B207D2C0A202020202020202072656D6F7665435353436C6173733A2020202020202066756E6374696F6E2863292020207B20696E73742E24777261';
wwv_flow_imp.g_varchar2_table(620) := '707065722E72656D6F7665436C6173732863293B207D2C0A2020202020202020697344697361626C65643A202020202020202020202066756E6374696F6E2829202020207B2072657475726E20696E73742E6F7074732E64697361626C65643B207D2C0A';
wwv_flow_imp.g_varchar2_table(621) := '20202020202020206E756C6C56616C75653A20202020202020202020202027272C0A202020202020202067657456616C69646974793A2066756E6374696F6E2829207B0A202020202020202020207661722076203D20696E73742E67657456616C756528';
wwv_flow_imp.g_varchar2_table(622) := '293B0A20202020202020202020696620282176292072657475726E207B2076616C69643A2074727565207D3B0A202020202020202020207661722073466D74203D207361666552657475726E466D7428696E73742E6F7074732E72657475726E466F726D';
wwv_flow_imp.g_varchar2_table(623) := '6174293B0A202020202020202020207661722064203D2049432E70617273652849432E746F4C6174696E28762E73706C697428272027295B305D292C2073466D74293B0A20202020202020202020696620282164292072657475726E207B2076616C6964';
wwv_flow_imp.g_varchar2_table(624) := '3A2066616C7365207D3B0A20202020202020202020696E73742E5F7265736F6C76654D696E4D617828293B0A2020202020202020202069662028696E73742E5F697344697361626C6564286429292072657475726E207B2076616C69643A2066616C7365';
wwv_flow_imp.g_varchar2_table(625) := '207D3B0A2020202020202020202072657475726E207B2076616C69643A2074727565207D3B0A20202020202020207D2C0A202020202020202067657456616C69646174696F6E4D6573736167653A2066756E6374696F6E2829207B2072657475726E2027';
wwv_flow_imp.g_varchar2_table(626) := 'D8AAD8A7D8B1DB8CD8AE20D988D8A7D8B1D8AF20D8B4D8AFD98720D985D8B9D8AAD8A8D8B120D986DB8CD8B3D8AA273B207D0A2020202020207D293B0A202020207D293B0A20207D0A0A2020617065782E6974656D2E61646441747461636848616E646C';
wwv_flow_imp.g_varchar2_table(627) := '657228617474616368293B0A0A2020617065783336302E706470496E6974203D2066756E6374696F6E28696429207B0A2020202076617220656C203D20646F63756D656E742E676574456C656D656E7442794964286964293B0A2020202069662028656C';
wwv_flow_imp.g_varchar2_table(628) := '29207B20617474616368282428656C292E706172656E742829293B207D0A20207D3B0A0A20202F2A20E29480E2948020496D70657269616C20796561723A206669782049472063656C6C20646973706C6179207465787420E29480E29480E29480E29480';
wwv_flow_imp.g_varchar2_table(629) := 'E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E294800A2020202A20496E20616E204564697461626C65204947207468652063656C';
wwv_flow_imp.g_varchar2_table(630) := '6C20646973706C61797320746865207261772053514C2076616C756520284A616C616C69292061730A2020202A20706C61696E2074657874204245464F524520746865207573657220636C69636B7320746F20656469742E2054686520706C7567696E20';
wwv_flow_imp.g_varchar2_table(631) := '6F6E6C792072756E73206F6E0A2020202A20636C69636B2E20546869732066756E6374696F6E2066696E647320657665727920496D70657269616C2050445020696E7075742C206C6F6361746573206974730A2020202A20706172656E74204947206469';
wwv_flow_imp.g_varchar2_table(632) := '73706C61792063656C6C2C20616E6420726577726974657320746865207465787420746F20496D70657269616C20796561722E0A2020202A2043616C6C65642061667465722061747461636820616E642061667465722065766572792049472072656672';
wwv_flow_imp.g_varchar2_table(633) := '6573682F706167696E6174696F6E2E0A2020202A2F0A202066756E6374696F6E20746443616C596561722824746429207B0A202020202F2F204C6F6F6B2075702063616C656E6461725965617220666F722061205444207573696E672074686520726567';
wwv_flow_imp.g_varchar2_table(634) := '697374727920706F70756C61746564206174206174746163682074696D652E0A202020202F2F205472793A206865616465727320617474722C20696420617474722C20696E707574206E616D6520696E7369646520544420287768656E2065646974696E';
wwv_flow_imp.g_varchar2_table(635) := '67290A202020207661722068647273203D20282474642E617474722827686561646572732729207C7C202727292E73706C697428272027293B0A20202020666F722028766172206869203D20303B206869203C20686472732E6C656E6774683B2068692B';
wwv_flow_imp.g_varchar2_table(636) := '2B29207B0A20202020202069662028675F6967436F6C43616C596561725B686472735B68695D5D292072657475726E20675F6967436F6C43616C596561725B686472735B68695D5D3B0A202020207D0A202020202F2F2046616C6C6261636B3A20696E70';
wwv_flow_imp.g_varchar2_table(637) := '757420697320696E73696465205444202865646974206D6F6465290A202020207661722024696E70203D202474642E66696E642827696E7075742E617065783336302D7064702D696E70757427293B0A202020206966202824696E702E6C656E67746829';
wwv_flow_imp.g_varchar2_table(638) := '207B0A202020202020766172206E203D2024696E702E6174747228276E616D652729207C7C2027273B0A20202020202069662028675F6967436F6C43616C596561725B6E5D292072657475726E20675F6967436F6C43616C596561725B6E5D3B0A202020';
wwv_flow_imp.g_varchar2_table(639) := '20202072657475726E2024696E702E64617461282763616C656E6461722D796561722729207C7C20276A616C616C69273B0A202020207D0A2020202072657475726E20276A616C616C69273B202F2F2064656661756C740A20207D0A0A202066756E6374';
wwv_flow_imp.g_varchar2_table(640) := '696F6E206170706C7943616C596561722824746429207B0A202020202F2F2044657465726D696E652063616C596561722066726F6D2074686520544420636C61737320E28094206E6F207265676973747279206E65656465642E0A202020202F2F207065';
wwv_flow_imp.g_varchar2_table(641) := '727369616E446174657069636B65722D69672D696D70657269616C20636C617373203D20696D70657269616C2C20616E797468696E6720656C7365203D206A616C616C692E0A202020207661722063616C59656172203D202474642E686173436C617373';
wwv_flow_imp.g_varchar2_table(642) := '28277065727369616E446174657069636B65722D69672D696D70657269616C27290A2020202020202020202020202020202020203F2027696D70657269616C27203A20276A616C616C69273B0A202020202F2F2046696E64207468652064697265637420';
wwv_flow_imp.g_varchar2_table(643) := '74657874206E6F64650A2020202076617220746578744E6F6465203D206E756C6C3B0A202020202474642E636F6E74656E747328292E656163682866756E6374696F6E2829207B0A20202020202069662028746869732E6E6F646554797065203D3D3D20';
wwv_flow_imp.g_varchar2_table(644) := '3320262620746869732E6E6F646556616C75652E7472696D282929207B0A2020202020202020746578744E6F6465203D20746869733B2072657475726E2066616C73653B0A2020202020207D0A202020207D293B0A202020206966202821746578744E6F';
wwv_flow_imp.g_varchar2_table(645) := '6465292072657475726E3B0A202020207661722074657874203D20746578744E6F64652E6E6F646556616C75652E7472696D28293B0A202020207661722079723420203D207061727365496E7428746578742E737562737472696E6728302C2034292C20';
wwv_flow_imp.g_varchar2_table(646) := '3130293B0A202020206966202869734E614E2879723429292072657475726E3B0A202020207661722069734A616C616C692020203D20797234203E3D203133303020262620797234203C3D20313539393B0A20202020766172206973496D70657269616C';
wwv_flow_imp.g_varchar2_table(647) := '203D20797234203E3D203234383020262620797234203C3D20323737393B0A202020206966202863616C59656172203D3D3D2027696D70657269616C272026262069734A616C616C6929207B0A202020202020746578744E6F64652E6E6F646556616C75';
wwv_flow_imp.g_varchar2_table(648) := '65203D20537472696E6728797234202B203131383029202B20746578742E737562737472696E672834293B0A202020207D20656C7365206966202863616C59656172203D3D3D20276A616C616C6927202626206973496D70657269616C29207B0A202020';
wwv_flow_imp.g_varchar2_table(649) := '202020746578744E6F64652E6E6F646556616C7565203D20537472696E6728797234202D203131383029202B20746578742E737562737472696E672834293B0A202020207D0A20207D0A0A202066756E6374696F6E206669784947496D70657269616C44';
wwv_flow_imp.g_varchar2_table(650) := '6973706C6179286374782429207B0A202020202F2F205461726765747320544473207769746820636C61737320277065727369616E446174657069636B65722D69672D696D70657269616C272E0A202020202F2F20576F726B7320666F7220424F544820';
wwv_flow_imp.g_varchar2_table(651) := '6A616C616C6920616E6420696D70657269616C2063616C656E646172596561722073657474696E67732E0A202020207661722024746473203D20637478240A2020202020203F2024282774642E7065727369616E446174657069636B65722D69672D696D';
wwv_flow_imp.g_varchar2_table(652) := '70657269616C272C2063747824290A2020202020203A2024282774642E7065727369616E446174657069636B65722D69672D696D70657269616C27293B0A20202020247464732E656163682866756E6374696F6E2829207B206170706C7943616C596561';
wwv_flow_imp.g_varchar2_table(653) := '722824287468697329293B207D293B0A20207D0A0A20202428646F63756D656E74292E6F6E2827617065786265666F726572656672657368272C2066756E6374696F6E2829207B0A20202020242827696E7075742E617065783336302D7064702D696E70';
wwv_flow_imp.g_varchar2_table(654) := '757427292E656163682866756E6374696F6E2829207B0A2020202020207661722069203D20242E6461746128746869732C20504C5547494E5F4E414D45293B0A20202020202069662028692920692E64657374726F7928293B0A202020207D293B0A2020';
wwv_flow_imp.g_varchar2_table(655) := '7D293B0A0A20202F2F204166746572204947207265667265736865732028706167696E6174696F6E2C207365617263682C2073617665292072652D6170706C7920496D70657269616C20646973706C61790A20202428646F63756D656E74292E6F6E2827';
wwv_flow_imp.g_varchar2_table(656) := '61706578616674657272656672657368272C2066756E6374696F6E286529207B0A202020206669784947496D70657269616C446973706C6179282428652E74617267657429293B0A20207D293B0A0A20202F2F20416C736F2072756E206F6E20696E6974';
wwv_flow_imp.g_varchar2_table(657) := '69616C2070616765206C6F616420616674657220616C6C206974656D73206172652061747461636865640A20202428646F63756D656E74292E6F6E2827617065787265616479656E64272C2066756E6374696F6E2829207B0A2020202073657454696D65';
wwv_flow_imp.g_varchar2_table(658) := '6F75742866756E6374696F6E2829207B206669784947496D70657269616C446973706C617928293B207D2C20313530293B0A20207D293B0A0A20202F2A20E29480E29480204D75746174696F6E4F627365727665723A20776174636820666F722069732D';
wwv_flow_imp.g_varchar2_table(659) := '6163746976652072656D6F76616C206F6E20496D70657269616C2054447320E29480E29480E29480E294800A2020202A205768656E207573657220636C69636B7320612063656C6C3A20415045582061646473202020202769732D666F63757365642069';
wwv_flow_imp.g_varchar2_table(660) := '732D616374697665270A2020202A205768656E2075736572206C656176657320612063656C6C3A20415045582072656D6F766573202769732D666F63757365642069732D616374697665270A2020202A20546861742072656D6F76616C20697320746865';
wwv_flow_imp.g_varchar2_table(661) := '206578616374206D6F6D656E742074686520544420676F6573206261636B20746F20646973706C6179206D6F64650A2020202A20616E64207765206E65656420746F2072652D6170706C7920746865204A616C616C6920E2869220496D70657269616C20';
wwv_flow_imp.g_varchar2_table(662) := '7965617220636F6E76657273696F6E2E0A2020202A205765206F62736572766520746865204947206772696420626F647920666F7220636C61737320617474726962757465206D75746174696F6E73206F6E205444732E0A2020202A2F0A20202F2F20E2';
wwv_flow_imp.g_varchar2_table(663) := '9480E294802053696E676C65204D75746174696F6E4F62736572766572206F6E20746865206772696420636F6E7461696E657220E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480';
wwv_flow_imp.g_varchar2_table(664) := 'E29480E29480E29480E29480E29480E294800A20202F2F205761746368657320666F722054574F207468696E6773206F6E20544420636C617373206368616E6765733A0A20202F2F20202031292069732D6163746976652052454D4F56454420E2869220';
wwv_flow_imp.g_varchar2_table(665) := '63656C6C206C6566742065646974206D6F64653A0A20202F2F2020202020202020612920436C6F73652074686520706C7567696E20706F70757020286669783A20646174657069636B6572207374617973206F70656E290A20202F2F2020202020202020';
wwv_flow_imp.g_varchar2_table(666) := '622920436F6E766572742054442074657874204A616C616C6920E2869220496D70657269616C0A20202F2F202020322920416E79206368696C644C697374206368616E6765206F6E2074686520677269642074626F64792028726F772072652D72656E64';
wwv_flow_imp.g_varchar2_table(667) := '65722061667465722073617665293A0A20202F2F202020202020202052652D6170706C7920496D70657269616C20746F20616C6C20696D70657269616C2054447320696E2074686520616666656374656420726F77730A202076617220675F69674F6273';
wwv_flow_imp.g_varchar2_table(668) := '657276657220203D206E756C6C3B0A20202F2F204D61707320544420686561646572732076616C756520E286922063616C656E646172596561722028276A616C616C69277C27696D70657269616C27290A20202F2F20506F70756C617465642061742061';
wwv_flow_imp.g_varchar2_table(669) := '74746163682074696D65207768656E2074686520696E70757420495320696E73696465207468652054442E0A202076617220675F6967436F6C43616C59656172203D207B7D3B0A0A202066756E6374696F6E20696E6974496D70657269616C4F62736572';
wwv_flow_imp.g_varchar2_table(670) := '7665722829207B0A202020202F2F20446973636F6E6E65637420616E792070726576696F757320696E7374616E63650A2020202069662028675F69674F6273657276657229207B20675F69674F627365727665722E646973636F6E6E65637428293B2067';
wwv_flow_imp.g_varchar2_table(671) := '5F69674F62736572766572203D206E756C6C3B207D0A202020202F2F204E6F7468696E6720746F20646F206966206E6F20696D70657269616C20636F6C756D6E73206F6E20706167650A20202020696620282124282774642E7065727369616E44617465';
wwv_flow_imp.g_varchar2_table(672) := '7069636B65722D69672D696D70657269616C27292E6C656E677468292072657475726E3B0A0A20202020675F69674F62736572766572203D206E6577204D75746174696F6E4F627365727665722866756E6374696F6E286D75746174696F6E7329207B0A';
wwv_flow_imp.g_varchar2_table(673) := '20202020202076617220726F7773546F466978203D207B7D3B0A2020202020206D75746174696F6E732E666F72456163682866756E6374696F6E286D757429207B0A0A20202020202020202F2F20E29480E29480204361736520313A20636C6173732063';
wwv_flow_imp.g_varchar2_table(674) := '68616E6765206F6E206120544420E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E29480E294';
wwv_flow_imp.g_varchar2_table(675) := '80E29480E294800A2020202020202020696620286D75742E74797065203D3D3D20276174747269627574657327202626206D75742E6174747269627574654E616D65203D3D3D2027636C6173732729207B0A20202020202020202020766172207464203D';
wwv_flow_imp.g_varchar2_table(676) := '206D75742E7461726765743B0A202020202020202020206966202874642E7461674E616D6520213D3D2027544427292072657475726E3B0A0A2020202020202020202076617220686164416374697665203D206D75742E6F6C6456616C7565202626206D';
wwv_flow_imp.g_varchar2_table(677) := '75742E6F6C6456616C75652E696E6465784F66282769732D6163746976652729203E3D20303B0A2020202020202020202076617220686173416374697665203D2074642E636C6173734C6973742E636F6E7461696E73282769732D61637469766527293B';
wwv_flow_imp.g_varchar2_table(678) := '0A0A202020202020202020202F2F2069732D616374697665206A7573742072656D6F76656420E286922063656C6C206C656176696E672065646974206D6F64650A2020202020202020202069662028686164416374697665202626202168617341637469';
wwv_flow_imp.g_varchar2_table(679) := '766529207B0A0A2020202020202020202020202F2F2046697820323A20636C6F736520616E79206F70656E20706C7567696E20706F70757020696E7369646520746869732054440A20202020202020202020202024287464292E66696E642827696E7075';
wwv_flow_imp.g_varchar2_table(680) := '742E617065783336302D7064702D696E70757427292E656163682866756E6374696F6E2829207B0A202020202020202020202020202076617220696E7374203D20242E6461746128746869732C20504C5547494E5F4E414D45293B0A2020202020202020';
wwv_flow_imp.g_varchar2_table(681) := '20202020202069662028696E737420262620696E73742E5F6F70656E29207B20696E73742E636C6F736528293B207D0A2020202020202020202020207D293B0A0A2020202020202020202020202F2F2052652D6170706C792063616C5965617220646973';
wwv_flow_imp.g_varchar2_table(682) := '706C617920616674657220415045582077726974657320746865206E65772076616C75650A2020202020202020202020206966202874642E636C6173734C6973742E636F6E7461696E7328277065727369616E446174657069636B65722D69672D696D70';
wwv_flow_imp.g_varchar2_table(683) := '657269616C272929207B0A20202020202020202020202020202866756E6374696F6E28696D70657269616C546429207B0A202020202020202020202020202020207661722074644F6273203D206E6577204D75746174696F6E4F62736572766572286675';
wwv_flow_imp.g_varchar2_table(684) := '6E6374696F6E2829207B0A20202020202020202020202020202020202074644F62732E646973636F6E6E65637428293B0A2020202020202020202020202020202020206170706C7943616C59656172282428696D70657269616C546429293B0A20202020';
wwv_flow_imp.g_varchar2_table(685) := '2020202020202020202020207D293B0A2020202020202020202020202020202074644F62732E6F62736572766528696D70657269616C54642C207B0A2020202020202020202020202020202020206368696C644C6973743A20747275652C206368617261';
wwv_flow_imp.g_varchar2_table(686) := '63746572446174613A20747275652C20737562747265653A20747275650A202020202020202020202020202020207D293B0A2020202020202020202020202020202073657454696D656F75742866756E6374696F6E2829207B0A20202020202020202020';
wwv_flow_imp.g_varchar2_table(687) := '202020202020202074644F62732E646973636F6E6E65637428293B0A2020202020202020202020202020202020206170706C7943616C59656172282428696D70657269616C546429293B0A202020202020202020202020202020207D2C20343030293B0A';
wwv_flow_imp.g_varchar2_table(688) := '20202020202020202020202020207D28746429293B0A2020202020202020202020207D0A202020202020202020207D0A20202020202020207D0A0A20202020202020202F2F20E29480E29480204361736520323A20726F77206E6F646573206164646564';
wwv_flow_imp.g_varchar2_table(689) := '20746F2074626F6479202872652D72656E64657220616674657220736176652920E29480E29480E294800A2020202020202020696620286D75742E74797065203D3D3D20276368696C644C69737427202626206D75742E61646465644E6F6465732E6C65';
wwv_flow_imp.g_varchar2_table(690) := '6E67746829207B0A202020202020202020206D75742E61646465644E6F6465732E666F72456163682866756E6374696F6E286E6F646529207B0A202020202020202020202020696620286E6F64652E7461674E616D65203D3D3D202754522729207B0A20';
wwv_flow_imp.g_varchar2_table(691) := '202020202020202020202020206966202821726F7773546F4669785B6E6F64655D29207B20726F7773546F4669785B6E6F64655D203D206E6F64653B207D0A2020202020202020202020207D0A202020202020202020207D293B0A20202020202020207D';
wwv_flow_imp.g_varchar2_table(692) := '0A2020202020207D293B0A0A2020202020202F2F204170706C7920496D70657269616C20636F6E76657273696F6E20746F20616C6C20616666656374656420726F777320696E206F6E6520706173730A20202020202076617220726F7773203D204F626A';
wwv_flow_imp.g_varchar2_table(693) := '6563742E6B65797328726F7773546F466978292E6D61702866756E6374696F6E286B29207B2072657475726E20726F7773546F4669785B6B5D3B207D293B0A20202020202069662028726F77732E6C656E67746829207B0A2020202020202020726F7773';
wwv_flow_imp.g_varchar2_table(694) := '2E666F72456163682866756E6374696F6E28747229207B206669784947496D70657269616C446973706C6179282428747229293B207D293B0A2020202020207D0A202020207D293B0A0A202020202F2F204F627365727665207468652067726964207363';
wwv_flow_imp.g_varchar2_table(695) := '726F6C6C20636F6E7461696E657220E28094206361746368657320626F74682074626F647920726F77206368616E6765730A202020202F2F20616E6420544420636C617373206368616E67657320696E206F6E65206F627365727665720A202020202428';
wwv_flow_imp.g_varchar2_table(696) := '276469762E612D47562D772D7363726F6C6C27292E656163682866756E6374696F6E2829207B0A202020202020675F69674F627365727665722E6F62736572766528746869732C207B0A2020202020202020737562747265653A20202020202020202020';
wwv_flow_imp.g_varchar2_table(697) := '20747275652C0A20202020202020206368696C644C6973743A202020202020202020747275652C2020202020202F2F20726F772072652D72656E64657220616674657220736176650A2020202020202020617474726962757465733A2020202020202020';
wwv_flow_imp.g_varchar2_table(698) := '747275652C2020202020202F2F20544420636C617373206368616E6765730A202020202020202061747472696275746546696C7465723A2020205B27636C617373275D2C0A20202020202020206174747269627574654F6C6456616C75653A2074727565';
wwv_flow_imp.g_varchar2_table(699) := '0A2020202020207D293B0A202020207D293B0A20207D0A0A20202428646F63756D656E74292E6F6E2827617065787265616479656E64272C2066756E6374696F6E2829207B0A202020206669784947496D70657269616C446973706C617928293B0A2020';
wwv_flow_imp.g_varchar2_table(700) := '2020696E6974496D70657269616C4F6273657276657228293B0A20207D293B0A0A20202F2F2052652D696E697420616674657220494720726566726573682028706167696E6174696F6E2C207365617263682920E28094206E657720444F4D2C206E6577';
wwv_flow_imp.g_varchar2_table(701) := '206F627365727665720A20202428646F63756D656E74292E6F6E282761706578616674657272656672657368272C2066756E6374696F6E286529207B0A202020206669784947496D70657269616C446973706C6179282428652E74617267657429293B0A';
wwv_flow_imp.g_varchar2_table(702) := '20202020696E6974496D70657269616C4F6273657276657228293B0A20207D293B0A0A7D286A51756572792C20617065782C2077696E646F772E4972616E69616E43616C2C206170657833363029293B0A';
null;
end;
/
begin
wwv_flow_imp_shared.create_plugin_file(
 p_id=>wwv_flow_imp.id(158266056596050556187)
,p_plugin_id=>wwv_flow_imp.id(158266056596050555837)
,p_file_name=>'js/apex360-persian-datepicker.js'
,p_mime_type=>'application/javascript'
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
