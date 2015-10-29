module ForemanTags
  module HostExtensions
    extend ActiveSupport::Concern
    included do
      acts_as_taggable_on :when, :who, :type, :reason
    end
  end
end
