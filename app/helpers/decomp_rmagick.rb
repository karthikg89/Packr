require 'rmagick'
include Magick

def r(p)
  p.red & 255
end

def b(p)
  p.blue & 255
end

def g(p)
  p.green & 255
end

def a(p)
  (~p.opacity) & 255
end

def size(p)
  r(p) << 24 | g(p) << 16 | b(p) << 8 | a(p)
end

def decompress imgFile, file
  img = ImageList.new(imgFile)
  size = size(img.pixel_color(img.rows - 1, img.columns - 1))
  puts size

  written = 0
  0.upto(img.rows - 1) { |i|
    0.upto(img.columns - 1) { |j|
      if (written < size)
        pix = img.pixel_color(i,j)
        chars = [r(pix), g(pix), b(pix), a(pix)]
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
