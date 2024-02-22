pico-8 cartridge // http://www.pico-8.com
version 41
__lua__

function dir(x1, y1, x2, y2)
    return atan2(x2 - x1, y2 - y1)
end

function dist(x1, y1, x2, y2)
    return sqrt((x2 - x1) ^ 2 + (y2 - y2) ^ 2)
end
