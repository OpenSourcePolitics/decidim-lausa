# frozen_string_literal: true

# Allows to create a form for simple Socio Demographic authorization
class SocioDemographicAuthorizationHandler < Decidim::AuthorizationHandler
  attribute :lastname, String
  attribute :firstname, String
  attribute :birthdate, String

  validates :lastname, :firstname, :birthdate, presence: true

  def metadata
    super.merge(lastname: lastname, firstname: firstname, birthdate: birthdate)
  end
end
