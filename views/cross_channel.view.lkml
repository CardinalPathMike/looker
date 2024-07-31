# The name of this view in Looker is "New Cross Channel"
view: cross_channel {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `cardinal-path.peloton.new_cross_channel` ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "2 3 Sec Video Views" in Explore.

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.


  dimension_group: date {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.Date ;;
  }

  dimension_group: week {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.Week ;;
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

### Measures

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

## ----------All raw metrics --------
## Impressions


  measure: clicks {
    type: sum
    sql: ${TABLE}.` Clicks ` ;;
  }

  measure: impressions {
    type: sum
    sql: CAST(${TABLE}.` Impressions ` as INT64) ;;
  }

  measure: spend {
    type: sum
    sql: ${TABLE}.` Spend ` ;;
    value_format_name: usd
  }


  measure: filtered_clicks {
    type: number
    sql: ${TABLE}.`Filtered Clicks` ;;
  }

  measure: filtered_impressions {
    type: number
    sql: ${TABLE}.`Filtered Impressions` ;;
  }

##  Total CF ATCs (Add to Carts)
  measure: total_cf_atcs {
    type: sum
    sql: ${TABLE}.`Total CF ATCs` ;;
  }

## Total CF Sales
  measure: total_cf_sales {
    type: sum
    sql: ${TABLE}.`Total CF Sales` ;;
    value_format_name:  usd
  }

## Total Sessions
  measure: total_sessions {
    type: sum
    sql: ${TABLE}.`Total Sessions` ;;
  }



  measure: paid_social_impressions {
    type: sum
    sql: ${TABLE}.`Paid Social Impressions` ;;
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

  measure: app_30_dt {
    type: sum
    sql: ${TABLE}.`App 30Dt` ;;
  }

  measure: app_one_30_dt {
    type: sum
    sql: ${TABLE}.`App One 30Dt` ;;
  }

  measure: app_plus_30_dt {
    type: sum
    sql: ${TABLE}.`App Plus 30Dt` ;;
  }

  measure: total_app_installs {
    type: sum
    sql: ${TABLE}.`Total App Installs` ;;
  }

  measure: video_views {
    type: sum
    sql: ${TABLE}.`Video Views` ;;
  }

  measure: you_tube_impressions {
    type:sum
    sql: ${TABLE}.`YouTube Impressions` ;;
  }

  measure: count {
    type: count
  }


##---------------All efficiency metrics---------------------

##  o CTR = Filtered Clicks / Filtered Impressions
  measure: CTR {
    type: number
    value_format_name: percent_2
    sql: ${filtered_clicks}/ NULLIF(${filtered_impressions},0) ;;
  }

##  o CPM = Spend / Impressions * 1000
  measure: CPM {
    type: number
    value_format_name: usd
    sql: (${spend}/ NULLIF(${impressions},0)) * 1000 ;;
  }

##  o YouTube VVR = Video Views / YouTube Impressions
  measure: YouTubeVVR {
    type: number
    value_format_name: percent_2
    sql: ${video_views}/ NULLIF(${you_tube_impressions},0) ;;
  }


##  o Amazon Vid RR = Amazon Video 1P Page Views / Amazon Video Impressions
  measure: AmazonVRR {
    type: number
    value_format_name: percent_2
    sql: ${amazon_video_1_p_page_views}/ NULLIF(${amazon_video_impressions},0) ;;
  }


##  o Social TSR = 2/3 sec video views / Paid Social Impressions
  measure: SocialTSR {
    type: number
    value_format_name: percent_2
    sql: ${2_3_sec_video_views}/ NULLIF(${paid_social_impressions},0) ;;
  }

## CF CAC, CF CPATC, CPI, CPT, CPV are all $ values
##  o CF CAC = spend / Total CF Sales
  measure: CF_CAC {
    type: number
    value_format_name: usd
    sql: ${spend}/ NULLIF(${total_cf_sales},0) ;;
  }

##  o CF CVR = Total CF Sales / Clicks
  measure: CF_CVR {
    type: number
    value_format_name: percent_2
    sql: ${total_cf_sales}/ NULLIF(${clicks},0) ;;
  }

##  o CF CPATC = Spend / Total CF ATCs
  measure: CF_CPATC {
    type: number
    value_format_name: usd
    sql: ${spend}/ NULLIF(${total_cf_atcs},0) ;;
  }

##  o CF ATC Rate = Total CF ATCs / Clicks
  measure: CF_ATC_Rate {
    type: number
    value_format_name: percent_2
    sql: ${total_cf_atcs}/ NULLIF(${clicks},0) ;;
  }

##  o CPV = Spend / Total Sessions
  measure: CPV {
    type: number
    value_format_name: usd
    sql: ${spend}/ NULLIF(${total_sessions},0) ;;
  }

##--------------Metrics specific to funnel level---------------------------
##----- Upper funnel (creation) engagement metric KPIs -------------------

##  o YouTube VVR = Video Views / YouTube Impressions
  measure: YouTube_VVR {
    type: number
    value_format_name: percent_2
    sql: ${video_views}/ NULLIF(${you_tube_impressions},0) ;;
  }

##  o Amazon Vid RR = Amazon Video 1P Page Views / Amazon Video Impressions
  measure: Amazon_VRR{
    type: number
    value_format_name: percent_2
    sql: ${amazon_video_1_p_page_views}/ NULLIF(${amazon_video_impressions},0) ;;
  }

##  o Social TSR = 2/3 sec video views / Paid Social Impressions
  measure: Social_TSR{
    type: number
    value_format_name: percent_2
    sql: ${2_3_sec_video_views}/ NULLIF(${paid_social_impressions},0) ;;
  }

##------------------ Mid funnel KPIs -------------------------------------
##  o CPV = Spend / Total Sessions
## Already Above

##------------- Lower funnel (capture) KPIs ------------------------------
##  o CF CAC = Spend / Total CF Sales - Above
##  o CF CVR = Total CF Sales / Clicks - Above
##  o CF CPATC = Spend / Total CF ATCs - Above
##  o CF ATC Rate = Total CF ATCs / Clicks - Above

## ---------------- App metrics ------------------------------------------
##• All raw metrics:
##  o Impressions
##  o Clicks
##  o Spend
##  o Total App Installs
##  o App 30DT
##  o App One 30DT
##  o App Plus 30DT
##  o Total Sessions



## -------------- All efficiency metrics -----------------------------

##  o CTR = Filtered Clicks / Filtered Impressions
##  o CPM = Spend / Impressions * 1000

##  o CPI = Spend / Total App Installs
  measure: CPI {
    type: number
    value_format_name: usd
    sql: ${spend}/ NULLIF(${total_app_installs},0) ;;
  }

##  o Install CVR = Total App Installs / Clicks
  measure: Install_CVR {
    type: number
    value_format_name: percent_2
    sql: ${total_app_installs}/ NULLIF(${clicks},0) ;;
  }

##  o CPT = Spend / App 30DT
  measure: CPT {
    type: number
    value_format_name: usd
    sql: ${spend}/ NULLIF(${app_30_dt},0) ;;
  }

##  o Trial CVR = App 30DT / Clicks
  measure: Trial_CVR {
    type: number
    value_format_name: percent_2
    sql: ${app_30_dt}/ NULLIF(${clicks},0) ;;
  }


}
