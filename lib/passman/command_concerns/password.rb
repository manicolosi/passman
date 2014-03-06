module Passman
  module CommandConcerns
    module Password
      def password
        record.password || raise("Record does not have a password")
      end

      def record
        @record ||= database.find_one(query)
      end

      def query
        args.first
      end
    end
  end
end
