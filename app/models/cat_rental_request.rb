# == Schema Information
#
# Table name: cat_rental_requests
#
#  id         :integer          not null, primary key
#  cat_id     :integer          not null
#  start_date :date             not null
#  end_date   :date             not null
#  status     :string
#

class CatRentalRequest < ActiveRecord::Base
  validates :cat_id, :start_date, :end_date, presence: true
  validates :status, inclusion: { in: %w( PENDING APPROVED DENIED ) }
  validate :approved_overlapping_requests_validation
  after_initialize :pending_status
  belongs_to :cat
  has_many :rental_requests, through: :cat, source: :cat_rental_requests

  def other_rental_requests
    if self.persisted?
      rental_requests.where('cat_rental_requests.id != ?', self.id)
    else
      rental_requests
    end
  end

  def overlapping_requests
    other_rental_requests.where(<<-SQL, start_date: self.start_date, end_date: self.end_date)
         ( (:start_date BETWEEN start_date  AND end_date)
      OR   (:end_date   BETWEEN start_date  AND end_date)
      OR   (start_date  BETWEEN :start_date AND :end_date) )
    SQL
  end

  def approved_overlapping_requests
    overlapping_requests.where('status = ?', 'APPROVED')
  end

  def approved_overlapping_requests_validation
     unless approved_overlapping_requests.empty?
      errors[:base] << "No dice"
    end
  end

  def pending_status
    self.status ||= "PENDING"
  end


end
