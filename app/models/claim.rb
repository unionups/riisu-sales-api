class Claim < ApplicationRecord
  include AASM
  resourcify
  belongs_to :place, autosave: true


  store_accessor :details, :talk_to_name, :talk_to_position, :talk_to_contact, :comment
  store_accessor :price, :place_price, :claim_price
  

  # after_initialize :initialize_defaults, :if => :new_record?

  before_create do
    throw :abort if self.place.claimed
    self.place_price = self.place.price
    self.place.update_attribute(:claimed, true)
  end
  
  aasm :user, column: :user_state, namespace: :user, logger: Rails.logger do
    state :started, initial: true
    state :canceled, enter: :mark_place_as_unclaimed!
    state :accepted
    state :declined #### ??? is need unclaim place?

    event :cancel do
      transitions from: :started, to: :canceled 
    end

    event :accept, binding_event: :start do
      transitions from: :started, to: :accepted 
    end

    event :decline, binding_event: :start do
      "p force decline"
      transitions from: :started, to: :declined
    end

  end

  aasm :admin, column: :admin_state, namespace: :admin,  logger: Rails.logger do
    state :pending, initial: true
    state :started
    state :accepted
    state :canceled, enter: :mark_place_as_unclaimed!

    event :start do
      transitions from: :pending, to: :started
    end 

    event :cancel do
      transitions from: [:pending, :started], to: :canceled
    end

    event :accept do
      transitions from: :started, to: :accepted
    end
  end

  private

  def mark_place_as_unclaimed!
    self.place.claimed = false
    self.place.save!
  end

end
