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
    type: date_time
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
    type: date_time
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

# Business Dimensions

  dimension: business {
    type: string
    sql: ${TABLE}.Business ;;
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

  measure: AmazonVRR_a {
    type: sum
    value_format_name: percent_3
    sql: sum(${TABLE}.`Amazon Video 1P Page Views`)/ sum(NULLIF(${TABLE}.`Amazon Video Impressions`,0)) ;;
    filters: [group_a_yesno: "yes"]
  }

  measure: AmazonVRR_b {
    type: sum
    value_format_name: percent_3
    sql: sum(${TABLE}.`Amazon Video 1P Page Views`)/ sum(NULLIF(${TABLE}.`Amazon Video Impressions`,0)) ;;
    filters: [group_b_yesno: "yes"]
  }

##  o Social TSR = 2/3 sec video views / Paid Social Impressions
  measure: SocialTSR {
    type: number
    value_format_name: percent_2
    sql: sum(${TABLE}.`2_3 sec video views`)/ sum(NULLIF(${TABLE}.`Paid Social Impressions`,0)) ;;
  }

  measure: SocialTSR_a {
    type: sum
    value_format_name: percent_3
    sql: sum(${TABLE}.`2_3 sec video views`)/ sum(NULLIF(${TABLE}.`Paid Social Impressions`,0)) ;;
    filters: [group_a_yesno: "yes"]
  }

  measure: SocialTSR_b {
    type: sum
    value_format_name: percent_3
    sql: sum(${TABLE}.`2_3 sec video views`)/ sum(NULLIF(${TABLE}.`Paid Social Impressions`,0)) ;;
    filters: [group_b_yesno: "yes"]
  }

##  o CF CAC = spend / Total CF Sales
  measure: CF_CAC {
    type: number
    value_format_name: usd
    sql: (case when sum(NULLIF(${TABLE}.`Total CF Sales`,0)) = 0 then 0 else sum( ${TABLE}.Spend) end)/ sum(NULLIF(${TABLE}.`Total CF Sales`,0))  ;;
  }

  measure: CF_CAC_a {
    type: sum
    value_format_name: percent_3
    sql: (case when sum(NULLIF(${TABLE}.`Total CF Sales`,0)) = 0 then 0 else sum( ${TABLE}.Spend) end)/ sum(NULLIF(${TABLE}.`Total CF Sales`,0))  ;;
    filters: [group_a_yesno: "yes"]
  }

  measure: CF_CAC_b {
    type: sum
    value_format_name: percent_3
    sql: (case when sum(NULLIF(${TABLE}.`Total CF Sales`,0)) = 0 then 0 else sum( ${TABLE}.Spend) end)/ sum(NULLIF(${TABLE}.`Total CF Sales`,0))  ;;
    filters: [group_b_yesno: "yes"]
  }

##  o CF CVR = Total CF Sales / Clicks
  measure: CF_CVR {
    type: number
    value_format_name: percent_2
    sql: sum(${TABLE}.`Total CF Sales`)/ sum(NULLIF(${TABLE}.Clicks,0)) ;;
  }

  measure: CF_CVR_a {
    type: sum
    value_format_name: percent_3
    sql: sum(${TABLE}.`Total CF Sales`)/ sum(NULLIF(${TABLE}.Clicks,0)) ;;
    filters: [group_a_yesno: "yes"]
  }

  measure: CF_CVR_b {
    type: sum
    value_format_name: percent_3
    sql: sum(${TABLE}.`Total CF Sales`)/ sum(NULLIF(${TABLE}.Clicks,0)) ;;
    filters: [group_b_yesno: "yes"]
  }

##  o CF CPATC = Spend / Total CF ATCs
  measure: CF_CPATC {
    type: number
    value_format_name: usd
    sql: sum( ${TABLE}.Spend)/ sum(NULLIF(${TABLE}.`Total CF ATCs`,0)) ;;
  }

  measure: CF_CPATC_a {
    type: sum
    value_format_name: percent_3
    sql: sum( ${TABLE}.Spend)/ sum(NULLIF(${TABLE}.`Total CF ATCs`,0)) ;;
    filters: [group_a_yesno: "yes"]
  }

  measure: CF_CPATC_b {
    type: sum
    value_format_name: percent_3
    sql: sum( ${TABLE}.Spend)/ sum(NULLIF(${TABLE}.`Total CF ATCs`,0)) ;;
    filters: [group_b_yesno: "yes"]
  }

##  o CF ATC Rate = Total CF ATCs / Clicks
  measure: CF_ATC_Rate {
    type: number
    value_format_name: percent_2
    sql: sum(NULLIF(${TABLE}.`Total CF ATCs`,0))/ sum(NULLIF(${TABLE}.Clicks,0)) ;;
  }

  measure: CF_ATC_Rate_a {
    type: sum
    value_format_name: percent_3
    sql: sum(NULLIF(${TABLE}.`Total CF ATCs`,0))/ sum(NULLIF(${TABLE}.Clicks,0)) ;;
    filters: [group_a_yesno: "yes"]
  }

  measure: CF_ATC_Rate_b {
    type: sum
    value_format_name: percent_3
    sql: sum(NULLIF(${TABLE}.`Total CF ATCs`,0))/ sum(NULLIF(${TABLE}.Clicks,0)) ;;
    filters: [group_b_yesno: "yes"]
  }

##  o CPV = Spend / Total Sessions
  measure: CPV {
    type: number
    value_format_name: usd
    sql: sum( ${TABLE}.Spend)/ sum(NULLIF(${TABLE}.`Total Sessions`,0)) ;;
  }

  measure: CPV_a {
    type: sum
    value_format_name: percent_3
    sql: sum( ${TABLE}.Spend)/ sum(NULLIF(${TABLE}.`Total Sessions`,0)) ;;
    filters: [group_a_yesno: "yes"]
  }

  measure: CPV_b {
    type: sum
    value_format_name: percent_3
    sql: sum( ${TABLE}.Spend)/ sum(NULLIF(${TABLE}.`Total Sessions`,0)) ;;
    filters: [group_b_yesno: "yes"]
  }

# CPQV - Spend/Quality Visitors
  measure: CPQV {
    type: number
    value_format_name: usd
    sql: sum( ${TABLE}.Spend)/ sum(NULLIF(${TABLE}.`Qualified Visitors`,0)) ;;
  }

  measure: CPQV_a {
    type: sum
    value_format_name: percent_3
    sql: sum( ${TABLE}.Spend)/ sum(NULLIF(${TABLE}.`Qualified Visitors`,0)) ;;
    filters: [group_a_yesno: "yes"]
  }

  measure: CPQV_b {
    type: sum
    value_format_name: percent_3
    sql: sum( ${TABLE}.Spend)/ sum(NULLIF(${TABLE}.`Qualified Visitors`,0)) ;;
    filters: [group_b_yesno: "yes"]
  }

##  o YouTube VVR = Video Views / YouTube Impressions
  measure: YouTube_VVR {
    type: number
    value_format_name: percent_2
    sql: sum(${TABLE}.`Total Sessions`)/ sum(NULLIF(${TABLE}.`YouTube Impressions`,0)) ;;
  }

  measure: YouTube_VVR_a {
    type: sum
    value_format_name: percent_3
    sql: sum(${TABLE}.`Total Sessions`)/ sum(NULLIF(${TABLE}.`YouTube Impressions`,0)) ;;
    filters: [group_a_yesno: "yes"]
  }

  measure: YouTube_VVR_b {
    type: sum
    value_format_name: percent_3
    sql: sum(${TABLE}.`Total Sessions`)/ sum(NULLIF(${TABLE}.`YouTube Impressions`,0)) ;;
    filters: [group_b_yesno: "yes"]
  }

##  o Amazon Vid RR = Amazon Video 1P Page Views / Amazon Video Impressions
  measure: Amazon_VRR{
    type: number
    value_format_name: percent_2
    sql: sum(${TABLE}.`Amazon Video 1P Page Views`)/ sum(NULLIF(${TABLE}.`Amazon Video Impressions`,0)) ;;
  }

  measure: Amazon_VVR_a {
    type: sum
    value_format_name: percent_3
    sql: sum(${TABLE}.`Amazon Video 1P Page Views`)/ sum(NULLIF(${TABLE}.`Amazon Video Impressions`,0)) ;;
    filters: [group_a_yesno: "yes"]
  }

  measure: Amazon_VVR_b {
    type: sum
    value_format_name: percent_3
    sql: sum(${TABLE}.`Amazon Video 1P Page Views`)/ sum(NULLIF(${TABLE}.`Amazon Video Impressions`,0)) ;;
    filters: [group_b_yesno: "yes"]
  }

##  o Social TSR = 2/3 sec video views / Paid Social Impressions
  measure: Thumb_Stop_Rate{
    type: number
    value_format_name: percent_2
    sql: sum(${TABLE}.`2_3 sec video views`)/ sum(NULLIF(${TABLE}.`Paid Social Impressions`,0)) ;;
  }

  measure: Thumb_Stop_Rate_a {
    type: sum
    value_format_name: percent_3
    sql: sum(${TABLE}.`2_3 sec video views`)/ sum(NULLIF(${TABLE}.`Paid Social Impressions`,0)) ;;
    filters: [group_a_yesno: "yes"]
  }

  measure: Thumb_Stop_Rate_b {
    type: sum
    value_format_name: percent_3
    sql: sum(${TABLE}.`2_3 sec video views`)/ sum(NULLIF(${TABLE}.`Paid Social Impressions`,0)) ;;
    filters: [group_b_yesno: "yes"]
  }

## CPC = Spend / clicks
  measure: CostPerClick {
    type: number
    value_format_name: usd
    sql: sum( ${TABLE}.Spend)/ sum(NULLIF(${TABLE}.Clicks,0)) ;;
  }

  measure: CostPerClick_a {
    type: sum
    value_format_name: percent_3
    sql: sum( ${TABLE}.Spend)/ sum(NULLIF(${TABLE}.Clicks,0)) ;;
    filters: [group_a_yesno: "yes"]
  }

  measure: CostPerClick_b {
    type: sum
    value_format_name: percent_3
    sql: sum( ${TABLE}.Spend)/ sum(NULLIF(${TABLE}.Clicks,0)) ;;
    filters: [group_b_yesno: "yes"]
  }



}
