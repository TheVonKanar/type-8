pico-8 cartridge // http://www.pico-8.com
version 41
__lua__

c_factory = {
    rate = 120,
    timer = 999,
    words = {},
    buffer = "",
    target = "",
    error_char = ""
}

function c_factory:new()
    local new = {}
    setmetatable(new, self)
    self.__index = self
    return new
end

function c_factory:update()
    if self.timer > self.rate then
        self.timer = 0
        self:spawn()
    end

    for i = count(self.words), 1, -1 do
        local word = self.words[i]
        word:update()

        -- loss
        if word.y > 120 then
            if word.txt == self.target then
                self:clear_target()
            end

            deli(self.words, i)
            _player:hit(#word.txt)
        end

        -- win
        if self.buffer == word.txt then
            self:clear_target()
            deli(self.words, i)
        end
    end

    self.timer += 1
end

function c_factory:draw()
    foreach(self.words, function(word) word:draw() end)
end

function c_factory:spawn()
    local rand_txt = rnd(_db)
    local valid = true
    repeat
        valid = true
        for w in all(self.words) do
            if rand_txt == w.txt then
                valid = false
                rand_txt = rnd(_db)
                break
            end
        end
    until valid

    add(self.words, c_word:new(rand_txt))
end

function c_factory:add_char(char)
    -- if no target, scan words to see if we can find one
    if #self.target < 1 then
        for w in all(self.words) do
            if sub(w.txt, 1, 1) == char then
                self.target = w.txt
                break
            end
        end
    end

    -- add char to buffer if target exists
    if #self.target > 0 then
        if sub(self.target, #self.buffer + 1, #self.buffer + 1) == char then
            self.buffer = self.buffer .. char
            self.error_char = ""
        else
            self.error_char = char
        end
    end
end

function c_factory:pop_char()
    if #self.target > 0 then
        self.buffer = sub(self.buffer, 1, -2)
    end

    if #self.buffer == 0 then
        self.target = ""
    end

    self.error_char = ""
end

function c_factory:clear_target()
    self.buffer = ""
    self.target = ""
    self.error_char = ""
end
