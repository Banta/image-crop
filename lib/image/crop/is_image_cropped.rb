class ActiveRecord::Base
  def self.is_image_cropped(*attr_names)
    before_save :process_cropped_images

    define_method 'process_cropped_images' do
      attr_names.each do |attr|
        if eval("self.#{attr}")
          image = Paperclip.io_adapters.for(eval("self.#{attr}"))
          image.original_filename = "cropped_file_#{Time.now.to_f.to_s.gsub('.','')}"
          eval("self.#{attr} = image")
        end
      end
    end
  end
end

