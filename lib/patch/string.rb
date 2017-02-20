class String
  def untitleize
    downcase.gsub(/\s/, '_')
  end
end
