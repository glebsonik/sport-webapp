class HashNilsSanitizer
  def self.sanitize_nils(hash)
    hash.select{|k,v| v.present?}
  end
end