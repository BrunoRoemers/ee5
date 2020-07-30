module FilterHelper
  def stays_status_filter_opts(selected = nil)
    opts = [
      ['show all', 'all'],
      ['show active', 'active'],
      ['show history', 'not-active']
    ]

    options_for_select(opts, selected || opts[0][0])
  end

  def people_status_filter_opts(selected = nil)
    opts = [
      ['show all', 'all'],
      ['show patients', 'patients'],
      ['show care takers', 'care-takers']
    ]

    options_for_select(opts, selected || opts[0][0])
  end
end
