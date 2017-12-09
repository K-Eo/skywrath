class BootstrapFormBuilder < ActionView::Helpers::FormBuilder
  delegate :content_tag, :concat, to: :@template

  %w[text_field text_area password_field email_field phone_field].each do |method_name|
    define_method(method_name) do |name, *args|
      input_args = append_input_classes(name, *args)
      content_tag :div, class: "form-group" do
        concat field_label(name, *args)
        concat super(name, *input_args)
        concat helper_label(name, *args)
        concat errors(name)
      end
    end
  end

  def check_box(name, *args)
    content_tag :div, class: "form-check" do
      label(name, class: "form-check-label") do
        concat super(name, class: "form-check-input")
        concat name.to_s.humanize
      end
    end
  end

  def submit(*args)
    options = args.extract_options!
    block = options.delete(:block) || false
    classes = options[:class] || ""

    classes = classes.split(" ")
    classes.push("btn", "btn-primary")
    classes.push("btn-block") if block
    options[:class] = classes.join(" ")

    args.push(options)
    content_tag :div, class: "form-group" do
      super(*args)
    end
  end

private

  def append_input_classes(name, *args)
    options = args.extract_options!
    classes = options[:class] || ""

    classes = classes.split(" ")
                     .push("form-control")

    classes << "is-invalid" if has_error?(name)
    options[:class] = classes.join(" ")
    args.push(options)
  end

  def errors(name)
    if has_error?(name)
      content_tag :div,
                  @object.errors[name].last,
                  class: "invalid-feedback"
    end
  end

  def has_error?(name)
    @object.errors[name].any?
  end

  def helper_label(name, *args)
    options = args.extract_options!
    if options[:helper].present? && !has_error?(name)
      content_tag :small, options[:helper], class: "form-text text-muted"
    end
  end

  def field_label(name, *args)
    options = args.extract_options!
    label name, options[:label]
  end

  def objectify_options(options)
    super.except(:label, :helper, :block)
  end
end
