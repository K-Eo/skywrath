module TimeHelper
  def timeago(time, options = nil)
    options ||= {}
    tag = options.delete(:tag) || :time
    options[:title] = options[:datetime] = time.iso8601
    options[:class] = join_classes(options[:class], "timeago")
    content_tag tag, nil, options
  end

private

  def join_classes(source, additional)
    classes = source || ""
    classes = classes.split(" ")

    (additional || "").split(" ").each do |klass|
      classes.unshift(klass)
    end

    classes.join(" ")
  end
end
