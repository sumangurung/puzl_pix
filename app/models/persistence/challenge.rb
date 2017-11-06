module Persistence
  class Challenge < ActiveRecord::Base
    def self.save!(challenge)
      attributes = challenge.attributes.dup
      challengees = attributes.delete(:challengees)

      challenge_ar = new(attributes)
      challengees.each do |challengee_id|
        challenge_ar.challengees.build(fb_id: challengee_id)
      end
      challenge_ar.save!
    end

    has_many :challengees, class_name: "Challengee"
  end
end
