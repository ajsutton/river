# -*- encoding : utf-8 -*-
class HashSerializer
  def self.dump(hash_array)
    JSON.dump(hash_array)
  end

  def self.load(hash_array)
    if hash_array.is_a? Array
      (hash_array || []).map { |x| x.with_indifferent_access }
    else
      hash_array
    end
  end
end
