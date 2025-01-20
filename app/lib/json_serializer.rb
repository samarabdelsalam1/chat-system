module JsonSerializer
    def self.serialize(object)
        if object.is_a?(ActiveRecord::Relation) || object.is_a?(Array)
            object.map { |item| serialize_item(item) }
        else
            serialize_item(object)
        end
    end
            
    def self.serialize_item(item)
        item.attributes.except("id")
    end
end