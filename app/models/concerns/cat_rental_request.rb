class CatRentalRequest < ApplicationRecord
   validates :status, inclusion: { in: ['PENDING', 'APPROVED', 'DENIED']}
   validates :cat_id, :status, :start_date, :end_date, presence: true
   validate :does_not_overlap_approved_request
   validate :start_date_must_come_before_end_date

  belongs_to :cat,
  foreign_key: :cat_id,
  class_name: 'Cat'

  def overlapping_approved_requests
     overlapping_requests.where(status: 'APPROVED')
  end

  def overlapping_pending_requests
     overlapping_requests.where(status: 'PENDING')
  end

  def does_not_overlap_approved_request
    return if overlapping_approved_requests.empty?
    errors[:start_date] << "Dates conflict with approved request"
  end

  def approve!
    CatRentalRequest.transaction do
      self.status = 'APPROVED'
      self.save!

    overlapping_pending_requests.update_all(status: 'DENIED')

    end
  end

  def deny!

    CatRentalRequest.transaction do
      self.status = "DENIED"
      self.save!
    end
  end

  private

  def start_date_must_come_before_end_date
    return if start_date < end_date
    errors[:start_date] << 'Start_date must come before end_date'
  end

  def overlapping_requests
      CatRentalRequest.where.not(id: self.id).where(cat_id: cat_id)
      .where.not('start_date > :end_date or end_date < :start_date', start_date: start_date, end_date: end_date)
  end

end
