RSpec::Matchers.define :have_content_type do |expected|
  match do |actual|
    actual.content_type == expected rescue false
  end

  description do
    "respond with content type \"#{expected}\""
  end

  failure_message do |actual|
    "expected \"#{actual.content_type}\" to have \"#{expected}\""
  end

  failure_message_when_negated do |actual|
    "expected \"#{actual.content_type}\" not to have \"#{expected}\""
  end
end
