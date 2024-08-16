# The name of this view in Looker is "New Cross Channel"
view: cross_channel {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `cardinal-path.peloton.combined_peloton_rfi` ;;

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.



  dimension_group: week {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.Week ;;
  }

  dimension_group: date {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.Date ;;
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

  dimension: creative_message_image {
    type: string
    sql: ${creative_message} ;;
    html:
              <!-- CREATION -->
              {% if creative_message._value == "just_in_time" and creative_variation._value == "mjpmpn6m500" %}
              <img src="https://storage.googleapis.com/peloton_creatives/just_in_time.png" width="255">
              {% elsif creative_message._value contains "annaline_v5" and creative_variation._value == "ptsp328" %}
              <img src="https://storage.googleapis.com/peloton_creatives/annaline_v5_spark.png" width="255">
              {% elsif creative_message._value == "alex_nguyen_v2" and creative_variation._value == "ptsp326" %}
              <img src="https://storage.googleapis.com/peloton_creatives/alex_nguyen_v2.png" width="255">
              {% elsif creative_message._value == "ben_aldis_v1" and creative_variation._value == "ptsp335" %}
              <img src="https://storage.googleapis.com/peloton_creatives/ben_aldis_v1.png" width="255">
              {% elsif creative_message._value == "rad_me_gusta" and creative_variation._value == "mjalse3t538" %}
              <img src="https://storage.googleapis.com/peloton_creatives/rad_me_gusta.png" width="255">
              {% elsif creative_message._value == "carlhermommy_v4" and creative_variation._value == "ptsp347" %}
              <img src="https://storage.googleapis.com/peloton_creatives/carlhermomm_v4.png" width="255">
              {% elsif creative_message._value == "jay_torres_v2_30dt" and creative_variation._value == "ptsp325" %}
              <img src="https://storage.googleapis.com/peloton_creatives/jay_torres_v2_30dt.png" width="255">

              <!-- CAPTURE -->
              {% elsif creative_message._value == "emotional" and creative_variation._value == "ptsp294" %}
              <img src="https://storage.googleapis.com/peloton_creatives/emotional.png" width="255">
              {% elsif creative_message._value == "wherever_you_call_home" and creative_variation._value == "mjpaah6t502" %}
              <img src="https://storage.googleapis.com/peloton_creatives/wherever_you_call_home.png" width="255">
              {% elsif creative_message._value == "wherever_you_call_home_sku" and creative_variation._value == "mjpaah5m553" %}
              <img src="https://storage.googleapis.com/peloton_creatives/wherever_you_call_home.png" width="255">
              {% elsif creative_message._value contains "carlher" and creative_variation._value == "ptsp292" %}
              <img src="https://storage.googleapis.com/peloton_creatives/carl_her_mommy_.png" width="255">
              {% elsif creative_message._value == "camila_music" and creative_variation._value == "mjblar6t554" %}
              <img src="https://storage.googleapis.com/peloton_creatives/camila_music.png" width="255">
              {% elsif creative_message._value == "camila_music" and creative_variation._value == "mjblar6m554" %}
              <img src="https://storage.googleapis.com/peloton_creatives/camila_music.png" width="255">
              {% elsif creative_message._value == "camila_music" and creative_variation._value == "mjblar6m554" %}
              <img src="https://storage.googleapis.com/peloton_creatives/camila_music.png" width="255">
              {% elsif creative_message._value == "functional" and creative_variation._value == "ptsp293" %}
              <img src="https://storage.googleapis.com/peloton_creatives/functional.png" width="255">

              <!-- MID FUNNEL -->
              {% elsif creative_message._value == "camila_bangers" and creative_variation._value == "mjtlie5t114" %}
              <img src="https://storage.googleapis.com/peloton_creatives/camila_bangers.png" width="255">
              {% elsif creative_message._value == "jess_decision_fatigue" and creative_variation._value == "mjtcwy1m531" %}
              <img src="https://storage.googleapis.com/peloton_creatives/jess_decision_fatigue.png" width="255">
              {% elsif creative_message._value == "jess_power_walk" and creative_variation._value == "mjtcww3m120" %}
              <img src="https://storage.googleapis.com/peloton_creatives/jess_power_walk.png" width="255">
              {% elsif creative_message._value == "30dht_sp" and creative_variation._value == "ptsp354" %}
              <img src="https://storage.googleapis.com/peloton_creatives/30dht_sp.png" width="255">
              {% elsif creative_message._value == "armani_dex" and creative_variation._value == "mjamco3t514" %}
              <img src="https://storage.googleapis.com/peloton_creatives/armani_dex.png" width="255">

              <!-- ELSE -->
              {% else %}
              <img src="https://storage.googleapis.com/peloton_creatives/peloton_logo.png" height="170" width="170">
              {% endif %} ;;
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

  dimension: dimension_group {
    type: string
    sql:   CASE
        WHEN ${TABLE}.Dimension IN ('6s') THEN '6s'
        WHEN ${TABLE}.Dimension IN ('7s','8s', '9s', '10s', '11s', '12s','13s','14s','15s') THEN '7s-15s'
        WHEN ${TABLE}.Dimension IN ('16s','17s', '18s', '19s', '20s', '21s','22s','23s','24s') THEN '16s-24s'
        WHEN ${TABLE}.Dimension IN ('25s','26s', '27s', '28s', '29s', '30s') THEN '25s-30s'
        ELSE 'Others'
       END ;;
  }

  dimension: partner {
    type: string
    sql: ${TABLE}.Partner ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: clicks {
    type: sum
    sql: ${TABLE}.Clicks ;;
  }

  measure: filtered_clicks {
    type: sum
    sql: ${TABLE}.`Filtered Clicks` ;;
  }

  measure: filtered_impressions {
    type: sum
    sql: ${TABLE}.`Filtered Impressions` ;;
  }

  measure: impressions {
    type: sum
    sql: ${TABLE}.Impressions ;;
  }

  measure: paid_social_impressions {
    type: sum
    sql: ${TABLE}.`Paid Social Impressions` ;;
  }

  measure: qualified_visitors {
    type: sum
    sql: ${TABLE}.`Qualified Visitors` ;;
  }

  measure: spend {
    type: sum
    value_format_name: usd_0
    sql: ${TABLE}.Spend ;;
  }

  measure: cf_atcs {
    type: sum
    sql: ${TABLE}.`Total CF ATCs` ;;
  }

  measure: cf_sales {
    type: sum
    sql: ${TABLE}.`Total CF Sales` ;;
  }

  measure: sessions {
    type: sum
    sql: ${TABLE}.`Total Sessions` ;;
  }

  measure: video_views {
    type: sum
    sql: ${TABLE}.`Video Views` ;;
  }

  measure: youtube_impressions {
    type: sum
    sql: ${TABLE}.`YouTube Impressions` ;;
  }

  measure: 2_3_sec_video_views {
    type: sum
    sql: ${TABLE}.`2_3 sec video views` ;;
  }

  measure: amazon_video_1_p_page_views {
    type: sum
    sql: ${TABLE}.`Amazon Video 1P Page Views` ;;
  }

  measure: amazon_video_impressions {
    type: sum
    sql: ${TABLE}.`Amazon Video Impressions` ;;
  }

##---------------All efficiency metrics---------------------

##  o CTR = Filtered Clicks / Filtered Impressions
  measure: CTR {
    type: number
    value_format_name: percent_3
    sql: sum(${TABLE}.`Filtered Clicks`)/ sum(NULLIF(${TABLE}.`Filtered Impressions`,0)) ;;
  }

##  o CPM = Spend / Impressions * 1000
  measure: CPM {
    type: number
    value_format_name: usd
    sql: (sum( ${TABLE}.Spend)/ sum(NULLIF(${TABLE}.Impressions ,0))) * 1000 ;;
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



# Parameters Needed
## KPI Comparison 1
##  Impressions
##  Clicks
##  Spend
##  Total CF Sales
##  Total Sessions
##  Qualified Visitors
##  Bike Sales
##  Tread Sales

  parameter: KPI_A_Selector {
    type: unquoted
    allowed_value: {
      label: "Impressions"
      value: "impressions"
    }
    allowed_value: {
      label: "Clicks"
      value: "clicks"
    }
    allowed_value: {
      label: "CF Sales"
      value: "cf_sales"
    }
    allowed_value: {
      label: "Total Sessions"
      value: "total_sessions"
    }
  }

  measure: KPI_A {
    type: number
    sql:
    {% if KPI_A_Selector._parameter_value == 'impressions' %}
    ${impressions}
    {% elsif KPI_A_Selector._parameter_value == 'clicks' %}
    ${clicks}
    {% elsif KPI_A_Selector._parameter_value == 'cf_sales' %}
    ${cf_sales}
    {% else %}
    ${sessions}
    {% endif %};;

  }


  parameter: date_granularity {
    type: unquoted
    allowed_value: {
      label: "Break down by Day"
      value: "day"
    }
    allowed_value: {
      label: "Break down by Month"
      value: "month"
    }
    allowed_value: {
      label: "Break down by Week"
      value: "week"
    }
    }

  parameter: prior_weeks_back {
    type: unquoted
    allowed_value: {
      label: "1 Week"
      value: "INTERVAL 1 WEEK"
    }
    allowed_value: {
      label: "2 Weeks"
      value: "INTERVAL 2 WEEK"
    }
    allowed_value: {
      label: "3 Weeks"
      value: "INTERVAL 3 WEEK"
    }
    allowed_value: {
      label: "4 Weeks"
      value: "INTERVAL 4 WEEK"
    }
    allowed_value: {
      label: "5 Weeks"
      value: "INTERVAL 5 WEEK"
    }
    allowed_value: {
      label: "6 Weeks"
      value: "INTERVAL 6 WEEK"
    }


  }



  dimension: first_date_in_period {
    type: date
    sql: DATE_TRUNC(CURRENT_DATE(), {% parameter prior_weeks_back %});;
  }




## KPI Comparison 2
##  CTR
##  CPC
##  CPM
##  TSR
##  VVR
##  AMZ Vid RR
##  CF CVR
##  CF CAC
##  CF CPATC
##  CF ATC Rate
##  CPV
##
## Channel Contribution
##  Impressions
##  Clicks
##  Spend
##  CF Sales
##  CF ATCs
##  Total Sessions
##  Bike Sales
##  Tread Sales




}
