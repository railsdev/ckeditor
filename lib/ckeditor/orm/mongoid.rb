require 'orm_adapter/adapters/mongo_mapper'
require 'ckeditor/orm/base'

module Ckeditor
  module Orm
    module Mongoid
      module AssetBase
        def self.included(base)
          base.send(:include, ::MongoMapper::Document)
          # base.send(:include, ::MongoMapper::Timestamps)
          base.send(:include, Base::AssetBase::InstanceMethods)
          base.send(:include, InstanceMethods)
          base.send(:extend, ClassMethods)
        end
        
        module InstanceMethods
          def type
            _type
          end
          
          def as_json_methods
            [:id, :type] + super
          end
        end

        module ClassMethods
          def self.extended(base)
            base.class_eval do
              key :data_content_type,  String
              key :data_file_size,  Integer
              key :width,  Integer
              key :height,  Integer
              timestamps!
              belongs_to :assetable, :polymorphic => true
              
              attr_accessible :data, :assetable_type, :assetable_id, :assetable
            end
          end
        end
      end
    end
  end
end
