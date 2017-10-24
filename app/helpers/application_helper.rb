module ApplicationHelper
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

  def field_has_error?(resource, key)
    if resource.nil? || resource.errors.nil?
      return false
    end

    unless resource.errors.key?(key)
      return false
    end

    resource.errors[key].any?
  end

  def field_error_message(resource, key, tag, options = nil)
    options ||= {}
    classes = options[:class] || ""

    options[:class] = classes
                      .split(" ")
                      .push("field_error_message")
                      .join(" ")

    if field_has_error?(resource, key)
      content_tag tag, resource.errors[key].first, options
    end
  end

  def field_error(resource, key)
    return "error" if field_has_error?(resource, key)
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
