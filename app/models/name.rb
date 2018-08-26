class Name < ApplicationRecord
  scope :roman_letter_like, lambda { |initial| where("roman_letter like :initial", initial: initial + '%') }
  extend Enumerize

  enumerize :sex, in: [:male, :female], scope: true

  def self.choose_name(original_name, birth_date, sex)
    row_num = (birth_date.year + birth_date.month + birth_date.day)

    if with_sex(sex).roman_letter_like(original_name[0..1]).present?
      candidates = with_sex(sex).roman_letter_like(original_name[0..1])
      logger.debug "プライオリティ1"
      return candidates[row_num % candidates.count]
    end

    if with_sex(sex).roman_letter_like(original_name[0]).present?
      logger.debug "プライオリティ2"
      candidates = with_sex(sex).roman_letter_like(original_name[0])
      return candidates[row_num % candidates.count]
    end

    candidates = with_sex(sex)
    logger.debug "プライオリティ3"
    candidates[row_num % candidates.count]
  end
end
