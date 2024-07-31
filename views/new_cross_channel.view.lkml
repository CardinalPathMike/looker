# The name of this view in Looker is "New Cross Channel"
view: new_cross_channel {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `cardinal-path.peloton.new_cross_channel` ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "2 3 Sec Video Views" in Explore.

  measure: 2_3_sec_video_views {
    type: sum
    sql: ${TABLE}.`2_3 sec video views` ;;
  }

  measure: _clicks_ {
    type: sum
    sql: ${TABLE}.` Clicks ` ;;
  }

  measure: _impressions_ {
    type: sum
    sql: ${TABLE}.` Impressions ` ;;
  }

  measure: _spend_ {
    type: sum
    sql: ${TABLE}.` Spend ` ;;
    value_format_name: usd
  }

  measure: amazon_video_1_p_page_views {
    type: sum
    sql: ${TABLE}.`Amazon Video 1P Page Views` ;;
  }

  measure: amazon_video_impressions {
    type: sum
    sql: ${TABLE}.`Amazon Video Impressions` ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_amazon_video_impressions {
    type: sum
    sql: ${amazon_video_impressions} ;;  }
  measure: average_amazon_video_impressions {
    type: average
    sql: ${amazon_video_impressions} ;;  }

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
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: date {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.Date ;;
  }

  dimension: filtered_clicks {
    type: number
    sql: ${TABLE}.`Filtered Clicks` ;;
  }

  dimension: filtered_impressions {
    type: number
    sql: ${TABLE}.`Filtered Impressions` ;;
  }

  dimension: lob {
    type: string
    sql: ${TABLE}.LOB ;;
  }

  dimension: market {
    type: string
    sql: ${TABLE}.Market ;;
  }

  measure: paid_social_impressions {
    type: sum
    sql: ${TABLE}.`Paid Social Impressions` ;;
  }

  dimension: partner {
    type: string
    sql: ${TABLE}.Partner ;;
  }

  measure: total_app_installs {
    type: sum
    sql: ${TABLE}.`Total App Installs` ;;
  }

  measure: total_cf_atcs {
    type: sum
    sql: ${TABLE}.`Total CF ATCs` ;;
  }

  measure: total_cf_sales {
    type: sum
    sql: ${TABLE}.`Total CF Sales` ;;
  }

  measure: total_sessions {
    type: sum
    sql: ${TABLE}.`Total Sessions` ;;
  }

  measure: video_views {
    type: sum
    sql: ${TABLE}.`Video Views` ;;
  }

  dimension_group: week {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.Week ;;
  }

  measure: you_tube_impressions {
    type:sum
    sql: ${TABLE}.`YouTube Impressions` ;;
  }
  measure: count {
    type: count
  }
}
