module RefundRequestHelper
  def filters_tag
    haml_tag :div, class: 'filters' do
      allowed_model_filters.each { |key, value| model_filter_button key, value }
      allowed_field_filters.each { |field| field_filter_button field }
    end
  end

  def add_filter_url(filter)
    refund_requests_path(params_plus(filter))
  end

  def params_without(param)
    params.slice(*allowed_params).except(param)
  end

  def params_plus(param)
    params.slice(*allowed_params).merge(param)
  end

  private

    def allowed_model_filters
      { Category => :title, User => :full_name }
    end

    def allowed_field_filters
      [:status]
    end

    def allowed_params
      allowed_model_filters.keys.map { |k| k.model_name.param_key } + allowed_field_filters
    end

    def model_filter_button(model_class, attr)
      param_key = model_class.model_name.param_key
      haml_tag :a, class: 'btn btn-xs btn-primary', type: 'button',
                   href: refund_requests_path(params_without(param_key)) do
        haml_concat "#{model_class.model_name.human}: "
        haml_tag :strong do
          haml_concat "#{model_class.find(params[param_key]).send attr}"
        end
        haml_tag :span, class: 'badge', style: 'font-size: 7pt' do
          haml_tag :span, class: 'glyphicon glyphicon-remove', 'aria-hidden': true
        end
      end if params[param_key].present?
    end

    def field_filter_button(field)
      param_key = field
      haml_tag :a, class: 'btn btn-xs btn-primary', type: 'button',
                   href: refund_requests_path(params_without(param_key)) do
        haml_concat "#{field}: "
        haml_tag :strong do
          haml_concat params[param_key]
        end
        haml_tag :span, class: 'badge', style: 'font-size: 7pt' do
          haml_tag :span, class: 'glyphicon glyphicon-remove', 'aria-hidden': true
        end
      end if params[param_key].present?
    end


end
