view: cross_channel_custom_timeframe {

  sql_table_name: `cardinal-path.peloton.combined_peloton_rfi` ;;

## Dimensions

    dimension_group: date {
      type: time
      timeframes: [raw, time, date]
      sql: TIMESTAMP(${TABLE}.Date) ;;
    }

  measure: spend {
    type: sum
    value_format_name: usd_0
    sql: ${TABLE}.Spend ;;
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

  ## filtered measure A
  measure: count_a {
    type: sum
    value_format_name: usd_0
    sql: ${TABLE}.Spend ;;
    filters: [group_a_yesno: "yes"]
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

  measure: count_b {
    type: sum
    value_format_name: usd_0
    sql: ${TABLE}.Spend ;;
    filters: [group_b_yesno: "yes"]
  }

  dimension: is_in_time_a_or_b {
    group_label: "Time Comparison Filters"
    type: yesno
    sql:
      {% condition timeframe_a %} ${date_raw} {% endcondition %} OR
      {% condition timeframe_b %} ${date_raw} {% endcondition %} ;;
  }

}
