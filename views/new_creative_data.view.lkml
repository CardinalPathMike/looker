# The name of this view in Looker is "New Creative Data"
view: new_creative_data {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `cardinal-path.peloton.new_creative_data` ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "2 3 Sec Video Views" in Explore.

measure: 2_3_sec_video_views {
    type: sum
    sql: ${TABLE}.`2_3 sec video views` ;;
  }

  dimension: ad_type {
    type: string
    sql: ${TABLE}.`Ad Type` ;;
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

  measure: clicks {
    type: sum
    sql: ${TABLE}.Clicks ;;
  }

  dimension: creative_concept {
    type: string
    sql: ${TABLE}.`Creative Concept` ;;
  }

  dimension: creative_message {
    type: string
    sql: ${TABLE}.`Creative Message` ;;
  }

  dimension: dimension {
    type: string
    sql: ${TABLE}.Dimension ;;
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

  measure: spend {
    type: number
    sql: ${TABLE}.Spend ;;
    value_format_name: usd
  }

  measure: total_cf_atcs {
    type: sum
    sql: ${TABLE}.`Total CF ATCs` ;;
  }

  measure: total_cf_sales {
    type: sum
    sql: ${TABLE}.`Total CF Sales` ;;
    value_format_name:  usd
  }

  measure: total_sessions {
    type: sum
    sql: ${TABLE}.`Total Sessions` ;;
  }

  measure: video_views {
    type: sum
    sql: ${TABLE}.`Video Views` ;;
  }
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: week_of {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.`Week of Date` ;;
  }

  measure: youtube_impressions {
    type: sum
    sql: ${TABLE}.`Youtube Impressions` ;;
  }
  measure: count {
    type: count
  }
}
