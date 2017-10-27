class SemanticFormBuilder < ActionView::Helpers::FormBuilder
  delegate :content_tag, :concat, to: :@template

  %w[text_field text_area password_field email_field].each do |method_name|
    define_method(method_name) do |name, *args|
      content_tag :div, class: field_classes(name) do
        concat field_label(name, *args)
        concat super(name, *args)
        concat helper_label(name, *args)
        concat errors(name)
      end
    end
  end

  def check_box(name, *args)
    content_tag :div, class: "field" do
      content_tag :div, class: "ui checkbox" do
        concat super(name)
        concat label(name)
      end
    end
  end

  def submit(*args)
    options = args.extract_options!
    options[:class] ||= ""
    options[:class] = options[:class].split(" ")
                                     .push("ui fluid positive button")
                                     .join(" ")
    args.push(options)
    content_tag :div, class: "field" do
      super(*args)
    end
  end

private

  def field_classes(name)
    classes = "field"
    classes << " error" if has_error?(name)
    classes
  end

  def errors(name)
    if has_error?(name)
      content_tag :span,
                  @object.errors[name].last,
                  class: "error block"
    end
  end

  def has_error?(name)
    @object.errors[name].any?
  end

  def helper_label(name, *args)
    options = args.extract_options!
    if options[:helper].present? && !has_error?(name)
      content_tag :span, options[:helper], class: "helper block"
    end
  end

  def field_label(name, *args)
    options = args.extract_options!
    label name, options[:label]
  end

  def objectify_options(options)
    super.except(:label, :helper)
  end
end
