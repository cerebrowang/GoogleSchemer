class AvatarUploader < ImageUploader
  # Create different versions of your uploaded files:
  version :large do
    process :resize_to_fill => [150, 150]
  end

  version :normal do
    process :resize_to_fill => [35, 35]
  end

  version :small do
    process :resize_to_fill => [24, 24]
  end

  version :thumb do
    process :resize_to_fill => [16, 16]
  end
end