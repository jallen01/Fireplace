module StringHelper
  def camel_to_underscore(str)
    str.gsub(/[a-zA-Z](?=[A-Z])/, '\0_').downcase
  end

  def camel_to_dash(str)
    str.gsub(/[a-zA-Z](?=[A-Z])/, '\0-').downcase
  end

  def camel_to_space(str)
    str.gsub(/[a-zA-Z](?=[A-Z])/, '\0 ')
  end
end