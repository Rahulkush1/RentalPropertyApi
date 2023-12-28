class Avo::Dashboards::MyDashboard < Avo::Dashboards::BaseDashboard
  self.id = "my_dashboard"
  self.name = "Dashy"
  self.description = "Tiny dashboard description"
  self.grid_cols = 3
  self.visible = -> do
    true
  end

  # def cards
  #   card Avo::Cards::ExampleMetric
  #   card Avo::Cards::ExampleAreaChart
  #   card Avo::Cards::ExampleScatterChart
  #   card Avo::Cards::PercentDone
  #   card Avo::Cards::AmountRaised
  #   card Avo::Cards::ExampleLineChart
  #   card Avo::Cards::ExampleColumnChart
  #   card Avo::Cards::ExamplePieChart
  #   card Avo::Cards::ExampleBarChart
  #   divider label: "Custom partials"
  #   card Avo::Cards::ExampleCustomPartial
  #   card Avo::Cards::MapCard
  # end
end
