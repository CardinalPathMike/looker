view: cross_channel_custom_timeframe {

  sql_table_name: `cardinal-path.peloton.combined_peloton_rfi` ;;

## Dimensions

## Timeframe Logic

  dimension_group: date {
    type: time
    timeframes: [raw, time, date]
    sql: TIMESTAMP(${TABLE}.Date) ;;
  }

  ## filter determining time range for all "A" measures
  filter: timeframe_a {
    type: date
  }

  dimension: date_row_a {
    type: string
    sql: ROW_NUMBER() OVER (ORDER BY ${date_raw}) ;;
  }

  dimension: date_row_b {
    type: string
    sql: ROW_NUMBER() OVER (ORDER BY ${date_raw});;
  }

  ## flag for "A" measures to only include appropriate time range
  dimension: group_a_yesno {
    hidden: yes
    type: yesno
    sql: {% condition timeframe_a %} ${date_raw} {% endcondition %} ;;
  }

  ## filter determining time range for all "B" measures
  filter: timeframe_b {
    type: date
  }

  ## flag for "B" measures to only include appropriate time range
  dimension: group_b_yesno {
    hidden: yes
    type: yesno
    sql: {% condition timeframe_b %} ${date_raw} {% endcondition %} ;;
  }

  dimension: is_in_time_a_or_b {
    group_label: "Time Comparison Filters"
    type: yesno
    sql:
      {% condition timeframe_a %} ${date_raw} {% endcondition %} OR
      {% condition timeframe_b %} ${date_raw} {% endcondition %} ;;
  }

  dimension: is_in_time_a {
    group_label: "Time Comparison Filters"
    type: yesno
    sql:
      {% condition timeframe_a %} ${date_raw} {% endcondition %}  ;;
  }

  dimension: is_in_time_b {
    group_label: "Time Comparison Filters"
    type: yesno
    sql:
      {% condition timeframe_b %} ${date_raw} {% endcondition %}  ;;
  }

  dimension: days_apart_in_period_a {
    type: number
    sql: DATE_DIFF({% date_end timeframe_a %}, ${date_raw}, DAY) ;;
  }

  dimension: days_apart_in_period_b {
    type: number
    sql: DATE_DIFF({% date_end timeframe_b %}, ${date_raw}, DAY) ;;
  }
  dimension: first_date_period_a {
    type: date
    sql: {% date_start timeframe_a %} ;;
  }

  dimension: first_date_period_b {
    type: date
    sql: {% date_start timeframe_b %} ;;
  }

  dimension: first_date_period_b_display {
    type: date
    sql: ${first_date_period_b};;
    html: <p>&nbsp;{{ rendered_value | date: "%b %d, %y" }} &nbsp;</p> ;;
  }

  dimension: last_date_period_a {
    type: date
    value_format: "m-d-yyyy"
    sql: {% date_end timeframe_a %} ;;
    html: {{ rendered_value | date: "%b %d, %y" }} ;;
  }

  dimension: last_date_period_b {
    type: date
    sql: {% date_end timeframe_b %} ;;
    html: {{ rendered_value | date: "%b %d, %y" }} ;;
  }


  dimension: date_align {
    type: number
    sql: ABS(date_DIFF({% date_start timeframe_a %} , {% date_start timeframe_b %}, DAY)) ;;
  }

## E2 - Distance between End of Timeframe A and Start of Timeframe B - Don't make it an ABSOLUTE VALUE
  dimension: date_align_part1 {
    type: number
    sql: date_DIFF({% date_end timeframe_a %} , {% date_start timeframe_b %}, DAY) ;;
  }
# A2 - Number of Days in Timeframe A
  dimension: date_align_part2 {
    type: number
    sql: date_DIFF({% date_end timeframe_a %} , {% date_start timeframe_a %}, DAY) ;;
  }
#B1 - Number of Days in Timeframe B
  dimension: date_align_part3 {
    type: number
    sql: date_DIFF({% date_end timeframe_b %} , {% date_start timeframe_b %}, DAY) ;;
  }

  dimension: total_alignment_needed{
    type: number
    sql: ${date_align_part1} - (${date_align_part2} + 1) ;;
  }

# =B3-$E$2-($C$2-1)
  dimension: date_transformed {
    type: date
    sql: CASE WHEN {% condition timeframe_b %} ${date_raw} {% endcondition %} THEN DATE_ADD(${date_raw} , INTERVAL ${total_alignment_needed}+1 DAY) else ${date_raw}  END ;;
  }

  dimension: date_transformed_align {
    type: date
    sql: DATE_DIFF(${date_transformed}, ${date_date}, DAY) ;;
  }


  dimension: camp_audience {
      type: string
      sql: ${TABLE}.`Camp Audience` ;;
  }

  dimension: campaign_funnel {
    type: string
    sql: ${TABLE}.`Campaign Funnel` ;;
  }

  dimension: channel {
    type: string
    sql: ${TABLE}.Channel ;;
  }

  dimension: business {
    type: string
    sql: ${TABLE}.Business ;;
  }

  dimension: ad_type {
    type: string
    sql: ${TABLE}.`Ad Type` ;;
  }

  dimension: search_tactic {
    type: string
    sql: ${TABLE}.`Search Tactic` ;;
  }

  dimension: creative_concept {
    type: string
    sql: ${TABLE}.`Creative Concept` ;;
  }

  dimension: creative_message {
    type: string
    sql: ${TABLE}.`Creative Message` ;;
  }

  dimension: sku {
    type: string
    sql: ${TABLE}.`SKU` ;;
  }
  dimension: creative_variation {
    type: string
    sql: ${TABLE}.`Creative Variation` ;;
  }

  dimension: landing_page {
    type: string
    sql: ${TABLE}.`Landing Page` ;;
  }

  dimension: lob {
    type: string
    sql: ${TABLE}.LOB ;;
  }

  dimension: market {
    type: string
    sql: ${TABLE}.Market ;;
  }

  dimension: dimension {
    type: string
    sql: ${TABLE}.Dimension ;;
  }

  dimension: partner {
    type: string
    sql: ${TABLE}.Partner ;;
  }

## KPI Selector
  parameter: KPI_Selector {
    type: unquoted
    allowed_value: {
      label: "Spend"
      value: "spend"
    }
    allowed_value: {
      label: "Impressions"
      value: "impressions"
    }
    allowed_value: {
      label: "Brand Product Queries"
      value: "bqp"
    }
    allowed_value: {
      label: "CPM"
      value: "cpm"
    }
    allowed_value: {
      label: "Clicks"
      value: "clicks"
    }
    allowed_value: {
      label: "CTR"
      value: "ctr"
    }
    allowed_value: {
      label: "CF ATC"
      value: "cf_atc"
    }
    allowed_value: {
      label: "CF ATC Rate"
      value: "cf_atc_rate"
    }
    allowed_value: {
      label: "CF CPATC"
      value: "cf_cpatc"
    }
    allowed_value: {
      label: "CF Sales"
      value: "cf_sales"
    }
    allowed_value: {
      label: "CF CAC"
      value: "cf_cac"
    }
    allowed_value: {
      label: "CF CVR"
      value: "cf_cvr"
    }
    default_value: "spend"
  }

  measure: KPI_A {
    type: number
    sql:
    {% if KPI_Selector._parameter_value == 'spend' %}
    ${spend_a}
    {% elsif KPI_Selector._parameter_value == 'impressions' %}
    ${impressions_a}
    {% elsif KPI_Selector._parameter_value == 'bpq' %}
    ${impressions_a}
    {% elsif KPI_Selector._parameter_value == 'cpm' %}
    ${CPM_a}
    {% elsif KPI_Selector._parameter_value == 'clicks' %}
    ${clicks_a}
    {% elsif KPI_Selector._parameter_value == 'ctr' %}
    ${CTR_a}
    {% elsif KPI_Selector._parameter_value == 'cf_atc_rate' %}
    ${CF_ATC_Rate_a}
    {% elsif KPI_Selector._parameter_value == 'cf_cpatc' %}
    ${CF_CPATC_a}
    {% elsif KPI_Selector._parameter_value == 'cf_sales' %}
    ${cf_sales_a}
    {% elsif KPI_Selector._parameter_value == 'cf_cac' %}
    ${CF_CAC_a}
    {% else %}
    ${CF_CVR_a}
    {% endif %};;

  }

  measure: KPI_B {
    type: number
    sql:
    {% if KPI_Selector._parameter_value == 'spend' %}
    ${spend_b}
    {% elsif KPI_Selector._parameter_value == 'impressions' %}
    ${impressions_b}
    {% elsif KPI_Selector._parameter_value == 'bpq' %}
    ${impressions_b}
    {% elsif KPI_Selector._parameter_value == 'cpm' %}
    ${CPM_b}
    {% elsif KPI_Selector._parameter_value == 'clicks' %}
    ${clicks_b}
    {% elsif KPI_Selector._parameter_value == 'ctr' %}
    ${CTR_b}
    {% elsif KPI_Selector._parameter_value == 'cf_atc_rate' %}
    ${CF_ATC_Rate_b}
    {% elsif KPI_Selector._parameter_value == 'cf_cpatc' %}
    ${CF_CPATC_b}
    {% elsif KPI_Selector._parameter_value == 'cf_sales' %}
    ${cf_sales_b}
    {% elsif KPI_Selector._parameter_value == 'cf_cac' %}
    ${CF_CAC_b}
    {% else %}
    ${CF_CVR_b}
    {% endif %};;
    }

  dimension: KPI_label {
    type: string
    sql:
     {% if KPI_Selector._parameter_value == 'spend' %}
     "Spend"
    {% elsif KPI_Selector._parameter_value == 'impressions' %}
    "Impressions"
    {% elsif KPI_Selector._parameter_value == 'bpq' %}
    "Brand Product Queries"
    {% elsif KPI_Selector._parameter_value == 'cpm' %}
    "CPM"
    {% elsif KPI_Selector._parameter_value == 'clicks' %}
    "Clicks"
    {% elsif KPI_Selector._parameter_value == 'ctr' %}
     "CTR"
    {% elsif KPI_Selector._parameter_value == 'cf_atc_rate' %}
    "CF ATC Rate"
    {% elsif KPI_Selector._parameter_value == 'cf_cpatc' %}
    "CF CPATC"
    {% elsif KPI_Selector._parameter_value == 'cf_sales' %}
    "CF Sales"
    {% elsif KPI_Selector._parameter_value == 'cf_cac' %}
    "CF CAC"
    {% else %}
    "CF CVR"
    {% endif %};;
    html:<p style="color:white;">&nbsp;{{rendered_value}}&nbsp;</p> ;;

  }


# Measures
  ## filtered measure A
  measure: spend {
    type: sum
    value_format_name: usd_0
    sql: ${TABLE}.Spend ;;
  }

  measure: spend_a {
    type: sum
    value_format_name: usd_0
    sql: ${TABLE}.Spend ;;
    filters: [group_a_yesno: "yes"]
  }

  measure: spend_b {
    type: sum
    value_format_name: usd_0
    sql: ${TABLE}.Spend ;;
    filters: [group_b_yesno: "yes"]
  }

  measure: clicks {
    type: sum
    value_format_name: usd_0
    sql: ${TABLE}.Clicks ;;
  }

  measure: clicks_a {
    type: sum
    value_format_name: usd_0
    sql: ${TABLE}.Clicks ;;
    filters: [group_a_yesno: "yes"]
  }

  measure:clicks_b {
    type: sum
    value_format_name: usd_0
    sql: ${TABLE}.Clicks ;;
    filters: [group_b_yesno: "yes"]
  }

  measure: filtered_clicks {
    type: sum
    sql: ${TABLE}.`Filtered Clicks` ;;
  }

  measure: filtered_clicks_a {
    type: sum
    sql: ${TABLE}.`Filtered Clicks` ;;
    filters: [group_a_yesno: "yes"]
  }

  measure: filtered_clicks_b {
    type: sum
    sql: ${TABLE}.`Filtered Clicks` ;;
    filters: [group_b_yesno: "yes"]
  }

  measure: filtered_impressions {
    type: sum
    sql: ${TABLE}.`Filtered Impressions` ;;
  }

  measure: filtered_impressions_a {
    type: sum
    sql: ${TABLE}.`Filtered Impressions` ;;
    filters: [group_a_yesno: "yes"]
  }

  measure: filtered_impressions_b {
    type: sum
    sql: ${TABLE}.`Filtered Impressions` ;;
    filters: [group_b_yesno: "yes"]
  }

  measure: impressions {
    type: sum
    sql: ${TABLE}.Impressions ;;
  }

  measure: impressions_a {
    type: sum
    sql: ${TABLE}.Impressions ;;
    filters: [group_a_yesno: "yes"]
  }

  measure: impressions_b {
    type: sum
    sql: ${TABLE}.Impressions ;;
    filters: [group_b_yesno: "yes"]
  }

  measure: paid_social_impressions {
    type: sum
    sql: ${TABLE}.`Paid Social Impressions` ;;
  }

  measure: paid_social_impressions_a {
    type: sum
    sql: ${TABLE}.`Paid Social Impressions` ;;
    filters: [group_a_yesno: "yes"]
  }

  measure: paid_social_impressions_b {
    type: sum
    sql: ${TABLE}.`Paid Social Impressions` ;;
    filters: [group_b_yesno: "yes"]
  }

  measure: qualified_visitors {
    type: sum
    sql: ${TABLE}.`Qualified Visitors` ;;
  }

  measure: qualified_visitors_a {
    type: sum
    sql: ${TABLE}.`Qualified Visitors` ;;
    filters: [group_a_yesno: "yes"]
  }

  measure: qualified_visitors_b {
    type: sum
    sql: ${TABLE}.`Qualified Visitors` ;;
    filters: [group_b_yesno: "yes"]
  }

  measure: cf_atcs {
    type: sum
    sql: ${TABLE}.`Total CF ATCs` ;;
  }

  measure: cf_atcs_a {
    type: sum
    sql: ${TABLE}.`Total CF ATCs` ;;
    filters: [group_a_yesno: "yes"]
  }

  measure: cf_atcs_b {
    type: sum
    sql: ${TABLE}.`Total CF ATCs` ;;
    filters: [group_b_yesno: "yes"]
  }

  measure: cf_sales {
    type: sum
    sql: ${TABLE}.`Total CF Sales` ;;
  }

  measure: cf_sales_a {
    type: sum
    sql: ${TABLE}.`Total CF Sales` ;;
    filters: [group_a_yesno: "yes"]
  }

  measure: cf_sales_b {
    type: sum
    sql: ${TABLE}.`Total CF Sales` ;;
    filters: [group_b_yesno: "yes"]
  }

  measure: sessions {
    type: sum
    sql: ${TABLE}.`Total Sessions` ;;
  }

  measure: sessions_a {
    type: sum
    sql: ${TABLE}.`Total Sessions` ;;
    filters: [group_a_yesno: "yes"]
  }

  measure: sessions_b {
    type: sum
    sql: ${TABLE}.`Total Sessions` ;;
    filters: [group_b_yesno: "yes"]
  }

  measure: video_views {
    type: sum
    sql: ${TABLE}.`Video Views` ;;
  }

  measure: video_views_a {
    type: sum
    sql: ${TABLE}.`Video Views` ;;
    filters: [group_a_yesno: "yes"]
  }

  measure: video_views_b {
    type: sum
    sql: ${TABLE}.`Video Views` ;;
    filters: [group_b_yesno: "yes"]
  }

  measure: youtube_impressions {
    type: sum
    sql: ${TABLE}.`YouTube Impressions` ;;
  }

  measure: youtube_impressions_a {
    type: sum
    sql: ${TABLE}.`YouTube Impressions` ;;
    filters: [group_a_yesno: "yes"]
  }

  measure: youtube_impressions_b {
    type: sum
    sql: ${TABLE}.`YouTube Impressions` ;;
    filters: [group_b_yesno: "yes"]
  }

  measure: 2_3_sec_video_views {
    type: sum
    sql: ${TABLE}.`2_3 sec video views` ;;
  }

  measure: 2_3_sec_video_views_a {
    type: sum
    sql: ${TABLE}.`2_3 sec video views` ;;
    filters: [group_a_yesno: "yes"]
  }

  measure: 2_3_sec_video_views_b {
    type: sum
    sql: ${TABLE}.`2_3 sec video views` ;;
    filters: [group_b_yesno: "yes"]
  }

  measure: amazon_video_1_p_page_views {
    type: sum
    sql: ${TABLE}.`Amazon Video 1P Page Views` ;;
  }

  measure: amazon_video_1_p_page_views_a {
    type: sum
    sql: ${TABLE}.`Amazon Video 1P Page Views` ;;
    filters: [group_a_yesno: "yes"]
  }

  measure: amazon_video_1_p_page_views_b {
    type: sum
    sql: ${TABLE}.`Amazon Video 1P Page Views` ;;
    filters: [group_b_yesno: "yes"]
  }

  measure: amazon_video_impressions {
    type: sum
    sql: ${TABLE}.`Amazon Video Impressions` ;;
  }

  measure: amazon_video_impressions_a {
    type: sum
    sql: ${TABLE}.`Amazon Video Impressions` ;;
    filters: [group_a_yesno: "yes"]
  }

  measure: amazon_video_impressions_b {
    type: sum
    sql: ${TABLE}.`Amazon Video Impressions` ;;
    filters: [group_b_yesno: "yes"]
  }
  ##---------------All efficiency metrics---------------------
##  o CTR = Filtered Clicks / Filtered Impressions

  measure: CTR {
    type: number
    value_format_name: percent_3
    sql: sum(${TABLE}.`Filtered Clicks`)/ sum(NULLIF(${TABLE}.`Filtered Impressions`,0)) ;;
  }

  dimension: filtered_clicks_dim {
    type: number
    sql: ${TABLE}.`Filtered Clicks` ;;
  }

  dimension: filtered_impressions_dim {
    type: number
    sql:${TABLE}.`Filtered Impressions` ;;
  }

  measure: sum_filtered_clicks_a {
    type: sum
    sql: CASE WHEN {% condition timeframe_a %} ${date_raw} {% endcondition %} THEN ${filtered_clicks_dim} END;;
  }

  measure: sum_filtered_clicks_b {
    type: sum
    sql: CASE WHEN {% condition timeframe_b %} ${date_raw} {% endcondition %} THEN ${filtered_clicks_dim} END;;
  }

  measure: sum_filtered_impressions_a {
    type: sum
    sql: CASE WHEN {% condition timeframe_a %} ${date_raw} {% endcondition %} THEN ${filtered_impressions_dim} END;;
  }

  measure: sum_filtered_impressions_b {
    type: sum
    sql: CASE WHEN {% condition timeframe_b %} ${date_raw} {% endcondition %} THEN ${filtered_impressions_dim} END;;
  }

  measure: CTR_a {
    type: number
    value_format_name: percent_3
    sql: case when ${sum_filtered_impressions_a} = 0 then 0 else ${sum_filtered_clicks_a}/${sum_filtered_impressions_a} end;;
  }

  measure: CTR_b {
    type: number
    value_format_name: percent_3
    sql: case when ${sum_filtered_impressions_b} = 0 then 0 else ${sum_filtered_clicks_b}/ ${sum_filtered_impressions_b} end ;;
  }

##  o CPM = Spend / Impressions * 1000
  measure: CPM {
    type: number
    value_format_name: usd
    sql: (sum( ${TABLE}.Spend)/ sum(NULLIF(${TABLE}.Impressions ,0))) * 1000 ;;
  }

  dimension: spend_dim {
    type: number
    sql: ${TABLE}.Spend ;;
  }

  dimension: impressions_dim {
    type: number
    sql:${TABLE}.Impressions ;;
  }

  measure: sum_spend_a {
    type: sum
    sql: CASE WHEN {% condition timeframe_a %} ${date_raw} {% endcondition %} THEN ${spend_dim} END;;
  }

  measure: sum_spend_b {
    type: sum
    sql: CASE WHEN {% condition timeframe_b %} ${date_raw} {% endcondition %} THEN ${spend_dim} END;;
  }

  measure: sum_impressions_a {
    type: sum
    sql: CASE WHEN {% condition timeframe_a %} ${date_raw} {% endcondition %} THEN ${impressions_dim} END;;
  }

  measure: sum_impressions_b {
    type: sum
    sql: CASE WHEN {% condition timeframe_b %} ${date_raw} {% endcondition %} THEN ${impressions_dim} END;;
  }

  measure: CPM_a {
    type: number
    value_format_name: usd
    sql: case when ${sum_impressions_a} = 0 then 0 else (${sum_spend_a}/${sum_impressions_a}) * 1000 end;;
  }

  measure: CPM_b {
    type: number
    value_format_name: usd
    sql: case when ${sum_impressions_b} = 0 then 0 else (${sum_spend_b}/ ${sum_impressions_b}) * 1000 end ;;
  }


  ##  o Amazon Vid RR = Amazon Video 1P Page Views / Amazon Video Impressions
  measure: AmazonVRR {
    type: number
    value_format_name: percent_2
    sql: sum(${TABLE}.`Amazon Video 1P Page Views`)/ sum(NULLIF(${TABLE}.`Amazon Video Impressions`,0)) ;;
  }

  dimension: amazon_video_1p_page_views_dim {
    type: number
    sql: ${TABLE}.`Amazon Video 1P Page Views` ;;
    }

  dimension: amazon_video_impressions_dim {
    type: number
    sql:${TABLE}.`Amazon Video Impressions` ;;
  }

  measure: sum_amazon_video_1p_page_views_a {
    type: sum
    sql: CASE WHEN {% condition timeframe_a %} ${date_raw} {% endcondition %} THEN ${amazon_video_1p_page_views_dim} END;;
  }

  measure: sum_amazon_video_1p_page_views_b {
    type: sum
    sql: CASE WHEN {% condition timeframe_b %} ${date_raw} {% endcondition %} THEN ${amazon_video_1p_page_views_dim} END;;
  }

  measure: sum_amazon_video_impressions_a {
    type: sum
    sql: CASE WHEN {% condition timeframe_a %} ${date_raw} {% endcondition %} THEN ${amazon_video_impressions_dim} END;;
  }

  measure: sum_amazon_video_impressions_b {
    type: sum
    sql: CASE WHEN {% condition timeframe_b %} ${date_raw} {% endcondition %} THEN ${amazon_video_impressions_dim} END;;
  }

  measure: AmazonVRR_a {
    type: number
    value_format_name: usd
    sql: case when ${sum_amazon_video_impressions_a} = 0 then 0 else (${sum_amazon_video_1p_page_views_a}/${sum_amazon_video_impressions_a}) end;;
  }

  measure: AmazonVRR_b {
    type: number
    value_format_name: usd
    sql: case when ${sum_amazon_video_impressions_b} = 0 then 0 else (${sum_amazon_video_1p_page_views_b}/${sum_amazon_video_impressions_b}) end;;
    }


##  o Social TSR = 2/3 sec video views / Paid Social Impressions
  measure: ThumbStopRate {
    type: number
    value_format_name: percent_2
    sql: sum(${TABLE}.`2_3 sec video views`)/ sum(NULLIF(${TABLE}.`Paid Social Impressions`,0)) ;;
  }

  dimension: 2_3_sec_video_views_dim {
    type: number
    sql: ${TABLE}.`2_3 sec video views` ;;
  }

  dimension: paid_social_impressions_dim {
    type: number
    sql:${TABLE}.`Paid Social Impressions` ;;
  }

  measure: sum_2_3_sec_video_views_a {
    type: sum
    sql: CASE WHEN {% condition timeframe_a %} ${date_raw} {% endcondition %} THEN ${2_3_sec_video_views_dim} END;;
  }

  measure: sum_2_3_sec_video_views_b {
    type: sum
    sql: CASE WHEN {% condition timeframe_b %} ${date_raw} {% endcondition %} THEN ${2_3_sec_video_views_dim} END;;
  }

  measure: sum_paid_social_impressions_dim_a {
    type: sum
    sql: CASE WHEN {% condition timeframe_a %} ${date_raw} {% endcondition %} THEN ${paid_social_impressions_dim} END;;
  }

  measure: sum_paid_social_impressions_dim_b {
    type: sum
    sql: CASE WHEN {% condition timeframe_b %} ${date_raw} {% endcondition %} THEN ${paid_social_impressions_dim} END;;
  }

  measure: ThumbStopRate_a {
    type: number
    value_format_name: percent_2
    sql: case when ${sum_paid_social_impressions_dim_a} = 0 then 0 else (${sum_2_3_sec_video_views_a}/${sum_paid_social_impressions_dim_a}) end;;
  }

  measure: ThumbStopRate_b {
    type: number
    value_format_name: percent_2
    sql: case when ${sum_paid_social_impressions_dim_b} = 0 then 0 else (${sum_2_3_sec_video_views_b}/${sum_paid_social_impressions_dim_b}) end;;
    }

##  o CF CAC = spend / Total CF Sales
  measure: CF_CAC {
    type: number
    value_format_name: usd
    sql: (case when sum(NULLIF(${TABLE}.`Total CF Sales`,0)) = 0 then 0 else sum( ${TABLE}.Spend) end)/ sum(NULLIF(${TABLE}.`Total CF Sales`,0))  ;;
  }

  dimension: total_cf_sales_dim {
    type: number
    sql: ${TABLE}.`Total CF Sales` ;;
  }

  measure: sum_total_cf_sales_a {
    type: sum
    sql: CASE WHEN {% condition timeframe_a %} ${date_raw} {% endcondition %} THEN ${total_cf_sales_dim} END;;
  }

  measure: sum_total_cf_sales_b {
    type: sum
    sql: CASE WHEN {% condition timeframe_b %} ${date_raw} {% endcondition %} THEN ${total_cf_sales_dim} END;;
  }

  measure: CF_CAC_a {
    type: number
    value_format_name: usd
    sql: case when ${sum_spend_a} = 0 then 0 else ${sum_spend_a}/${sum_total_cf_sales_a} end;;
  }

  measure: CF_CAC_b {
    type: number
    value_format_name: usd
    sql: case when ${sum_spend_b} = 0 then 0 else ${sum_spend_b}/ ${sum_total_cf_sales_b} end ;;
  }


##  o CF CVR = Total CF Sales / Clicks
  measure: CF_CVR {
    type: number
    value_format_name: percent_2
    sql: sum(${TABLE}.`Total CF Sales`)/ sum(NULLIF(${TABLE}.Clicks,0)) ;;
  }

  dimension: clicks_dim {
    type: number
    sql: ${TABLE}.Clicks ;;
  }

  measure: sum_clicks_a {
    type: sum
    sql: CASE WHEN {% condition timeframe_a %} ${date_raw} {% endcondition %} THEN ${clicks_dim} END;;
  }

  measure: sum_clicks_b {
    type: sum
    sql: CASE WHEN {% condition timeframe_b %} ${date_raw} {% endcondition %} THEN ${clicks_dim} END;;
  }


  measure: CF_CVR_a {
    type: number
    value_format_name: percent_3
    sql: case when ${sum_clicks_a} = 0 then 0 else ${sum_total_cf_sales_a}/${sum_clicks_a} end;;
  }

  measure: CF_CVR_b {
    type: number
    value_format_name: percent_3
    sql: case when ${sum_clicks_b} = 0 then 0 else ${sum_total_cf_sales_b}/ ${sum_clicks_b} end ;;
  }

##  o CF CPATC = Spend / Total CF ATCs
  measure: CF_CPATC {
    type: number
    value_format_name: usd
    sql: sum( ${TABLE}.Spend)/ sum(NULLIF(${TABLE}.`Total CF ATCs`,0)) ;;
  }

  dimension: total_cf_atcs_dim {
    type: number
    sql: ${TABLE}.`Total CF ATCs` ;;
  }

  measure: sum_total_cf_atcs_a {
    type: sum
    sql: CASE WHEN {% condition timeframe_a %} ${date_raw} {% endcondition %} THEN ${total_cf_atcs_dim} END;;
  }

  measure: sum_total_cf_atcs_b {
    type: sum
    sql: CASE WHEN {% condition timeframe_b %} ${date_raw} {% endcondition %} THEN ${total_cf_atcs_dim} END;;
  }

  measure: CF_CPATC_a {
    type: number
    value_format_name: usd
    sql: case when ${sum_total_cf_atcs_a} = 0 then 0 else ${sum_spend_a}/${sum_total_cf_atcs_a} end;;
  }

  measure: CF_CPATC_b {
    type: number
    value_format_name: usd
    sql: case when ${sum_total_cf_atcs_b} = 0 then 0 else ${sum_spend_b}/ ${sum_total_cf_atcs_b} end ;;
  }



##  o CF ATC Rate = Total CF ATCs / Clicks
  measure: CF_ATC_Rate {
    type: number
    value_format_name: percent_2
    sql: sum(NULLIF(${TABLE}.`Total CF ATCs`,0))/ sum(NULLIF(${TABLE}.Clicks,0)) ;;
  }

  measure: CF_ATC_Rate_a {
    type: number
    value_format_name: percent_2
    sql: case when ${sum_clicks_a} = 0 then 0 else ${sum_total_cf_atcs_a}/${sum_clicks_a} end;;
  }

  measure: CF_ATC_Rate_b {
    type: number
    value_format_name: percent_2
    sql: case when ${sum_clicks_b} = 0 then 0 else ${sum_total_cf_atcs_b}/ ${sum_clicks_b} end ;;
  }


##  o CPV = Spend / Total Sessions
  measure: CPV {
    type: number
    value_format_name: usd
    sql: sum( ${TABLE}.Spend)/ sum(NULLIF(${TABLE}.`Total Sessions`,0)) ;;
  }

  dimension: total_sessions_dim {
    type: number
    sql: ${TABLE}.`Total Sessions` ;;
  }

  measure: sum_total_sessions_a {
    type: sum
    sql: CASE WHEN {% condition timeframe_a %} ${date_raw} {% endcondition %} THEN ${total_sessions_dim} END;;
  }

  measure: sum_total_sessions_b {
    type: sum
    sql: CASE WHEN {% condition timeframe_b %} ${date_raw} {% endcondition %} THEN ${total_sessions_dim} END;;
  }

  measure: CPV_a {
    type: number
    value_format_name: usd
    sql: case when ${sum_total_sessions_a} = 0 then 0 else ${sum_spend_a}/${sum_total_sessions_a} end;;
  }

  measure: CPV_b {
    type: number
    value_format_name: usd
    sql: case when ${sum_total_sessions_b} = 0 then 0 else ${sum_spend_b}/ ${sum_total_sessions_b} end ;;
  }


# CPQV - Spend/Quality Visitors
  measure: CPQV {
    type: number
    value_format_name: usd
    sql: sum( ${TABLE}.Spend)/ sum(NULLIF(${TABLE}.`Qualified Visitors`,0)) ;;
  }

  dimension: qualified_visitors_dim {
    type: number
    sql: ${TABLE}.`Qualified Visitors` ;;
  }

  measure: sum_qualified_visitors_a {
    type: sum
    sql: CASE WHEN {% condition timeframe_a %} ${date_raw} {% endcondition %} THEN ${qualified_visitors_dim} END;;
  }

  measure: sum_qualified_visitors_b {
    type: sum
    sql: CASE WHEN {% condition timeframe_b %} ${date_raw} {% endcondition %} THEN ${qualified_visitors_dim} END;;
  }

  measure: CPQV_a {
    type: number
    value_format_name: usd
    sql: case when ${sum_qualified_visitors_a} = 0 then 0 else ${sum_spend_a}/${sum_qualified_visitors_a} end;;
  }

  measure: CPQV_b {
    type: number
    value_format_name: usd
    sql: case when ${sum_total_sessions_b} = 0 then 0 else ${sum_spend_b}/ ${sum_qualified_visitors_b} end ;;
  }

##  o YouTube VVR = Video Views / YouTube Impressions
  measure: YouTube_VVR {
    type: number
    value_format_name: percent_2
    sql: sum(${TABLE}.`Total Sessions`)/ sum(NULLIF(${TABLE}.`YouTube Impressions`,0)) ;;
  }

  dimension: youtube_impressions_dim {
    type: number
    sql: ${TABLE}.`YouTube Impressions` ;;
  }

  measure: sum_youtube_impressions_a {
    type: sum
    sql: CASE WHEN {% condition timeframe_a %} ${date_raw} {% endcondition %} THEN ${youtube_impressions_dim} END;;
  }

  measure: sum_youtube_impressions_b {
    type: sum
    sql: CASE WHEN {% condition timeframe_b %} ${date_raw} {% endcondition %} THEN ${youtube_impressions_dim} END;;
  }

  measure: YouTube_VVR_a {
    type: number
    value_format_name: percent_2
    sql: case when ${sum_youtube_impressions_a} = 0 then 0 else ${sum_total_sessions_a}/${sum_youtube_impressions_a} end;;
  }

  measure: YouTube_VVR_b {
    type: number
    value_format_name: percent_2
    sql: case when ${sum_youtube_impressions_b} = 0 then 0 else ${sum_total_sessions_b}/ ${sum_youtube_impressions_b} end ;;
  }


##  o Amazon Vid RR = Amazon Video 1P Page Views / Amazon Video Impressions
  measure: Amazon_VRR{
    type: number
    value_format_name: percent_2
    sql: sum(${TABLE}.`Amazon Video 1P Page Views`)/ sum(NULLIF(${TABLE}.`Amazon Video Impressions`,0)) ;;
  }

  measure: Amazon_VRR_a {
    type: number
    value_format_name: percent_2
    sql: case when ${sum_amazon_video_impressions_a} = 0 then 0 else ${sum_amazon_video_1p_page_views_a}/${sum_amazon_video_impressions_a} end;;
  }

  measure: Amazon_VRR_b {
    type: number
    value_format_name: percent_2
    sql: case when ${sum_amazon_video_impressions_b} = 0 then 0 else ${sum_amazon_video_1p_page_views_b}/ ${sum_amazon_video_impressions_b} end ;;
  }

##  o Social TSR = 2/3 sec video views / Paid Social Impressions

## CPC = Spend / clicks
  measure: CostPerClick {
    type: number
    value_format_name: usd
    sql: sum( ${TABLE}.Spend)/ sum(NULLIF(${TABLE}.Clicks,0)) ;;
  }

  measure: CostPerClick_a {
    type: number
    value_format_name: percent_2
    sql: case when ${sum_clicks_a} = 0 then 0 else ${sum_spend_a}/${sum_clicks_a} end;;
  }

  measure: CostPerClick_b {
    type: number
    value_format_name: percent_2
    sql: case when ${sum_clicks_b} = 0 then 0 else ${sum_spend_b}/ ${sum_clicks_b} end ;;
  }

## Variance Measures

  measure: spend_variance {
    type: number
    value_format: "0.00\%;0.00%"
    sql: (${spend_a} - ${spend_b})/${spend_b} ;;
  }

  measure: impressions_variance {
    type: number
    value_format: "0.00\%;0.00%"
    sql: (${impressions_a} - ${impressions_b})/${impressions_b} ;;
  }

  measure: CPM_variance {
    type: number
    value_format: "0.00\%;0.00%"
    sql: (${CPM_a} - ${CPM_b})/${CPM_b} ;;
  }

  measure: clicks_variance {
    type: number
    value_format: "0.00\%;0.00%"
    sql: (${clicks_a} - ${clicks_b})/${clicks_b} ;;
  }

  measure: CTR_variance {
    type: number
    value_format: "0.00\%;0.00%"
    sql: (${CTR_a} - ${CTR_b})/${CTR_b} ;;
  }

  measure: CF_CPATC_variance {
    type: number
    value_format: "0.00\%;0.00%"
    sql: (${CF_CPATC_a} - ${CF_CPATC_b})/${CF_CPATC_b} ;;
  }

  measure: cf_sales_variance {
    type: number
    value_format: "0.00\%;0.00%"
    sql: (${cf_sales_a} - ${cf_sales_b})/${cf_sales_b} ;;
  }

  measure: CF_CAC_variance {
    type: number
    value_format: "0.00\%;0.00%"
    sql: (${CF_CAC_a} - ${CF_CAC_b})/${CF_CAC_b} ;;
  }

  measure: CF_CVR_variance {
    type: number
    value_format: "0.00\%;0.00%"
    sql: (${CF_CVR_a} - ${CF_CVR_b})/${CF_CVR_b} ;;
  }

  measure: CF_ATC_Rate_variance {
    type: number
    value_format: "0.00\%;0.00%"
    sql: (${CF_ATC_Rate_a} - ${CF_ATC_Rate_b})/${CF_ATC_Rate_b} ;;
  }

  measure: CF_ATCs_variance {
    type: number
    value_format: "0.00\%;0.00%"
    sql: (${cf_atcs_a} - ${cf_atcs_b})/${cf_atcs_b} ;;
  }

### Build Out the Report
##
  measure: kpi_banner {
    type: count
    html:
      <div class="vis">
         <div class="vis-custom" style="background-image: linear-gradient(to right, #1b1662, #000000, #91aa2d); color:#ffffff">
          <div style="display: grid; justify-content: space-between;  grid-template-columns: 100px auto; gap: 10px; !important">
            <div><b>MEDIA&nbsp;THAT&nbsp;MOVES&nbsp;WITH&nbsp;YOU</b></div>
                <div>dentsu&nbsp;|&nbsp;PELOTON</div>
             </div>
          </div>
      </div>;;
  }

 measure: spend_variance_viz {
  type: count
  group_label: "Report Elements"
  html: <div class="vis">
          <div class="vis-single-value" style="background-color:#1b1662; color:#ffffff">
            <p>
              <font color="white">
                <center>
                  <b>
                  <div style="font-size: 1em;">Spend</div><br>
                  <div style="font-size: 1em;">Current</div>
                  <div style="font-size: 1.5em;">{{cross_channel_custom_timeframe.spend_a._rendered_value}}</div><br>
                  <div style="font-size: 1em;">Prior</div>
                  <div style="font-size: 1.5em;">{{cross_channel_custom_timeframe.spend_b._rendered_value}}</div><br>
                  <div style="font-size: 1em;">Variance</div>
                  <div style="font-size: 1.5em;">
                    {% if cross_channel_custom_timeframe.spend_variance._value > 0 %}
                       <p style="color:green;">&#8679;&nbsp;{{ cross_channel_custom_timeframe.spend_variance._rendered_value }}</p>
                    {% elsif cross_channel_custom_timeframe.spend_variance._value == 0 %}
                      <p style="color:yellow;">&#8680;&nbsp;{{ cross_channel_custom_timeframe.spend_variance._rendered_value }}</p>
                    {% else %}
                        <p style="color:red;" >&#8681;&nbsp;{{ cross_channel_custom_timeframe.spend_variance._rendered_value }}</p>
                    {% endif %}
                  </div>
                  </b>
                </center>
              </font>
            </p>
      </div>
      </div>
   ;;
  }

  measure: impressions_variance_viz {
    type: count
    group_label: "Report Elements"
    html: <div class="vis">
          <div class="vis-single-value" style="background-color:#1b1662; color:#ffffff">
            <p>
              <font color="white">
                <center>
                  <b>
                  <div style="font-size: 1em;">Impressions</div><br>
                  <div style="font-size: 1em;">Current</div>
                  <div style="font-size: 1.5em;">{{cross_channel_custom_timeframe.impressions_a._rendered_value}}</div><br>
                  <div style="font-size: 1em;">Prior</div>
                  <div style="font-size: 1.5em;">{{cross_channel_custom_timeframe.impressions_b._rendered_value}}</div><br>
                  <div style="font-size: 1em;">Variance</div>
                  <div style="font-size: 1.5em;">
                    {% if cross_channel_custom_timeframe.impressions_variance._value > 0 %}
                       <p style="color:green;">&#8679;&nbsp;{{ cross_channel_custom_timeframe.impressions_variance._rendered_value }}</p>
                    {% elsif cross_channel_custom_timeframe.impressions_variance._value == 0 %}
                      <p style="color:yellow;">&#8680;&nbsp;{{ cross_channel_custom_timeframe.impressions_variance._rendered_value }}</p>
                    {% else %}
                        <p style="color:red;" >&#8681;&nbsp;{{ cross_channel_custom_timeframe.impressions_variance._rendered_value }}</p>
                    {% endif %}
                  </div>
                  </b>
                </center>
              </font>
            </p>
      </div>
      </div>
   ;;
  }

  measure: impressions_BQP_variance_viz {
    type: count
    group_label: "Report Elements"
    html: <div class="vis">
           <div class="vis-single-value" style="background-color:#1b1662; color:#ffffff">
            <p>
              <font color="white">
                <center>
                  <b>
                  <div style="font-size: .75em;">Brand Product Queries</div><br>
                  <div style="font-size: 1em;">Current</div>
                  <div style="font-size: 1.5em;">{{cross_channel_custom_timeframe.impressions_a._rendered_value}}</div><br>
                  <div style="font-size: 1em;">Prior</div>
                  <div style="font-size: 1.5em;">{{cross_channel_custom_timeframe.impressions_b._rendered_value}}</div><br>
                  <div style="font-size: 1em;">Variance</div>
                  <div style="font-size: 1.5em;">
                    {% if cross_channel_custom_timeframe.impressions_variance._value > 0 %}
                       <p style="color:green;">&#8679;&nbsp;{{ cross_channel_custom_timeframe.impressions_variance._rendered_value }}</p>
                    {% elsif cross_channel_custom_timeframe.impressions_variance._value == 0 %}
                      <p style="color:yellow;">&#8680;&nbsp;{{ cross_channel_custom_timeframe.impressions_variance._rendered_value }}</p>
                    {% else %}
                        <p style="color:red;" >&#8681;&nbsp;{{ cross_channel_custom_timeframe.impressions_variance._rendered_value }}</p>
                    {% endif %}
                  </div>
                  </b>
                </center>
              </font>
            </p>
      </div>
      </div>
   ;;
  }

  measure: CPM_variance_viz {
    type: count
    group_label: "Report Elements"
    html: <div class="vis">
          <div class="vis-single-value" style="background-image: linear-gradient(to right, #1b1662, #000000); color:#ffffff">
            <p>
              <font color="white">
                <center>
                  <b>
                  <div style="font-size: 1em;">CPM</div><br>
                  <div style="font-size: 1em;">Current</div>
                  <div style="font-size: 1.5em;">{{cross_channel_custom_timeframe.CPM_a._rendered_value}}</div><br>
                  <div style="font-size: 1em;">Prior</div>
                  <div style="font-size: 1.5em;">{{cross_channel_custom_timeframe.CPM_b._rendered_value}}</div><br>
                  <div style="font-size: 1em;">Variance</div>
                  <div style="font-size: 1.5em;">
                    {% if cross_channel_custom_timeframe.CPM_variance._value > 0 %}
                       <p style="color:red;">&#8679;&nbsp;{{ cross_channel_custom_timeframe.CPM_variance._rendered_value }}</p>
                    {% elsif cross_channel_custom_timeframe.CPM_variance._value == 0 %}
                      <p style="color:yellow;">&#8680;&nbsp;{{ cross_channel_custom_timeframe.CPM_variance._rendered_value }}</p>
                    {% else %}
                        <p style="color:green;" >&#8681;&nbsp;{{ cross_channel_custom_timeframe.CPM_variance._rendered_value }}</p>
                    {% endif %}
                  </div>
                  </b>
                </center>
              </font>
            </p>
      </div>
      </div>
   ;;
  }

  measure: clicks_variance_viz {
    type: count
    group_label: "Report Elements"
    html: <div class="vis">
            <div class="vis-single-value" style="background-color:#000000; color:#ffffff">
              <p>
              <font color="white">
                <center>
                  <b>
                  <div style="font-size: 1em;">Clicks</div><br>
                  <div style="font-size: 1em;">Current</div>
                  <div style="font-size: 1.5em;">{{cross_channel_custom_timeframe.clicks_a._rendered_value}}</div><br>
                  <div style="font-size: 1em;">Prior</div>
                  <div style="font-size: 1.5em;">{{cross_channel_custom_timeframe.clicks_b._rendered_value}}</div><br>
                  <div style="font-size: 1em;">Variance</div>
                  <div style="font-size: 1.5em;">
                    {% if cross_channel_custom_timeframe.clicks_variance._value > 0 %}
                       <p style="color:green;">&#8679;&nbsp;{{ cross_channel_custom_timeframe.clicks_variance._rendered_value }}</p>
                    {% elsif cross_channel_custom_timeframe.clicks_variance._value == 0 %}
                      <p style="color:yellow;">&#8680;&nbsp;{{ cross_channel_custom_timeframe.clicks_variance._rendered_value }}</p>
                    {% else %}
                        <p style="color:red;" >&#8681;&nbsp;{{ cross_channel_custom_timeframe.clicks_variance._rendered_value }}</p>
                    {% endif %}
                  </div>
                  </b>
                </center>
              </font>
            </p>
      </div>
      </div>
   ;;
  }

  measure: CTR_variance_viz {
    type: count
    group_label: "Report Elements"
    html: <div class="vis">
            <div class="vis-single-value" style="background-color:#000000; color:#ffffff">
            <p>
              <font color="white">
                <center>
                  <b>
                  <div style="font-size: 1em;">CTR</div><br>
                  <div style="font-size: 1em;">Current</div>
                  <div style="font-size: 1.5em;">{{cross_channel_custom_timeframe.CTR_a._rendered_value}}</div><br>
                  <div style="font-size: 1em;">Prior</div>
                  <div style="font-size: 1.5em;">{{cross_channel_custom_timeframe.CTR_b._rendered_value}}</div><br>
                  <div style="font-size: 1em;">Variance</div>
                  <div style="font-size: 1.5em;">
                    {% if cross_channel_custom_timeframe.CTR_variance._value > 0 %}
                       <p style="color:green;">&#8679;&nbsp;{{ cross_channel_custom_timeframe.CTR_variance._rendered_value }}</p>
                    {% elsif cross_channel_custom_timeframe.CTR_variance._value == 0 %}
                      <p style="color:yellow;">&#8680;&nbsp;{{ cross_channel_custom_timeframe.CTR_variance._rendered_value }}</p>
                    {% else %}
                        <p style="color:red;" >&#8681;&nbsp;{{ cross_channel_custom_timeframe.CTR_variance._rendered_value }}</p>
                    {% endif %}
                  </div>
                  </b>
                </center>
              </font>
            </p>
      </div>
      </div>
   ;;
  }

  measure: CF_CPATC_variance_viz {
    type: count
    group_label: "Report Elements"
    html: <div class="vis">
          <div class="vis-single-value" style="background-image: linear-gradient(to right, #000000, #91AA2d); color:#ffffff">
            <p>
              <font color="white">
                <center>
                  <b>
                  <div style="font-size: 1em;">CF CPATC</div><br>
                  <div style="font-size: 1em;">Current</div>
                  <div style="font-size: 1.5em;">{{cross_channel_custom_timeframe.CF_CPATC_a._rendered_value}}</div><br>
                  <div style="font-size: 1em;">Prior</div>
                  <div style="font-size: 1.5em;">{{cross_channel_custom_timeframe.CF_CPATC_b._rendered_value}}</div><br>
                  <div style="font-size: 1em;">Variance</div>
                  <div style="font-size: 1.5em;">
                    {% if cross_channel_custom_timeframe.CF_CPATC_variance._value > 0 %}
                       <p style="color:red;">&#8679;&nbsp;{{ cross_channel_custom_timeframe.CF_CPATC_variance._rendered_value }}</p>
                    {% elsif cross_channel_custom_timeframe.CF_CPATC_variance._value == 0 %}
                      <p style="color:yellow;">&#8680;&nbsp;{{ cross_channel_custom_timeframe.CF_CPATC_variance._rendered_value }}</p>
                    {% else %}
                        <p style="color:green;" >&#8681;&nbsp;{{ cross_channel_custom_timeframe.CF_CPATC_variance._rendered_value }}</p>
                    {% endif %}
                  </div>
                  </b>
                </center>
              </font>
            </p>
      </div>
      </div>
   ;;
  }

  measure: cf_sales_variance_viz {
    type: count
    group_label: "Report Elements"
    html: <div class="vis">
            <div class="vis-single-value" style="background-color:#91AA2d; color:#000000">
            <p>
              <font color="white">
                <center>
                  <b>
                  <div style="font-size: 1em;">CF Sales</div><br>
                  <div style="font-size: 1em;">Current</div>
                  <div style="font-size: 1.5em;">{{cross_channel_custom_timeframe.cf_sales_a._rendered_value}}</div><br>
                  <div style="font-size: 1em;">Prior</div>
                  <div style="font-size: 1.5em;">{{cross_channel_custom_timeframe.cf_sales_b._rendered_value}}</div><br>
                  <div style="font-size: 1em;">Variance</div>
                  <div style="font-size: 1.5em;">
                    {% if cross_channel_custom_timeframe.cf_sales_variance._value > 0 %}
                       <p style="color:green;">&#8679;&nbsp;{{ cross_channel_custom_timeframe.cf_sales_variance._rendered_value }}</p>
                    {% elsif cross_channel_custom_timeframe.cf_sales_variance._value == 0 %}
                      <p style="color:yellow;">&#8680;&nbsp;{{ cross_channel_custom_timeframe.cf_sales_variance._rendered_value }}</p>
                    {% else %}
                        <p style="color:red;" >&#8681;&nbsp;{{ cross_channel_custom_timeframe.cf_sales_variance._rendered_value }}</p>
                    {% endif %}
                  </div>
                  </b>
                </center>
              </font>
            </p>
      </div>
      </div>
   ;;
  }

  measure: CF_CAC_variance_viz {
    type: count
    group_label: "Report Elements"
    html: <div class="vis">
            <div class="vis-single-value" style="background-color:#91AA2d; color:#000000">
            <p>
              <font color="white">
                <center>
                  <b>
                  <div style="font-size: 1em;">CF CAC</div><br>
                  <div style="font-size: 1em;">Current</div>
                  <div style="font-size: 1.5em;">{{cross_channel_custom_timeframe.CF_CAC_a._rendered_value}}</div><br>
                  <div style="font-size: 1em;">Prior</div>
                  <div style="font-size: 1.5em;">{{cross_channel_custom_timeframe.CF_CAC_b._rendered_value}}</div><br>
                  <div style="font-size: 1em;">Variance</div>
                  <div style="font-size: 1.5em;">
                    {% if cross_channel_custom_timeframe.CF_CAC_variance._value > 0 %}
                       <p style="color:red;">&#8679;&nbsp;{{ cross_channel_custom_timeframe.CF_CAC_variance._rendered_value }}</p>
                    {% elsif cross_channel_custom_timeframe.CF_CAC_variance._value == 0 %}
                      <p style="color:yellow;">&#8680;&nbsp;{{ cross_channel_custom_timeframe.CF_CAC_variance._rendered_value }}</p>
                    {% else %}
                        <p style="color:green;" >&#8681;&nbsp;{{ cross_channel_custom_timeframe.CF_CAC_variance._rendered_value }}</p>
                    {% endif %}
                  </div>
                  </b>
                </center>
              </font>
            </p>
      </div>
      </div>
   ;;
  }

  measure: CF_CVR_variance_viz {
    type: count
    group_label: "Report Elements"
    html: <div class="vis">
            <div class="vis-single-value" style="background-color:#91AA2d; color:#000000">
            <p>
              <font color="white">
                <center>
                  <b>
                  <div style="font-size: 1em;">CF CVR</div><br>
                  <div style="font-size: 1em;">Current</div>
                  <div style="font-size: 1.5em;">{{cross_channel_custom_timeframe.CF_CVR_a._rendered_value}}</div><br>
                  <div style="font-size: 1em;">Prior</div>
                  <div style="font-size: 1.5em;">{{cross_channel_custom_timeframe.CF_CVR_b._rendered_value}}</div><br>
                  <div style="font-size: 1em;">Variance</div>
                  <div style="font-size: 1.5em;">
                    {% if cross_channel_custom_timeframe.CF_CVR_variance._value > 0 %}
                       <p style="color:green;">&#8679;&nbsp;{{ cross_channel_custom_timeframe.CF_CVR_variance._rendered_value }}</p>
                    {% elsif cross_channel_custom_timeframe.CF_CVR_variance._value == 0 %}
                      <p style="color:yellow;">&#8680;&nbsp;{{ cross_channel_custom_timeframe.CF_CVR_variance._rendered_value }}</p>
                    {% else %}
                        <p style="color:red;" >&#8681;&nbsp;{{ cross_channel_custom_timeframe.CF_CVR_variance._rendered_value }}</p>
                    {% endif %}
                  </div>
                  </b>
                </center>
              </font>
            </p>
      </div>
      </div>
   ;;
  }

  measure: CF_ATC_Rate_variance_viz {
    type: count
    group_label: "Report Elements"
    html: <div class="vis">
            <div class="vis-single-value" style="background-color:#000000; color:#ffffff">
            <p>
              <font color="white">
                <center>
                  <b>
                  <div style="font-size: 1em;">CF ATC Rate</div><br>
                  <div style="font-size: 1em;">Current</div>
                  <div style="font-size: 1.5em;">{{cross_channel_custom_timeframe.CF_ATC_Rate_a._rendered_value}}</div><br>
                  <div style="font-size: 1em;">Prior</div>
                  <div style="font-size: 1.5em;">{{cross_channel_custom_timeframe.CF_ATC_Rate_b._rendered_value}}</div><br>
                  <div style="font-size: 1em;">Variance</div>
                  <div style="font-size: 1.5em;">
                    {% if cross_channel_custom_timeframe.CF_ATC_Rate_variance._value > 0 %}
                       <p style="color:green;">&#8679;&nbsp;{{ cross_channel_custom_timeframe.CF_ATC_Rate_variance._rendered_value }}</p>
                    {% elsif cross_channel_custom_timeframe.CF_ATC_Rate_variance._value == 0 %}
                      <p style="color:yellow;">&#8680;&nbsp;{{ cross_channel_custom_timeframe.CF_ATC_Rate_variance._rendered_value }}</p>
                    {% else %}
                        <p style="color:red;" >&#8681;&nbsp;{{ cross_channel_custom_timeframe.CF_ATC_Rate_variance._rendered_value }}</p>
                    {% endif %}
                  </div>
                  </b>
                </center>
              </font>
            </p>
      </div>
      </div>
   ;;
  }

  measure: CF_ATC_variance_viz {
    type: count
    group_label: "Report Elements"
    html: <div class="vis">
            <div class="vis-single-value" style="background-color:#000000; color:#ffffff">
            <p>
              <font color="white">
                <center>
                  <b>
                  <div style="font-size: 1em;">CF ATC</div><br>
                  <div style="font-size: 1em;">Current</div>
                  <div style="font-size: 1.5em;">{{cross_channel_custom_timeframe.cf_atcs_a._rendered_value}}</div><br>
                  <div style="font-size: 1em;">Prior</div>
                  <div style="font-size: 1.5em;">{{cross_channel_custom_timeframe.cf_atcs_b._rendered_value}}</div><br>
                  <div style="font-size: 1em;">Variance</div>
                  <div style="font-size: 1.5em;">
                    {% if cross_channel_custom_timeframe.CF_ATCs_variance._value > 0 %}
                       <p style="color:green;">&#8679;&nbsp;{{ cross_channel_custom_timeframe.CF_ATCs_variance._rendered_value }}</p>
                    {% elsif cross_channel_custom_timeframe.CF_ATCs_variance._value == 0 %}
                      <p style="color:yellow;">&#8680;&nbsp;{{ cross_channel_custom_timeframe.CF_ATCs_variance._rendered_value }}</p>
                    {% else %}
                        <p style="color:red;" >&#8681;&nbsp;{{ cross_channel_custom_timeframe.CF_ATCs_variance._rendered_value }}</p>
                    {% endif %}
                  </div>
                  </b>
                </center>
              </font>
            </p>
      </div>
      </div>
   ;;
  }

# <span style="color: ##1408C9"><b>{{ cross_channel_custom_timeframe.first_date_period_a._rendered_value }} to {{ cross_channel_custom_timeframe.last_date_period_a._rendered_value }}</b></span>
  measure: graph_banner {
    type: count
     html:
      <div class="vis" >
        <div class="vis-single-value" style="width=100% font-size:2em; background-image: linear-gradient(to right, #1b1662, #000000, #91aa2d); color:#ffffff">
            <div>
                <span><b>{{ cross_channel_custom_timeframe.KPI_label._value }}</b></span>
            </div>
            <div style="width=100% background-image: linear-gradient(to right, #1b1662, #000000, #91aa2d);">
              <span style="color: #1408C9 font-size:2em"><b>&nbsp;{{ cross_channel_custom_timeframe.first_date_period_a._rendered_value }} - {{ cross_channel_custom_timeframe.last_date_period_a._rendered_value }}</b></span>
              <span><b>&nbsp; vs </b></span>
              <span style="color: #8C75F5 font-size:2em "><b>&nbsp;{{ cross_channel_custom_timeframe.first_date_period_b_display._rendered_value }} - {{ cross_channel_custom_timeframe.last_date_period_b._rendered_value }}</b></span>
            </div>
        </div>
    </div>;;
  }


}
