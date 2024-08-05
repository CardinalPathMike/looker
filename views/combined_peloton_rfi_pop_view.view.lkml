view: cross_channel_pop {
  sql_table_name: `peloton.combined_peloton_rfi_pop_view` ;;

## Dimensions

  dimension_group: date {
    type: time
    timeframes: [raw, date]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.Date ;;
  }

##  dimension_group: time_selection {
##    type: string
##    sql: cast(${TABLE}.Date as VARCHAR) ;;
##  }


  dimension: timeframe {
    type: string
    sql: ${TABLE}.Timeframe ;;
  }

  dimension: lob {
    type: string
    sql: ${TABLE}.LOB ;;
  }

  dimension: market {
    type: string
    sql: ${TABLE}.Market ;;
  }

  dimension: partner {
    type: string
    sql: ${TABLE}.Partner ;;
  }

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

  dimension: creative_concept {
    type: string
    sql: ${TABLE}.`Creative Concept` ;;
  }

  dimension: creative_message {
    type: string
    sql: ${TABLE}.`Creative Message` ;;
  }

  dimension: creative_variation {
    type: string
    sql: ${TABLE}.`Creative Variation` ;;
  }

  dimension: dimension {
    type: string
    sql: ${TABLE}.Dimension ;;
  }

  dimension: landing_page {
    type: string
    sql: ${TABLE}.`Landing Page` ;;
  }

  dimension: sku {
    type: string
    sql: ${TABLE}.SKU ;;
  }

  measure: search_tactic {
    type: string
    sql: ${TABLE}.`Search Tactic` ;;
  }

  measure: ad_type {
    type: string
    sql: ${TABLE}.`Ad Type` ;;
  }

  ### Measures
  measure: spend {
    type: number
    sql: ${TABLE}.Spend ;;
  }

  measure: prior_spend {
    type: number
    sql: ${TABLE}.prior_Spend ;;
  }

  measure: impressions {
    type: number
    sql: ${TABLE}.impressions ;;
  }

  measure: prior_impressions {
    type: number
    sql: ${TABLE}.prior_impressions ;;
  }

  measure: clicks {
    type: number
    sql: ${TABLE}.Clicks ;;
  }
  measure: prior_clicks {
    type: number
    sql: ${TABLE}.prior_clicks ;;
  }

  measure: filtered_clicks {
    type: number
    sql: ${TABLE}.`Filtered Clicks` ;;
  }

  measure: prior_filtered_clicks {
    type: number
    sql: ${TABLE}.`prior_Filtered Clicks` ;;
  }

  measure: filtered_impressions {
    type: number
    sql: ${TABLE}.`Filtered Impressions` ;;
  }

  measure: prior_filtered_impressions {
    type: number
    sql: ${TABLE}.`prior_Filtered Impressions` ;;
  }

  measure: paid_social_impressions {
    type: number
    sql: ${TABLE}.`Paid Social Impressions` ;;
  }

  measure: prior_paid_social_impressions {
    type: number
    sql: ${TABLE}.`prior_Paid Social Impressions` ;;
  }

  measure: 2_3_sec_video_views {
    type: number
    sql: ${TABLE}.`2_3 sec video views` ;;
  }

  measure: prior_2_3_sec_video_views {
    type: number
    sql: ${TABLE}.`prior_2_3 sec video views` ;;
  }

  measure: amazon_video_impressions {
    type: number
    sql: ${TABLE}.`Amazon Video Impressions` ;;
  }

  measure: prior_amazon_video_impressions {
    type: number
    sql: ${TABLE}.`prior_Amazon Video Impressions` ;;
  }

  measure: amazon_video_1_p_page_views {
    type: number
    sql: ${TABLE}.`Amazon Video 1P Page Views` ;;
  }

  measure: prior_amazon_video_1_p_page_views {
    type: number
    sql: ${TABLE}.`prior_Amazon Video 1P Page Views` ;;
  }

  measure: qualified_visitors {
    type: number
    sql: ${TABLE}.`Qualified Visitors` ;;
  }

  measure: prior_qualified_visitors {
    type: number
    sql: ${TABLE}.`prior_Qualified Visitors` ;;
  }

  measure: total_cf_atcs {
    type: number
    sql: ${TABLE}.`Total CF ATCs` ;;
  }

  measure: prior_total_cf_atcs {
    type: number
    sql: ${TABLE}.`prior_Total CF ATCs` ;;
  }

  measure: total_cf_sales {
    type: number
    sql: ${TABLE}.`Total CF Sales` ;;
  }

  measure: prior_total_cf_sales {
    type: number
    sql: ${TABLE}.`prior_Total CF Sales` ;;
  }

  measure: total_sessions {
    type: number
    sql: ${TABLE}.`Total Sessions` ;;
  }

  measure: prior_total_sessions {
    type: number
    sql: ${TABLE}.`prior_Total Sessions` ;;
  }

  measure: video_views {
    type: number
    sql: ${TABLE}.`Video Views` ;;
  }

  measure: prior_video_views {
    type: number
    sql: ${TABLE}.`prior_Video Views` ;;
  }

  measure: youtube_impressions {
    type: number
    sql: ${TABLE}.`YouTube Impressions` ;;
  }

  measure: prior_youtube_impressions {
    type: number
    sql: ${TABLE}.`prior_YouTube Impressions` ;;
  }

##  o CTR = Filtered Clicks / Filtered Impressions
  measure: CTR {
    type: number
    value_format_name: percent_3
    sql: sum(${TABLE}.`Filtered Clicks`)/ sum(NULLIF(${TABLE}.`Filtered Impressions`,0)) ;;
  }

  measure: Prior_CTR {
    type: number
    value_format_name: percent_3
    sql: sum(${TABLE}.`prior_Filtered Clicks`)/ sum(NULLIF(${TABLE}.`prior_Filtered Impressions`,0)) ;;
  }

  ##  o CPM = Spend / Impressions * 1000
  measure: CPM {
    type: number
    value_format_name: usd
    sql: (sum( ${TABLE}.Spend)/ sum(NULLIF(${TABLE}.Impressions ,0))) * 1000 ;;
  }

  measure: Prior_CPM {
    type: number
    value_format_name: usd
    sql: (sum( ${TABLE}.prior_Spend)/ sum(NULLIF(${TABLE}.prior_Impressions ,0))) * 1000 ;;
  }

##  o Amazon Vid RR = Amazon Video 1P Page Views / Amazon Video Impressions
  measure: AmazonVRR {
    type: number
    value_format_name: percent_2
    sql: sum(${TABLE}.`Amazon Video 1P Page Views`)/ sum(NULLIF(${TABLE}.`Amazon Video Impressions`,0)) ;;
  }

  measure: Prior_AmazonVRR {
    type: number
    value_format_name: percent_2
    sql: sum(${TABLE}.`prior_Amazon Video 1P Page Views`)/ sum(NULLIF(${TABLE}.`prior_Amazon Video Impressions`,0)) ;;
  }

  ##  o Social TSR = 2/3 sec video views / Paid Social Impressions
  measure: Thumb_stop_rate {
    type: number
    value_format_name: percent_2
    sql: sum(${TABLE}.`2_3 sec video views`)/ sum(NULLIF(${TABLE}.`Paid Social Impressions`,0)) ;;
  }

  measure: prior_Thumb_stop_rate {
    type: number
    value_format_name: percent_2
    sql: sum(${TABLE}.`prior_2_3 sec video views`)/ sum(NULLIF(${TABLE}.`prior_Paid Social Impressions`,0)) ;;
  }

##  o CF CAC = spend / Total CF Sales
  measure: CF_CAC {
    type: number
    value_format_name: usd
    sql: (case when sum(NULLIF(${TABLE}.`Total CF Sales`,0)) = 0 then 0 else sum( ${TABLE}.Spend) end)/ sum(NULLIF(${TABLE}.`Total CF Sales`,0))  ;;
  }

  measure: prior_CF_CAC {
    type: number
    value_format_name: usd
    sql: (case when sum(NULLIF(${TABLE}.`prior_Total CF Sales`,0)) = 0 then 0 else sum( ${TABLE}.Spend) end)/ sum(NULLIF(${TABLE}.`prior_Total CF Sales`,0))  ;;
  }

##  o CF CVR = Total CF Sales / Clicks
  measure: CF_CVR {
    type: number
    value_format_name: percent_2
    sql: sum(${TABLE}.`Total CF Sales`)/ sum(NULLIF(${TABLE}.Clicks,0)) ;;
  }

  measure: prior_CF_CVR {
    type: number
    value_format_name: percent_2
    sql: sum(${TABLE}.`prior_Total CF Sales`)/ sum(NULLIF(${TABLE}.prior_Clicks,0)) ;;
  }

##  o CF CPATC = Spend / Total CF ATCs
  measure: CF_CPATC {
    type: number
    value_format_name: usd
    sql: sum( ${TABLE}.Spend)/ sum(NULLIF(${TABLE}.`Total CF ATCs`,0)) ;;
  }

  measure: prior_CF_CPATC {
    type: number
    value_format_name: usd
    sql: sum( ${TABLE}.prior_Spend)/ sum(NULLIF(${TABLE}.`prior_Total CF ATCs`,0)) ;;
  }

##  o CF ATC Rate = Total CF ATCs / Clicks
  measure: CF_ATC_Rate {
    type: number
    value_format_name: percent_2
    sql: sum(NULLIF(${TABLE}.`Total CF ATCs`,0))/ sum(NULLIF(${TABLE}.Clicks,0)) ;;
  }

  measure: prior_CF_ATC_Rate {
    type: number
    value_format_name: percent_2
    sql: sum(NULLIF(${TABLE}.`prior_Total CF ATCs`,0))/ sum(NULLIF(${TABLE}.prior_Clicks,0)) ;;
  }

##  o CPV = Spend / Total Sessions
  measure: CPV {
    type: number
    value_format_name: usd
    sql: sum( ${TABLE}.Spend)/ sum(NULLIF(${TABLE}.`Total Sessions`,0)) ;;
  }

  measure: Prior_CPV {
    type: number
    value_format_name: usd
    sql: sum( ${TABLE}.prior_Spend)/ sum(NULLIF(${TABLE}.`prior_Total Sessions`,0)) ;;
  }

# CPQV - Spend/Quality Visitors
  measure: CPQV {
    type: number
    value_format_name: usd
    sql: sum( ${TABLE}.Spend)/ sum(NULLIF(${TABLE}.`Qualified Visitors`,0)) ;;
  }

  measure: prior_CPQV {
    type: number
    value_format_name: usd
    sql: sum( ${TABLE}.prior_Spend)/ sum(NULLIF(${TABLE}.`prior_Qualified Visitors`,0)) ;;
  }


##--------------Metrics specific to funnel level---------------------------
##----- Upper funnel (creation) engagement metric KPIs -------------------

##  o YouTube VVR = Video Views / YouTube Impressions
  measure: YouTube_VVR {
    type: number
    value_format_name: percent_2
    sql: sum(${TABLE}.`Total Sessions`)/ sum(NULLIF(${TABLE}.`YouTube Impressions`,0)) ;;
  }

  measure: prior_YouTube_VVR {
    type: number
    value_format_name: percent_2
    sql: sum(${TABLE}.`prior_Total Sessions`)/ sum(NULLIF(${TABLE}.`prior_YouTube Impressions`,0)) ;;
  }

  ##  o Amazon Vid RR = Amazon Video 1P Page Views / Amazon Video Impressions
  measure: Amazon_VRR{
    type: number
    value_format_name: percent_2
    sql: sum(${TABLE}.`Amazon Video 1P Page Views`)/ sum(NULLIF(${TABLE}.`Amazon Video Impressions`,0)) ;;
  }

  ##  o Amazon Vid RR = Amazon Video 1P Page Views / Amazon Video Impressions
  measure: prior_Amazon_VRR{
    type: number
    value_format_name: percent_2
    sql: sum(${TABLE}.`prior_Amazon Video 1P Page Views`)/ sum(NULLIF(${TABLE}.`prior_Amazon Video Impressions`,0)) ;;
  }

## CPC = Spend / clicks
  measure: CPC {
    type: number
    value_format_name: usd
    sql: sum( ${TABLE}.Spend)/ sum(NULLIF(${TABLE}.Clicks,0)) ;;
  }

  measure: prior_CPC {
    type: number
    value_format_name: usd
    sql: sum( ${TABLE}.prior_Spend)/ sum(NULLIF(${TABLE}.prior_Clicks,0)) ;;
  }



}
