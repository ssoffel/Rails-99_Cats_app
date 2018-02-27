class Cat < ApplicationRecord
  validates :color, inclusion: {in: ['black', 'white', 'gray', 'red', 'brown', 'green', 'purple']}
  validates :sex, inclusion: {in: ['M', 'F']}
  validates :birth_date, :name, :color, :sex,  presence: true


  def age
    date.new.year - self.birth_date.year
  end

  has_many :requests,
  foreign_key: :cat_id,
  class_name: 'CatRentalRequest'
 

end
