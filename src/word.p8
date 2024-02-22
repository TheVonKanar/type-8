pico-8 cartridge // http://www.pico-8.com
version 41
__lua__

c_word = {
    spd = 0.5,
    x = 0,
    y = 0,
    w = 0,
    h = 6,
    txt = "",
    col_bg = 7,
    col_txt = 1,
    col_txt_match = 11
}

function c_word:new(txt)
    local new = {}
    setmetatable(new, self)
    self.__index = self
    new.txt = txt
    new.w = print("\#7" .. new.txt, 0, 1000, 1)
    new.x = new.w / 2 + rnd(128 - new.w)
    new.y = -16
    return new
end

function c_word:draw()
    local x = self.x - self.w / 2
    local y = self.y - self.h / 2
    local match_count = 0
    for i = 1, #self.txt do
        local my_char = sub(self.txt, i, i)
        local buffer_char = sub(_factory.buffer, i, i)
        if my_char == buffer_char then match_count += 1 end
        local col = self.col_txt
        if match_count >= i then col = self.col_txt_match end
        x = print("\#" .. self.col_bg .. my_char, x, y, col)
    end
end

function c_word:update()
    self:move()
end

function c_word:move()
    local dir = dir(self.x, self.y, 64, 128)
    -- self.x += self.spd * cos(dir)
    -- self.y += self.spd * sin(dir)
    self.y += self.spd
end
