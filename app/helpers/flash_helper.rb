module FlashHelper
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
