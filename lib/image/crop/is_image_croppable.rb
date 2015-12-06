module Image
  module Crop
    module ActiveRecord
      module InstanceMethods

        def cropping?
          !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
        end

        def avatar_geometry(style = :original)
          @geometry ||= {}
          @geometry[style] ||= Paperclip::Geometry.from_file(eval("#{opts[:name]}").path(style))
        end
      end
    end
  end

  class ActiveRecord::Base
    def self.is_image_croppable(opts={})
      include Pageviews::ActiveRecord::InstanceMethods
      attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
      after_update eval(":reprocess_#{opts[:name]}"), :if => :cropping?
    end
  end
end

