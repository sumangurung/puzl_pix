require 'arel'
module Challenges
  def self.fetch(fb_id)
    challengees_table = Arel::Table.new(Challengee.table_name)
    Challenge.joins(:challengees)
      .where(challengees_table[:fb_id].eq(fb_id))
  end

  def self.create!(params)
    attributes = params.dup
    challengees = attributes.delete(:challengees) || []

    challenge = Challenge.new(attributes)
    challengees.each do |challengee_id|
      challenge.challengees.build(fb_id: challengee_id)
    end
    challenge.save!
    ChallengeNotifier.notify(challenge)
  end

  def self.challenges
    @challenges ||= []
  end
  private_class_method :challenges
end
