module ApplicationHelper
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
end
