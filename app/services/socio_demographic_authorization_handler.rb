# frozen_string_literal: true

# Allows to create a form for simple Socio Demographic authorization
class SocioDemographicAuthorizationHandler < Decidim::AuthorizationHandler
  attribute :firstname, String
  attribute :birthdate, String

  validates :firstname, :birthdate, presence: true

  def metadata
    super.merge(firstname: firstname, birthdate: birthdate)
  end
end
