from PIL import Image
import numpy as np

# Define the 3-bit color palette
palette = [
    (0, 0, 0),       # 000: Black
    (0, 0, 255),     # 001: Blue
    (0, 255, 0),     # 010: Green
    (0, 255, 255),   # 011: Cyan
    (255, 0, 0),     # 100: Red
    (255, 0, 255),   # 101: Magenta
    (255, 255, 0),   # 110: Yellow
    (255, 255, 255)  # 111: White
]

# Function to quantize the image to 3-bit color
def quantize_to_3bit(image):
    # Convert the image to RGB format and get its pixel data
    image = image.convert('RGB')
    pixels = np.array(image)
    
    # Quantize the image by finding the nearest color in the palette
    quantized_pixels = np.zeros(pixels.shape[:2], dtype=np.uint8)
    for y in range(pixels.shape[0]):
        for x in range(pixels.shape[1]):
            pixel = pixels[y, x]
            # Find the nearest color in the palette
            distances = [np.sum((np.array(color) - pixel) ** 2) for color in palette]
            quantized_pixels[y, x] = np.argmin(distances)
    
    return quantized_pixels

# Function to save the quantized image data to a text file
def save_3bit_image_as_text(quantized_pixels, filename):
    with open(filename, 'w') as f:
        for pixel in quantized_pixels.flatten():
            f.write(f'{pixel:03b}\n')

# Function to load the 3-bit image data from a text file
def load_3bit_image_from_text(filename, image_size):
    with open(filename, 'r') as f:
        lines = f.readlines()
    quantized_pixels = np.array([int(line.strip(), 2) for line in lines], dtype=np.uint8)
    quantized_pixels = quantized_pixels.reshape(image_size)
    return quantized_pixels

# Function to reconstruct the image from quantized pixels
def reconstruct_image(quantized_pixels):
    height, width = quantized_pixels.shape
    image = np.zeros((height, width, 3), dtype=np.uint8)
    for y in range(height):
        for x in range(width):
            image[y, x] = palette[quantized_pixels[y, x]]
    return Image.fromarray(image)

# Load an image
image = Image.open('bird before edit.jpg')

# Resize the image to 340x120
image = image.resize((340, 120))

# Quantize the image to 3-bit color
quantized_pixels = quantize_to_3bit(image)

# Save the quantized image data to a text file
save_3bit_image_as_text(quantized_pixels, 'output_image.txt')

# Load the 3-bit image data from the text file
loaded_quantized_pixels = load_3bit_image_from_text('output_image.txt', quantized_pixels.shape)

# Reconstruct the image from the loaded quantized pixels
reconstructed_image = reconstruct_image(loaded_quantized_pixels)

# Show the reconstructed image
reconstructed_image.show()

