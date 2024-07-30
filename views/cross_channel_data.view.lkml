# The name of this view in Looker is "Cross Channel Data"
view: cross_channel_data {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `peloton.cross_channel_data` ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called " Clicks " in Explore.

  measure: _clicks_ {
    type: sum
    sql: ${TABLE}.` Clicks ` ;;
  }

  dimension: _impressions_ {
    type: number
    sql: ${TABLE}.` Impressions ` ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total__impressions_ {
    type: sum
    sql: ${_impressions_} ;;  }
  measure: average__impressions_ {
    type: average
    sql: ${_impressions_} ;;  }

  measure: _spend_ {
    type: sum
    sql: ${TABLE}.` Spend ` ;;
    value_format_name: usd
    label: "Total Spend"
  }

  measure: _spend__scorecard {
    type: sum
    sql: ${TABLE}.` Spend ` ;;
    value_format: "0.0a"
    value_format_name: usd
    label: "Total Spend Scorecard"
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

  measure: total_cf_atcs {
    type: sum
    sql: ${TABLE}.`Total CF ATCs` ;;
    value_format: "0.00"
    label: "Total CF ATC"
  }

  measure: total_cf_sales {
    type: sum
    sql: ${TABLE}.`Total CF Sales` ;;
    value_format: "0.00"
    label: "Total CF Sales"
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
