pico-8 cartridge // http://www.pico-8.com
version 41
__lua__

c_player = {
    hp = 100,
    hp_max = 100
}

function c_player:new()
    local new = {}
    setmetatable(new, self)
    self.__index = self
    return new
end

function c_player:update()
end

function c_player:draw()
    -- sprite
    spr(1, 60, 114)

    -- hp bar
    self:draw_hp_bar()
end

function c_player:draw_hp_bar()
    local x = 0
    local y = 121
    local w = 127
    local h = 6
    rect(x, y, x + w, y + h, 7)
    rect(x + 1, y + 1, x + w - 1, y + h - 1, 0)
    rectfill(x + 2, y + 2, self.hp / self.hp_max * (x + w - 2), y + h - 2, 11)
end

function c_player:hit(dmg)
    self.hp -= dmg
end
