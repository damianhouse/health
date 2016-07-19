require "administrate/base_dashboard"

class CoachDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    users: Field::HasMany,
    messages: Field::HasMany,
    conversations: Field::HasMany,
    id: Field::Number,
    first: Field::String,
    last: Field::String,
    email: Field::String,
    password_digest: Field::String,
    role: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    avatar_url: Field::String,
    phone: Field::String,
    zip: Field::String,
    greeting: Field::Text,
    philosophy: Field::Text,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :users,
    :first,
    :last,
    :messages,
    :conversations,
    :id,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :users,
    :messages,
    :conversations,
    :id,
    :first,
    :last,
    :email,
    :password_digest,
    :role,
    :created_at,
    :updated_at,
    :zip,
    :phone,
    :avatar_url,
    :greeting,
    :philosophy,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :users,
    :messages,
    :conversations,
    :first,
    :last,
    :email,
    :password_digest,
    :role,
    :zip,
    :phone,
    :avatar_url,
    :greeting,
    :philosophy,
  ].freeze

  # Overwrite this method to customize how coaches are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(coach)
  #   "Coach ##{coach.id}"
  # end
end
