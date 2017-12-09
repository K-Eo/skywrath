module FlashHelper
  def normalize_flash(key)
    if key.nil?
      return "alert-info"
    end

    if key.is_a?(String)
      key = key.to_sym
    elsif !key.is_a?(Symbol)
      return "alert-info"
    end

    case key
    when :notice
      return "alert-success"
    when :success
      return "alert-success"
    when :alert
      return "alert-danger"
    when :error
      return "alert-danger"
    else
      return "alert-#{key.to_s}"
    end
  end
end
