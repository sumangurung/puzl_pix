require 'arel'
module Challenges
  def self.fetch(fb_id)
    challengees_table = Arel::Table.new(Persistence::Challengee.table_name)
    Persistence::Challenge.joins(:challengees)
      .where(challengees_table[:fb_id].eq(fb_id))
  end

  def self.create!(params)
    challenge = Challenge.new(params.with_indifferent_access)
    Persistence::Challenge.save!(challenge)
    ChallengeNotifier.notify(challenge)
  end

  def self.challenges
    @challenges ||= []
  end
  private_class_method :challenges
end
