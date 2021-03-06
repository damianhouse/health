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
    avatar_url: Field::Image,
    phone: Field::String,
    zip: Field::String,
    greeting: Field::Text,
    philosophy: Field::Text,
    approved: Field::Boolean,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :first,
    :last,
    :users,
    :conversations,
    :approved,
    :avatar_url,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :avatar_url,
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
    :greeting,
    :philosophy,
    :approved,
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
    :approved,
  ].freeze

  # Overwrite this method to customize how coaches are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(coach)
    if coach
      "#{coach.first if coach.first}" + " " + "#{coach.last.capitalize if coach.last}"
    end
  end

end
