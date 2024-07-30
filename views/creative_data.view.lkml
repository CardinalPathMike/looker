# The name of this view in Looker is "Creative Data"
view: creative_data {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `peloton.creative_data` ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "2 3 Sec Video Views" in Explore.

  dimension: 2_3_sec_video_views {
    type: number
    sql: ${TABLE}.`2_3 sec video views` ;;
  }

  dimension: ad_type {
    type: string
    sql: ${TABLE}.`Ad Type` ;;
  }

  dimension: amazon_video_1_p_page_views {
    type: number
    sql: ${TABLE}.`Amazon Video 1P Page Views` ;;
  }

  dimension: amazon_video_rr {
    type: number
    sql: ${TABLE}.`Amazon Video RR` ;;
  }

  dimension: atc_rate {
    type: number
    sql: ${TABLE}.`ATC Rate` ;;
  }

  dimension: business {
    type: string
    sql: ${TABLE}.Business ;;
  }

  dimension: cf_cvr {
    type: number
    sql: ${TABLE}.`CF CVR` ;;
  }

  dimension: channel {
    type: string
    sql: ${TABLE}.Channel ;;
  }

  dimension: clicks {
    type: number
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

  dimension: ctr {
    type: number
    sql: ${TABLE}.CTR ;;
  }

  dimension: dimension {
    type: string
    sql: ${TABLE}.Dimension ;;
  }

  dimension: funnel {
    type: string
    sql: ${TABLE}.Funnel ;;
  }

  dimension: impressions {
    type: number
    sql: ${TABLE}.Impressions ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_impressions {
    type: sum
    sql: ${impressions} ;;  }
  measure: average_impressions {
    type: average
    sql: ${impressions} ;;  }

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

  dimension: spend {
    type: number
    sql: ${TABLE}.Spend ;;
  }

  dimension: total_cf_atcs {
    type: number
    sql: ${TABLE}.`Total CF ATCs` ;;
  }

  dimension: total_cf_sales {
    type: number
    sql: ${TABLE}.`Total CF Sales` ;;
  }

  dimension: tsr {
    type: number
    sql: ${TABLE}.TSR ;;
  }

  dimension: video_views {
    type: number
    sql: ${TABLE}.`Video Views` ;;
  }

  dimension: vvr {
    type: number
    sql: ${TABLE}.VVR ;;
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
  measure: count {
    type: count
  }
}
