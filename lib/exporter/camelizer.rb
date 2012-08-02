class String
  def to_camelcase(first_letter_in_uppercase = true)
    if first_letter_in_uppercase
      self.
        gsub(/\/(.?)/) { "::#{$1.upcase}" }.
        gsub(/(?:^|_)(.)/) { $1.upcase }
    else
      camelized = self.to_camelcase
      camelized[0].chr.downcase + camelized[1..self.size-1]
    end
  end

  def camelcase!(first_letter_in_uppercase = true)
    self.replace(self.to_camelcase first_letter_in_uppercase)
  end

  def to_underscore
    self.split(/(?![a-z])(?=[A-Z])/).map{|s| s.downcase}.join('_')
  end
end
