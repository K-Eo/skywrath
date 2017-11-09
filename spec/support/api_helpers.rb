module ApiHelpers
  def api(path, user = nil)
    full_path = "/api/v1#{path}"

    if user && user.respond_to?(:access_token)
      query_string = "access_token=#{user.access_token}"
    end

    if query_string
      full_path << (path.index("?") ? "&" : "?")
      full_path << query_string
    end

    full_path
  end

  def json_response
    JSON.parse(response.body)
  end
end
