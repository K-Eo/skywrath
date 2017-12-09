module ApplicationHelper
  def state_class(alert)
    case alert.state
    when "opened"
      state = "success"
    when "closed"
      state = "danger"
    else
      state = "warning"
    end

    "text-#{state}"
  end

  def active_link_to(name, path, options = nil)
    options ||= {}
    controller = options.delete(:controller) || path

    classes = (options[:class] || "").split(" ")
    classes.push("active") if controller.include?(controller_name)
    options[:class] = classes.join(" ") if classes.any?

    link_to(name, path, options)
  end

  def alert_icon(alert)
    classes = ["ui", "tiny", "circular", "label"]

    if alert.state == "opened"
      classes << "green"
    else
      classes << "red"
    end

    classes = classes.join(" ")

    content_tag :span, class: classes do
      content_tag :i, nil, class: "warning icon"
    end
  end

  def gravatar(user, args = {})
    return "" if user.nil?

    options = {
      d: args.delete(:display) || "retro",
      s: args.delete(:size) || "80"
    }

    args[:alt] = args.delete(:alt) ||
                 (user.name || user.email)[0, 1].upcase
    args[:width] = options[:s]
    args[:height] = options[:s]

    hash = Digest::MD5.hexdigest(user.email)
    image_tag "https://www.gravatar.com/avatar/#{hash}?#{options.to_query}", args
  end
end
