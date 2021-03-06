Feature: Add a chart
  In order to include custom charts in a presentation
  As a developer using python-pptx
  I need a way to add a chart to a slide, specifying its type and data


  Scenario Outline: Add a category chart
    Given a blank slide
     When I add a <type> chart with <cats> categories and <sers> series
     Then chart.chart_type is <chart-type>
      And len(plot.categories) is <cats>
      And len(chart.series) is <sers>
      And len(series.values) is <cats> for each series
      And the chart has an Excel data worksheet

    Examples: Chart specs
      | type                      | chart-type               | cats | sers |
      | Area                      | AREA                     |   3  |   3  |
      | Stacked Area              | AREA_STACKED             |   3  |   3  |
      | 100% Stacked Area         | AREA_STACKED_100         |   3  |   3  |
      | Clustered Bar             | BAR_CLUSTERED            |   3  |   3  |
      | Stacked Bar               | BAR_STACKED              |   3  |   3  |
      | 100% Stacked Bar          | BAR_STACKED_100          |   3  |   3  |
      | Clustered Column          | COLUMN_CLUSTERED         |   3  |   3  |
      | Stacked Column            | COLUMN_STACKED           |   3  |   3  |
      | 100% Stacked Column       | COLUMN_STACKED_100       |   3  |   3  |
      | Doughnut                  | DOUGHNUT                 |   5  |   1  |
      | Exploded Doughnut         | DOUGHNUT_EXPLODED        |   5  |   1  |
      | Line                      | LINE                     |   3  |   2  |
      | Line with Markers         | LINE_MARKERS             |   3  |   2  |
      | Line Markers Stacked      | LINE_MARKERS_STACKED     |   3  |   2  |
      | 100% Line Markers Stacked | LINE_MARKERS_STACKED_100 |   3  |   2  |
      | Line Stacked              | LINE_STACKED             |   3  |   2  |
      | 100% Line Stacked         | LINE_STACKED_100         |   3  |   2  |
      | Pie                       | PIE                      |   5  |   1  |
      | Exploded Pie              | PIE_EXPLODED             |   5  |   1  |
      | Radar                     | RADAR                    |   5  |   2  |
      | Filled Radar              | RADAR_FILLED             |   5  |   2  |
      | Radar with markers        | RADAR_MARKERS            |   5  |   2  |


  Scenario: Add a multi-level category chart
    Given a blank slide
     When I add a Clustered bar chart with multi-level categories
     Then chart.chart_type is BAR_CLUSTERED
      And len(plot.categories) is 4
      And the chart has an Excel data worksheet


  Scenario Outline: Add an XY chart
    Given a blank slide
     When I add an <chart-type> chart having 2 series of 3 points each
     Then chart.chart_type is <chart-type>
      And len(chart.series) is 2
      And len(series.values) is 3 for each series
      And the chart has an Excel data worksheet

    Examples: Chart specs
      | chart-type                   |
      | XY_SCATTER                   |
      | XY_SCATTER_LINES             |
      | XY_SCATTER_LINES_NO_MARKERS  |
      | XY_SCATTER_SMOOTH            |
      | XY_SCATTER_SMOOTH_NO_MARKERS |


  Scenario Outline: Add a bubble chart
    Given a blank slide
     When I add a <chart-type> chart having 2 series of 3 points each
     Then chart.chart_type is <chart-type>
      And len(chart.series) is 2
      And len(series.values) is 3 for each series
      And the chart has an Excel data worksheet

    Examples: Chart specs
      | chart-type            |
      | BUBBLE                |
      | BUBBLE_THREE_D_EFFECT |
