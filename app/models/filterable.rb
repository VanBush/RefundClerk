module Filterable
  def filter(params)
    @results = self.all
    allowed_filters.each do |f|
      val = params[f]
      val = defined_enums[f.to_s][val] if defined_enums.has_key? f.to_s
      @results.where!(f => val) if val.present?
    end
    @results
  end
end
