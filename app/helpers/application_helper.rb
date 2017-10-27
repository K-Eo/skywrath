module ApplicationHelper
  def semantic_form_for(object, options = {}, &block)
    options[:builder] = SemanticFormBuilder

    if options[:html].present?
      options[:html][:class] = "ui form"
    else
      options[:html] = { class: "ui form" }
    end

    form_for(object, options, &block)
  end

  def active_link_to(name, path, options = nil)
    options ||= {}
    controller = options[:controller] || path

    classes = (options[:class] || "").split(" ")
    classes.push("active") if controller.include?(controller_name)
    options[:class] = classes.join(" ")

    link_to(name, path, options)
  end

  def gravatar(object, args = {})
    options = {
      d: args.fetch(:d, "retro"),
      s: args.fetch(:height, "80")
    }

    args.delete(:d)

    hash = Digest::MD5.hexdigest(object.email)
    image_tag "https://www.gravatar.com/avatar/#{hash}?#{options.to_query}", args
  end

  def normalize_flash(key)
    if key.nil?
      return "info"
    end

    if key.is_a?(String)
      key = key.to_sym
    elsif !key.is_a?(Symbol)
      return "info"
    end

    case key
    when :notice
      return "success"
    when :success
      return "success"
    when :alert
      return "error"
    when :error
      return "error"
    else
      return key.to_s
    end
  end
end
