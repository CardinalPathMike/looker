# Define the database connection to be used for this model.
connection: "peloton"

# include all the views
include: "/views/**/*.view.lkml"

# Datagroups define a caching policy for an Explore. To learn more,
# use the Quick Help panel on the right to see documentation.

datagroup: peloton_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: peloton_default_datagroup

# Explores allow you to join together different views (database tables) based on the
# relationships between fields. By joining a view into an Explore, you make those
# fields available to users for data analysis.
# Explores should be purpose-built for specific use cases.

# To see the Explore you’re building, navigate to the Explore menu and select an Explore under "Peloton"

# To create more sophisticated Explores that involve multiple views, you can use the join parameter.
# Typically, join parameters require that you define the join type, join relationship, and a sql_on clause.
# Each joined view also needs to define a primary key.

explore: cross_channel {
#---- This is an example explore file



#---- Add in this sql_always_where clause replacing your_view_name
  sql_always_where:
  {% if cross_channel.current_date_range._is_filtered %}
    {% condition cross_channel.current_date_range %} ${event_raw} {% endcondition %}

    {% if cross_channel.previous_date_range._is_filtered or cross_channel.compare_to._in_query %}
    {% if cross_channel.comparison_periods._parameter_value == "2" %}
    or
    ${event_raw} between ${period_2_start} and ${period_2_end}

    {% elsif cross_channel.comparison_periods._parameter_value == "3" %}
    or
    ${event_raw} between ${period_2_start} and ${period_2_end}
    or
    ${event_raw} between ${period_3_start} and ${period_3_end}


    {% elsif cross_channel.comparison_periods._parameter_value == "4" %}
    or
    ${event_raw} between ${period_2_start} and ${period_2_end}
    or
    ${event_raw} between ${period_3_start} and ${period_3_end}
    or
    ${event_raw} between ${period_4_start} and ${period_4_end}

    {% else %} 1 = 1
    {% endif %}
    {% endif %}
    {% else %} 1 = 1
    {% endif %};;

}

explore: creative_data {}
