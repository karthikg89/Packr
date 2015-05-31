require 'chunky_png'

def compress file, out, bytes, side
  curr = 0
  img = ChunkyPNG::Image.new(side, side, ChunkyPNG::Color::BLACK)

  row = 0
  col = 0

  percent = bytes / 100

  while curr < bytes
    i = 0
    rgb = [0,0,0,0]
    while curr < bytes && i < 4
      rgb[i] = file.readbyte
      i = i + 1
      if row % percent == 0
        print ". "
      end
      curr = curr + 1
    end
    
    img[row,col] = ChunkyPNG::Color.rgba(rgb[0],rgb[1],rgb[2],rgb[3])
    col = col + 1


    if col >= side

      row = row + 1
      col = 0
    end
  end
  puts "done"

  img[side - 1, side - 1] = bytes
    
  img.save(out)
end

def main 
  file = File.open(ARGV[0])
  out = ARGV[1]
  
  size = file.size
  
  side = Math.sqrt((size / 4) + 1).to_i + 1
  compress file, out, size, side
  
  file.close
end
main
