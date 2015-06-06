require 'oily_png'

def decompress imgFile, file
  img = ChunkyPNG::Image.from_file(imgFile)
  size = img[img.height - 1, img.width - 1]
  puts size

  written = 0
  0.upto(img.height - 1) {|i|
    0.upto(img.width - 1) {|j|
      if (written < size)
        chars = [ChunkyPNG::Color.r(img[i,j]),\
                 ChunkyPNG::Color.g(img[i,j]),\
                 ChunkyPNG::Color.b(img[i,j]),\
                 ChunkyPNG::Color.a(img[i,j])]
        if (written + 4 > size) 
          diff = size - written
          (4 - diff).times { chars.pop }
          file.write(chars.pack("C" * diff))
        else
          file.write(chars.pack("CCCC"))
        end
        written = written + 4
      end
    }
  }

end

def main
  dirname = ARGV[0]
  filename = dirname[0..(dirname[-1] == '/' ? -6 : -5)]
  out = filename
  if (ARGV[1])
    out = ARGV[1]
  end

  dir = Dir.new(dirname)
  file = File.open(out, "w")

  numImg = dir.entries.length - 2
  dir.close

  1.upto(numImg) {|i|
    imgName = File.join(dirname, filename + ".#{i}.png")
    decompress(imgName, file)
    puts "#{i} "
  }
end
main
