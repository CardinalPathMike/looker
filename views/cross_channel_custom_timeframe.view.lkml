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
##  o CTR = Filtered Clicks / Filtered Impressions

  measure: CTR {
    type: number
    value_format_name: percent_3
    sql: sum(${TABLE}.`Filtered Clicks`)/ sum(NULLIF(${TABLE}.`Filtered Impressions`,0)) ;;
  }

  measure: CTR_a {
    type: sum
    value_format_name: percent_3
    sql: sum(${TABLE}.`Filtered Clicks`)/ sum(NULLIF(${TABLE}.`Filtered Impressions`,0)) ;;
    filters: [group_a_yesno: "yes"]
  }

  measure: CTR_b {
    type: sum
    value_format_name: percent_3
    sql: sum(${TABLE}.`Filtered Clicks`)/ sum(NULLIF(${TABLE}.`Filtered Impressions`,0)) ;;
    filters: [group_b_yesno: "yes"]
  }

##  o CPM = Spend / Impressions * 1000
  measure: CPM {
    type: number
    value_format_name: usd
    sql: (sum( ${TABLE}.Spend)/ sum(NULLIF(${TABLE}.Impressions ,0))) * 1000 ;;
  }

  measure: CPM_a {
    type: sum
    value_format_name: percent_3
    sql: (sum( ${TABLE}.Spend)/ sum(NULLIF(${TABLE}.Impressions ,0))) * 1000 ;;
    filters: [group_a_yesno: "yes"]
  }

  measure: CPM_b {
    type: sum
    value_format_name: percent_3
    sql: (sum( ${TABLE}.Spend)/ sum(NULLIF(${TABLE}.Impressions ,0))) * 1000 ;;
    filters: [group_b_yesno: "yes"]
  }

##  o Amazon Vid RR = Amazon Video 1P Page Views / Amazon Video Impressions
  measure: AmazonVRR {
    type: number
    value_format_name: percent_2
    sql: sum(${TABLE}.`Amazon Video 1P Page Views`)/ sum(NULLIF(${TABLE}.`Amazon Video Impressions`,0)) ;;
  }

##  o Social TSR = 2/3 sec video views / Paid Social Impressions
  measure: SocialTSR {
    type: number
    value_format_name: percent_2
    sql: sum(${TABLE}.`2_3 sec video views`)/ sum(NULLIF(${TABLE}.`Paid Social Impressions`,0)) ;;
  }

##  o CF CAC = spend / Total CF Sales
  measure: CF_CAC {
    type: number
    value_format_name: usd
    sql: (case when sum(NULLIF(${TABLE}.`Total CF Sales`,0)) = 0 then 0 else sum( ${TABLE}.Spend) end)/ sum(NULLIF(${TABLE}.`Total CF Sales`,0))  ;;
  }

##  o CF CVR = Total CF Sales / Clicks
  measure: CF_CVR {
    type: number
    value_format_name: percent_2
    sql: sum(${TABLE}.`Total CF Sales`)/ sum(NULLIF(${TABLE}.Clicks,0)) ;;
  }

##  o CF CPATC = Spend / Total CF ATCs
  measure: CF_CPATC {
    type: number
    value_format_name: usd
    sql: sum( ${TABLE}.Spend)/ sum(NULLIF(${TABLE}.`Total CF ATCs`,0)) ;;
  }

##  o CF ATC Rate = Total CF ATCs / Clicks
  measure: CF_ATC_Rate {
    type: number
    value_format_name: percent_2
    sql: sum(NULLIF(${TABLE}.`Total CF ATCs`,0))/ sum(NULLIF(${TABLE}.Clicks,0)) ;;
  }

##  o CPV = Spend / Total Sessions
  measure: CPV {
    type: number
    value_format_name: usd
    sql: sum( ${TABLE}.Spend)/ sum(NULLIF(${TABLE}.`Total Sessions`,0)) ;;
  }

# CPQV - Spend/Quality Visitors
  measure: CPQV {
    type: number
    value_format_name: usd
    sql: sum( ${TABLE}.Spend)/ sum(NULLIF(${TABLE}.`Qualified Visitors`,0)) ;;
  }


##--------------Metrics specific to funnel level---------------------------
##----- Upper funnel (creation) engagement metric KPIs -------------------

##  o YouTube VVR = Video Views / YouTube Impressions
  measure: YouTube_VVR {
    type: number
    value_format_name: percent_2
    sql: sum(${TABLE}.`Total Sessions`)/ sum(NULLIF(${TABLE}.`YouTube Impressions`,0)) ;;
  }

##  o Amazon Vid RR = Amazon Video 1P Page Views / Amazon Video Impressions
  measure: Amazon_VRR{
    type: number
    value_format_name: percent_2
    sql: sum(${TABLE}.`Amazon Video 1P Page Views`)/ sum(NULLIF(${TABLE}.`Amazon Video Impressions`,0)) ;;
  }

##  o Social TSR = 2/3 sec video views / Paid Social Impressions
  measure: Social_TSR{
    type: number
    value_format_name: percent_2
    sql: sum(${TABLE}.`2_3 sec video views`)/ sum(NULLIF(${TABLE}.`Paid Social Impressions`,0)) ;;
  }

## CPC = Spend / clicks
  measure: CostPerClick {
    type: number
    value_format_name: usd
    sql: sum( ${TABLE}.Spend)/ sum(NULLIF(${TABLE}.Clicks,0)) ;;
  }




}
