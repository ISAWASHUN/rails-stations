class Schedule < ApplicationRecord
  belongs_to :movie
  def display_name
    "#{movie.name} - #{created_at.strftime('%Y-%m-%d %H:%M')}"
  end
end
