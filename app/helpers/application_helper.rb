module ApplicationHelper

  def flash_class(level)
    case level
    when :notice then "alert alert-info"
    when :success then "alert alert-success"
    when :error then "alert alert-error"
    when :alert then "alert alert-error"
    end
  end
  def errors_for(form, field)
    content_tag(:p, form.object.errors[field].try(:first), class: 'help-block')
  end

  def form_group_for(form, field, opts={}, &block)
    label = opts.fetch(:label) { true }
    has_errors = form.object.errors[field].present?

    content_tag :div, class: "form-group #{'has-error' if has_errors}" do
      concat form.label(field, class: 'control-label') if label
      concat capture(&block)
      #concat errors_for(form, field)
    end
  end
  def build_refer_link(position)
    users_sign_up_url(refered_name: current_user.username, position: position)
  end
  def plan_polymorphic_path(id)
    (controller.controller_name == "buy_plans" || current_user.adapter.can_upgrade_url?(id.to_s)) && send("#{controller.controller_name.singularize}_url", id, subdomain: 'office') || "#"
  end
end
