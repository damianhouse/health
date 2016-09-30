require "administrate/base_dashboard"

class UserDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    coach: Field::BelongsTo,
    conversations: Field::HasMany,
    messages: Field::HasMany,
    notes: Field::HasMany,
    id: Field::Number,
    first: Field::String,
    email: Field::String,
    password_digest: Field::String,
    role: Field::String,
    coach_1: Field::Number,
    coach_2: Field::Number,
    coach_3: Field::Number,
    coach_4: Field::Number,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    avatar_url: Field::Image,
    phone: Field::String,
    zip: Field::String,
    last_name: Field::String,
    last: Field::String,
    paid: Field::Boolean,
    admin: Field::Boolean,
    stripe_id: Field::String,
    exp_date: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :first,
    :last,
    :coach,
    :conversations,
    :messages,
    :notes,
    :avatar_url,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :coach,
    :conversations,
    :messages,
    :notes,
    :id,
    :first,
    :email,
    :password_digest,
    :role,
    :coach_1,
    :coach_2,
    :coach_3,
    :coach_4,
    :created_at,
    :updated_at,
    :avatar_url,
    :phone,
    :zip,
    :last_name,
    :last,
    :paid,
    :admin,
    :stripe_id,
    :exp_date,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :coach,
    :conversations,
    :messages,
    :notes,
    :id,
    :first,
    :email,
    :password_digest,
    :role,
    :coach_1,
    :coach_2,
    :coach_3,
    :coach_4,
    :created_at,
    :updated_at,
    :avatar_url,
    :phone,
    :zip,
    :last_name,
    :last,
    :paid,
    :admin,
    :stripe_id,
    :exp_date,
  ].freeze

  # Overwrite this method to customize how users are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(user)
    if user
      "#{user.first.capitalize if user.first}" + " " + "#{user.last.capitalize if user.last}"
    end
  end
end
