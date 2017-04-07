class CoverUploader < ImageUploader
  # Create different versions of your uploaded files:
  version :huge do
    process :resize_to_fill => [275, 275]
  end

  version :big do
    process :resize_to_fill => [75, 75]
  end
end