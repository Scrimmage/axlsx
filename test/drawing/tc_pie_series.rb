require 'tc_helper.rb'

class TestPieSeries < Test::Unit::TestCase

  def setup
    p = Axlsx::Package.new
    @ws = p.workbook.add_worksheet :name=>"hmmm"
    chart = @ws.drawing.add_chart Axlsx::Pie3DChart, :title => "fishery"
    @series = chart.add_series :data=>[0,1,2], :labels=>["zero", "one", "two"], :title=>"bob"
  end

  def test_initialize
    assert_equal(@series.title.text, "bob", "series title has been applied")
    assert_equal(@series.labels.class, Axlsx::AxDataSource)
    assert_equal(@series.data.class, Axlsx::NumDataSource)
    assert_equal(@series.explosion, nil, "series shape has been applied")
  end

  def test_explosion
    assert_raise(ArgumentError, "require valid explosion") { @series.explosion = :lots }
    assert_nothing_raised("allow valid explosion") { @series.explosion = 20 }
    assert(@series.explosion == 20)
  end

  #TODO test unique serialization parts

end
