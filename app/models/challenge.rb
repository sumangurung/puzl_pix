class Challenge < ActiveRecord::Base
  has_many :challengees, class_name: "Challengee"
end
