module Bazzar
  module Exception
    class InvalidParameter < ArgumentError; end
    class NotImplementedError < NoMethodError; end
    class InsufficientPrivilege < StandardError; end
    class WebhookIntegration < StandardError; end
    class DocMigration < StandardError; end
  end
end