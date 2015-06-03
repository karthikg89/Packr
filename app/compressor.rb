require 'oily_png'

def compress file, out, bytes, side

    curr = 0
    img = ChunkyPNG::Image.new(side, side, ChunkyPNG::Color::BLACK)
  puts bytes
    row = 0
    col = 0

    percent = bytes / 100

    while curr < bytes
      i = 0
      rgb = [0,0,0,0]
      while curr < bytes && i < 4
        rgb[i] = file.readbyte
        i = i + 1
        curr = curr + 1
      end
      
      img[row,col] = ChunkyPNG::Color.rgba(rgb[0],rgb[1],rgb[2],rgb[3])
      col = col + 1
      if col >= side
        row = row + 1
        col = 0
      end
    end
    img[side - 1, side - 1] = bytes
    
    img.save(out, :fast_rgba)
end

def picSize curr, total, mod
  if curr + mod <= total
    return mod
  else
    return (total - curr) % mod
  end
end

def main 
  f = File.open(ARGV[0])
  totalSize = f.size
  f.close

  bytesPerPic = 1 << 4 << 20

  currPos = 0
  pic = 1
  dirStr = ARGV[0] + ".pac"

  begin
    Dir.mkdir(dirStr)
  rescue SystemCallError
  end
  

  while currPos < totalSize
    file = File.new(ARGV[0])
    file.seek(currPos)
    
    size = picSize currPos, totalSize, bytesPerPic

    currPos = currPos + size

    side = Math.sqrt((size / 4) + 1).to_i + 1
    compress file, (File.join(dirStr, ARGV[0] + ".#{pic}.png")), size, side

    print "#{pic} "

    pic = pic + 1
    file.close
  end
  puts

end
main
