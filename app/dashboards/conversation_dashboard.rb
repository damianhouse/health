require "administrate/base_dashboard"

class ConversationDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    user: Field::BelongsTo,
    coach: Field::BelongsTo,
    messages: Field::HasMany,
    id: Field::Number,
    active: Field::Boolean,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :user,
    :coach,
    :messages,
    :id,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :user,
    :coach,
    :messages,
    :id,
    :active,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :user,
    :coach,
    :messages,
    :active,
  ].freeze

  # Overwrite this method to customize how conversations are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(conversation)
    if conversation.coach && conversation.user
      "#{conversation.coach.first if conversation.coach.first}" + " and " + "#{conversation.user.first.capitalize if conversation.user.first}"
    end
  end
end
