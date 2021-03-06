class Booking < ActiveRecord::Base

  belongs_to :user

  attr_accessor :current_user

  validates_presence_of :date, :hour

  validate :ownership, on: [:update]
  validate :not_past, on: [:create, :update]
  validate :free, on: [:create, :update]

  before_destroy :ownership #Nao funciona
  before_destroy :not_past #Nao funciona

  scope :order_by_date, -> { order(:date, :hour) }
  scope :in_range, ->(x) { where('date BETWEEN ? AND ?', x, x + 5.day)}

  private

  def ownership
    errors.add(:user, 'Não é possível alterar/excluir a reserva de outro usuário') if user != current_user
  end

  def not_past
    if date.nil?
      errors.add(:date, 'Impossível calcular a data vazia')
      return
    end
    errors.add(:date, 'Não é possível criar/alterar/excluir uma reserva com data passada') if date.past?
  end

  def free
    booking = Booking.where(date: date, hour: hour).where.not(id: id)
    restrict = 0
    booking.each do |f|
      restrict = f.id
    end
    errors.add(:date, 'Essa data hora já está reservada') unless restrict.zero?
  end

end


