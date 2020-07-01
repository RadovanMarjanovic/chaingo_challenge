module SerialsUuidConcern
  extend ActiveSupport::Concern

  included do
    after_create :add_serial_number
    after_create :add_uuid

    def add_serial_number
        self.update(serial_number: self.class.name.first + self.id.to_s.rjust(6, "0"))
    end

    def add_uuid
      self.update(uuid: SecureRandom.uuid)
    end
  end
end
