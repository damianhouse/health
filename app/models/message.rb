class Message < ActiveRecord::Base
  belongs_to :conversation
  belongs_to :user
  belongs_to :coach

  def body_snippet
    body[0..30] + " ..."
  end
end
