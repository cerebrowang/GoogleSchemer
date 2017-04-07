class Tag < ActsAsTaggableOn::Utils
  def as_json(opts={})
    {
      :id => self.id,
      :item_string => self.name,
      :class_name => self.class.name
    }
  end
end