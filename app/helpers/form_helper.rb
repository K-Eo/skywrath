module FormHelper
  def semantic_form_for(object, options = {}, &block)
    options[:builder] = SemanticFormBuilder
    options[:html] ||= {}
    classes = options[:html][:class] || ""

    options[:html][:class] = classes.split(" ")
                                    .unshift("ui", "form")
                                    .join(" ")

    form_for(object, options, &block)
  end
end
